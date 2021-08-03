//
//  File.swift
//  File
//
//  Created by Michael Helmbrecht on 28.07.21.
//

import Foundation
///////////////////////////////////////////////////////////////
///
///
///   PROTOCOLS
///
///
///////////////////////////////////////////////////////////////

public protocol DateRepresentable {
  var createdAt: Date? { get }
  var updatedAt: Date? { get }
  var deletedAt: Date? { get }
}

public protocol PathRepresentable {
  /// First and last ``pathCoordinates`` will be used as ``IntersectionNode``s. Use them in your UI to make selectable objects and to attach new ``InfrastructureType``s to them.
  var pathCoordinates: [Coordinate] { get }
}

public protocol CoordinateRepresentable {
  var coordinate: Coordinate { get }
}

public protocol IDRepresentable {
  var id: UUID? { get }
}

public protocol AdjacentInfrastructuresRepresentable {
  var adjacentInfrastructures: [String] { get }
}

public typealias InfrastructureType = DateRepresentable & PathRepresentable & IDRepresentable & Codable & Hashable
