//
//  UITableView+extension.swift
//  GoFixCustomer
//
//  Created by hieu nguyen on 6/12/18.
//  Copyright © 2018 gofix.vinova.sg. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 9.0, *)
extension UITableView {
    func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        self.register(T.self, forCellReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
    
    func registerXibFile<T: UITableViewCell>(_ type: T.Type) {
        self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T.self))
    }
    
    func register(header: UITableViewHeaderFooterView.Type) {
        self.register(header.self, forHeaderFooterViewReuseIdentifier: String(describing: header.self))
    }
    
    func registerHeaderFooterView(header: UITableViewHeaderFooterView.Type, fromNib: Bool = true) {
        if fromNib {
            self.register(UINib(nibName: header.className, bundle: nil), forHeaderFooterViewReuseIdentifier: header.identifier)
        } else {
            self.register(header.self, forHeaderFooterViewReuseIdentifier: header.identifier)
        }
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                             for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }
    
    func dequeueCell(reuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(header: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as! T
    }
}

@available(iOS 9.0, *)
extension UITableViewHeaderFooterView {
    static var className: String {
        return String(describing: self)
    }
}

