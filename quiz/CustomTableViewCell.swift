//
//  CustomTableViewCell.swift
//  quiz
//
//  Created by 濱野将士 on 2017/12/05.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var listImageView: UIImageView!
    
    @IBOutlet weak var listLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var godinfo = GodList[indexPath.row] as! NSDictionary
    print(godinfo["name"] as! String)
    print(godinfo["image"] as! String)
    
    
}
