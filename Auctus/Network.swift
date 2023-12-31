//
//  Network.swift
//  Auctus
//
//  Created by Hasan Aybars Ari on 11/2/23.
//

import Foundation
import Apollo


// GQL APOLLO CONFIGURATION
// URL HARD CODED
class Network{
    static let shared = Network()
    let url = "https://f02e-165-124-85-13.ngrok-free.app/graphql"
    private(set) lazy var apollo = ApolloClient(url: URL(string: url)!)
}
