import UIKit

class SignupViewController: UIViewController {
    @IBOutlet var handle: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBAction func createAccount(_ sender: Any) {
        performSegue(withIdentifier: "signupsegue", sender: self)
    }
    
    @IBAction func login(_ sender: Any) {
        // [FINAL] go RED and display message if login is incorrect
        guard let handle = handle.text else {return}
        guard let userInDatabase = users[handle] else {return}
        guard userInDatabase.password == password.text else {return}
        
        performSegue(withIdentifier: "loggedinsegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
