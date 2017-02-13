//
//  Sweet.swift
//  Trial
//
//  Created by lava m on 2/13/17.
//  Copyright © 2017 Firebase. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Sweet {
    let key:String!
    let content:String!
    let addedbyUser:String!
    let itemRef:FIRDatabaseReference?
    
    init(content:String,addedbyUser:String,key:String = "") {
        self.key = key
        self.content = content
        self.addedbyUser = addedbyUser
        self.itemRef = nil
    }
    
    init(snapshot:FIRDataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
       content = (snapshot.value as? NSDictionary)?["content"] as? String ?? ""
        
        addedbyUser = (snapshot.value as? NSDictionary)?["addedbyUser"] as? String ?? ""
    }
}
