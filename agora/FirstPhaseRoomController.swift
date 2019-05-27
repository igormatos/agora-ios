//
//  FirstPhaseRoomController.swift
//  agora
//
//  Created by Tarcísio Chaves Monteiro on 5/21/19.
//  Copyright © 2019 agora. All rights reserved.
//

import UIKit

class FirstPhaseRoomController: AgoraViewController {
    var code: String!
    @IBOutlet var themeLabel: UITextView!
    
    @IBAction func next(_ sender: UIButton) {
        performSegue(withIdentifier: "writetextsegue", sender: self)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTheme()
    }
    
    func setTheme() {
        guard let theme = AppSingleton.shared().loggedRoom?.theme else {
            return
        }
        
        themeLabel.text = theme
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let room = segue.destination as? WriteTextController {
            room.code = code
        }
    }
}
