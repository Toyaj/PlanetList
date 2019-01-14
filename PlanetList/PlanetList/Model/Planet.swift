//
//  Planet.swift
//  PlanetList
//
//  Created by Toyaj Nigam on 06/01/19.
//  Copyright © 2019 Toyaj Nigam. All rights reserved.
//

import Foundation


struct PlanetDetails: Decodable {
    let results: [Planet]
}

struct Planet : Decodable {
      let name: String?
}
