//
//  DataStorageManager.swift
//  DemoApp
//
//  Created by Gopal Kumar on 06/03/26.
//

import Foundation

struct Student: Identifiable, Codable {
    var id = UUID()
    var name: String = ""
    var phoneNo: String = ""
    var email: String = ""
    var age : String = ""
    var gender : String = ""
    var fatherName: String = ""
    var motherName: String = ""
    var profileImage: String = "" 
}
