//
//  ViewController.swift
//  Challenge2
//
//  Created by Melody Davis on 7/23/22.
//

import UIKit

class ViewController: UITableViewController {
    var allItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearList))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = allItems[indexPath.row]
        return cell
    }
    
    // delete individual cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Enter item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitItem = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        
        ac.addAction(submitItem)
        present(ac, animated: true)
    }
    
    @objc func clearList() {
        let ac = UIAlertController(title: "Clear entire list?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: { action in
            self.allItems.removeAll()
            self.tableView.reloadData()
        }))
        ac.addAction(UIAlertAction(title: "No", style: .default))
        present(ac, animated: true)
    }
    
    func submit(_ item: String) {
        allItems.insert(item, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
}

