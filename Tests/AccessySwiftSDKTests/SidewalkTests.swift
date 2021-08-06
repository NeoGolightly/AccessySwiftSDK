//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 11.07.21.
//

import Quick
import Nimble
@testable import AccessySwiftSDK

class SidewalksSpec: QuickSpec {
  override func spec() {
    var sdk = AccessySwiftSDK.shared
    sdk.configuration = AccessySKDConfiguration(enviroment: .testing)
    
    
    describe("A Sidewalk") {
      let sidewalk = Sidewalk.mock()
      
      context("can be created") {
        it("it returns a Sidewalk with uuid and nodes set"){
          var createdSidewalkResult: Result<CreateSidewalkResponse, AccessySKDError>?
          sdk.createSidewalk(sidewalk, completion: { result in
            createdSidewalkResult = result
          })
          expect(createdSidewalkResult).toEventuallyNot(beNil(), timeout: .seconds(10))
          expect(createdSidewalkResult).toEventually(beSuccess(test: { createdSidewalkResponse in
            expect(createdSidewalkResponse.createdSidewalk.id).toNot(beNil())
            expect(createdSidewalkResponse.createdSidewalk.pathCoordinates.count).to(equal(2))
            sdk.deleteSidewalk(for: try! createdSidewalkResponse.createdSidewalk.id!) { result in
              print("deleted?: \(result)")
            }
          }), timeout: .seconds(10))
          
          
        }
      }
    }
  }
}
