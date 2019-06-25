//
//  TrainingCell.swift
//  iGym
//
//  Created by Юханов Сергей Сергеевич on 04/04/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit

class TrainingCell: UITableViewCell {

    
    var dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // code common to all your cells goes here
        self.addSubview(dateLabel)
       

        
    }
    
    func iconFrame() {
        let iconSideLinght: CGFloat = 100
        let iconSize = CGSize(width: iconSideLinght, height: iconSideLinght)
        let iconOrigin = CGPoint(x: bounds.midX - iconSideLinght / 2, y: bounds.midY - iconSideLinght / 2)
        dateLabel.frame = CGRect(origin: iconOrigin, size: iconSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconFrame()
        
    }
    

}
