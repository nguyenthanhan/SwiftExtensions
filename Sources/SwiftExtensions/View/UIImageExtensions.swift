//
//  UIImageExtensions.swift
//  Khind
//
//  Created by An Nguyen Thanh on 8/22/19.
//  Copyright © 2019 KaiPham. All rights reserved.
//
import Foundation
import UIKit

@available(iOS 9.0, *)
extension UIImageView {
    func setRoundedWithBorder(borderColor : UIColor = UIColor.lightGray, borderWidth : CGFloat = 1) {
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
