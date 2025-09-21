//
//  Network.swift
//  RocketReserver
//
//  Created by Tingsong Ou on 9/14/25.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/graphql")!)
}
