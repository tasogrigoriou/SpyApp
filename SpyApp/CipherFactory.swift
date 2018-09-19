import Foundation

struct CipherFactory {
    private var ciphers: [String : Cipher] = [
        "Ceaser" : CeaserCipher(),
        "Alphanumeric" : AlphanumericCeasarCipher(),
        "Atbash" : AtbashCeasarCipher(),
        "Qwerty" : QwertyCeasarCipher()
    ]

    func cipher(for key: String) -> Cipher? {
        return ciphers[key]
    }
}
