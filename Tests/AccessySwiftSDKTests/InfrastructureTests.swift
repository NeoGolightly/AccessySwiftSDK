//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 11.07.21.
//

import Quick
import Nimble
@testable import AccessySwiftSDK

class InfrastructureSpec: QuickSpec {
  override func spec() {
    var sdk = AccessySwiftSDK.shared
    sdk.configuration = AccessySKDConfiguration(enviroment: .testing)
    

    describe("An Infrastructure") {
      let coordinate = Coordinate(latitude: 51.909575619490916, longitude: 10.426226336816571)
      
      context("can be fetched") {
        it("an returns an empty infrastructure"){
          var searchInfrastructureResult: Result<Infrastructure, AccessySKDError>?
          sdk.getInfrastructure(for: coordinate, in: 1000) { result in
            searchInfrastructureResult = result
          }
          expect(searchInfrastructureResult).toEventuallyNot(beNil(),timeout: .seconds(10))
          expect(searchInfrastructureResult).toEventually(beSuccess(test: { infrastructure in
            expect(infrastructure.sidewalks).to(beEmpty())
          }))
        }
      }
    }
  }
}
