//
//  CardECell.swift
//  iBPMMonitor
//
//  Created by kuutsav on 5/24/17.
//  Copyright © 2017 Qi Zhan. All rights reserved.
//

import UIKit
import MMCardView

class CardECell: CardCell , CardCellProtocol  {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var labTitle:UILabel!
    @IBOutlet weak var txtView:UITextView!
    
    public static func cellIdentifier() -> String {
        return "CardE"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(colorLiteralRed: 0.110, green: 0.584, blue: 0.820, alpha: 1.00)
        // Initialization code
    }


}
