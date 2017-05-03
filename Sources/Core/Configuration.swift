//
//  Configuration.swift
//  OctoKitRacSwift
//
//  Created by eony on 28/04/2017.
//  Copyright © 2017 Maxwell. All rights reserved.
//

import Foundation
import Alamofire

let githubApiURL = "https://api.github.com"
let githubWebURL = "https://github.com"

internal extension URL {
    var URLParameters: [String: String] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return [:] }
        var params = [String: String]()
        components.queryItems?.forEach { queryItem in
            params[queryItem.name] = queryItem.value
        }
        return params
    }
}

public protocol Configuration {
    
    var apiEndpoint: String { get }
    
    var accessToken: String? { get }
    
    var accessTokenFieldName: String { get }
    
    var errorDomain: String { get }
}

public extension Configuration {
    var accessTokenFieldName: String {
        return OctoKitAccessToken
    }
    
    var errorDomain: String {
        return OctoKitErrorDomain
    }
}

public let OctoKitErrorDomain = "com.maxsey.octokit"
public let OctoKitAccessToken = "access_token"

public struct TokenConfiguration : Configuration {
    public var apiEndpoint: String
    public var accessToken: String?
    
    public init(_ token: String? = nil, url: String = githubApiURL) {
        apiEndpoint = url
        accessToken = token
    }
}

public struct OAuthConfiguration: Configuration {
    public var apiEndpoint: String
    public var accessToken: String?
    public let token: String
    public let secrect: String
    public let scopes: [String]
    public let webEndpoint: String
    
    public init(_ url: String = githubApiURL, webURL: String = githubWebURL,
                token: String, secrect: String, scopes: [String]) {
        apiEndpoint = url
        webEndpoint = webURL
        self.token = token
        self.secrect = secrect
        self.scopes = scopes
    }
    
    public func authenticate() -> URL? {
        do {
            var urlRequest = try OAuthRouter.authorize(self).asURLRequest()
            return urlRequest.url
        } catch {
            return nil
        }
    }
    
    // MARK: authorize
    
    public func authorize(_ session: SessionManager = SessionManager.default, code: String, completion: @escaping (_ config: TokenConfiguration) -> Void) {
        let request = OAuthRouter.accessToken(self, code)
        session.request(request).validate(statusCode: [200]).responseString(completionHandler: { response in
            switch response.result {
            case .success:
                if let string = response.result.value {
                    let accessToken = self.accessTokenFromResponse(string)
                    if let accessToken = accessToken {
                        let config = TokenConfiguration(accessToken, url: self.apiEndpoint)
                        completion(config)
                    }
                }
                break
            case .failure(let error):
                print("error: \(error)")
                break
            }
        })
    }
    
    public func handleOpenURL(_ session: SessionManager = SessionManager.default, url: URL, completion: @escaping (_ config: TokenConfiguration) -> Void) {
        if let code = url.URLParameters["code"] {
            authorize(session, code: code) { (config) in
                completion(config)
            }
        }
    }
    
    public func accessTokenFromResponse(_ response: String) -> String? {
        let accessTokenParam = response.components(separatedBy: "&").first
        if let accessTokenParam = accessTokenParam {
            return accessTokenParam.components(separatedBy: "=").last
        }
        return nil
    }
}

enum OAuthRouter: URLRequestConvertible {
    case authorize(OAuthConfiguration)
    case accessToken(OAuthConfiguration, String)
    
    var configuration: Configuration {
        switch self {
        case .authorize(let config): return config
        case .accessToken(let config, _): return config
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .authorize: return .get
        case .accessToken: return .post
        }
    }
    
    var encoding: URLEncoding {
        switch self {
        case .authorize: return URLEncoding.queryString
        default:
            return URLEncoding.methodDependent
        }
    }
    
    var path: String {
        switch self {
        case .authorize:
            return "login/oauth/authorize"
        case .accessToken:
            return "login/oauth/access_token"
        }
    }
    
    var params: [String: Any] {
        switch self {
        case .authorize(let config):
            let scope = (config.scopes as NSArray).componentsJoined(by: ",")
            return ["scope": scope, "client_id": config.token, "allow_signup": "false"]
        case .accessToken(let config, let code):
            return ["client_id": config.token, "client_secret": config.secrect, "code": code]
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .authorize(let config):
            let url = URL(string: path, relativeTo: URL(string: config.webEndpoint)!)
            var urlRequest = URLRequest(url: (url?.appendingPathComponent(path))!)
            urlRequest.httpMethod = method.rawValue
            return try encoding.encode(urlRequest, with: params)
        case .accessToken(let config, _):
            let url = URL(string: path, relativeTo: URL(string: config.webEndpoint)!)
            var urlRequest = URLRequest(url: (url?.appendingPathComponent(path))!)
            urlRequest.httpMethod = method.rawValue
            return try encoding.encode(urlRequest, with: params)
        }
    }
}
