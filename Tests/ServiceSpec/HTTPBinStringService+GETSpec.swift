//     _____                  ____  __.
//    /  _  \ _____ _______  |    |/ _|____  ___.__.
//   /  /_\  \\__  \\_  __ \ |      < \__  \<   |  |
//  /    |    \/ __ \|  | \/ |    |  \ / __ \\___  |
//  \____|__  (____  /__|    |____|__ (____  / ____|
//          \/     \/                \/    \/\/
//
//  Copyright (c) 2016 RahulKatariya. All rights reserved.
//

import Quick
import Nimble
import Alamofire

class HTTPBinStringGETServiceSpec: ServiceSpec {

    override func spec() {
        describe("HTTPBinStringGETService") {

            it("should succeed") {

                let actual = "Rahul Katariya"
                var expected: String!

                let service = HTTPBinStringGETService(parameters: ["name": "Rahul Katariya"])
                service.executeTask() {
                    if let response = $0.result.value as? [String: AnyObject], value = response["name"] as? String {
                        expected = value
                    }
                }

                expect(expected).toEventually(equal(actual), timeout: self.timeout, pollInterval: self.pollInterval)

            }
        }
    }

}
