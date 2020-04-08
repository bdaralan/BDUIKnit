//
//  UITableView+Extension.swift
//  
//
//  Created by Dara Beng on 3/12/20.
//

import UIKit


extension UITableView {
    
    // MARK: Register
    
    func registerCell<Cell>(_ cell: Cell.Type) where Cell: UICollectionViewCell {
        register(cell, forCellReuseIdentifier: cell.reuseID)
    }
    
    func registerHeader<HeaderFooter>(_ headerFooter: HeaderFooter.Type) where HeaderFooter: UIView {
        register(headerFooter, forHeaderFooterViewReuseIdentifier: headerFooter.reuseID)
    }
    
    // MARK: Dequeue
    
    func dequeueCell<Cell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UITableViewCell {
        dequeueReusableCell(withIdentifier: cell.reuseID, for: indexPath) as! Cell
    }
    
    func dequeueHeaderFooter<HeaderFooter>(_ headerFooter: HeaderFooter.Type) -> HeaderFooter where HeaderFooter: UIView {
        dequeueReusableHeaderFooterView(withIdentifier: headerFooter.reuseID) as! HeaderFooter
    }
}

