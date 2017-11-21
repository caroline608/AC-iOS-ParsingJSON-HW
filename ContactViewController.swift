//
//  ContactViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Keshawn Swanston on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {

    var contacts = [Contact]()
    var searchBar = UISearchBar()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    var searchTerm: String? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var filteredContacts: [Contact] {
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return contacts
        }
        return contacts.filter{$0.name.fullName.lowercased().contains(searchTerm.lowercased())}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchButton = navigationItem.rightBarButtonItem
        loadData()
    }
    
    func loadData() {
        guard let path = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            return
        }
        let myURL = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: myURL) else { return }
        let myDecoder = JSONDecoder()
        do {
            let results = try myDecoder.decode(ResultsWrapper.self, from: data)
            self.contacts = results.results.sorted(by: {$0.name.fullName < $1.name.fullName})
        }
        catch let error {
            print(error)
        }
    }
    
    
    //    MARK: - Data Source Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (filteredContacts.max{$0.name.sectionName.number < $1.name.sectionName.number}?.name.sectionName.number)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.filter{$0.name.sectionName.number == section}.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = filteredContacts.filter{$0.name.sectionName.number == indexPath.section}[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        cell.textLabel?.text = "\(contact.name.fullName.capitalized)"
        cell.detailTextLabel?.text = contact.location.state.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredContacts.filter{$0.name.sectionName.1 == section}.first?.name.sectionName.0
    }
    

    //    MARK: - Search Bar Methods
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        showSearchBar()
    }
    
    func showSearchBar() {
        searchBar.alpha = 0
        navigationItem.titleView = searchBar
        navigationItem.setLeftBarButton(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBar.becomeFirstResponder()
        })
    }
    
    func hideSearchBar() {
        navigationItem.titleView = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
        hideSearchBar()
    }
   

    
    // MARK: - Navigation

    override func prepare(for segue:  UIStoryboardSegue, sender: Any?) {
        guard
            let contactDVC = segue.destination as? ContactDetailViewController,
            let contactCell = sender as? UITableViewCell,
            let thisIndexPath = tableView.indexPath(for: contactCell)
            else {
                return
        }
        let thisContact = filteredContacts[thisIndexPath.row]
        contactDVC.contact = thisContact
    }
    

}
