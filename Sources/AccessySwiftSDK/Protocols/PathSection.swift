//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 11.07.21.
//

import Foundation

///Protocol to describe objects that can be used as infrastructures (Sidewalk, Crossing,...)
public protocol PathSection: Codable, Hashable {
  /// Unique identifier created by the database
  /// >Warning: Must not created by yourself. Database takes care of it!
  var id: UUID? { get }
  /// All points that define the sidewalk path
  var pathCoordinates: [Coordinate] { get }
  /// First and last ``pathCoordinates`` will be used as path nodes. Use them in your UI to make selectable objects and to attach new ``PathSection``s to them.
  /// >Important: Only attach existing ``PathNode``s to the sidewalks ``PathSection/pathNodes`` property. Not existing path nodes will be created on the server. You retriev them from  ``AccessySwiftSDK/createSidewalk(_:completion:)``. ``pathNodes`` count **can't be greater than 2**.
  var pathNodes: [PathNode] { get }
}
