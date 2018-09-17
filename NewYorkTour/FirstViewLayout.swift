//
//  FirstViewLayout.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 4. 10..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit


/*
1.  _layoutMap – is a container to keep all UICollectionViewLayoutAttributes for each UICollectionView’s IndexPath appropriately.
 When you call prepare(), you’ll calculate the attributes for all items and add them to this container. When the collection view later requests the layout attributes, you can be efficient and query the cache instead of recalculating them every time.
2.  _columnsYoffset – this array would contain max yOffset for each column. The yOffset array tracks the y-position for every column. So when you’re adding next item to the same column, you would already have yOffset value to start from.
3.  _contentSize – total content size, needed for scroll view.
4.  totalColumns and interItemsSpacing – two public variables for configuring the layout: the number of columns and the cell inter-item space.
5.  contentInsets – is collection view content insets.
 
 */
class FirstViewLayout: UICollectionViewLayout {
    private var _layoutmap = [IndexPath : UICollectionViewLayoutAttributes]() //1
    private var _columnsYoffset: [CGFloat]! //2
    private var _contentSize: CGSize! //3
    
    private(set) var totalItemInSection = 0
    
    //4
    var totalColums = 0
    var interItemSpacing: CGFloat = 8
    
    //5
    var contentInsets: UIEdgeInsets {
        return collectionView!.contentInset
    }
    
    override var collectionViewContentSize: CGSize {
        return _contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
         var layoutAttributesArray = [UICollectionViewLayoutAttributes]()
        
        for (_, layoutAttributes) in _layoutmap {
            if rect.intersects(layoutAttributes.frame) {
                layoutAttributesArray.append(layoutAttributes)
            }
        }
        
        return layoutAttributesArray

    }
    
    func columnIndexForItemAt(indexPath: IndexPath) -> Int {
        return indexPath.item % totalColums
    }
    // 2
    func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat) -> CGRect {
        return CGRect.zero
    }
    // 3
    func calculateItemsSize() {}
    
    override func prepare() {
        // 1
        _layoutmap.removeAll()
        _columnsYoffset = Array(repeating: 0, count: totalColums)
        
        totalItemInSection = collectionView!.numberOfItems(inSection: 0)
        
        // 2
        if totalItemInSection > 0 && totalColums > 0 {
            // 3
            self.calculateItemsSize()
            
            var itemIndex = 0
            var contentSizeHeight: CGFloat = 0
            
            // 4
            while itemIndex < totalItemInSection {
                // 5
                let indexPath = IndexPath(item: itemIndex, section: 0)
                let columnIndex = self.columnIndexForItemAt(indexPath: indexPath)
                
                // 6
                let attributeRect = calculateItemFrame(indexPath: indexPath, columnIndex: columnIndex, columnYoffset: _columnsYoffset[columnIndex])
                let targetLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                targetLayoutAttributes.frame = attributeRect
                
                // 7
                contentSizeHeight = max(attributeRect.maxY, contentSizeHeight)
                _columnsYoffset[columnIndex] = attributeRect.maxY + interItemSpacing
                _layoutmap[indexPath] = targetLayoutAttributes
                
                itemIndex += 1
            }
            
            // 8
            _contentSize = CGSize(width: collectionView!.bounds.width - contentInsets.left - contentInsets.right,
                                  height: contentSizeHeight)
        }
    }
    
    
}
