//
//  MemeTableViewCell.swift
//  mememeproject1
//
//  Created by user on 4/10/22.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    @IBOutlet var memeImage: UIImageView!
    @IBOutlet var memeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
