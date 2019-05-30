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
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    @IBAction func next(_ sender: UIButton) {
        performSegue(withIdentifier: "gradetextsegue", sender: self)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let userId = AppSingleton.shared().loggedUser?.uid, let roomId = AppSingleton.shared().loggedRoom?.code else { return }
        
        FirebaseHelper.shared().waitForNextPhase(to: 1, ofUser: userId, onRoom: roomId, onError: { (String) in
            
        }) { (classroom) in
            AppSingleton.shared().loggedRoom = classroom
            self.subtitleLabel.text = "Você já pode opinar"
            self.okButton.isEnabled = true
            self.okButton.backgroundColor = self.hexStringToUIColor(hex: "#241E17")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        FirebaseHelper.shared().clearObservers()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let room = segue.destination as? GradeTextController {
            room.code = code
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
