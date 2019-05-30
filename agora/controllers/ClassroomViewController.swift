//
//  ClassroomViewController.swift
//  agora
//
//  Created by Igor Matos  on 5/26/19.
//  Copyright © 2019 agora. All rights reserved.
//

import UIKit


class ClassroomViewController: AgoraViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classroom?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath) as! TableViewCell
        cell.leftLabel.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    @IBOutlet weak var clasroomName: UILabel!
    @IBOutlet weak var peopleCountLabel: UILabel!
    var classroom: Classroom?
    var users: [CustomUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        
        let classroomId = AppSingleton.shared().loggedRoom?.code
        
        if let classroomId = classroomId {
            FirebaseHelper.shared().getClassroomRealtime(id: classroomId, onError: { error in
                self.showAlert(title: "Erro ao carregar sala", message: error)
            }) { classroom in
                self.classroom = classroom
                self.users = classroom.users.values.map({ custom -> CustomUser in
                  return custom
                })
                self.clasroomName.text = classroom.name
                
                self.tableView.reloadData()
                
                self.peopleCountLabel.text = "\(classroom.users.count) PESSOAS NA SALA"
            }
        }
        
    }

}
