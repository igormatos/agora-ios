//
//  UserViewController.swift
//  agora
//
//  Created by Tarcisio Chaves Monteiro on 16/05/19.
//  Copyright © 2019 Tarcisio Chaves Monteiro. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet var code: UITextField!
    
    @IBAction func logout(_ sender: UIButton) {
        activeUser = nil
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createRoom(_ sender: UIButton) {
        performSegue(withIdentifier: "joinasteachersegue", sender: self)
    }
    
    @IBAction func join(_ sender: UIButton) {
        guard let code = code.text else {return}
        guard rooms[code] != nil else {return}
        
        guard activeUser != nil else {return}
        if rooms[code]?.users[activeUser!] == nil {
            rooms[code]?.users[activeUser!] = Phase.justJoined
        }
        
        performSegue(withIdentifier: "joinasstudentsegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let room = segue.destination as? FirstPhaseRoomController {
            room.code = code.text!
        }
    }
    @IBAction func clickOnReturn(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
