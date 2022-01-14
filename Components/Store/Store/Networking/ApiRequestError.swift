//
//  ApiRequestError.swift
//  Store
//
//  Created by Fahad Baig on 13/01/2022.
//

import Foundation
import Moya

enum RequestError: Error {
	///when server crahes
	case internalServerError(ApiRequestError)
	///when request is successfully called but server returns error
	case serverReturnedError(ApiRequestError)
	///when request fails
	case requestFailed(ApiRequestError)
}

public struct ApiRequestError {
	let statusCode: Int
	let message: String
	let underlyringError: Error
	let code: Int
}

protocol ApiRequestErrrorParser {
	func getError() -> RequestError
}

class MoyaErrorParser: ApiRequestErrrorParser {

	let error: Error

	init(error: Error) {
		self.error = error
	}

	func getError() -> RequestError {
		return parseError(error: error)
	}

	private func parseError(error: Error) -> RequestError {
		guard let mError = error as? MoyaError else {
			return .requestFailed(.init(statusCode: -1, message: "Unknown Error", underlyringError: error, code: 0))
		}

		let statusCode = mError.response?.statusCode ?? 0

		//custom error
		let decoder = JSONDecoder()
		//api request was success but server returned error
		if let errorData = mError.response?.data, let serverError = try? decoder.decode(ServerError.self, from: errorData) {
			return .serverReturnedError(.init(statusCode: statusCode, message: serverError.message, underlyringError: error, code: serverError.cod))
		}

		//internal server error
		else if statusCode == 500 {
			return .internalServerError(.init(statusCode: 500, message: "Unfortunately, server error occurred", underlyringError: error, code: 0))
		}

		else {
			return .requestFailed(.init(statusCode: statusCode, message: mError.localizedDescription, underlyringError: error, code: 0))
		}
	}
}
