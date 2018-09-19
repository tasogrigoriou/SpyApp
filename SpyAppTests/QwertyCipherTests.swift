import XCTest
@testable import SpyApp

class QwertyCipherTests: XCTestCase {
    
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = QwertyCeasarCipher()
    }
    
    func test_startOfAlphabetStringGetsMappedToQwertyAlphabet() {
        let plaintext = "abcdef"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        let expectedResult = "QWERTY"
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_lastThreeLettersOfAlphabetGetsMappedToLastThreeLettersInQwertyAlphabet() {
        let plaintext = "XYZ"
        
        let result = cipher.decode(plaintext, secret: "0")
        
        let expectedResult = "BNM"
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_nonNumericInputForSecret() {
        let result = cipher.encode("ABC", secret: "nonNumericString")
        
        XCTAssertNil(result)
    }
    
    func test_encodeAndShiftByNegativeTwoPlacesWithSecret() {
        let plaintext = "abc"
        
        let result = cipher.encode(plaintext, secret: "-2")
        
        let expectedDecodedResult = "NMQ"
        
        XCTAssertEqual(result, expectedDecodedResult)
    }
    
    func test_decodeAndShiftByThreePlacesWithSecret() {
        let plaintext = "XYZ"
        
        let result = cipher.decode(plaintext, secret: "-3")
        
        let expectedDecodedResult = "QWE"
        
        XCTAssertEqual(result, expectedDecodedResult)
    }
    
}
