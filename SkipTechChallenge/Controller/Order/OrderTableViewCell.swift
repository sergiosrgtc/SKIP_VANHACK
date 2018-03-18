//
//  OrderTableViewCell.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 18/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
