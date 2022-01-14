//
//  ServerError.swift
//  Store
//
//  Created by Fahad Baig on 13/01/2022.
//

import Foundation

public struct ServerError: Codable {
	public let cod: Int
	public let message: String

	public init(cod: Int, message: String) {
		self.cod = cod
		self.message = message
	}
}
