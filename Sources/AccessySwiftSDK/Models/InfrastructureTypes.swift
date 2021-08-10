//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 12.07.21.
//

import Foundation

///////////////////////////////////////////////////////////////
///
///
///   INFRASTRUCTURE TYPES
///
///
///////////////////////////////////////////////////////////////

///
public struct Infrastructure: Codable {
  public let sidewalks: [Sidewalk]
  public let trafficLights: [TrafficLight]
  public let trafficIsland: [TrafficIsland]
  public let zebraCrossing: [ZebraCrossing]
  public let pedestrianCrossing: [PedestrianCrossing]
  public let intersectionNodes: [IntersectionNode]
  ///
  public init(sidewalks: [Sidewalk] = [],
              trafficLights: [TrafficLight] = [],
              trafficIsland: [TrafficIsland] = [],
              zebraCrossing: [ZebraCrossing] = [],
              pedestrianCrossing: [PedestrianCrossing] = [],
              intersectionNodes: [IntersectionNode] = []) {
    self.sidewalks = sidewalks
    self.trafficLights = trafficLights
    self.trafficIsland = trafficIsland
    self.zebraCrossing = zebraCrossing
    self.pedestrianCrossing = pedestrianCrossing
    self.intersectionNodes = intersectionNodes
  }
}


/// >Important: Don't attach existing ``IntersectionNode``s by yourself. You retriev them from  ``AccessySwiftSDK/createSidewalk(_:completion:)``
public struct Sidewalk: InfrastructureType {
  public let id: UUID?
  public let pathCoordinates: [Coordinate]
  public let createdAt: Date?
  public let updatedAt: Date?
  public let deletedAt: Date?
  ///
  public init(id: UUID? = nil,
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
  
  public init(pathCoordinates: [Coordinate]) {
    self.init(id: nil, pathCoordinates: pathCoordinates, createdAt: nil, updatedAt: nil, deletedAt: nil)
  }
  
  /// First and last ``pathCoordinates`` will be used as path nodes. Use them in your UI to make selectable objects and to attach new ``IntersectionNode``s to them.
}

public struct TrafficLight: InfrastructureType {
  public let id: UUID?
  public let pathCoordinates: [Coordinate]
  public let createdAt: Date?
  public let updatedAt: Date?
  public let deletedAt: Date?
}

public struct TrafficIsland: InfrastructureType {
  public let id: UUID?
  public let pathCoordinates: [Coordinate]
  public let createdAt: Date?
  public let updatedAt: Date?
  public let deletedAt: Date?
}

public struct ZebraCrossing: InfrastructureType {
  public let id: UUID?
  public let pathCoordinates: [Coordinate]
  public let createdAt: Date?
  public let updatedAt: Date?
  public let deletedAt: Date?
}

public struct PedestrianCrossing: InfrastructureType {
  public let id: UUID?
  public let pathCoordinates: [Coordinate]
  public let createdAt: Date?
  public let updatedAt: Date?
  public let deletedAt: Date?
}

public struct IntersectionNode: DateRepresentable,
                                IDRepresentable,
                                AdjacentInfrastructuresRepresentable,
                                CoordinateRepresentable,
                                Codable {
  public let id: UUID?
  public let coordinate: Coordinate
  public let createdAt: Date?
  public let updatedAt: Date?
  public let deletedAt: Date?
  ///
  public let adjacentInfrastructures: [String]
  ///
  public init(id: UUID? = nil,
              coordinate: Coordinate,
              createdAt: Date? = nil,
              updatedAt: Date? = nil,
              deletedAt: Date? = nil,
              adjacentInfrastructures: [String] = []) {
    self.id = id
    self.coordinate = coordinate
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.deletedAt = deletedAt
    self.adjacentInfrastructures = adjacentInfrastructures
  }
  
  public init(coordinate: Coordinate) {
    self.init(id: nil, coordinate: coordinate, createdAt: nil, updatedAt: nil, deletedAt: nil)
  }
}
