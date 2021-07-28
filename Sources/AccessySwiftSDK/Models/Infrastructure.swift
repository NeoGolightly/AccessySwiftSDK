//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 12.07.21.
//

import Foundation

public struct Infrastructure: Codable {
  public let sidewalks: [Sidewalk]
//  public let trafficLights: [TrafficLights]
//  public let trafficIsland: [TrafficIsland]
//  public let zebraCrossing: [ZebraCrossing]
//  public let pedestrianCrossing: [PedestrianCrossing]
//  public let pathNodes: [PathNode]
}

public struct TrafficIsland: PathSection {
  public let id: UUID?
  public let pathCoordinates: [Coordinate]
  public let pathNodes: [PathNode]
}

public struct TrafficLights: PathSection {
  public let id: UUID?
  public let pathCoordinates: [Coordinate]
  public let pathNodes: [PathNode]
}

public struct ZebraCrossing: PathSection {
  public let id: UUID?
  public let pathCoordinates: [Coordinate]
  public let pathNodes: [PathNode]
}

public struct PedestrianCrossing: PathSection {
  public let id: UUID?
  public let pathCoordinates: [Coordinate]
  public let pathNodes: [PathNode]
}


struct InfrastructureInRegionRequest: ObjectsInRegionRequest {
  typealias ModelType = Infrastructure
  let pathComponent: String = "infrastructure/region"
  var coordinateRegion: CoordinateRegion
}
