//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 13.07.21.
//

import Foundation
import MapKit


///Basic object to describe a location on a map.
public struct Coordinate: Codable, Hashable {
  ///Latitude as Double
  public let latitude: Double
  ///Longitude as Double
  public let longitude: Double
  
  public init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }
}


protocol ObjectsInRegionRequest{
  associatedtype ModelType: Codable
  var pathComponent: String { get }
  var coordinateRegion: CoordinateRegion { get }
}

struct CoordinateRegion: Codable{
  let latitude: Double
  let longitude: Double
  let radius: Double
}
