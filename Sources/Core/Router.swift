//
//  Router.swift
//  OctoKitRacSwift
//
//  Created by eony on 28/04/2017.
//  Copyright © 2017 Maxwell. All rights reserved.
//

//import Foundation
//import Alamofire
//import ReactiveSwift

//public protocol Router {
//    var method: HTTPMethod { get }
//    var path: URLConvertible { get }
//    var encoding: ParameterEncoding { get }
//    var params: Parameters { get }
//    var configuration: Configuration { get }
    
//    func urlQuery(_ parameters: [String: Any]) -> [URLQueryItem]?
//    func request(_ urlComponents: URLComponents, parameters: [String: Any]) -> URLRequest?
//    func loadJSON<T>(_ session: RequestKitURLSession, expectedResultType: T.Type, completion: @escaping (_ json: T?, _ error: Error?) -> Void) -> URLSessionDataTaskProtocol?
//    func request() -> URLRequest?
//}

//public extension Router {

//    public func request() -> URLRequestConvertible? {
////        let url = URL(string: path, relativeTo: URL(string: configuration.apiEndpoint)!)
////        var parameters = encoding == .json ? [:] : params
////        if let accessToken = configuration.accessToken {
////            parameters[configuration.accessTokenFieldName] = accessToken as AnyObject?
////        }
////        let components = URLComponents(url: url!, resolvingAgainstBaseURL: true)
////        return request(components!, parameters: parameters)
//        
//        
//        
//        return
////        return URLRequestConvertible
//    }
    
//}

//public extension Router {
//    public func request() -> URLRequest? {
//        let url = URL(string: path, relativeTo: URL(string: configuration.apiEndpoint)!)
//        var parameters = encoding == .json ? [:] : params
//        if let accessToken = configuration.accessToken {
//            parameters[configuration.accessTokenFieldName] = accessToken as AnyObject?
//        }
//        let components = URLComponents(url: url!, resolvingAgainstBaseURL: true)
//        return request(components!, parameters: parameters)
//    }
    
//    public func urlQuery(_ parameters: [String: Any]) -> [URLQueryItem]? {
//        guard parameters.count > 0 else { return nil }
//        var components: [URLQueryItem] = []
//        for key in parameters.keys.sorted(by: <) {
//            guard let value = parameters[key] else { continue }
//            switch value {
//            case let value as String:
//                if let escapedValue = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.requestKit_URLQueryAllowedCharacterSet()) {
//                    components.append(URLQueryItem(name: key, value: escapedValue))
//                }
//            case let valueArray as [String]:
//                for (index, item) in valueArray.enumerated() {
//                    if let escapedValue = item.addingPercentEncoding(withAllowedCharacters: CharacterSet.requestKit_URLQueryAllowedCharacterSet()) {
//                        components.append(URLQueryItem(name: "\(key)[\(index)]", value: escapedValue))
//                    }
//                }
//            case let valueDict as [String: Any]:
//                for nestedKey in valueDict.keys.sorted(by: <) {
//                    guard let value = valueDict[nestedKey] as? String else { continue }
//                    if let escapedValue = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.requestKit_URLQueryAllowedCharacterSet()) {
//                        components.append(URLQueryItem(name: "\(key)[\(nestedKey)]", value: escapedValue))
//                    }
//                }
//            default:
//                print("Cannot encode object of type \(type(of: value))")
//            }
//        }
//        return components
//    }
//    
//    public func request(_ urlComponents: URLComponents, parameters: [String: Any]) -> URLRequest? {
//        var urlComponents = urlComponents
//        urlComponents.percentEncodedQuery = urlQuery(parameters)?.map({ [$0.name, $0.value ?? ""].joined(separator: "=") }).joined(separator: "&")
//        guard let url = urlComponents.url else { return nil }
//        switch encoding {
//        case .url, .json:
//            var mutableURLRequest = URLRequest(url: url)
//            mutableURLRequest.httpMethod = method.rawValue
//            return mutableURLRequest
//        case .form:
//            let queryData = urlComponents.percentEncodedQuery?.data(using: String.Encoding.utf8)
//            urlComponents.queryItems = nil // clear the query items as they go into the body
//            var mutableURLRequest = URLRequest(url: urlComponents.url!)
//            mutableURLRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
//            mutableURLRequest.httpBody = queryData
//            mutableURLRequest.httpMethod = method.rawValue
//            return mutableURLRequest as URLRequest
//        }
//    }
//    
//    public func loadJSON<T>(_ session: RequestKitURLSession = URLSession.shared, expectedResultType: T.Type, completion: @escaping (_ json: T?, _ error: Error?) -> Void) -> URLSessionDataTaskProtocol? {
//        guard let request = request() else {
//            return nil
//        }
//        
//        let task = session.dataTask(with: request) { data, response, err in
//            if let response = response as? HTTPURLResponse {
//                if response.wasSuccessful == false {
//                    let error = NSError(domain: self.configuration.errorDomain, code: response.statusCode, userInfo: nil)
//                    completion(nil, error)
//                    return
//                }
//            }
//            
//            if let err = err {
//                completion(nil, err)
//            } else {
//                if let data = data {
//                    do {
//                        let JSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? T
//                        completion(JSON, nil)
//                    } catch {
//                        completion(nil, error)
//                    }
//                }
//            }
//        }
//        task.resume()
//        return task
//    }
//}
