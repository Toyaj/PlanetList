//
//  ViewController.swift
//  PlanetList
//
//  Created by Toyaj Nigam on 06/01/19.
//  Copyright © 2019 Toyaj Nigam. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var planetTableView: UITableView!
    var planetList =  [Planet]()
    var presenter: Presenter!
    var planets: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Planet Name"
        confugureTableView()
        configure()
    }
    
    private func confugureTableView(){
        planetTableView.tableFooterView = UIView()
        self.planetTableView.estimatedRowHeight = 80
        self.planetTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configure(){
        presenter = Presenter(interactor: Interactor(service: Service()))
        presenter.delegate = self as? PresenterDelegate
        presenter.loadData()
    }
}

extension ViewController : PresenterDelegate {
    func didUpdateViewControllerWith(planerArray: [NSManagedObject]) {
        self.planets = planerArray
        DispatchQueue.main.async {
            self.planetTableView.reloadData()
        }
    }
}

//Extension for Table View
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let planetValue = planets[indexPath.row]
        let cell  = tableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath) as! PlanetTableViewCell
        cell.setPlanetName(planet: planetValue)
        return cell
    }
}
