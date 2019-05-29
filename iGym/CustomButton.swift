//
//  CustomButton.swift
//  iGym
//
//  Created by Юханов Сергей Сергеевич on 26/03/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        initialSetup()
    }
    
    fileprivate func initialSetup() {
        self.backgroundColor = UIColor.white
        //        self.titleLabel?.font = YSKAppearanceSettings.font(14.0)
        
        self.layer.cornerRadius = 4.0
        self.layer.borderWidth = 1/UIScreen.main.scale
        self.layer.borderColor = UIColor.black.cgColor
    }

}
