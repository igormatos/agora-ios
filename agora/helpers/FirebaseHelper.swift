//
//  FirebaseHelper.swift
//  agora
//
//  Created by Igor Matos  on 5/26/19.
//  Copyright © 2019 agora. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CodableFirebase

class FirebaseHelper {
    
    private static let firebaseHelper = FirebaseHelper()
    var dbReference: DatabaseReference!
    
    class func shared() -> FirebaseHelper {
        return firebaseHelper
    }
    
    func createClassroom(classroom: Classroom, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void)  {
  
        let data = try! FirebaseEncoder().encode(classroom)
    
        self.dbReference.child(classroom.code).setValue(data) { (error:Error?, ref:DatabaseReference) in
            if let error = error {
                onError(error.localizedDescription)
            } else {
                AppSingleton.shared().loggedRoom = classroom
                onSuccess()
            }
        }
    }
    
    func getClassroom(id: String, onError: @escaping (String) -> (), onSuccess: @escaping (Classroom) -> () ) {
        dbReference.child(id).observe(.value) { snapshot in
            guard let value = snapshot.value else { return }
            
            do {
                let model = try FirebaseDecoder().decode(Classroom.self, from: value)
                onSuccess(model)
            } catch let error {
                onError(error.localizedDescription)
            }
            
        }
    }
    
    func join(user: CustomUser, onClassroom id: String, onError: @escaping (String) -> (), onSuccess: @escaping (Classroom) -> () ) {
        
        let userData = try! FirebaseEncoder().encode(user)

        let roomReference = dbReference.child(id)
        
        roomReference.observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value else {
                onError("Problema ao conectar a sala")
                return
            }
            
            do {
                var classroomModel = try FirebaseDecoder().decode(Classroom.self, from: value)
                
                var usersList: [CustomUser] = []
                
                if (classroomModel.users.count > 0) {
                    usersList = classroomModel.users
                }
                
                let userAlreadySigned = usersList.contains(where: { customUser -> Bool in
                    return user.id == customUser.id
                })
                
                if (!userAlreadySigned) {
                    usersList.append(user)
                }
                
                
                let usersData = try! FirebaseEncoder().encode(usersList)

                roomReference.child("users").setValue(usersData) { (error:Error?, ref:DatabaseReference) in
                    
                    guard snapshot.value != nil else { onError(error?.localizedDescription ?? "")
                        return
                    }
                    
                    classroomModel.users.append(user)
                    onSuccess(classroomModel)
                }
                
            } catch let error {
                onError(error.localizedDescription)
            }
        }
    }
    
    func clearObservers() {
        dbReference.removeAllObservers()
    }
    
    private init() {
        dbReference = Database.database().reference().child("classrooms")
    }
    
    

}
