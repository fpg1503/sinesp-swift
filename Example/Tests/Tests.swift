import UIKit
import XCTest
import sinesp

class Tests: XCTestCase {
    
    func testPlateInformation() {

        let requestExpectation = expectation(description: "Async request")
        
        if let plate = Plate(plate: "ABC-1234") {
            SinespClient().information(for: plate) { (information) in
                requestExpectation.fulfill()
                guard let _info = information else {
                    XCTFail()
                    return
                }
                XCTAssertNotNil(_info.brand)
                XCTAssertNotNil(_info.chassis)
                XCTAssertNotNil(_info.city)
                XCTAssertNotNil(_info.color)
                XCTAssertNotNil(_info.date)
                XCTAssertNotNil(_info.model)
                XCTAssertNotNil(_info.modelYear)
                XCTAssertNotNil(_info.plate.letters)
                XCTAssertNotNil(_info.plate.numbers)
                XCTAssertEqual(_info.plate.letters, plate.letters)
                XCTAssertEqual(_info.plate.numbers, plate.numbers)
            }

            waitForExpectations(timeout: 30) { (error) in
                XCTAssertNil(error)
            }
        }
        
    }
    
}
