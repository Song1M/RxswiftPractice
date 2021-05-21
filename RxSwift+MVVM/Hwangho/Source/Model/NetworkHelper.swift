//
//  NetworkHelper.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/14.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case json(url: String, parameters: Parameters?)
    case data(url: String)
    case post(url: String, parameters: Parameters?)
    case postWithQuery(url: String, parameters: Parameters?)
    case delete(url: String, parameters: Parameters?)
    case upload(url: String)

    var method: HTTPMethod {
        switch self {
        case .data:
            return .get
        case .json:
            return .get
        case .post:
            return .post
        case .postWithQuery:
            return .post
        case .delete:
            return .delete
        case .upload:
            return .post
        }
    }

    var fullURL: String {
        return Constant.default.domain.url + self.apiURL
    }

    var apiURL: String {
        switch self {
        case .data(let url): return "\(url)"
        case .json(let url, _): return "\(url)"
        case .post(let url, _): return "\(url)"
        case .postWithQuery(let url, _): return "\(url)"
        case .delete(let url, _): return "\(url)"
        case .upload(let url): return "\(url)"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let baseUrl = try Constant.default.domain.url.asURL()

        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(apiURL))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .json(_, let parameters),
             .postWithQuery(_, let parameters):
            guard let param = parameters else {
                break
            }

            urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
        case .post(_, let parameters),
             .delete(_, let parameters):

            guard let param = parameters else {
                break
            }

            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let data = try! JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            urlRequest.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
        default: break
        }

        return urlRequest
    }
}

protocol NetworkHelperProtocol {
    func jsonRequest(url: String, parameters: Parameters?, completion: @escaping (DataResponse<Any, AFError>) -> Void)
    func dataRequest(url: String, completion: @escaping (DataResponse<Any, AFError>) -> Void)
    func postRequest(url: String, parameters: Parameters?, completion: @escaping (DataResponse<Any, AFError>) -> Void)
    func postWithQueryRequest(url: String, parameters: Parameters?, completion: @escaping (DataResponse<Any, AFError>) -> Void)
    func deleteRequest(url: String, parameters: Parameters?, completion: @escaping (DataResponse<Any, AFError>) -> Void)
//    func upload(url: String, parameters: Parameters, completion: @escaping (DataResponse<Any, AFError>) -> Void)
//    func imageUpload(url: String, multipartFormData formDataHandler: @escaping (MultipartFormData) -> Void, completion: @escaping (Bool) -> Void)
}

struct NetworkHelper: NetworkHelperProtocol {

    func jsonRequest(url: String, parameters: Parameters?, completion: @escaping (DataResponse<Any, AFError>) -> Void) {
        AF.request(Router.json(url: url, parameters: parameters)).responseJSON { response in
            completion(response)
        }
    }

    func dataRequest(url: String, completion: @escaping (DataResponse<Any, AFError>) -> Void) {
        AF.request(Router.data(url: url)).responseJSON { response in
            completion(response)
        }
    }

    func postRequest(url: String, parameters: Parameters?, completion: @escaping (DataResponse<Any, AFError>) -> Void) {
        AF.request(Router.post(url: url, parameters: parameters)).responseJSON { response in
            completion(response)
        }
    }

    func postWithQueryRequest(url: String, parameters: Parameters?, completion: @escaping (DataResponse<Any, AFError>) -> Void) {
        AF.request(Router.postWithQuery(url: url, parameters: parameters)).responseJSON { response in
            completion(response)
        }
    }

    func deleteRequest(url: String, parameters: Parameters?, completion: @escaping (DataResponse<Any, AFError>) -> Void) {
        AF.request(Router.delete(url: url, parameters: parameters)).responseJSON { response in
            completion(response)
        }
    }
}
