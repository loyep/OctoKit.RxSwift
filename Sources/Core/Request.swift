//
//  Request.swift
//  OctoKitRacSwift
//
//  Created by eony on 28/04/2017.
//  Copyright © 2017 Maxwell. All rights reserved.
//

import Foundation
import Alamofire

//struct Router: URLRequestConvertible {
////    static var host = Configuration.self
//    static let timeoutInterval = 15.0
//    
//    public func asURLRequest() throws -> URLRequest {
//        
//        var request = URLRequest(url: path, timeoutInterval: Router.timeoutInterval)
//        request.httpMethod = method.rawValue
//        return try URLEncoding.default.encode(request, with: parameters)
//    }
//    
//    init(_ path: String, method: HTTPMethod = .post ,parameters: [String: Any]? = nil) {
//        
//        self.path   = path
//        self.method = .post
//        if let params = parameters {
//            self.parameters += params
//        }
//    }
//    
//    var parameters: [String: Any] = {
//        
//        return ["token": QEngine.shared.user?.token ?? "",
//                "_version": SystemVersion.shortVersionString()
//        ]
//    }()
//    
//    var path: String
//    var method: HTTPMethod
//    
//    struct Path {
//        
//        struct User {
//            
//        }
//        
//        struct Purchase {
//            static let info         = "order/pay/view.do"
//            static let pay          = "order/pay.do"
//            static let result       = "order/pay/result.do"
//            static let aliSync      = "order/pay/ali/sync.do"
//            static let wechatSync   = "order/pay/wechat/sync.do"
//        }
//        
//        struct Fund {
//            static let list         = "crowdfunding/list.do"
//            static let detail       = "crowdfunding/view.do"
//        }
//        
//        struct Address {
//            static let list         = "/user/address/list.do"
//            static let add          = "/user/address/add.do"
//            static let delete       = "/user/address/delete.do"
//            static let edit         = "/user/address/edit.do"
//        }
//        
//        struct System {
//            static let publicNumber = "/system/weChatPublicNumber.do"
//        }
//    }
//}
