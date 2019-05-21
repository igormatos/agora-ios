//
//  FirstPhaseRoomController.swift
//  agora
//
//  Created by Tarcísio Chaves Monteiro on 5/21/19.
//  Copyright © 2019 agora. All rights reserved.
//

import UIKit

class FirstPhaseRoomController: UIViewController {
    var code: String!
    @IBOutlet var theme: UITextView!
    
    @IBAction func next(_ sender: UIButton) {
        performSegue(withIdentifier: "writetextsegue", sender: self)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let code = code else {return}
        guard let roomTheme = rooms[code]?.theme else {return}
        
        theme.text = roomTheme
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let room = segue.destination as? WriteTextController {
            room.code = code
        }
    }
}
