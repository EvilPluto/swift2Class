//
//  PhotoCell.swift
//  Swift2Class
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 team. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodStar: UILabel!
    @IBOutlet weak var foodDetail: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
