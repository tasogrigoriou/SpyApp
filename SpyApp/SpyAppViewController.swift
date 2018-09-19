import UIKit

class SpyAppViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var secret: UITextField!
    @IBOutlet weak var output: UILabel!

    let factory = CipherFactory()
    var cipher: Cipher?

    @IBAction func encodeButtonPressed(_ sender: UIButton) {
        guard let cipher = cipher else {
            output.text = "No cipher selected"
            return
        }
        if let plainText = input.text, let secret = secret.text {
            output.text = cipher.encode(plainText, secret: secret)
        } else {
            output.text = "Error encoding"
        }
    }
    
    @IBAction func decodeButtonPressed(_ sender: UIButton) {
        guard let cipher = cipher else {
            output.text = "No cipher selected"
            return
        }
        if let encryptedText = input.text, let secret = secret.text {
            output.text = cipher.decode(encryptedText, secret: secret)
        } else {
            output.text = "Error decoding"
        }
    }
    
    @IBAction func cipherButtonPressed(_ sender: UIButton) {
        if let key = sender.titleLabel?.text {
            cipher = factory.cipher(for: key)
        } else {
            output.text = "No button or no button text"
        }
    }
}
