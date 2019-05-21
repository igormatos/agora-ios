//
//  WriteTextController.swift
//  agora
//
//  Created by Tarcísio Chaves Monteiro on 5/21/19.
//  Copyright © 2019 agora. All rights reserved.
//

import UIKit

class WriteTextController: UIViewController {
    var code: String!
    
    @IBOutlet var textTitle: UITextView!
    @IBOutlet var textBody: UITextView!
    
    @IBAction func send(_ sender: UIButton) {
        performSegue(withIdentifier: "secondphasesegue", sender: self)
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
