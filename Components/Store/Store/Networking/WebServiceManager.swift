//
//  NetweorkManager.swift
//  iPredictStore
//
//  Created by Fahad Baig on 13/03/2019.
//  Copyright © 2019 Fahad Baig. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public protocol WebServiceManager {
	func setHeaders(headers: [String:String])
	func newRequest<T>(method: Moya.Method, task: Task, path: String, headers: [String: String]?) -> Single<T> where T: Decodable
}

public class MoyaWebServiceManager: WebServiceManager {

	public let baseUrl: URL!
	private var customHeaders: [String:String] = [:]
    private let provider = MoyaProvider<ApiEndPoint>()
    
	public init(baseUrl: URL) {
		self.baseUrl = baseUrl
	}

	/// add headers to custom header
	/// - Parameter headers: new headers
	public func setHeaders(headers: [String:String]) {
		for (key,value) in headers {
			customHeaders[key] = value
		}
	}
    
    /// Create new request and return observable of response model
    ///
    /// - Parameters:
    ///   - method: HTTP method
    ///   - task: task that will be executed
    ///   - path: url path which will be appended at the end of baseurl
    ///   - headers: request header\[
    ///
    /// - Returns: Single(Observable Sequence) of  Reponse Model
	public func newRequest<T>(method: Moya.Method, task: Task, path: String, headers: [String: String]? = nil) -> Single<T> where T: Decodable  {
        let mergedHeaders = add(customHeaders: customHeaders, toRequestHeaders: headers ?? [:])
        let endPoint = ApiEndPoint(baseUrl: baseUrl, customHeaders: mergedHeaders, path: path, method: method, task: task)
        return request(endPoint: endPoint)
    }

    /// Create new request, filter success status codes and map json to response model
    ///
    /// - Parameter endPoint: contains apiEndPoint
    /// - Returns: Single(Observable Sequence) of  Reponse Model
    private func request<T>(endPoint: ApiEndPoint) -> Single<T> where T: Decodable {
        let request =  provider.rx.request(endPoint)
        
        return request.flatMap { (response) -> Single<T> in
            return Observable.create { (observer) -> Disposable in
                do {
                    let data = try response.filterSuccessfulStatusCodes()
                    if T.self != NoResponse.self {
						let decoder = JSONDecoder()
						decoder.keyDecodingStrategy = .convertFromSnakeCase
						let model = try decoder.decode(T.self, from: data.data)
                        observer.onNext(model)
                    }else {
                        observer.onNext(NoResponse() as! T)
                    }
                }catch {
					observer.onError(MoyaErrorParser(error: error).getError())
                }
                
                observer.onCompleted()
                return Disposables.create()
                }.asSingle()
        }
    }

    /// Combine customHeaders and request headers if a key exist in both request header will be selected
    ///
    /// - Parameters:
    ///   - customHeaders: headers in networking manager e.g session token
    ///   - request: request specific header sent in request object
    /// - Returns: merge of custom and request headers
    private func add(customHeaders: [String:String], toRequestHeaders requestHeaders: [String:String]) -> [String:String] {
        var newHeaders = [String:String]()
        
        //Custom Headers
        for (header, value) in customHeaders {
            newHeaders[header] = value
        }
        
        //Request Headers
        for (header, value) in requestHeaders {
            newHeaders[header] = value
        }
        
        return newHeaders
    }
}
