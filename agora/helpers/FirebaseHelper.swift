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
        }}
    
    
    private init() {
        dbReference = Database.database().reference().child("classrooms")
    }
    
    

}
