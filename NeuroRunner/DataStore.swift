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
    
    let user = User()
    let realm = try! Realm()

    func addUserToRealm() {
        try! realm.write {
            realm.add(user)
        }
    }
    
}
