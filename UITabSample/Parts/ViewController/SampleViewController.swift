//
//  SampleViewController.swift
//  UITabSample
//
//  Created by 水野祥子 on 2018/01/28.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {
    let viewframewidth:CGFloat = UIScreen.main.bounds.size.width

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func Set(Text:String){
        let Label = UILabel(frame:CGRect.zero)
        Label.frame.size = CGSize(width:viewframewidth, height:100)
        Label.center = self.view.center
        Label.text = Text
        Label.textAlignment = .center
        Label.layer.borderColor = UIColor.blue.cgColor
        Label.layer.borderWidth = 1
        self.view.backgroundColor = .white
        self.view.addSubview(Label)
    }
}
