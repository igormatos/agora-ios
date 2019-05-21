//
//  SecondPhaseViewController.swift
//  agora
//
//  Created by Tarcísio Chaves Monteiro on 5/21/19.
//  Copyright © 2019 agora. All rights reserved.
//

import UIKit

class SecondPhaseViewController: UIViewController {
    var code: String!
    
    @IBAction func next(_ sender: UIButton) {
        performSegue(withIdentifier: "gradetextsegue", sender: self)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let room = segue.destination as? GradeTextController {
            room.code = code
        }
    }
}
