//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 11.07.21.
//

import Foundation

public enum AccessySKDEnviroment{
  case testing, development, staging, production, custom(String)
}

public struct AccessySKDConfiguration{
  public let enviroment: AccessySKDEnviroment
  internal var baseURL: String {
    switch enviroment {
    case .testing:
      return "http://0.0.0.0:7070/api/"
    case .development:
      return "http://0.0.0.0:7070/api/"
    case .production:
      return "http://162.55.217.142:8080/api/"
    case .staging:
      return "http://162.55.217.142:8080/api/"
    case .custom(let customURL):
      return customURL
    }
  }
  
  public init(enviroment: AccessySKDEnviroment) {
    self.enviroment = enviroment
  }
}
