//
//  Protocols.swift
//  DiscoverServices
//
//  Created by anoop mohanan on 19/03/18.
//  Copyright © 2018 com.anoopm. All rights reserved.
//

import Foundation

protocol DiscoverServicesProtocol {
    
}

protocol DiscoverServicesUIProtocol: class {
    
    func updateUIWith (message: String)
    func updateUIWithSearch(status: Bool)
    // TODO: Use viewmodel
    func updateUIWith(services: [NetService])
}
