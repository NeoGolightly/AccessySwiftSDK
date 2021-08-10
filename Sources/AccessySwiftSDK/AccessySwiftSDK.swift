//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 04.07.21.
//

import Foundation
import Alamofire


enum HttpMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}



struct CoordinateRegionParameter: Codable{
  let latitude: Double
  let longitude: Double
  let radius: Double
}

final public class AccessySwiftSDK: AccessySwiftSDKType {
 
  ///Shared instance
  public static let shared: AccessySwiftSDKType = AccessySwiftSDK()
  public static var apiVersion: String = "0.0.1-Beta"
  ///Configure the SDK
  public var configuration: AccessySKDConfiguration = AccessySKDConfiguration(enviroment: .production)
  
  private init() {}
  
  private var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }
}

extension AccessySwiftSDK {
  
  public func getInfrastructure(for centerCoordinate: Coordinate, in radius: Double, completion: @escaping (Result<Infrastructure, AccessySKDError>) -> Void ) {
    let centerCoordinateData = CenterCoordinateRequestData(latitude: centerCoordinate.longitude,
                                                           longitude: centerCoordinate.longitude,
                                                           radius: radius)
    let request = GetInfrastructureForCenterCoordinateRequest(parameterData: centerCoordinateData)
    getRequest(for: request, completion: completion)
  }
  
  public func getInfrastructure(completion: @escaping (Result<Infrastructure, AccessySKDError>) -> Void) {
    let request = GetInfrastructureRequest()
    getRequest(for: request, completion: completion)
  }
  
  @available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
  public func getInfrastructure() async throws -> Infrastructure {
    return try await withCheckedThrowingContinuation { continuation in
      getInfrastructure() { result in
        continuation.resume(with: result)
      }
    }
  }
  
}

//MARK: Sidewalks
extension AccessySwiftSDK {
  

  public func createSidewalk(_ sidewalk: Sidewalk, completion: @escaping (Result<CreateSidewalkResponse, AccessySKDError>) -> Void) {
    createRequest(for: CreateSidewalkRequest(object: sidewalk), completion: completion)
  }
  
  public func getSidewalk(id: UUID, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void) {
    
  }
  
  public func getSidewalks(ids: [UUID], completion: @escaping (Result<[Sidewalk], AccessySKDError>) -> Void) {
    
  }
  
  public func getSidewalks(for centerCoordinate: Coordinate, in radius: Double, completion: @escaping (Result<[Sidewalk], AccessySKDError>) -> Void) {
    let centerCoordinateData = CenterCoordinateRequestData(latitude: centerCoordinate.longitude,
                                                           longitude: centerCoordinate.longitude,
                                                           radius: radius)
    let request = GetSidewalksForCenterCoordinateRequest(parameterData: centerCoordinateData)
    getRequest(for: request, completion: completion)
  }
  
  public func getSidewalks(completion: @escaping (Result<[Sidewalk], AccessySKDError>) -> Void) {
    
  }
  
  public func updateSidewalk(_ sidewalk: Sidewalk, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void) {
    
  }
  
  public func deleteSidewalk(for id: UUID, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void) {
    let request = DeleteSidewalkRequest(id: id)
//    deleteRequest(for: request, completion: completion)
    deleteRequest(for: request, completion: completion)
  }
}

//MARK: Private functions
private extension AccessySwiftSDK{
  
 
  
  func getRequest<R: GetRequest>(for request: R, completion: @escaping (Result<R.ResponseType, AccessySKDError>) -> Void) {
    guard let url = URL(string: configuration.baseURL) else { completion(.failure(.wrongBaseURL)); return }

    let requestURL = url.appendingPathComponent(request.urlPathComponent)

    AF.request(requestURL,
               method: .get,
               parameters: request.parameterData,
               encoder: URLEncodedFormParameterEncoder.default)
      .responseDecodable(of: R.ResponseType.self, decoder: decoder) { response in
        switch response.result {
        case .success(let responseObject):
          completion(.success(responseObject))
        case .failure:
          guard let data = response.data else { completion(.failure(.noData)); return }
          do {
            let serverError = try JSONDecoder().decode(ResponseError.self, from: data)
            completion(.failure(AccessySKDError.responseError(response.response!.statusCode, serverError.reason))); return
          } catch {
            completion(.failure(.jsonDecodingError))
          }
          
        }
      }
  }
  
  func createRequest<R: CreateRequest>(for request: R, completion: @escaping (Result<R.ResponseType, AccessySKDError>) -> Void) {
    guard let url = URL(string: configuration.baseURL) else { completion(.failure(.wrongBaseURL)); return }

    let requestURL = url.appendingPathComponent(request.urlPathComponent)

    AF.request(requestURL,
               method: .post,
               parameters: request.object,
               encoder: JSONParameterEncoder.default)
      .responseDecodable(of: R.ResponseType.self, decoder: decoder) { response in
        switch response.result {
        case .success(let responseObject):
          completion(.success(responseObject))
        case .failure:
          guard let data = response.data else { completion(.failure(.noData)); return }
          do {
            let serverError = try JSONDecoder().decode(ResponseError.self, from: data)
            completion(.failure(AccessySKDError.responseError(response.response!.statusCode, serverError.reason))); return
          } catch {
            completion(.failure(.jsonDecodingError))
          }
          
        }
      }
  }
  
  func deleteRequest<R: DeleteRequest>(for request: R, completion: @escaping (Result<R.ResponseType, AccessySKDError>) -> Void) {
    guard let url = URL(string: configuration.baseURL) else { completion(.failure(.wrongBaseURL)); return }

    let requestURL = url.appendingPathComponent(request.urlPathComponent)

    AF.request(requestURL,
               method: .delete)
      .responseDecodable(of: R.ResponseType.self, decoder: decoder) { response in
        switch response.result {
        case .success(let responseObject):
          completion(.success(responseObject))
        case .failure:
          guard let data = response.data else { completion(.failure(.noData)); return }
          do {
            let serverError = try JSONDecoder().decode(ResponseError.self, from: data)
            completion(.failure(AccessySKDError.responseError(response.response!.statusCode, serverError.reason))); return
          } catch {
            completion(.failure(.jsonDecodingError))
          }
          
        }
      }
  }
}


//MARK: PING
extension AccessySwiftSDK{
  public func ping(completion: @escaping (Result<String, AccessySKDError>) -> Void) {
    guard let url = URL(string: configuration.baseURL) else {
      completion(.failure(AccessySKDError.wrongBaseURL))
      return
    }
    
    let resourceURL = url.appendingPathComponent("ping")
    
    let task = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
      
      if let error = error {
        print("error: \(error)")
        completion(.failure(.some(error)))
      }
      guard let stringData = data else { completion(.failure(.noData)); return}
      
      if let pong = String(data: stringData, encoding: .utf8) {
        completion(.success(pong))
      } else {
        completion(.failure(.stringDecodingError))
      }
    }
    
    task.resume()
  }
}
