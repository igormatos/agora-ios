//
//  ThirdPhaseRoomController.swift
//  agora
//
//  Created by Tarcísio Chaves Monteiro on 5/21/19.
//  Copyright © 2019 agora. All rights reserved.
//

import UIKit

class ThirdPhaseRoomController: UIViewController {
    var code: String!
    @IBOutlet var fragment: UITextView!
    @IBAction func goBack(_ sender: UIButton) {
        presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fragment.text = "Aguarde.."
        
        guard let userId = AppSingleton.shared().loggedUser?.uid, let roomId = AppSingleton.shared().loggedRoom?.code else {return}

        FirebaseHelper.shared().waitForNextPhase(to: 2, ofUser: userId, onRoom: roomId, onError: { error in
            //
        }) { classroom in
            AppSingleton.shared().loggedRoom = classroom
            
            guard let globalConsensus = classroom.globalConsensus else { return }
            
            self.fragment.text = globalConsensus.entryId
        }
        
        
//        "\"\(rooms[code]!.highlightedText)\""
    }
    
}
