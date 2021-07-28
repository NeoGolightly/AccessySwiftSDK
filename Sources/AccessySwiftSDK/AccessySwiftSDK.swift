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

protocol CreateRequest{
  associatedtype ModelType: Codable
  var pathComponent: String { get }
  var object: ModelType { get }
}

struct CoordinateRegionParameter: Codable{
  let latitude: Double
  let longitude: Double
  let radius: Double
}

struct ResponseError: Codable {
  let error: Bool
  let reason: String
}


final public class AccessySwiftSDK: AccessySwiftSDKType {
 
  ///Shared instance
  public static let shared: AccessySwiftSDKType = AccessySwiftSDK()
  ///Configure the SDK
  public var configuration: AccessySKDConfiguration = AccessySKDConfiguration(enviroment: .production)
  
  private init() {}
}

extension AccessySwiftSDK {
  public func getInfrastructure(for coordinate: Coordinate, in radius: Double, completion: @escaping (Result<Infrastructure, AccessySKDError>) -> Void ){
    guard let url = URL(string: configuration.baseURL) else { completion(.failure(.wrongBaseURL)); return }
    let request = InfrastructureInRegionRequest(coordinateRegion: CoordinateRegion(latitude: coordinate.longitude,
                                                                                   longitude: coordinate.longitude,
                                                                                   radius: radius))
    let requestURL = url.appendingPathComponent(request.pathComponent)
    
    AF.request(requestURL,
               method: .get,
               parameters: CoordinateRegionParameter(latitude: coordinate.latitude, longitude: coordinate.longitude, radius: radius),
               encoder: URLEncodedFormParameterEncoder.default)
      
      .responseDecodable(of: Infrastructure.self) { response in
        print(response)
        switch response.result {
        case .success(let infrastructure):
          completion(.success(infrastructure))
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

//MARK: Sidewalks
extension AccessySwiftSDK {
  

  public func createSidewalk(_ sidewalk: Sidewalk, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void) {
    createObject(for: SidewalkCreateRequest(object: sidewalk), completion: completion)
  }
  
  public func getSidewalk(id: UUID, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void) {
    
  }
  
  public func getSidewalks(ids: [UUID], completion: @escaping (Result<[Sidewalk], AccessySKDError>) -> Void) {
    
  }
  
  public func getSidewalks(for centerCoordinate: Coordinate, in radius: Double, completion: @escaping (Result<[Sidewalk], AccessySKDError>) -> Void) {
    
  }
  
  public func getSidewalks(completion: @escaping (Result<[Sidewalk], AccessySKDError>) -> Void) {
    
  }
  
  public func updateSidewalk(_ sidewalk: Sidewalk, completion: @escaping (Result<Sidewalk, AccessySKDError>) -> Void) {
    
  }
  
  public func deleteSidewalk(_ sidewalk: Sidewalk, completion: @escaping (Result<Bool, AccessySKDError>) -> Void) {
    
  }
}

private extension AccessySwiftSDK{
  
  func getObjectForCoordinate<R: ObjectsInRegionRequest>( for request: R, completion: @escaping (Result<R.ModelType, AccessySKDError>) -> Void) {
    guard let url = URL(string: configuration.baseURL) else { completion(.failure(.wrongBaseURL)); return }
    let resourceURL = url.appendingPathComponent(request.pathComponent)
    var urlRequest = URLRequest(url: resourceURL)
    urlRequest.httpMethod = "GET"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    print(urlRequest)
    do {
      let jsonData = try JSONEncoder().encode(request.coordinateRegion)
      urlRequest.httpBody = jsonData
    } catch {
      completion(.failure(.jsonEncodingError))
    }
    let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      if let error = error {
        completion(.failure(.some(error)))
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        print("No valid response")
        return
      }
      
      guard 200 ..< 300 ~= httpResponse.statusCode else {
        completion(.failure(AccessySKDError.responseError(httpResponse.statusCode)))
        return
      }
      
      
      guard let data = data else { completion(.failure(.noData)); return}
      do{
        let objects = try JSONDecoder().decode(R.ModelType.self, from: data)
        completion(.success(objects))
      }catch {
        completion(.failure(.jsonDecodingError))
      }
    }
    
    task.resume()
    
  }
  
  func createObject<R: CreateRequest>(for request: R, completion: @escaping (Result<R.ModelType, AccessySKDError>) -> Void) {
    
    var urlRequest: URLRequest?
    do {
      urlRequest = try createPostRequest(request: request)
    } catch let error as AccessySKDError { completion(.failure(error)) } catch {}
    
    guard let urlRequest = urlRequest else { completion(.failure(.noURLRequest)); return }

    let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      if let error = error {
        completion(.failure(.some(error)))
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        print("No valid response")
        return
      }
      
      guard 200 ..< 300 ~= httpResponse.statusCode else {
        completion(.failure(AccessySKDError.responseError(httpResponse.statusCode)))
        return
      }
      
      
      guard let data = data else { completion(.failure(.noData)); return}
      do{
        let object = try JSONDecoder().decode(R.ModelType.self, from: data)
        completion(.success(object))
      }catch {
        completion(.failure(.jsonDecodingError))
      }
    }
    
    task.resume()
  }
  
  func createPostRequest<R: CreateRequest>(request: R) throws -> URLRequest {
    guard let url = URL(string: configuration.baseURL) else {
      throw AccessySKDError.wrongBaseURL
    }
    let resourceURL = url.appendingPathComponent(request.pathComponent)
    var urlRequest = URLRequest(url: resourceURL)
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    do {
      let jsonData = try JSONEncoder().encode(request.object)
      urlRequest.httpBody = jsonData
    } catch {
      throw AccessySKDError.jsonDecodingError
    }
    
    return urlRequest
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
