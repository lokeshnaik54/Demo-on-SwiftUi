//
//  DemoAppApp.swift
//  DemoApp
//
//  Created by Gopal Kumar on 05/03/26.
//

import SwiftUI

@main
struct DemoAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
//                ContentView()
                StudentsList()
            }
        }
    }
}
