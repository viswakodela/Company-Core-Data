//
//  EmployeesController.swift
//  Company Core Data
//
//  Created by Viswa Kodela on 9/29/18.
//  Copyright © 2018 Viswa Kodela. All rights reserved.
//

import UIKit

class EmployeesContoller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .blue
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(handlePlusButton))
    }
    
    var company: Company! {
        didSet {
            navigationItem.title = company.name
        }
    }
    
    @objc func handlePlusButton() {
        let createEmployee = CreateEmployeeController()
        let createEmployeeWithNavBar = UINavigationController(rootViewController: createEmployee)
        present(createEmployeeWithNavBar, animated: true, completion: nil)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    
    
    
}
