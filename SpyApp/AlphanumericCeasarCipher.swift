import Foundation

struct AlphanumericCeasarCipher {
    private let numberOfArithmeticNumerals = 10
    private let startingDecimalForAlphaCode = 65
    private let startingDecimalForNumericCode = 48
    
    private let map: [Int : Character] = [
        0 : "0",
        1 : "1",
        2 : "2",
        3 : "3",
        4 : "4",
        5 : "5",
        6 : "6",
        7 : "7",
        8 : "8",
        9 : "9",
        10 : "A",
        11 : "B",
        12 : "C",
        13 : "D",
        14 : "E",
        15 : "F",
        16 : "G",
        17 : "H",
        18 : "I",
        19 : "J",
        20 : "K",
        21 : "L",
        22 : "M",
        23 : "N",
        24 : "O",
        25 : "P",
        26 : "Q",
        27 : "R",
        28 : "S",
        29 : "T",
        30 : "U",
        31 : "V",
        32 : "W",
        33 : "X",
        34 : "Y",
        35 : "Z"
    ]
}

extension AlphanumericCeasarCipher: Cipher {
    func encode(_ plainText: String, secret: String) -> String? {
        return transformText(plainText, secret: secret, codingType: .encoding)
    }
    
    func decode(_ encryptedText: String, secret: String) -> String? {
        return transformText(encryptedText, secret: secret, codingType: .decoding)
    }
    
    private func transformText(_ text: String, secret: String, codingType: CodingType) -> String? {
        guard let shiftBy = Int(secret) else { return nil }
        var transformedText = ""
        let letters = CharacterSet.letters
        
        for char in text {
            let uppercaseChar = Character(String(char).uppercased())
            var charInt: Int
            let unicode = uppercaseChar.unicodeScalars.first!
            if letters.contains(unicode) {
                charInt = Int(unicode.value) - startingDecimalForAlphaCode + numberOfArithmeticNumerals
            } else {
                charInt = Int(unicode.value) - startingDecimalForNumericCode // Assumes that input will only be alphanumeric
            }
            
            var shiftedCharInt: Int
            switch codingType {
            case .encoding:
                shiftedCharInt = charInt + shiftBy
            case .decoding:
                shiftedCharInt = charInt - shiftBy
            }
            
            // Get positive modulo
            let key = ((shiftedCharInt % map.count) + map.count) % map.count
            if let newChar: Character = map[key] {
                transformedText.append(newChar)
            }
        }
        
        return transformedText
    }
}


