//
//  MainTVCell.swift
//  MedVents
//
//  Created by Alex de France on 3/6/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit

class MainTVCell: UITableViewCell {
    
    @IBOutlet weak var eventLbl: UILabel!
    @IBOutlet weak var medLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        
        
    }

    

}
