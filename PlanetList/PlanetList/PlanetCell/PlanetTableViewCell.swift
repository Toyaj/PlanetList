//
//  PlanetTableViewCell.swift
//  PlanetList
//
//  Created by Toyaj Nigam on 06/01/19.
//  Copyright © 2019 Toyaj Nigam. All rights reserved.
//

import UIKit
import CoreData

class PlanetTableViewCell: UITableViewCell {

    @IBOutlet weak var planetName: UILabel!
    
    func setPlanetName(planet : NSManagedObject) {
        self.planetName.text = planet.value(forKeyPath: "name") as? String
    }
}
