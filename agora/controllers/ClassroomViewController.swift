//
//  ClassroomViewController.swift
//  agora
//
//  Created by Igor Matos  on 5/26/19.
//  Copyright © 2019 agora. All rights reserved.
//

import UIKit


class ClassroomViewController: AgoraViewController {
    
    @IBOutlet weak var clasroomName: UILabel!
    @IBOutlet weak var peopleCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let classroomId = AppSingleton.shared().loggedRoom?.code
        if let classroomId = classroomId {
            FirebaseHelper.shared().getClassroom(id: classroomId, onError: { error in
                self.showAlert(title: "Erro ao carregar sala", message: error)
            }) { classroom in
                self.clasroomName.text = classroom.name
                
                self.peopleCountLabel.text = "\(classroom.users.count) PESSOAS NA SALA"
            }
        }
        
    }

}
