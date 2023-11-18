//
//  ContentView.swift
//  Auctus
//
//  Created by Hasan Aybars Ari on 11/1/23.
//

import SwiftUI


// MAIN UI
struct ContentView: View {
    @EnvironmentObject var viewModel: DiagnoseCarViewmodel
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.darkGray 
        
        if let customFont = UIFont(name: "Rubik-Bold", size: 12) {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: customFont
            ]
            
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = attributes
            appearance.inlineLayoutAppearance.normal.titleTextAttributes = attributes
            appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = attributes

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        } else {
            print("Failed to load the 'Rubik-Medium' font.")
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            topBar
            tabView
        }
        .edgesIgnoringSafeArea(.top)
        .blur(radius: viewModel.isLoading ? 3 : 0)
        .overlay(
            viewModel.isLoading ? LoadingView().edgesIgnoringSafeArea(.all) : nil
        )
    }

    var topBar: some View {
        HStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 80)
                .padding(.bottom, -20)
                .padding(.top, 0)
            Spacer()
        }
        .padding()
        .background(Color.darkGray)
        .foregroundColor(.white)
    }

    var tabView: some View {
        TabView {
            DiagnoseCarView(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            Text("Search View")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            

            Text("Profile View")
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DiagnoseCarViewmodel()

        ContentView()
            .environmentObject(viewModel)
            .preferredColorScheme(.dark)
    }
}

