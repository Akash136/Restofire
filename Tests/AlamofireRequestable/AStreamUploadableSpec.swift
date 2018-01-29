//
//  AStreamUploadableSpec.swift
//  Restofire
//
//  Created by Rahul Katariya on 27/01/18.
//  Copyright © 2018 AarKay. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofire
@testable import Restofire

class AStreamUploadableSpec: BaseSpec {

    override func spec() {
        describe("AStreamUpload") {
            
            it("request should succeed") {
                // Given
                struct Upload: AStreamUploadable {
                    var stream: InputStream = InputStream(url: BaseSpec.url(forResource: "rainbow", withExtension: "jpg"))!
                }
                
                let request = Upload().request()
                
                // When
                waitUntil(timeout: self.timeout) { done in
                    request
                        .response { response in
                            defer { done() }
                            
                            //Then
                            expect(response.request).to(beNonNil())
                            expect(response.response).to(beNonNil())
                            expect(response.data).to(beNonNil())
                            expect(response.error).to(beNil())
                    }
                }
            }
            
        }
    }
    
}

