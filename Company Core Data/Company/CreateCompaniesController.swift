//
//  PersonsTableViewController.swift
//  Company Core Data
//
//  Created by Viswa Kodela on 9/19/18.
//  Copyright © 2018 Viswa Kodela. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate: class {
    func addCompany(with comapany: Company)
    func editCompany(of company: Company)
}

class CreateCompaniesController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    weak var delgate: CreateCompanyControllerDelegate?
    
    var company: Company?  {
        didSet {
            nameTextField.text = company?.name
            guard let founded = company?.founded else {return}
            datePicker.date = founded
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    lazy var companyImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "select_photo_empty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(companyImageViewTapped)))
        return imageView
    }()
    
    @objc func companyImageViewTapped() {
        print("Image Tapped")
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        companyImageView.image = originalImage
        companyImageView.layer.borderColor = UIColor.black.cgColor
        companyImageView.layer.borderWidth = 2
        
        dismiss(animated: true, completion: nil)
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter name"
        return tf
    }()
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.datePickerMode = .date
        return dp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    
    fileprivate func setupUI() {
        
        let lightBlueView = UIView()
        lightBlueView.translatesAutoresizingMaskIntoConstraints = false
        lightBlueView.backgroundColor = UIColor(red: 173, green: 216, blue: 230)
        
        view.addSubview(lightBlueView)
        lightBlueView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        lightBlueView.addSubview(companyImageView)
        companyImageView.topAnchor.constraint(equalTo: lightBlueView.topAnchor, constant: 8).isActive = true
        companyImageView.centerXAnchor.constraint(equalTo: lightBlueView.centerXAnchor).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        lightBlueView.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: lightBlueView.leftAnchor, constant: 16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        lightBlueView.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: lightBlueView.rightAnchor, constant: -8).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        lightBlueView.addSubview(datePicker)
        datePicker.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: lightBlueView.rightAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: lightBlueView.bottomAnchor).isActive = true
    }
    
    func setupNavigationStyle() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 153, blue: 153)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Create Company"
        view.backgroundColor = UIColor(red: 0, green: 128, blue: 128)
        setupNaigationButtons()
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    fileprivate func setupNaigationButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    @objc func handleSave() {
        if company == nil {
            createCompany()
        } else {
            updateCompany()
        }
    }
    
    fileprivate func createCompany() {
        let context = CoreDataManager.shared.persistanceContainer.viewContext
        
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(nameTextField.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        
        if let companyImage = companyImageView.image {
            let imageData = companyImage.jpegData(compressionQuality: 0.8)
            company.setValue(imageData, forKey: "imageData")
        }
        
        // Perform the save
        do {
            try context.save()
            dismiss(animated: true) {
                self.delgate?.addCompany(with: company as! Company)
            }
        } catch {
            print(error)
        }
    }
    
    fileprivate func updateCompany() {
        let context = CoreDataManager.shared.persistanceContainer.viewContext
        company?.name = nameTextField.text
        company?.founded = datePicker.date
        
        let imageData = companyImageView.image?.jpegData(compressionQuality: 0.8)
        company?.imageData = imageData
        do {
            try context.save()
            dismiss(animated: true) {
                guard let company = self.company else {return}
                self.delgate?.editCompany(of: company)
            }
        } catch {
            print(error)
        }
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
