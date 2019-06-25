//
//  SetTableViewCell.swift
//  iGym
//
//  Created by Сергей Юханов on 18/04/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit

class SetTableViewCell: UITableViewCell {

    var exLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // code common to all your cells goes here
        self.addSubview(exLabel)
   
        
        
    }
    
    func iconFrame() {
        let iconSideLinght: CGFloat = 200
        let iconSize = CGSize(width: iconSideLinght, height: iconSideLinght)
        let iconOrigin = CGPoint(x: bounds.midX - iconSideLinght / 2, y: bounds.midY - iconSideLinght / 2)
        exLabel.frame = CGRect(origin: iconOrigin, size: iconSize)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconFrame()
        
    }


}
