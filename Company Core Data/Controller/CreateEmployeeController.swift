//
//  CreateEmployeeController.swift
//  Company Core Data
//
//  Created by Viswa Kodela on 9/29/18.
//  Copyright © 2018 Viswa Kodela. All rights reserved.
//

import UIKit

class CreateEmployeeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Employee"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        view.backgroundColor = .green
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}
