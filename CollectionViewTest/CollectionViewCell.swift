//
//  CollectionViewCell.swift
//  CollectionViewTest
//
//  Created by 段昊宇 on 16/4/15.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView?
    
    var text: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        
        imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: CGRectGetWidth(self.frame) - 10, height: CGRectGetHeight(self.frame) - 30))
        imageView?.backgroundColor = rand_color()
        
        if let imageView = imageView {
            self.addSubview(imageView)
            
            text = UILabel(frame: CGRect(x: 5, y: CGRectGetMaxY(imageView.frame), width: CGRectGetWidth(self.frame) - 10, height: 20))
            text?.backgroundColor = UIColor.clearColor()
            text?.textAlignment = .Center
            
            if let text = text {
                self.addSubview(text)
            }
        }
    }
    
    func rand_color() -> UIColor {
        let color:  CGFloat = CGFloat(random()) / CGFloat(RAND_MAX);
        let color1: CGFloat = CGFloat(random()) / CGFloat(RAND_MAX);
        let color2: CGFloat = CGFloat(random()) / CGFloat(RAND_MAX);
        let color3: CGFloat = CGFloat(random()) / CGFloat(RAND_MAX);
        // txta.text = "result: \(color) \(color1) \(color2)";
        return UIColor(red: color, green: color1, blue: color2, alpha: 1);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
