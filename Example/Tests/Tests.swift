import UIKit
import XCTest
import sinesp

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        let expectation = expectationWithDescription("Request")

        if let plate = Plate(plate: "ABC1234") {
            SinespClient().information(for: plate) { (info) in
                print(info)
                expectation.fulfill()
            }
        }
        waitForExpectationsWithTimeout(30, handler: nil)
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
