import UIKit
import FirebaseAuth

class LoginViewController: AgoraViewController {
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    var authHandle: AuthStateDidChangeListenerHandle?
    
    
    @IBAction func createAccount(_ sender: Any) {
        performSegue(withIdentifier: "signupsegue", sender: self)
    }
    
    @IBAction func login(_ sender: Any) {
        doLogin()
    }
       
    func doLogin() {
        guard let email = usernameField.text, let password = passwordField.text else {
            showAlert(title: "Preencha todos campos", message: "Verifique se todos campos foram escritos")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (auth, error) in
            if let errorMessage = error {
                self.showAlert(title: "Falha no login", message: errorMessage.localizedDescription)
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        passwordField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        authHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let user = user else { return }
            
            AppSingleton.shared().loggedUser = user

            self.performSegue(withIdentifier: "loggedinsegue", sender: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(authHandle!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        
        doLogin()
        return true
    }
    
}
