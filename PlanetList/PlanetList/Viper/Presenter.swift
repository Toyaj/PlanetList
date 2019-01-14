//
//  Presenter.swift
//  PlanetList
//
//  Created by Toyaj Nigam on 06/01/19.
//  Copyright © 2019 Toyaj Nigam. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/** Protocol to used for communication between ViewController and presenter to load tableView */
protocol PresenterDelegate : class{
    func didUpdateViewControllerWith(planerArray:[NSManagedObject])
}

class Presenter {
    var interactor: Interactor
    var planetList : [Planet]
    weak var delegate : PresenterDelegate?
    var planets: [NSManagedObject] = []
    
    init(interactor: Interactor) {
        self.interactor = interactor
        self.planetList = [Planet]()
    }
    
    func loadData(){
        if isDataAvailableLocally(){
            delegate?.didUpdateViewControllerWith(planerArray: planets)
        }
        else {
            getPlanetListFromService(onSuccess: { (planetArray) in
                self.saveData(planetArray: planetArray)
                self.delegate?.didUpdateViewControllerWith(planerArray: self.planets)
            }) {
                print("Network issue")
            }
        }
    }
    
    private func getPlanetListFromCoreData() -> [NSManagedObject]?{
        let managedContext = CoreDataBaseLayer.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PlanetModel")
        var result = [NSManagedObject]()
        do {
            result = try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return result
    }
    
    private func isDataAvailableLocally() -> Bool {
        planets = getPlanetListFromCoreData() ?? []
        if planets.count > 0 {
            return true
        }
        return false
    }
    
    private func getPlanetListFromService(onSuccess: @escaping ([Planet]) -> (), onFailure: @escaping () -> ()) {
        interactor.getPlanetName(onSuccess: { (planetArray) in
            self.planetList = planetArray
            print(self.planetList.count)
            onSuccess(self.planetList)
        }) {
            onFailure()
        }
    }
    
    func saveData(planetArray : [Planet]){
        
        //We need to create a context from this container
        let managedContext = CoreDataBaseLayer.shared.persistentContainer.viewContext
        
        //Now let’s create an entity and new planet records.
        let planetEntity = NSEntityDescription.entity(forEntityName: "PlanetModel", in: managedContext)!
        
        for i in planetArray {
            let planet = NSManagedObject(entity: planetEntity, insertInto: managedContext)
            planet.setValue(i.name!, forKeyPath: "name")
            print("\(i.name!)")
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        getPlanetListFromCoreData()
    }
    
}
