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
    
    static var startDelegateCalled = false

    override func spec() {
        describe("AStreamUpload") {
            
            it("request should succeed") {
                // Given
                struct Upload: AStreamUploadable {
                    var path: String? = "post"
                    var stream: InputStream = InputStream(url: BaseSpec.url(forResource: "rainbow", withExtension: "jpg"))!
                    
                    func prepare(_ request: URLRequest, requestable: ARequestable) -> URLRequest {
                        var request = request
                        let header = HTTPHeaders.authorization(username: "user", password: "password")
                        header.forEach {
                            request.setValue($0.value, forHTTPHeaderField: $0.key)
                        }
                        expect(request.value(forHTTPHeaderField: "Authorization"))
                            .to(equal("Basic dXNlcjpwYXNzd29yZA=="))
                        return request
                    }
                    
                    func didSend(_ request: Request, requestable: ARequestable) {
                        expect(request.request?.value(forHTTPHeaderField: "Authorization")!)
                            .to(equal("Basic dXNlcjpwYXNzd29yZA=="))
                        AStreamUploadableSpec.startDelegateCalled = true
                    }
                    
                }
                
                let request = Upload().request
                print(request.debugDescription)
                
                expect(AStreamUploadableSpec.startDelegateCalled).to(beTrue())
                
                // When
                waitUntil(timeout: self.timeout) { done in
                    request
                        .response { response in
                            defer { done() }
                            
                            // Then
                            expect(response.request).toNot(beNil())
                            expect(response.response).toNot(beNil())
                            expect(response.data).toNot(beNil())
                            expect(response.error).to(beNil())
                    }
                }
            }
            
        }
    }
    
}

