//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 11.07.21.
//

import Foundation

public protocol AccessySwiftSDKType {
  static var shared: AccessySwiftSDKType { get }
  static var apiVersion: String { get }
  var configuration: AccessySKDConfiguration { get set}
  
  ///Receive all infrastructure objects around the center coordinate with specified radius.
  /// - Parameters:
  ///   - centerCoordinate: Center coordinate for the region
  ///   - radius: Radius around the center coordinate for the region
  ///   - completion: Closure returning a Result type with the fetched ``Infrastructure`` object or an ``AccessySKDError``
  func getInfrastructure(for centerCoordinate: Coordinate, in radius: Double, completion: @escaping (Result<Infrastructure, AccessySKDError>) -> Void)
  
  ///Receive all infrastructure objects
  /// - Parameters:
  ///   - completion: Closure returning a Result type with the fetched ``Infrastructure`` object or an ``AccessySKDError``
  func getInfrastructure(completion: @escaping (Result<Infrastructure, AccessySKDError>) -> Void)
  @available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
  func getInfrastructure() async throws -> Infrastructure
  ///Create sidewalk in database
  ///
  /// Use this method to create new ``Sidewalk`` in the database.
  /// >Important: Only attach existing ``PathNode``s to the sidewalks ``Sidewalk/pathNodes`` property. Not existing path nodes will be created on the server. You retriev them from  ``createSidewalk(_:completion:)``
  ///
  /// - Parameters:
  ///   - sidewalk: the ``Sidewalk`` object you want to create. ``Sidewalk/id``, ``Sidewalk/createdAt``, ``Sidewalk/updatedAt`` and ``Sidewalk/deletedAt`` will be ignored.
  ///   - completion: completion handler with created ``Sidewalk`` or ``AccessySKDError``
  func createSidewalk(_ sidewalk: Sidewalk, completion: @escaping (Result<CreateSidewalkResponse, AccessySKDError>) -> Void)
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
  func deleteSidewalk(for id: UUID, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void)
  //Ping
  func ping(completion: @escaping (Result<String, AccessySKDError>) -> Void)
}
