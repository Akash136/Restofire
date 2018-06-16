//
//  DownloadableSpec.swift
//  Restofire
//
//  Created by Rahul Katariya on 29/01/18.
//  Copyright © 2015-present Restofire. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofire
@testable import Restofire

class DownloadableSpec: BaseSpec {
    
    static var successDelegateCalled = false
    static var errorDelegateCalled = false
    
    override func spec() {
        describe("Downloadable") {
            
            it("request should succeed") {
                // Given
                struct HTTPBin: Decodable {
                    let url: URL
                }
                
                waitUntil(timeout: self.timeout) { done in
                    struct Request: Downloadable {
                        typealias Response = HTTPBin
                        
                        var path: String? = "get"
                        var destination: DownloadFileDestination? = { _, _ in (BaseSpec.jsonFileURL, []) }
                        
                        var responseSerializer: DownloadResponseSerializer<HTTPBin> = DownloadRequest.JSONDecodableResponseSerializer()
                        
                        func request(_ request: DownloadOperation<Request>, didCompleteWithValue value: HTTPBin) {
                            print("Completed")
                            DownloadableSpec.successDelegateCalled = true
                            expect(value.url.absoluteString).to(equal("https://httpbin.org/get"))
                        }
                        
                        func request(_ request: DownloadOperation<Request>, didFailWithError error: Error) {
                            DownloadableSpec.errorDelegateCalled = true
                            fail(error.localizedDescription)
                        }
                    }
                    
                    let request = Request()
                    
                    // When
                    let operation = request.execute { response in
                        
                        // Then
                        if let statusCode = response.response?.statusCode,
                            statusCode != 200 {
                            fail("Response status code should be 200")
                        }
                        
                        expect(response.request).toNot(beNil())
                        expect(response.response).toNot(beNil())
                        expect(response.destinationURL).toNot(beNil())
                        expect(response.resumeData).to(beNil())
                        expect(response.error).to(beNil())
                    }
                    
                    operation.completionBlock = {
                        expect(DownloadableSpec.successDelegateCalled).to(beTrue())
                        expect(DownloadableSpec.errorDelegateCalled).to(beFalse())
                        done()
                    }
                }
            }
            
        }
    }
    
}


