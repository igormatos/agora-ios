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

    var dbReference: DatabaseReference!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var themeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbReference = Database.database().reference().child("rooms")
    }
    
    @IBAction func createRoomClick(_ sender: UIButton) {
        guard let name = nameField.text, let theme = themeField.text, let loggedUser = AppSingleton.shared().loggedUser else {
            return
        }
        
        
        let roomId = NanoID.new(7)
        
        let room = Room(code: roomId,
                        authorId: loggedUser.uid,
                        author: loggedUser.displayName!,
                        theme: theme,
                        texts: [],
                        users: [:],
                        canJoin: true)
        
        let data = try! FirebaseEncoder().encode(room)
        
        self.dbReference.child(room.code).setValue(data)

    }
    
    @IBAction func backClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func returnClick(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
}
