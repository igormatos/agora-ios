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
        let roomReference = dbReference.child(id)
        let userData = try! FirebaseEncoder().encode(user)
        roomReference.observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value else {
                onError("Problema ao conectar a sala")
                return
            }
            
            do {
                var classroomModel = try FirebaseDecoder().decode(Classroom.self, from: value)
                
                roomReference.child("users/\(user.id)").setValue(userData) { (error:Error?, ref:DatabaseReference) in
                    
                    guard snapshot.value != nil else {
                        onError(error?.localizedDescription ?? "")
                        return
                    }
                    
                    classroomModel.users[user.id] = user
                    onSuccess(classroomModel)
                }
                
            } catch let error {
                onError(error.localizedDescription)
            }
        }
    }
    
    func send(text: Text, toRoom roomId: String, onError: @escaping (String) -> (), onSuccess: @escaping () -> () ) {
        let textData = try! FirebaseEncoder().encode(text)
        
        dbReference.child(roomId).child("texts/\(text.id)").setValue(textData) { (error, ref) in
            if let error = error?.localizedDescription {
                onError(error)
                return
            }
            
            onSuccess()
        }
        
    }
    
    func waitForNextPhase(to stage: Int,
                          ofUser userId: String,
                          onRoom roomId: String,
                          onError: @escaping (String) -> (),
                          onSuccess: @escaping (Classroom) -> ()) {
        
        dbReference.child(roomId).child("stage").observe(.value) { snapshot in
            
            guard let value = snapshot.value else {
                return
            }
            
            if let newValue = value as? Int, newValue == stage {
                
                self.dbReference.child(roomId).observeSingleEvent(of: .value, with: { snapshott in
                    guard let value = snapshott.value else {
                        return
                    }
                    do {
                        let model = try FirebaseDecoder().decode(Classroom.self, from: value)
                        onSuccess(model)
                    } catch let error {
                        onError(error.localizedDescription)
                    }
                })
                
            } else {
                onError("")
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
