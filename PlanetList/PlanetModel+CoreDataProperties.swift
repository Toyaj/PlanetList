//
//  PlanetModel+CoreDataProperties.swift
//  PlanetList
//
//  Created by Toyaj Nigam on 10/01/19.
//  Copyright © 2019 Toyaj Nigam. All rights reserved.
//
//

import Foundation
import CoreData


extension PlanetModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlanetModel> {
        return NSFetchRequest<PlanetModel>(entityName: "PlanetModel")
    }

    @NSManaged public var name: String?

}
