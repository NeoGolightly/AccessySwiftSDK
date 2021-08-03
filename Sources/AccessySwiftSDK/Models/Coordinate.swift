//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 13.07.21.
//

import Foundation
import MapKit



///Basic object to describe a coordinate on a map.
public struct Coordinate: Codable, Hashable {
  ///Latitude as Double
  public let latitude: Double
  ///Longitude as Double
  public let longitude: Double
  
  /// Initializes and returns a newly allocated Coordinate object with the specified latitude and longitude.
  /// - Parameters:
  ///   - latitude: The latitude in degree as Double
  ///   - longitude: The longitude in degree as Double
  public init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }
}
