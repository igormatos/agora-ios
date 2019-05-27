//
//  GetCodeViewController.swift
//  agora
//
//  Created by Igor Matos  on 5/26/19.
//  Copyright © 2019 agora. All rights reserved.
//

import UIKit

class GetCodeViewController: AgoraViewController {

    @IBOutlet weak var roomCodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let roomCode = AppSingleton.shared().loggedRoom?.code else {
            return
        }
        
        roomCodeLabel.text = roomCode
    }

    @IBAction func copyCodeClick(_ sender: Any) {
        UIPasteboard.general.string = roomCodeLabel.text!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
