//
//  File.swift
//  File
//
//  Created by Michael Helmbrecht on 28.07.21.
//

import Foundation

protocol CreateRequest{
  associatedtype ModelType: Codable
  associatedtype ResponseType: Codable
  var urlPathComponent: String { get }
  var object: ModelType { get }
}

struct CreateSidewalkRequest: CreateRequest {
  typealias ModelType = Sidewalk
  typealias ResponseType = CreateSidewalkResponse
  let urlPathComponent: String = "sidewalks"
  let object: Sidewalk
}


public struct CreateSidewalkData: PathRepresentable, Codable {
  public let pathCoordinates: [Coordinate]
}

public struct CreateSidewalkResponse: Codable{
  let createdSidewalk: Sidewalk
  let createdIntersectionNodes: [IntersectionNode]
  public init(createdSidewalk: Sidewalk, createdIntersectionNodes: [IntersectionNode]) {
    self.createdSidewalk = createdSidewalk
    self.createdIntersectionNodes = createdIntersectionNodes
  }
}
