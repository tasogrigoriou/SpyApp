import XCTest
@testable import SpyApp

class AlphanumericCipherTests: XCTestCase {
    
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = AlphanumericCeasarCipher()
    }
    
    func test_threeCharacterStringGetsMappedToUppercasedSelfWith_0_secret() {
        let plaintext = "abc"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual(plaintext.uppercased(), result)
    }
    
    func test_nonNumericInputForSecret() {
        let result = cipher.encode("bd", secret: "nonNumericString")
        
        XCTAssertNil(result)
    }
    
    func test_encodeAndShiftByThreePlacesWithSecret() {
        let plaintext = "xyz"
        
        let result = cipher.encode(plaintext, secret: "3")
        
        let expectedDecodedResult = "012"
        
        XCTAssertEqual(result, expectedDecodedResult)
    }
    
    func test_encodeAndShiftByNegativeFivePlacesWithSecret() {
        let plaintext = "ABC"
        
        let result = cipher.encode(plaintext, secret: "-5")
        
        let expectedDecodedResult = "567"
        
        XCTAssertEqual(result, expectedDecodedResult)
    }
    
    func test_decodeAndShiftByThreePlacesWithSecret() {
        let plaintext = "123"
        
        let result = cipher.decode(plaintext, secret: "3")
        
        let expectedDecodedResult = "YZ0"
        
        XCTAssertEqual(result, expectedDecodedResult)
    }
    
    func test_decodeAndShiftByNegativeFivePlacesWithSecret() {
        let plaintext = "789A"
        
        let result = cipher.decode(plaintext, secret: "-5")
        
        let expectedDecodedResult = "CDEF"
        
        XCTAssertEqual(result, expectedDecodedResult)
    }
    
    func test_encodeAndHaveLargeNumberForSecret() {
        let plaintext = "abc123"
        
        let result = cipher.encode(plaintext, secret: "5900")
        
        let expectedDecodedResult = "678XYZ"
        
        XCTAssertEqual(result, expectedDecodedResult)
    }
    
}
