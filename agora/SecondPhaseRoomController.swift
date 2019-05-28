//
//  SecondPhaseViewController.swift
//  agora
//
//  Created by Tarcísio Chaves Monteiro on 5/21/19.
//  Copyright © 2019 agora. All rights reserved.
//

import UIKit

class SecondPhaseViewController: AgoraViewController {
    var code: String!
    @IBOutlet weak var okButton: UIButton!
    
    @IBAction func next(_ sender: UIButton) {
        performSegue(withIdentifier: "gradetextsegue", sender: self)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let userId = AppSingleton.shared().loggedUser?.uid, let roomId = AppSingleton.shared().loggedRoom?.authorId else { return }
        
        FirebaseHelper.shared().waitForNextPhase(to: .mayGrade, ofUser: userId, onRoom: roomId, onError: { (String) in
            
        }) { (phase) in
            self.showAlert(title: "Pode avaliar!", message: "hihi")
            self.okButton.isEnabled = true
        }
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let room = segue.destination as? GradeTextController {
            room.code = code
        }
    }
}
