//
//  UITextField+Extensions.swift
//  Superstar Mentor
//
//  Created by vinova on 10/9/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else { return }
        attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }
}
