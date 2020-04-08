//
//  UICollectionView+Extension.swift
//  
//
//  Created by Dara Beng on 3/12/20.
//

import UIKit


extension UICollectionView {
    
    // MARK: Register
    
    func registerCell<Cell>(_ cell: Cell.Type) where Cell: UICollectionViewCell {
        register(cell, forCellWithReuseIdentifier: Cell.reuseID)
    }
    
    func registerHeader<Header>(_ header: Header.Type) where Header: UICollectionReusableView {
        register(header, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.reuseID)
    }
    
    func registerFooter<Footer>(_ footer: Footer.Type) where Footer: UICollectionReusableView {
        register(footer, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Footer.reuseID)
    }
    
    // MARK: Dequeue
    
    func dequeueCell<Cell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UICollectionViewCell {
        dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPath) as! Cell
    }
    
    func dequeueHeader<Header>(_ header: Header.Type, for indexPath: IndexPath) -> Header where Header: UICollectionReusableView {
        dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.reuseID, for: indexPath) as! Header
    }
    
    func dequeueFooter<Footer>(_ header: Footer.Type, for indexPath: IndexPath) -> Footer where Footer: UICollectionReusableView {
        dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Footer.reuseID, for: indexPath) as! Footer
    }
}

