//
//  CustomTableViewCell.swift
//  gitclient
//
//  Created by 小林知弥 on 2018/02/27.
//  Copyright © 2018年 小林知弥. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Label1: UILabel!
    
    @IBOutlet weak var Label2: UILabel!
    
    @IBOutlet weak var Label3: UILabel!
    
    
    
    func setCell(LabelText1: String, LabelText2: String, LabelText3: String) {
        self.Label1.text = LabelText1
        self.Label2.text = LabelText2
        self.Label3.text = LabelText3
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
