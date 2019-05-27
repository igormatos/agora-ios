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

        fragment.text = "HighlightedText"
//        "\"\(rooms[code]!.highlightedText)\""
    }
    
}
