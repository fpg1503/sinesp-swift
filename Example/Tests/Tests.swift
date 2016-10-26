import UIKit
import XCTest
import sinesp

class Tests: XCTestCase {
    //TODO
    
    func testTest() {
        let _expectation = expectationWithDescription("Async")
        
        let plate = Plate(plate: "ABC-1234")
    
        let client = SinespClient()
        client.information(for: plate!) { (info) in
            print("Info: \(info)")
            _expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(30, handler: nil)
    }
}
