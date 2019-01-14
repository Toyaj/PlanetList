//
//  Service.swift
//  PlanetList
//
//  Created by Toyaj Nigam on 06/01/19.
//  Copyright © 2019 Toyaj Nigam. All rights reserved.
//

import Foundation

class Service {
    
    func getPlanetName(onSuccess: @escaping ([Planet]) -> (), onFailure: @escaping () -> ()) {
        
        let planetURL = PlanetURL.planetURL
        guard let url = URL(string: planetURL)  else {return}
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            guard let data = data else{return}
            
            do {
                let planetDetails = try JSONDecoder().decode(PlanetDetails.self, from: data)
                onSuccess(planetDetails.results)
            }catch let jsonerr {
                print("JSON error",jsonerr)
            }
            }.resume()
    }
}
