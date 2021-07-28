//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 11.07.21.
//

import Foundation

/// >Important: Only attach existing ``PathNode``s to the sidewalks ``Sidewalk/pathNodes`` property. Not existing path nodes will be created on the server. You retriev them from  ``AccessySwiftSDK/createSidewalk(_:completion:)``
public struct Sidewalk: Codable {
  public let id: UUID?
  public let pathCoordinates: [Coordinate]
  public let createdAt: Date?
  public let updatedAt: Date?
  public let deletedAt: Date?
  public init(id: UUID? = UUID(),
              pathCoordinates: [Coordinate],
              createdAt: Date? = nil,
              updatedAt: Date? = nil,
              deletedAt: Date? = nil) {
    self.id = id
    self.pathCoordinates = pathCoordinates
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.deletedAt = deletedAt
  }
}


struct SidewalkCreateRequest: CreateRequest {
  typealias ModelType = Sidewalk
  let pathComponent: String = "sidewalks"
  let object: Sidewalk
}
