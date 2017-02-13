//
//  User.swift
//  Trial
//
//  Created by lava m on 2/13/17.
//  Copyright © 2017 Firebase. All rights reserved.
//

import Foundation
import FirebaseAuth

struct user {
    let uid:String
    let email:String
    
    init(userData: FIRUser) {
        uid = userData.uid
        if let  mail = userData.providerData.first?.email{
            email = mail
        } else{
            email = ""
        }
    }
    init(uid:String,email:String) {
        self.uid = uid
        self.email = email
    }
    
}
