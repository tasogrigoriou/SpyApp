import XCTest
@testable import SpyApp

class AtbashCipherTests: XCTestCase {
    
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = AtbashCeasarCipher()
    }
    
    func test_threeCharStringGetsMappedToReversedAlphabet() {
        let plaintext = "abc"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        let expectedResult = "ZYX"
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_nonNumericInputForSecret() {
        let result = cipher.encode("bddweh", secret: "nonNumericString")
        
        XCTAssertNil(result)
    }
    
    func test_encodeAndShiftByNegativeThreePlacesWithSecret() {
        let plaintext = "xyz"
        
        let result = cipher.encode(plaintext, secret: "-3")
        
        let expectedDecodedResult = "FED"
        
        XCTAssertEqual(result, expectedDecodedResult)
    }
    
    func test_decodeAndShiftByThreePlacesWithSecret() {
        let plaintext = "XYZ"
        
        let result = cipher.decode(plaintext, secret: "3")
        
        let expectedDecodedResult = "FED"
        
        XCTAssertEqual(result, expectedDecodedResult)
    }
    
    func test_decodeAndShiftByNegativeFivePlacesWithSecret() {
        let plaintext = "YZA"
        
        let result = cipher.decode(plaintext, secret: "-5")
        
        let expectedDecodedResult = "WVU"
        
        XCTAssertEqual(result, expectedDecodedResult)
    }
    
    func test_encodeAndHaveNegativeNumberForSecret() {
        let plaintext = "abc"
        
        let result = cipher.encode(plaintext, secret: "-59")
        
        let expectedDecodedResult = "GFE"
        
        XCTAssertEqual(result, expectedDecodedResult)
    }
    
    func test_decodeAndHaveLargeNegativeNumberForSecret() {
        let plaintext = "abc"
        
        let result = cipher.decode(plaintext, secret: "-3000")
        
        let expectedDecodedResult = "PON"
        
        XCTAssertEqual(result, expectedDecodedResult)
    }
    
}
