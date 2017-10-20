//
//  RecipePuppyAPI.swift
//  RecipePuppy
//
//  Created by Kuba Domaszewicz on 20.10.2017.
//  Copyright © 2017 kdomaszewicz. All rights reserved.
//

import Foundation
import Moya

enum RecipePuppyAPI {
    
    case GetRecipe( query: String, page: Int? )
}

let endpointClosure = { (target: RecipePuppyAPI) -> Endpoint<RecipePuppyAPI> in
    
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    
    var endpoint: Endpoint<RecipePuppyAPI> = Endpoint<RecipePuppyAPI>(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    
    switch target {
        
    case .GetRecipe(_):
        
        return endpoint.adding(newParameterEncoding: URLEncoding.default)
    }
}

func defaultRequest( recipePuppy: RecipePuppyAPI, completion: @escaping Completion ) -> Cancellable {
    
    let defaultRecipePuppyAPIProvider = MoyaProvider<RecipePuppyAPI>(endpointClosure: endpointClosure, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: nil)])
    
    return defaultRecipePuppyAPIProvider.request(recipePuppy, queue: DispatchQueue.main, completion: { result in
        
        if case let .success(response) = result {
                
            if( response.statusCode >= 400 && 499 <= response.statusCode ) {
                
                print("Network error. Response status code: \(response.statusCode)")
                
                completion( .failure(defaultError) )
                
            } else {
                
                completion( result )
            }
            
        } else if case let .failure(error) = result {
            
            completion( result )
            
            print(error)
        }
    })
}

fileprivate var defaultError: Moya.MoyaError = {
    
    Moya.MoyaError.underlying(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil))
}()

extension RecipePuppyAPI: TargetType {
    
    var baseURL: URL { return URL(string: "http://www.recipepuppy.com/api")! }
    
    var path: String {
        
        switch self {
            
        case .GetRecipe:
            return "/"
        }
    }
    
    var method: Moya.Method {
        
        switch self {
            
        case .GetRecipe:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        
        switch self {
            
        case .GetRecipe(let query, let page):
            return ["q":query, "p": page ?? 1]
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        
        switch self {
        case .GetRecipe:
            return URLEncoding.default
        }
    }
    
    var sampleData: Data {
        
        switch self {
            
        default:
            return Data()
        }
    }
    
    var task: Task {
        
        switch self {
            
        default:
            return .request
        }
    }
}
