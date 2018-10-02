//
//  ViewController.swift
//  Company Core Data
//
//  Created by Viswa Kodela on 9/18/18.
//  Copyright © 2018 Viswa Kodela. All rights reserved.
//

import UIKit
import CoreData

class CompaniesViewController: UITableViewController, CreateCompanyControllerDelegate {
    
    let cellId = "cellId"
    
    var companies = [Company]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationStyle()
        fetchCompanies()
        tableView.register(CompanyCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor(red: 0, green: 128, blue: 128)
        tableView.separatorStyle = .none
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
    }
    
    @objc func handleReset() {
        
        let context = CoreDataManager.shared.persistanceContainer.viewContext
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            
            var indexpathsToRemove = [IndexPath]()
            
            for (index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexpathsToRemove.append(indexPath)
            }
            companies.removeAll()
            tableView.deleteRows(at: indexpathsToRemove, with: .left)
        } catch {
            print(error)
        }
    }
    
    fileprivate func fetchCompanies() {
        
        let context = CoreDataManager.shared.persistanceContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            self.companies = companies
            self.tableView.reloadData()
        } catch {
            print("Failed to fetch Companies: \(error)")
        }
    }
    
    func addCompany(with comapany: Company) {
        self.companies.append(comapany)
        let indexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .top)
    }
    
    func editCompany(of company: Company) {
        guard let row = self.companies.index(of: company) else {return}
        let indexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
    func setupNavigationStyle() {
        
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(plusButtonTapped))
    }
    
    @objc func plusButtonTapped() {
        let createCompanies = CreateCompaniesController()
        let navBar = UINavigationController(rootViewController: createCompanies)
        createCompanies.delgate = self
        present(navBar, animated: true, completion: nil)
    }
    
    //MARK:- UITableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CompanyCell
        
        let company = self.companies[indexPath.row]
        cell.company = company
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let company = self.companies[indexPath.row]
        let employeesController = EmployeesContoller()
        employeesController.company = company
        navigationController?.pushViewController(employeesController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            let company = self.companies[indexPath.row]
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            let context = CoreDataManager.shared.persistanceContainer.viewContext
            context.delete(company)
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            
            let editCompany = CreateCompaniesController()
            editCompany.delgate = self
            let navBar = UINavigationController(rootViewController: editCompany)
            editCompany.company = self.companies[indexPath.row]
            self.present(navBar, animated: true, completion: nil)
            
        }
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "No Companies Available..."
        label.textColor = .white
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.isEmpty ? 150 : 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    } 
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Names"
        return label
    }()
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
//        view.translatesAutoresizingMaskIntoConstraints = false
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Names"
//        label.backgroundColor = .lightGray
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//
//        view.addSubview(label)
//
//        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
//        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
//        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        return view
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

