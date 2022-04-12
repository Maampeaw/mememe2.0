//
//  MemeTableViewDiffableDataSource.swift
//  mememeproject1
//
//  Created by user on 4/10/22.
//

import UIKit

enum Section{
    case all
}

class MemeTableViewDiffableDataSource: UITableViewDiffableDataSource <Section, Meme>{
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    

}
