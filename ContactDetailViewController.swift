//
//  ContactDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Keshawn Swanston on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    var contact: Contact!
    
    
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        nameLabel.text = contact.name.fullName.capitalized
        emailLabel.text = contact.email
        locationLabel.text = contact.location.state.capitalized
        getImage()
    }
    
    
    func getImage() {
        let apiManager = APIManager()
        apiManager.getData(endPoint: contact.picture.large) { (data: Data?) in
            if let data = data {
                DispatchQueue.main.async {
                    self.contactImageView.image = UIImage(data: data)
                }
            }
        }
    }

}
