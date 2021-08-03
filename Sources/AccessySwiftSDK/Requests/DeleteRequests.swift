//
//  File.swift
//  File
//
//  Created by Michael Helmbrecht on 29.07.21.
//

import Foundation

protocol DeleteRequest{
  associatedtype ResponseType: Codable
  var urlPathComponent: String { get }
  init(id: UUID)
}

struct DeleteSidewalkRequest: DeleteRequest {
  typealias ResponseType = Sidewalk
  private(set) var urlPathComponent: String = "sidewalks/"
  init(id: UUID) {
    urlPathComponent.append(contentsOf: id.uuidString)
  }
}
