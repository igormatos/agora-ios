import UIKit

class SignupViewController: UIViewController {
    @IBOutlet var handle: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    
    @IBAction func create(_ sender: UIButton) {
        // [FINAL] Flash red and specify error on failure
        // [FINAL] Validate all fields
        // [FINAL] Never overwrite users!!!
        guard let handle = handle.text else {return}
        guard let password = password.text else {return}
        guard let email = email.text else {return}
        
        users[handle] = User(handle: handle, password: password, email: email)
        navigationController!.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
