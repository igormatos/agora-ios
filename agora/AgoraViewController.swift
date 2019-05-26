//
//  AgoraViewController.swift
//  agora
//
//  Created by Igor Matos  on 5/26/19.
//  Copyright © 2019 agora. All rights reserved.
//

import UIKit

class AgoraViewController: UIViewController, UITextFieldDelegate {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Cancelar", style: .cancel, handler: { _ in
            //
        }))
        self.present(alertController, animated: false)
    }
}
