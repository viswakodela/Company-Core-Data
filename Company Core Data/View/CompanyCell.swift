//
//  CompanyCell.swift
//  Company Core Data
//
//  Created by Viswa Kodela on 9/29/18.
//  Copyright © 2018 Viswa Kodela. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewsAndConstraints()
    }
    
    var company: Company! {
        didSet {
            if let name = company.name, let founded = company.founded {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                
                if let imageData = company.imageData {
                    imageview.image = UIImage(data: imageData)
                }
                let foundedDateString = dateFormatter.string(from: founded)
                label.text = "\(name) - Founded: \(foundedDateString)"
            }
            backgroundColor = UIColor(red: 250, green: 250, blue: 210)
        }
    }
    
    let imageview: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = 20
        imageview.clipsToBounds = true
        return imageview
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    fileprivate func setupViewsAndConstraints() {
        
        addSubview(imageview)
        
        imageview.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        imageview.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(label)
        label.leftAnchor.constraint(equalTo: imageview.rightAnchor, constant: 8).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        label.topAnchor.constraint(equalTo: imageview.topAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
