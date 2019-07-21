//
//  APIManager.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 1/29/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire


typealias CallResponse<T> = ((ServerResponse<T>) -> Void)?

protocol APIRequestHandler: HandleAlamoResponse {
    
}

enum ServerResponse<T> {
    case success(T), failure(Error)
}


struct UploadData {
    var data: Data
    var fileName, mimeType, name: String
}

extension APIRequestHandler {
    
    private func uploadToServerWith<T: CodableInit>(_ decoder: T.Type, data: UploadData, request: URLRequestConvertible, parameters: Parameters?, progress: ((Progress) -> Void)?, completion: CallResponse<T>) {
        
        upload(multipartFormData: { (mul) in
            mul.append(data.data, withName: data.name, fileName: data.fileName, mimeType: data.mimeType)
            guard let parameters = parameters else { return }
            for (key, value) in parameters {
                mul.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, with: request) { (response) in
            switch response {
            case .success(let requestUp, _, _):
                requestUp.responseData(completionHandler: { (results) in
                    self.handleResponse(results, completion: completion)
                }).responseString(completionHandler: { (string) in
                    print(string.result.value as Any)
                })
                
            case .failure(let error):
                completion?(ServerResponse<T>.failure(error))
            }
            
        }
    }
    
  
}

extension APIRequestHandler where Self: URLRequestBuilder {
    func send<T: CodableInit>(_ decoder: T.Type, data: UploadData? = nil, progress: ((Progress) -> Void)? = nil, debug: ((DataResponse<Any>) -> Void)? = nil, completion: CallResponse<T>) {
        if let data = data {
            uploadToServerWith(decoder, data: data, request: self, parameters: self.parameters, progress: progress, completion: completion)
        } else {
            request(self).validate().responseData { (response) in
                self.handleResponse(response, completion: completion)
                }.responseJSON { (results) in
                    debug?(results)
                    let res = results.result.value as? [String: Any]
                    print(res?["message"] as Any)
            }
        }
    }
}
