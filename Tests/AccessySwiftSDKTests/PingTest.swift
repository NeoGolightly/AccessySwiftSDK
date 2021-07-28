//
//  File.swift
//  
//
//  Created by Michael Helmbrecht on 04.07.21.
//

import Quick
import Nimble
@testable import AccessySwiftSDK

class PingSpec: QuickSpec {
  override func spec() {
    let sdk = AccessySwiftSDK.shared
    describe("AccessySDK") {
      it("will send back a 'Ping'"){
        
        waitUntil { done in
          sdk.ping { result in
            switch result {
            case .success(let value):
              expect(value) == "pong"
              done()
            case .failure(let error):
              fail(error.localizedDescription)
            }
          }
        }
      }
    }
  }
}
