import Foundation

protocol Cipher {
    func encode(_ plainText: String, secret: String) -> String?
    func decode(_ encryptedText: String, secret: String) -> String?
}

enum CodingType {
    case encoding
    case decoding
}
