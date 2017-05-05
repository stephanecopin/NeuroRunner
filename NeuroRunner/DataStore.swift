//
//  DataStore.swift
//  NeuroRunner
//
//  Created by Robert Deans on 3/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import RealmSwift

final class DataStore {
    
    static let shared = DataStore()
    let realm = try! Realm()

    var user: User! = User()

    func addUserToRealm() {
        
        try! realm.write {
            realm.add(user)
        }
    }
    
}
