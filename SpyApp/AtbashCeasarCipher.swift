import Foundation

// The Atbash cipher is the alphabet backwards. For example, A would become Z.

// A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
// maps to...
// Z Y X W V U T S R Q P O N M L K J I H G F E D C B A

// Input must be an alpha character (A-Z or a-z)
// Secret must be an integer value and shifts input alpha character
struct AtbashCeasarCipher {
    private let startingDecimalForAlphaCode = 65

    private let map: [Int : Character] = [
        0 : "Z",
        1 : "Y",
        2 : "X",
        3 : "W",
        4 : "V",
        5 : "U",
        6 : "T",
        7 : "S",
        8 : "R",
        9 : "Q",
        10 : "P",
        11 : "O",
        12 : "N",
        13 : "M",
        14 : "L",
        15 : "K",
        16 : "J",
        17 : "I",
        18 : "H",
        19 : "G",
        20 : "F",
        21 : "E",
        22 : "D",
        23 : "C",
        24 : "B",
        25 : "A"
    ]
}

extension AtbashCeasarCipher: Cipher {
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
