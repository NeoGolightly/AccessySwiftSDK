//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 11.07.21.
//

import Foundation

public protocol AccessySwiftSDKType {
  static var shared: AccessySwiftSDKType { get }
  var configuration: AccessySKDConfiguration { get set}
  //Infrastructure
  func getInfrastructure(for coordinate: Coordinate, in radius: Double, completion: @escaping (Result<Infrastructure, AccessySKDError>) -> Void)
  
  //Sidewalks
  ///Create sidewalk in database
  ///
  /// Use this method to create new ``Sidewalk`` in the database.
  /// >Important: Only attach existing ``PathNode``s to the sidewalks ``Sidewalk/pathNodes`` property. Not existing path nodes will be created on the server. You retriev them from  ``createSidewalk(_:completion:)``
  ///
  /// - Parameters:
  ///   - sidewalk: the ``Sidewalk`` object you want to create
  ///   - completion: completion handler with created ``Sidewalk`` or ``AccessySKDError``
  func createSidewalk(_ sidewalk: Sidewalk, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void)
  ///Get sidewalk from database with corresponding id
  func getSidewalk(id: UUID, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void)
  ///Get all sidewalks from database with corresponding ids
  func getSidewalks(ids: [UUID], completion: @escaping (Result<[Sidewalk], AccessySKDError>) -> Void)
  ///Get all sidewalks from database within a certain radius
  func getSidewalks(for centerCoordinate: Coordinate, in radius: Double, completion: @escaping (Result<[Sidewalk], AccessySKDError>) -> Void)
  ///Get all sidewalks from database
  func getSidewalks(completion: @escaping (Result<[Sidewalk], AccessySKDError>) -> Void)
  ///Update sidewalk in database
  func updateSidewalk(_ sidewalk: Sidewalk, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void)
  ///Delete sidewalk from database
  func deleteSidewalk(_ sidewalk: Sidewalk, completion: @escaping (Result<Bool, AccessySKDError>) -> Void)
  //Ping
  func ping(completion: @escaping (Result<String, AccessySKDError>) -> Void)
}
