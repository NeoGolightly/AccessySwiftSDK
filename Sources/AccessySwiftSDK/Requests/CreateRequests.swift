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
  typealias ResponseType = Sidewalk
  let urlPathComponent: String = "sidewalks"
  let object: Sidewalk
}


public struct CreateSidewalkData: PathRepresentable, Codable {
  public let pathCoordinates: [Coordinate]
}

struct CreateSidewalkResponse{
  let createdSidewalk: Sidewalk
  let createdIntersectionNodes: [IntersectionNode]
}
