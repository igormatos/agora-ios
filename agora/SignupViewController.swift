import UIKit

class SignupViewController: AgoraViewController {
    @IBOutlet var handle: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    
    @IBAction func create(_ sender: UIButton) {
        // [FINAL] Flash red and specify error on failure
        // [FINAL] Validate all fields
        // [FINAL] Never overwrite users!!!
        guard let username = handle.text,
            let password = password.text,
            let email = email.text else {
                
            showAlert(title: "Algum campo está vázio", message: "Preencha todos campos")
            return
        }
        
        users[username] = User(handle: username, password: password, email: email)
        navigationController!.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickedOnReturn(_ textField: UITextField) {
        textField.resignFirstResponder() // Dismiss the keyboard

    }
}
