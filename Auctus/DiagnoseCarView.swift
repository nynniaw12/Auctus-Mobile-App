//
//  DiagnoseCarView.swift
//  Auctus
//
//  Created by Hasan Aybars Ari on 11/2/23.
//

import Foundation
import SwiftUI
import Combine


extension Color {static let darkGray = Color(red: 0.25, green: 0.25, blue: 0.25)}


// DIAGNOSIS VIEW
struct DiagnoseCarView: View {
    @ObservedObject var viewModel: DiagnoseCarViewmodel
    
    let allWarningLights: [String] = ["Warning Light 1", "Warning Light 2", "Warning Light 3"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Something wrong with your ride?")
                            .foregroundColor(.white)
                            .font(.custom("Inter-Bold", size: 32))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Car Diagnosis")
                                .foregroundColor(.green)
                                .font(.custom("Rubik-Bold", size: 32))
                            
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundColor(.white)
                                
                                Text("Estimated time 5 min.")
                                    .foregroundColor(.white)
                                    .font(.custom("Inter-Bold", size: 22))
                            }
                            .padding(.bottom, 10)
                            
                            TextField("Car Make", text: $viewModel.carMake)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.custom("Inter-Bold", size: 20))
                            TextField("Car Model", text: $viewModel.carModel)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.custom("Inter-Bold", size: 20))
                            TextField("Car Year", text: $viewModel.carYear)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.custom("Inter-Bold", size: 20))
                                .padding(.bottom, 10)
                            HStack{
                                Spacer()
                                    NavigationLink("Continue") { IssueDetailsView(viewModel: viewModel)}
                                    .buttonStyle(GreenButtonStyle())
                                    .font(.custom("Inter-Bold", size: 18))
                                    .onAppear {UITableViewCell.appearance().backgroundColor = UIColor.clear
                                        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "Inter-Bold", size: 34)!]
                                        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Inter-Bold", size: 20)!]
                                        UISegmentedControl.appearance().setTitleTextAttributes(
                                            [
                                                .font: UIFont(name: "Inter-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16),
                                            ], for: .selected)

                                        UISegmentedControl.appearance().setTitleTextAttributes(
                                            [
                                                .font: UIFont(name: "Inter-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12),
                                            ], for: .normal)
                                    }
                                Spacer()
                            }
                            .padding(.bottom, 5)
                        }
                        .padding()
                        .background(
                            Image("car1")
                                .resizable() 
                                .aspectRatio(contentMode: .fill)
                                .edgesIgnoringSafeArea(.all)
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .cornerRadius(25)
                        Text("Car Parts Categories")
                            .foregroundColor(.white)
                            .font(.custom("Inter-Bold", size: 28))
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                CategoryView(iconName: "bolt.fill", text: "Electrical", backgroundColor: Color.darkGray, borderColor: Color.darkGray)
                                    .frame(width: 130, height: 75)
                                CategoryView(iconName: "car.fill", text: "Suspension", backgroundColor: .black, borderColor: Color.darkGray)
                                    .frame(width: 130, height: 75)
                                CategoryView(iconName: "wrench.fill", text: "Brake", backgroundColor: Color.darkGray, borderColor: Color.darkGray)
                                    .frame(width: 130, height: 75)
                                CategoryView(iconName: "gear", text: "Engine", backgroundColor: .black, borderColor: Color.darkGray)
                                    .frame(width: 130, height: 75)
                                // Handle parts action
                            }
                        }
                        HStack{
                            Spacer()
                            Button("Compare Shops") {
                                // Handle compare shops action
                            }
                            .buttonStyle(GreenButtonStyle())
                            .font(.custom("Rubik-Medium", size: 22))
                            Spacer()
                        }
                    }
                    .padding()
                    Spacer()
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .foregroundColor(.green)
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
    }
}


// SUBMIT FORM VIEW
struct IssueDetailsView: View {
    @ObservedObject var viewModel: DiagnoseCarViewmodel
    @State private var showingSubmissionAlert = false
    var body: some View {
        ZStack {
            Form {
                Section(header: Text("Issue Description")) {
                    TextEditor(text: $viewModel.issueDescription)
                        .frame(minHeight: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.clear, lineWidth: 1)
                        )
                }
                Section(header: Text("Issue Frequency")) {
                    Picker("Issue Frequency", selection: $viewModel.issueFrequency) {
                        Text("Frequently").tag("Frequently")
                        Text("Sometimes").tag("Sometimes")
                        Text("Rarely").tag("Rarely")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .scaleEffect(x:1.1, y:1.1)
                }
                .listRowBackground(Color.clear)
                Section {
                    HStack {
                        Spacer()
                        Button("Submit Form") {
                            viewModel.isLoading = true
                            viewModel.submitForm {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    viewModel.isLoading = false
                                    showingSubmissionAlert = true
                                }
                            }
                        }
                        .buttonStyle(GreenButtonStyle())
                        .font(.custom("Rubik-Medium", size: 22))
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
            }
            .alert(isPresented: $showingSubmissionAlert) {
                Alert(
                    title: Text("Submission Result"),
                    message: Text(submissionResultMessage()),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationTitle("What is the issue?")
            .font(.custom("Inter-Bold", size: 14))

        }
    }

    private func submissionResultMessage() -> String {
        if let error = viewModel.fetchError {
            return "Error: \(error)"
        } else {
            var message = ""
            if let diagnosis = viewModel.diagnosis {
                message += "Diagnosis: \(diagnosis)\n\n"
            }
            if let part = viewModel.part {
                message += "Part: \(part)\n\n"
            }
            if let expl = viewModel.expl {
                message += "Explanation: \(expl)\n\n"
            }
            if let estimate = viewModel.estimate {
                message += "Estimate: \(estimate)"
            }
            return message.isEmpty ? "No data available." : message
        }
    }
}


// LOADING WHILE DIAGNOSIS
struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
                .padding()
            Text("Loading...")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
    }
}


// CUSTOM STYLING
struct CategoryView: View {
    var iconName: String
    var text: String
    var backgroundColor: Color
    var borderColor: Color

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding(.top, 10)

            Spacer(minLength: 8)

            Text(text)
                .font(.custom("Inter-Bold", size: 15))
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(backgroundColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(borderColor, lineWidth: 2)
        )
        .padding(.horizontal, 10)
    }
}


struct GreenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.vertical, 5)
            .padding(.horizontal, 50)
            .background(Color.green)
            .cornerRadius(30)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}


// PREVIEW
struct DiagnoseCarView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnoseCarView(viewModel: DiagnoseCarViewmodel())
            .preferredColorScheme(.dark)
    }
}
