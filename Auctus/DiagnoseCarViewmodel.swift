//
//  DiagnoseCarViewmodel.swift
//  Auctus
//
//  Created by Hasan Aybars Ari on 11/2/23.
//

import Foundation
import Apollo
import Combine

final class DiagnoseCarViewmodel: ObservableObject {
        @Published var carMake = ""
        @Published var carModel = ""
        @Published var carYear = ""
        @Published var issueType = ""
        @Published var issueDescription = ""
        @Published var issueFrequency = ""
        @Published var issueOccurrence = ""
        @Published var unusualNoisesSmellsCheck = ""
        @Published var unusualNoisesSmells = ""
        @Published var warningLights = [String]()
        @Published var pastIssues = ""
        @Published var carMileage = ""
        @Published var acBlowAir = ""
        @Published var acAirTemperature = ""
        @Published var acUnusualSmells = ""
        @Published var lightNotWorking = ""
        @Published var lightStatus = ""
        @Published var bulbReplacement = ""
        @Published var messageDisplayed = ""
        @Published var messageAppearance = ""
        @Published var messageFrequency = ""
        @Published var startIssue = ""
        @Published var batteryAge = ""
        @Published var jumpStart = ""
        @Published var headlights = ""
        @Published var clickingNoise = ""
        @Published var carPull = ""
        @Published var brakeNoise = ""
        @Published var brakeFeel = ""
        @Published var radioOn = ""
        @Published var radioSound = ""
        @Published var radioStations = ""
        @Published var engineSpeed = ""
        @Published var engineSputter = ""
        @Published var engineIdle = ""
        @Published var steeringSpeed = ""
        @Published var steeringShake = ""
        @Published var steeringBrake = ""
        @Published var fluidColor = ""
        @Published var fluidLocation = ""
        @Published var fluidAmount = ""
        @Published var crackSize = ""
        @Published var crackSight = ""
        @Published var crackDuration = ""
        @Published var engineNoise = ""
        @Published var electricalIssues = ""
        @Published var jumpStartAttempt = ""
        @Published var overheatSpeed = ""
        @Published var overheatWeather = ""
        @Published var coolantLevel = ""
        var warningLightsText: String {
            warningLights.joined(separator: ", ")
        }
    
    func submitForm() {
        let carInfo = [
            carMake,
            carModel,
            carYear,
            issueType,
            issueDescription,
            issueFrequency,
            issueOccurrence,
            unusualNoisesSmellsCheck,
            unusualNoisesSmells,
            warningLightsText,
            pastIssues,
            carMileage,
            acBlowAir,
            acAirTemperature,
            acUnusualSmells,
            lightNotWorking,
            lightStatus,
            bulbReplacement,
            messageDisplayed,
            messageAppearance,
            messageFrequency,
            startIssue,
            batteryAge,
            jumpStart,
            headlights,
            clickingNoise,
            carPull,
            brakeNoise,
            brakeFeel,
            radioOn,
            radioSound,
            radioStations,
            engineSpeed,
            engineSputter,
            engineIdle,
            steeringSpeed,
            steeringShake,
            steeringBrake,
            fluidColor,
            fluidLocation,
            fluidAmount,
            crackSize,
            crackSight,
            crackDuration,
            engineNoise,
            electricalIssues,
            jumpStartAttempt,
            overheatSpeed,
            overheatWeather,
            coolantLevel
        ]
            
        fetch(carInfo: carInfo)
    }
    
    
    private func fetch(carInfo: [String]) {
        Network.shared.apollo.fetch(query: DiagnoseCarQuery(carInfo: carInfo)) { result in // Change the query name to your query name
            switch result {
            case .success(let graphQLResult):
                if let diagnosis = graphQLResult.data?.diagnoseCar?.diagnosis {
                    print("Diagnosis: \(diagnosis)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

}


