import UIKit
import FirebaseAuth

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
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user else {
                self.showAlert(title: "Erro no cadastro", message: "\(error!.localizedDescription)")
                return
                
            }
            
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges { (error) in
                if error != nil {
                    return
                }
                self.navigationController!.popViewController(animated: true)
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickedOnReturn(_ textField: UITextField) {
        textField.resignFirstResponder() // Dismiss the keyboard

    }
}
