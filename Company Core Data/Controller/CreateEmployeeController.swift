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
        view.backgroundColor = .blue
        navigationItem.title = "Create Employee"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
        setupConstraints()
    }
    
    @objc func handleSave() {
        guard let name = nameTextField.text else {return}
        let _ = CoreDataManager.shared.createEmployee(name: name)
        dismiss(animated: true, completion: nil)
        
    }
    
    let lightBlueBackGround: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 173, green: 216, blue: 230)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter Name"
        return tf
    }()
    
    let birthDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Birthday"
        return label
    }()
    
    let birthDayTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter Name"
        return tf
    }()
    
    fileprivate func setupConstraints() {
        
        view.addSubview(lightBlueBackGround)
        lightBlueBackGround.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackGround.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackGround.heightAnchor.constraint(equalToConstant: 250).isActive = true
        lightBlueBackGround.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        lightBlueBackGround.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: lightBlueBackGround.leftAnchor, constant: 8).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.topAnchor.constraint(equalTo: lightBlueBackGround.topAnchor, constant: 8).isActive = true
        
        lightBlueBackGround.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: lightBlueBackGround.rightAnchor, constant: -8).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        lightBlueBackGround.addSubview(birthDayLabel)
        birthDayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        birthDayLabel.leftAnchor.constraint(equalTo: lightBlueBackGround.leftAnchor, constant: 8).isActive = true
        birthDayLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        birthDayLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        lightBlueBackGround.addSubview(birthDayTextField)
        birthDayTextField.leftAnchor.constraint(equalTo: birthDayLabel.rightAnchor).isActive = true
        birthDayTextField.rightAnchor.constraint(equalTo: lightBlueBackGround.rightAnchor, constant: -8).isActive = true
        birthDayTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        birthDayTextField.topAnchor.constraint(equalTo: birthDayLabel.topAnchor).isActive = true
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}
