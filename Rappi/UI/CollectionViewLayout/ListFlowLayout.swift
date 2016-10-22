//
//  List.swift
//  Rappi
//
//  Created by lbriceno on 10/19/16.
//  Copyright © 2016 Lbriceno. All rights reserved.
//

import UIKit

class ListFlowLayout: UICollectionViewFlowLayout {
    let itemHeight: CGFloat = 120
    
    override init() {
        super.init()
        setupLayout()
    }
    
    /**
     Init method
     
     - parameter aDecoder: aDecoder
     
     - returns: self
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 5
        minimumLineSpacing = 5
        scrollDirection = .Vertical
    }
    
    func itemWidth() -> CGFloat {
        return CGRectGetWidth(collectionView!.frame)
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSizeMake(itemWidth(), itemHeight)
        }
        get {
            return CGSizeMake(itemWidth(), itemHeight)
        }
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}