//
//  ContentView.swift
//  Auctus
//
//  Created by Hasan Aybars Ari on 11/1/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: DiagnoseCarViewmodel
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.darkGray // Here you set your color
        
        // Ensure your custom font is correctly referenced and included in your project.
        if let customFont = UIFont(name: "Rubik-Bold", size: 12) {
            // Create a new attributes dictionary for your font
            let attributes: [NSAttributedString.Key: Any] = [
                .font: customFont
                // Add other attributes if needed, like .foregroundColor: UIColor.white
            ]
            
            // Set the titleTextAttributes for the normal state
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = attributes
            appearance.inlineLayoutAppearance.normal.titleTextAttributes = attributes
            appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = attributes

            // Apply the appearance to the tabBar
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        } else {
            print("Failed to load the 'Rubik-Medium' font.")
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Your custom top bar here
            topBar
            // Your tab view here
            tabView
        }
        .edgesIgnoringSafeArea(.top) // Allows the top bar to extend to the top edge of the screen
    }

    var topBar: some View {
        HStack {
            Image("logo") // Replace "logo" with your actual logo image asset name
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 80) // Adjust the height to change the size of the logo
                .padding(.bottom, -20)
                .padding(.top, 0)
            Spacer()
        }
        .padding()
        .background(Color.darkGray) // Use the color you want for your top bar
        .foregroundColor(.white)
    }

    var tabView: some View {
        TabView {
            // Home tab
            DiagnoseCarView(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            // Search tab
            Text("Search View") // Replace with your actual view
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            // Profile tab
            Text("Profile View") // Replace with your actual view
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(.white) // Change the tab item selection color if needed
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of your ViewModel
        let viewModel = DiagnoseCarViewmodel()

        // Pass the instance to the ContentView as an environment object
        ContentView()
            .environmentObject(viewModel) // Provide the mock
            .preferredColorScheme(.dark)
    }
}

