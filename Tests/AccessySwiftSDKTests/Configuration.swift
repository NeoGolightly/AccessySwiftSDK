//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 11.07.21.
//

import Foundation
@testable import AccessySwiftSDK
import CoreLocation


class AccessySwiftSDKStub: AccessySwiftSDKType {
  func getInfrastructure(for centerCoordinate: Coordinate, in radius: Double) async throws -> Infrastructure {
    Infrastructure()
  }
  
  func getInfrastructure(for centerCoordinate: Coordinate, in radius: Double, completion: @escaping (Result<Infrastructure, AccessySKDError>) -> Void) {
    
  }
  
  func getInfrastructure(completion: @escaping (Result<Infrastructure, AccessySKDError>) -> Void) {
    
  }
  
  func getInfrastructure() async throws -> Infrastructure {
    Infrastructure()
  }
  
  func getSidewalk(id: UUID, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void) {
    
  }
  
  func getSidewalks(ids: [UUID], completion: @escaping (Result<[Sidewalk], AccessySKDError>) -> Void) {
    
  }
  
  func getSidewalks(for centerCoordinate: Coordinate, in radius: Double, completion: @escaping (Result<[Sidewalk], AccessySKDError>) -> Void) {
    
  }
  
  func getSidewalks(completion: @escaping (Result<[Sidewalk], AccessySKDError>) -> Void) {
    
  }
  
  func updateSidewalk(_ sidewalk: Sidewalk, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void) {
    
  }
  
  func deleteSidewalk(for id: UUID, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void) {

  }
  
  static let shared: AccessySwiftSDKType = AccessySwiftSDKStub()
  static var apiVersion: String = ""
  var configuration: AccessySKDConfiguration = AccessySKDConfiguration(enviroment: .testing)
  
  func createSidewalk(_ sidewalk: Sidewalk, completion: @escaping (Result<CreateSidewalkResponse, AccessySKDError>) -> Void) {
    completion(.success(CreateSidewalkResponse(createdSidewalk: sidewalk, createdIntersectionNodes: [])))
  }
  
  func ping(completion: @escaping (Result<String, AccessySKDError>) -> Void) {
    completion(.success("pong"))
  }
  
  
}

extension Sidewalk {
  static func mock() -> Sidewalk {
    Sidewalk(pathCoordinates: [.mockCoordinate1(), .mockCoordinate2()])
  }
}


extension Coordinate {
  static func mockCoordinate1() -> Coordinate {
    Coordinate(latitude: 51.909575619490916,
               longitude: 10.42622633681657)
  }
  
  static  func mockCoordinate2() -> Coordinate {
    Coordinate(latitude: 51.909465831118,
               longitude: 10.426269308514238)
  }
}
