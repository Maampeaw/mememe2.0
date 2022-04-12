//
//  newTableViewController.swift
//  mememeproject1
//
//  Created by user on 4/12/22.
//

import UIKit

class newTableViewController: UITableViewController {
//    var trial = ["heart.fill"]
    lazy var dataSource = configureTable()
    
    func configureTable()->MemeTableViewDiffableDataSource{
        let cellIdentifier = "memedataCell"
        
        let dataSource = MemeTableViewDiffableDataSource(tableView: self.tableView, cellProvider: {tableView, indexPath, meme in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! newTableViewCell
            cell.memedImage?.image = UIImage(systemName: "heart.fill")
            return cell
        })
        
        
        return dataSource
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("I am working")
        var snapShot = NSDiffableDataSourceSnapshot<Section, Meme>()
        snapShot.appendSections([.all])
        snapShot.appendItems(memes, toSection: .all)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
     print(memes)
        super.viewWillAppear(animated)
        print(memes.count)
        tableView.reloadData()
//        var snapShot = NSDiffableDataSourceSnapshot<Section, Meme>()
//        snapShot.appendSections([.all])
//        snapShot.appendItems(memes, toSection: .all)
    }

  
}
