//
//  EmployeesController.swift
//  Company Core Data
//
//  Created by Viswa Kodela on 9/29/18.
//  Copyright © 2018 Viswa Kodela. All rights reserved.
//

import UIKit
import CoreData

class IndentedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 50, left: 16, bottom: 0, right: 0)
        let customeRect = CGRect().inset(by: insets)
        super.drawText(in: customeRect)
    }
}

class EmployeesContoller: UITableViewController, CreateEmployeeDelegate {
    
    func didAddEmployee(employee: Employee) {
        
        guard let employeeType = employee.type else { return }
        guard let section = employeeTypes.index(of: EmployeeTypes(rawValue: employeeType)!) else {return}
        let row = allEmployees[section].count
        let indexPath = IndexPath(row: row, section: section)
        allEmployees[section].append(employee)
        tableView.insertRows(at: [indexPath], with: .middle)
    }
    
    var company: Company?
    let cellId = "cellId"
    var employees = [Employee]()
    var allEmployees = [[Employee]]()
    
//    var executiveEmployees: [Employee]?
//    var seniorManagementEmployees: [Employee]?
//    var staffEmployees: [Employee]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(handlePlusButton))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0, green: 128, blue: 128)
        fetchEmployees()
    }
    
    var employeeTypes = [EmployeeTypes.Executive, EmployeeTypes.SeniorManagement, EmployeeTypes.Staff]
    
    private func fetchEmployees() {
        
        guard let employeess = company?.employees?.allObjects as? [Employee] else {return}
//        self.employees = employeess
//        let context = CoreDataManager.shared.persistanceContainer.viewContext
//
//        let request = NSFetchRequest<Employee>(entityName: "Employee")
//        do {
//            let employee = try context.fetch(request)
//            self.employees = employee
//            tableView.reloadData()
//        } catch {
//            print("Failed to fetch Employees:", error)
//        }
        
        allEmployees.removeAll()
        
        self.employeeTypes.forEach { (emptype) in
            
            allEmployees.append(employeess.filter({ (employ) -> Bool in
                return employ.type == emptype.rawValue
            }))
        }
        
//        let executives = employeess.filter { (employee) -> Bool in
//            return employee.type == EmployeeTypes.Executive.rawValue    //"Executive"
//        }
//
//        let seniorManagement = employeess.filter { (employee) -> Bool in
//            return employee.type == EmployeeTypes.SeniorManagement.rawValue //"Senior Management"
//        }
//
//        let staff = employeess.filter { $0.type == EmployeeTypes.Staff.rawValue }
//
//        allEmployees = [executives, seniorManagement, staff]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }
    
    @objc func handlePlusButton() {
        let createEmployee = CreateEmployeeController()
        let createEmployeeWithNavBar = UINavigationController(rootViewController: createEmployee)
        createEmployee.delegate = self
        createEmployee.company = self.company
        present(createEmployeeWithNavBar, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
//        if section == 0 {
//            return shortNameEmployees.count
//        } else {
//            return longNameEmployees.count
//        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
//        let employee = employees[indexPath.row]
//        let employee = indexPath.section == 0 ? shortNameEmployees[indexPath.row] : longNameEmployees[indexPath.row]
        
        let employee = allEmployees[indexPath.section][indexPath.row]
        
        if let employeeBirthday = employee.birthDay {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let birthday = dateFormatter.string(from: employeeBirthday)
            cell.textLabel?.text = "\(employee.name ?? "")     \(birthday)"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
        cell.backgroundColor = UIColor(red: 128, green: 128, blue: 128)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
//        if section == 0 {
//            label.text = "Executive"
//        } else if section == 1 {
//            label.text = "Senior Management"
//        } else {
//            label.text = "Staff"
//        }
        label.text = employeeTypes[section].rawValue
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = UIColor(red: 32, green: 32, blue: 32)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
