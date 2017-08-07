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
    
    var realm: Realm!
    
    

    var user: User! = User()

    func addUserToRealm() {
        
        try! realm.write {
            realm.add(user)
        }
    }
    
    init() {
        do {
            realm = try Realm()
        } catch let error {
            print("ERROR: \(error)")
        }
    }
    
}
