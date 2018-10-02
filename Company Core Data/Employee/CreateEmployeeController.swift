//
//  CreateEmployeeController.swift
//  Company Core Data
//
//  Created by Viswa Kodela on 9/29/18.
//  Copyright © 2018 Viswa Kodela. All rights reserved.
//

import UIKit

protocol CreateEmployeeDelegate: class {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
    
    weak var delegate: CreateEmployeeDelegate?
    
    var company: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationItem.title = "Create Employee"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
        view.backgroundColor = UIColor(red: 0, green: 153, blue: 153)
        setupConstraints()
    }
    
    @objc func handleSave() {
        guard let name = nameTextField.text else {return}
        guard let company = self.company else {return}
        guard let birthdayText = birthDayTextField.text else {return}
        
        if birthdayText.isEmpty {
            showAlert(title: "Birthday Field is Empty", message: "You haven't filled the Birthday Field")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let birthday = dateFormatter.date(from: birthdayText) else {
            showAlert(title: "Bad Date", message: "Birthday not vaild")
            return
        }
        
        guard let employeeType = segemntedControl.titleForSegment(at: segemntedControl.selectedSegmentIndex) else {return}
        
        let tuple = CoreDataManager.shared.createEmployee(name: name, employeeType: employeeType, birthday: birthday, company: company)
        if let error = tuple.1 {
            print(error)
        } else {
            dismiss(animated: true) {
                guard let employee = tuple.0 else {return}
                self.delegate?.didAddEmployee(employee: employee)
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
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
        tf.placeholder = "MM/dd/yyyy"
        return tf
    }()
    
    let segemntedControl: UISegmentedControl = {
        let items = [EmployeeTypes.Executive.rawValue, EmployeeTypes.SeniorManagement.rawValue, EmployeeTypes.Staff.rawValue]
        let sc = UISegmentedControl(items: items)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor(red: 0, green: 153, blue: 153)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    fileprivate func setupConstraints() {
        
        view.addSubview(lightBlueBackGround)
        lightBlueBackGround.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackGround.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackGround.heightAnchor.constraint(equalToConstant: 160).isActive = true
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
        
        lightBlueBackGround.addSubview(segemntedControl)
        segemntedControl.leftAnchor.constraint(equalTo: lightBlueBackGround.leftAnchor, constant: 8).isActive = true
        segemntedControl.rightAnchor.constraint(equalTo: lightBlueBackGround.rightAnchor, constant: -8).isActive = true
        segemntedControl.topAnchor.constraint(equalTo: birthDayLabel.bottomAnchor).isActive = true
        segemntedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}
