//
//  CoinView.swift
//  Planck
//
//  Created by NULL on 12/04/15.
//  Copyright (c) 2015年 Echx. All rights reserved.
//

import UIKit

class CoinView: UIView {
    
    private struct CoinImage {
        static let normal = UIImage(named: "coin");
        static let empty = UIImage(named: "emptycoin")
    }
    
    let defaultWidth: CGFloat = 150;
    var imageView: UIImageView
    init(isOn: Bool, width: CGFloat = 150) {
        let rect = CGRectMake(0, 0, width, width)
        self.imageView = UIImageView(frame: rect)
        super.init(frame: rect)
        if isOn {
            self.imageView.image = CoinImage.normal
        } else {
            self.imageView.image = CoinImage.empty
        }
        self.addSubview(self.imageView)
    }

    required init(coder aDecoder: NSCoder) {
        let rect = CGRectMake(0, 0, self.defaultWidth, self.defaultWidth)
        self.imageView = UIImageView(frame: rect)
        super.init(coder: aDecoder)
        self.imageView.image = CoinImage.normal
        self.addSubview(self.imageView)
    }
    
    func setEmpty(booleanValue: Bool) {
        if booleanValue {
            self.imageView.image = CoinImage.empty
        } else {
            self.imageView.image = CoinImage.normal
        }
    }
}
