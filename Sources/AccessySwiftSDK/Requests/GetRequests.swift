//
//  File.swift
//  File
//
//  Created by Michael Helmbrecht on 29.07.21.
//

import Foundation

protocol GetRequest {
  associatedtype ResponseType: Codable
  associatedtype ParameterData: Codable
  var urlPathComponent: String { get }
  var parameterData: ParameterData? { get }
}

struct NoParameterData: Codable {}

struct CenterCoordinateRequestData: Codable{
  let latitude: Double
  let longitude: Double
  let radius: Double
}

//


struct GetAllSidewalksRequest: GetRequest {
  typealias ResponseType = [Sidewalk]
  let urlPathComponent: String = "sidewalks"
  let parameterData: NoParameterData? = nil
}

struct GetSidewalksForCenterCoordinateRequest: GetRequest {
  typealias ResponseType = [Sidewalk]
  let urlPathComponent: String = "sidewalks/withCenterCoordinate"
  var parameterData: CenterCoordinateRequestData?
}

struct GetSidewalkWithIDRequest: GetRequest {
  typealias ResponseType = Sidewalk
  private(set) var urlPathComponent: String = "sidewalks/"
  let parameterData: NoParameterData? = nil
  init(id: UUID) {
    urlPathComponent.append(contentsOf: id.uuidString)
  }
}


struct GetInfrastructureRequest: GetRequest {
  typealias ResponseType = Infrastructure
  let urlPathComponent: String = "infrastructure"
  let parameterData: NoParameterData? = nil
}


struct GetInfrastructureForCenterCoordinateRequest: GetRequest {
  typealias ResponseType = Infrastructure
  let urlPathComponent: String = "infrastructure/withCenterCoordinate"
  var parameterData: CenterCoordinateRequestData?
}



