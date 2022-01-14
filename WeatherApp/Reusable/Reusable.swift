//
//  Reusable.swift
//  WeatherApp
//
//  Created by Fahad Baig on 14/01/2022.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: Protocol definition
/// Make your `UITableViewCell` and `UICollectionViewCell` subclasses
/// conform to this protocol when they are *not* NIB-based but only code-based
/// to be able to dequeue them in a type-safe manner
public protocol Reusable: AnyObject {
  /// The reuse identifier to use when registering and later dequeuing a reusable cell
  static var reuseIdentifier: String { get }
}

// MARK: - Default implementation
public extension Reusable {
  /// By default, use the name of the class as String for its reuseIdentifier
  static var reuseIdentifier: String {
	return String(describing: self)
  }
}
#endif
