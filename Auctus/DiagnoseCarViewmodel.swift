//
//  DiagnoseCarViewmodel.swift
//  Auctus
//
//  Created by Hasan Aybars Ari on 11/2/23.
//

import Foundation
import Apollo
import Combine

// HANDLE DIAGNOSIS QUERY
final class DiagnoseCarViewmodel: ObservableObject {
        @Published var isLoading: Bool = false
    
        @Published var isNavigatingToIssueDetails = false
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
    
    
        @Published var diagnosis: String?
        @Published var part: String?
        @Published var expl: String?
        @Published var estimate: String?
        @Published var fetchError: String?
    
        var warningLightsText: String {
            warningLights.joined(separator: ", ")
        }
    
    func submitForm(completion: @escaping () -> Void) {
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
            
        fetch(carInfo: carInfo){
            completion()
        }
    }
    
    
    private func fetch(carInfo: [String], completion: @escaping () -> Void) {
        Network.shared.apollo.fetch(query: DiagnoseCarQuery(carInfo: carInfo)) { [weak self] result in
             switch result {
             case .success(let graphQLResult):
                 DispatchQueue.main.async {
                     self?.diagnosis = graphQLResult.data?.diagnoseCar?.diagnosis
                     self?.part = graphQLResult.data?.diagnoseCar?.part
                     self?.expl = graphQLResult.data?.diagnoseCar?.expl
                     self?.estimate = graphQLResult.data?.diagnoseCar?.estimate
                 }
             case .failure(let error):
                 DispatchQueue.main.async {
                     self?.fetchError = error.localizedDescription
                 }
            }
            DispatchQueue.main.async {
                completion()
            }
         }
    }

}


