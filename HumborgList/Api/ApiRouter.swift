//
//  ApiRouter.swift
//  HumborgList
//
//  Created by Amir Daliri on 3/22/18.
//  Copyright © 2018 AmirDaliri. All rights reserved.
//

import Foundation
import Alamofire


enum BackendError: Error {
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
}

public protocol ResponseCollectionSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self]
}

public protocol ResponseObjectSerializable {
    init?(response: HTTPURLResponse, representation: Any)
}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self] {
        var collection: [Self] = []
        if let representation = representation as? [[String: Any]] {
            for itemRepresentation in representation {
                if let item = Self(response: response, representation: itemRepresentation) {
                    collection.append(item)
                }
            }
        }
        
        return collection
    }
}


extension DataRequest {
    @discardableResult
    public func responseObject<T: ResponseObjectSerializable>(
        _ queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self {
            let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
                guard error == nil else { return .failure(BackendError.network(error: error!)) }
                
                let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
                let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
                
                guard case let .success(jsonObject) = result else {
                    return .failure(BackendError.jsonSerialization(error: result.error!))
                }
                
                guard let response = response, let responseObject = T(response: response, representation: jsonObject) else {
                    return .failure(BackendError.objectSerialization(reason: "JSON could not be serialized: \(jsonObject)"))
                }
                
                return .success(responseObject)
            }
            
            return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseCollection<T: ResponseCollectionSerializable>(
        _ queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self {
        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
            guard error == nil else { return .failure(BackendError.network(error: error!)) }
            
            let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(BackendError.jsonSerialization(error: result.error!))
            }
            
            guard let response = response else {
                let reason = "Response collection could not be serialized due to nil response."
                return .failure(BackendError.objectSerialization(reason: reason))
            }
            
            return .success(T.collection(from: response, withRepresentation: jsonObject))
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

struct ApiRouter {
    enum Router: URLRequestConvertible {
        
        //Membership and Activation
        case getEvents(pageSize: String, pageNumber: String, cityId: String)

        var method: Alamofire.HTTPMethod {
            switch self {

            case .getEvents:
                return .get
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let result: (path: String, parameters: [String: AnyObject]?) = {
                switch self {
                    
                //Membership and Activation
                case .getEvents(let pageSize, let pageNumber, let cityId):
                    return("events?pageSize=\(pageSize)&pageNumber=\(pageNumber)&cityId=\(cityId)",nil)
                }
            }()
            
            
            // MARK: - Set HTTP Header Field
            
            let base = URL(string: Constants.ApiConstants.baseURLString)!
            let baseAppend = base.appendingPathComponent(result.path).absoluteString.removingPercentEncoding
            let url = URL(string: baseAppend!)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = method.rawValue
            if let token = User.getToken() {
                urlRequest.setValue(token, forHTTPHeaderField: "")
            }
            let encoding = try Alamofire.URLEncoding.default.encode(urlRequest, with: result.parameters)
            
            return encoding
        }
    }
    
    
    
    enum ImageRouter {
        case avatar(String)
        
        func getImageLink() -> String {
            let path: String = {
                switch self {
                case .avatar(let avatarUrl):
                    return (avatarUrl)
                    
                }
            }()
            
            let urlString = Constants.ApiConstants.imageURLString + path
            return urlString
        }
    }
    
}



