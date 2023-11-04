//
//  AuctusApp.swift
//  Auctus
//
//  Created by Hasan Aybars Ari on 11/1/23.
//

import SwiftUI

@main
struct AuctusApp: App {
    @StateObject var diagnoseCarViewmodel = DiagnoseCarViewmodel()
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(diagnoseCarViewmodel) // if you want to use the same ViewModel across your app
                .preferredColorScheme(.dark)
        }
    }
}

