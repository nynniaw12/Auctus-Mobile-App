//
//  DiagnoseCarView.swift
//  Auctus
//
//  Created by user249296 on 11/2/23.
//

import Foundation

import SwiftUI

import Combine
extension Color {
    static let darkGray = Color(red: 0.25, green: 0.25, blue: 0.25)
}
struct DiagnoseCarView: View {
    @ObservedObject var viewModel: DiagnoseCarViewmodel
    
    let allWarningLights: [String] = ["Warning Light 1", "Warning Light 2", "Warning Light 3"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    
                    
                    
                    //                    TextField("Issue Type", text: $viewModel.issueType)
                    //                    TextField("Issue Description", text: $viewModel.issueDescription)
                    //
                    //                    Toggle("Unusual Noises/Smells", isOn: Binding(get: {
                    //                        self.viewModel.unusualNoisesSmellsCheck == "Yes"
                    //                    }, set: {
                    //                        self.viewModel.unusualNoisesSmellsCheck = $0 ? "Yes" : "No"
                    //                    }))
                    //
                    //                    if viewModel.unusualNoisesSmellsCheck == "Yes" {
                    //                        TextField("Describe Unusual Noises/Smells", text: $viewModel.unusualNoisesSmells)
                    //                    }
                    //
                    //                    Picker("Issue Frequency", selection: $viewModel.issueFrequency) {
                    //                        Text("Frequently").tag("Frequently")
                    //                        Text("Sometimes").tag("Sometimes")
                    //                        Text("Rarely").tag("Rarely")
                    //                    }.pickerStyle(SegmentedPickerStyle())
                    //
                    //                    NavigationLink(destination: WarningLightsSelectionView(viewModel: viewModel, allWarningLights: allWarningLights)) {
                    //                        Text("Select Warning Lights")
                    //                    }
                    
                    // ... Other UI components
                    
                    //                    Button(action: viewModel.submitForm) {
                    //                        Text("Submit")
                    //                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Something wrong with your ride?")
                            .foregroundColor(.white)
                            .font(.custom("Inter-Bold", size: 32))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Car Diagnosis")
                                .foregroundColor(.green)
                                .font(.custom("Rubik-Bold", size: 32))
                            
                            HStack {
                                Image(systemName: "clock") // Replace with your icon name if it's not a system icon
                                    .foregroundColor(.white) // Sets the color of the icon to white
                                
                                Text("Estimated time 5 min.")
                                    .foregroundColor(.white) // Sets the color of the text to white
                                    .font(.custom("Inter-Bold", size: 22))
                                    // Additional styling can be applied here if needed
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
                                Button("Continue") {
                                    // Handle continue action
                                }
                                .buttonStyle(GreenButtonStyle())
                                .font(.custom("Inter-Bold", size: 18))
                                Spacer()
                            }
                            .padding(.bottom, 5)
                            
                        }
                        .padding()
                        .background(
                            Image("car1") // Replace with your image name
                                .resizable() // Make the image resizable
                                .aspectRatio(contentMode: .fill) // Fill the space without distorting the image
                                .edgesIgnoringSafeArea(.all) // Let the image extend to the screen edges
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure VStack takes the full available width and height
                        .cornerRadius(25)
                        
                        Text("Car Parts Categories")
                            .foregroundColor(.white)
                            .font(.custom("Inter-Bold", size: 28))
                        // Horizontal slider
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
                    
                    // Bottom bar
                    
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .foregroundColor(.green)
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
    }
}

struct WarningLightsSelectionView: View {
    @ObservedObject var viewModel: DiagnoseCarViewmodel
    let allWarningLights: [String]

    var body: some View {
        List {
            ForEach(allWarningLights, id: \.self) { light in
                MultipleSelectionRow(title: light, isSelected: self.viewModel.warningLights.contains(light)) {
                    if self.viewModel.warningLights.contains(light) {
                        self.viewModel.warningLights.removeAll { $0 == light }
                    } else {
                        self.viewModel.warningLights.append(light)
                    }
                }
            }
        }
        .navigationTitle("Warning Lights")
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
        .foregroundColor(self.isSelected ? Color.accentColor : Color.primary)
    }
}

struct GreenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.vertical, 5) // maintain the vertical padding of 10
            .padding(.horizontal, 50)
            .background(Color.green)
            .cornerRadius(30)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

// Category view for the horizontal slider
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
                .frame(width: 30, height: 30) // Smaller icon size
                .foregroundColor(.white)
                .padding(.top, 10) // Padding at the top of the icon

            Spacer(minLength: 8) // Space between the icon and the text

            Text(text)
                .font(.custom("Inter-Bold", size: 15))
                .foregroundColor(.white)
                .padding(.horizontal, 10) // Horizontal padding for the text
                .padding(.bottom, 10) // Padding at the bottom of the text
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity) // Expand to all available space within the parent's frame
        .background(backgroundColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(borderColor, lineWidth: 2)
        )
        .padding(.horizontal, 10) // Padding around the entire view to separate from other elements
    }
}






struct DiagnoseCarView_Previews: PreviewProvider {
    static var previews: some View {
        // Inject your mock ViewModel here
        DiagnoseCarView(viewModel: DiagnoseCarViewmodel())
            .preferredColorScheme(.dark) // Set the color scheme for the preview
    }
}
