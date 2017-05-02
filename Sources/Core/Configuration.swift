//
//  Configuration.swift
//  OctoKitRacSwift
//
//  Created by eony on 28/04/2017.
//  Copyright © 2017 Maxwell. All rights reserved.
//

import Foundation

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
}
