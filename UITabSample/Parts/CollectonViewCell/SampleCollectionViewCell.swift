//
//  SampleCollectionViewCell.swift
//  UITabSample
//
//  Created by 水野祥子 on 2018/01/28.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var CategoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func Set(Text:String){
        CategoryNameLabel.layer.borderColor = UIColor.blue.cgColor
        CategoryNameLabel.layer.borderWidth = 10
        CategoryNameLabel.text = Text
    }

}
