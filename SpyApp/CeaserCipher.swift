import Foundation

struct CeaserCipher: Cipher {
    func encode(_ plainText: String, secret: String) -> String? {
        return transformText(plainText, secret: secret, codingType: .encoding)
    }

    func decode(_ encryptedText: String, secret: String) -> String? {
        return transformText(encryptedText, secret: secret, codingType: .decoding)
    }
    
    private func transformText(_ text: String, secret: String, codingType: CodingType) -> String? {
        guard let shiftBy = UInt32(secret) else { return nil }
        var transformedText = ""
        
        for character in text {
            if let unicode = character.unicodeScalars.first?.value {
                var shiftedUnicode: UInt32
                switch codingType {
                case .encoding:
                    shiftedUnicode = unicode + shiftBy
                case .decoding:
                    let shifted = Int(unicode) - Int(shiftBy)
                    if shifted >= 0 {
                        shiftedUnicode = UInt32(shifted)
                    } else {
                        return nil
                    }
                }
                if shiftedUnicode <= UInt8.max {
                    let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
                    transformedText = transformedText + shiftedCharacter
                }
            }
        }
        
        return transformedText
    }
}
