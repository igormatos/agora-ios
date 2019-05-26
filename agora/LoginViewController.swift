import UIKit

class LoginViewController: AgoraViewController {
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBAction func createAccount(_ sender: Any) {
        performSegue(withIdentifier: "signupsegue", sender: self)
    }
    
    @IBAction func login(_ sender: Any) {
        // [FINAL] go RED and display message if login is incorrect
        doLogin()
    }
       
    func doLogin() {
        guard let username = usernameField.text, let password = passwordField.text else {
            showAlert(title: "Preencha todos campos", message: "Verifique se todos campos foram escritos")
            return
        }
        
        guard let userInDatabase = users[username], userInDatabase.password == password else {
            showAlert(title: "Dados incorretos", message: "Verifique as informações")
            return
        }
        
        activeUser = username
        performSegue(withIdentifier: "loggedinsegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        passwordField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        
        doLogin()
        return true
    }
    
}
