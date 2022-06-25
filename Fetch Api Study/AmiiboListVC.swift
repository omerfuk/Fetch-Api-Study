//
//  ViewController.swift
//  Fetch Api Study
//
//  Created by Ömer Faruk Kılıçaslan on 25.06.2022.
//

import UIKit

class AmiiboListVC: UIViewController {
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var amiiboList: [Amiibo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.safeAreaLayoutGuide
        setupTableView()
        
        let anonymusFunction = { (fetchedAmiiboList: [Amiibo]) in
            self.amiiboList = fetchedAmiiboList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        AmiiboAPI.shared.fetchAmiiboList(onCompletion: anonymusFunction)
        
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        
    }


}

extension AmiiboListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amiiboList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid",for: indexPath)
        let amiibo = amiiboList[indexPath.row]
        cell.textLabel?.text = amiibo.name
        return cell
    }
}
