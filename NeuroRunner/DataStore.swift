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
    var user: User!
    
    
    init() {
        do {
            realm = try Realm()
            
            if realm.objects(User.self).count == 0 {
                user = User()
                addUserToRealm()
            } else {
                user = realm.objects(User.self).first
            }
            
        } catch let error {
            print("ERROR initializing Realm: \(error)")
        }
    }
    
    
    func addUserToRealm() {
        do {
            try realm.write {
                realm.add(user)
            }
        } catch let error {
            print("Could not write to database: \(error)")
        }
    }
    
    func deleteRealm() {
        do {
            try realm.write {
                realm.deleteAll()
                print("Realm databased deleted")
            }
        } catch let error {
            print("Could not delete database: \(error)")
        }
    }
    
    
    
}
