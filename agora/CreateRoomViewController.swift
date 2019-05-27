//
//  CreateRoomViewController.swift
//  agora
//
//  Created by Igor Matos  on 5/26/19.
//  Copyright © 2019 agora. All rights reserved.
//

import UIKit

import FirebaseDatabase
import CodableFirebase

class CreateRoomViewController: AgoraViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var themeField: UITextField!
    var firebaseHelper: FirebaseHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseHelper = FirebaseHelper.shared()
    }
    
    @IBAction func createRoomClick(_ sender: UIButton) {
        guard let name = nameField.text, let theme = themeField.text, let loggedUser = AppSingleton.shared().loggedUser else {
            return
        }
        
        let room = Classroom(name: name,
                             authorId: loggedUser.uid,
                             author: loggedUser.displayName!,
                             theme: theme)

        firebaseHelper.createClassroom(classroom: room, onError: { error in
            self.showAlert(title: "Problema ao criar a sala", message: "\(error)")
        }, onSuccess: {
            self.performSegue(withIdentifier: "getcodesegue", sender: self)
        })
        
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func returnClick(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
}
