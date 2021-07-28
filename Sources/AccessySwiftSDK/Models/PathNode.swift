//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 11.07.21.
//

import Foundation

public struct PathNode: Codable, Hashable{
  /// Unique identifier created by the database
  /// >Warning: Must not created by yourself. Database takes care of it!
  public let id: UUID?
  ///``Coordinate`` for the path node.
  public let coordinate: Coordinate
  
  public init(id: UUID? = nil, coordinate: Coordinate){
    self.id = id
    self.coordinate = coordinate
  }
}
