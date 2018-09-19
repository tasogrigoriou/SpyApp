import Foundation

// The Qwerty cipher is the order of letters on the keyboard (starting from top-left corner)

// A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
// becomes...
// Q W E R T Y U I O P A S D F G H J K L Z X C V B N M

// Input must be an alpha character (A-Z or a-z)
// Secret must be an integer value and shifts input alpha character
struct QwertyCeasarCipher {
    private let startingDecimalForAlphaCode = 65
    
    // A is the letter 0 from the start of mapping...
    // after mapping, it becomes 10 (since A is the 11th letter that appears on the keyboard (from top-left corner)
    private let map: [Int : Character] = [
        0 : "Q",
        1 : "W",
        2 : "E",
        3 : "R",
        4 : "T",
        5 : "Y",
        6 : "U",
        7 : "I",
        8 : "O",
        9 : "P",
        10 : "A",
        11 : "S",
        12 : "D",
        13 : "F",
        14 : "G",
        15 : "H",
        16 : "J",
        17 : "K",
        18 : "L",
        19 : "Z",
        20 : "X",
        21 : "C",
        22 : "V",
        23 : "B",
        24 : "N",
        25 : "M"
    ]
}

extension QwertyCeasarCipher: Cipher {
    func encode(_ plainText: String, secret: String) -> String? {
        return transformText(plainText, secret: secret, codingType: .encoding)
    }
    
    func decode(_ encryptedText: String, secret: String) -> String? {
        return transformText(encryptedText, secret: secret, codingType: .decoding)
    }
    
    private func transformText(_ text: String, secret: String, codingType: CodingType) -> String? {
        guard let shiftBy = Int(secret) else { return nil }
        var transformedText = ""
        
        for char in text {
            let uppercaseChar = Character(String(char).uppercased())
            let unicode = uppercaseChar.unicodeScalars.first!
            
            // Assuming all input is an alpha character (A-Z or a-z)
            let charInt = Int(unicode.value) - startingDecimalForAlphaCode
            
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
