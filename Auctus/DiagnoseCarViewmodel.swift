//
//  DiagnoseCarViewmodel.swift
//  Auctus
//
//  Created by Hasan Aybars Ari on 11/2/23.
//

import Foundation
import Apollo

final class DiagnoseCarViewmodel: ObservableObject {
    
    let carInfo: [String] = [
            "Toyota",
            "Camry",
            "2020",
            "Engine Problem",
            "The engine makes a strange noise",
            "Frequently",
            "During driving",
            "Yes",
            "Burning smell",
            "Check Engine, Oil Pressure",
            "No",
            "120000",
            "Yes",
            "Cold",
            "No",
            "Headlight",
            "Off",
            "Yes",
            "Yes",
            "On dashboard",
            "Sometimes",
            "No",
            "2 years",
            "No",
            "Both",
            "Yes",
            "Right",
            "No",
            "Normal",
            "Yes",
            "Normal",
            "All",
            "Normal",
            "No",
            "Normal",
            "High",
            "No",
            "Normal",
            "Clear",
            "Under the car",
            "Small amount",
            "Small",
            "Front windshield",
            "1 week",
            "No",
            "No",
            "No",
            "Normal",
            "Warm",
            "Full"
    ]
    
    init(){
        fetch()
    }
    
    func fetch() {
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


