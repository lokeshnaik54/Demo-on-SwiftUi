//
//  SaveManager.swift
//  DemoApp
//
//  Created by Gopal Kumar on 05/03/26.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    let person_listKey = "person_ListKey"
    
    func saveUserData(_ person : [Student]) {
        guard let encoded = try? JSONEncoder().encode(person) else{return}
        UserDefaults.standard.set(encoded, forKey: person_listKey)
    }
    
    func fetchPeople() -> [Student] {
        guard let data = UserDefaults.standard.data(forKey: person_listKey),
              let decoded = try? JSONDecoder().decode([Student].self, from: data) else { return []}
        return decoded
    }
}
