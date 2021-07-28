//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 11.07.21.
//

import Foundation

public enum AccessySKDError: Error {
  case wrongBaseURL
  case noData
  case jsonDecodingError
  case jsonEncodingError
  case stringDecodingError
  case noURLRequest
  case some(Error)
  case responseError(Int)
  case responseError(Int, String)
}
