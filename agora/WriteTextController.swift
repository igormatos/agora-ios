//
//  WriteTextController.swift
//  agora
//
//  Created by Tarcísio Chaves Monteiro on 5/21/19.
//  Copyright © 2019 agora. All rights reserved.
//

import UIKit

class WriteTextController: AgoraViewController {
    var code: String!
    
    @IBOutlet var textTitle: UITextView!
    @IBOutlet var textBody: UITextView!
    
    @IBAction func send(_ sender: UIButton) {
        guard let user = AppSingleton.shared().loggedUser, let name = user.displayName, let room = AppSingleton.shared().loggedRoom else { return }
        
        let text = Text(author: name, authorId: user.uid, body: textBody.text, theme: textTitle.text)
        
        FirebaseHelper.shared().send(text: text, toRoom: room.code, onError: { error in
            self.showAlert(title: "Erro ao enviar o artigo", message: error)
        }) {
            self.performSegue(withIdentifier: "secondphasesegue", sender: self)
        }
        

    }
    @IBAction func close(_ sender: UIButton) {
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let room = segue.destination as? SecondPhaseViewController {
            room.code = code
        }
    }

}
