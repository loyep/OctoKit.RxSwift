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
        var urlRequest = OAuthRouter.authorize(self).asURLRequest()
        return urlRequest.url
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
        default:
            return .post
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

        let url = URL(string: path)
        return URLRequest(url: url!)
    }
}
