//
//  DiagnoseCarView.swift
//  Auctus
//
//  Created by user249296 on 11/2/23.
//

import Foundation

import SwiftUI

struct DiagnoseCarView: View {
    @ObservedObject var viewModel: DiagnoseCarViewmodel
    
    let allWarningLights: [String] = ["Warning Light 1", "Warning Light 2", "Warning Light 3"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextField("Car Make", text: $viewModel.carMake)
                    TextField("Car Model", text: $viewModel.carModel)
                    TextField("Car Year", text: $viewModel.carYear)
                    TextField("Issue Type", text: $viewModel.issueType)
                    TextField("Issue Description", text: $viewModel.issueDescription)
                    
                    Toggle("Unusual Noises/Smells", isOn: Binding(get: {
                        self.viewModel.unusualNoisesSmellsCheck == "Yes"
                    }, set: {
                        self.viewModel.unusualNoisesSmellsCheck = $0 ? "Yes" : "No"
                    }))
                    
                    if viewModel.unusualNoisesSmellsCheck == "Yes" {
                        TextField("Describe Unusual Noises/Smells", text: $viewModel.unusualNoisesSmells)
                    }
                    
                    Picker("Issue Frequency", selection: $viewModel.issueFrequency) {
                        Text("Frequently").tag("Frequently")
                        Text("Sometimes").tag("Sometimes")
                        Text("Rarely").tag("Rarely")
                    }.pickerStyle(SegmentedPickerStyle())

                    NavigationLink(destination: WarningLightsSelectionView(viewModel: viewModel, allWarningLights: allWarningLights)) {
                        Text("Select Warning Lights")
                    }

                    // ... Other UI components

                    Button(action: viewModel.submitForm) {
                        Text("Submit")
                    }
                }
                .padding()
            }
            .navigationTitle("Diagnose Car")
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

