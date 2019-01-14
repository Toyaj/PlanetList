//
//  Interactor.swift
//  PlanetList
//
//  Created by Toyaj Nigam on 06/01/19.
//  Copyright © 2019 Toyaj Nigam. All rights reserved.
//

import Foundation

class Interactor {
    
    var service: Service
    
    init(service: Service) {
        self.service = service
    }
    
    func getPlanetName(onSuccess: @escaping ([Planet]) -> (), onFailure: @escaping () -> ()) {
        service.getPlanetName(onSuccess: { (planets) in
            onSuccess(planets)
        }) {
            onFailure()
        }
    }
}
