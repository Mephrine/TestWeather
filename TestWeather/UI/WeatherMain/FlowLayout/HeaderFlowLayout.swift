//
//  HeaderFlowLayout.swift
//  TestWeather
//
//  Created by Mephrine on 2020/06/01.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class HeaderFlowLayout: UICollectionViewFlowLayout {
    // 헤더 상단 최소 높이 150 + 하단 최소 높이 100
    private let MAX_HEIGHT: CGFloat = 250
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attr = super.layoutAttributesForElements(in: rect)
        
        attr?.forEach {
            if $0.representedElementKind == UICollectionView.elementKindSectionHeader,
            $0.indexPath.section == 0 {
                if let cv = collectionView {
                    // 스크롤 관련 처리.
                    let offsetY = cv.contentOffset.y
                    p("offsetY : \(offsetY) | \($0.frame.height) | \($0.frame.height)")
                    
                    if offsetY > MAX_HEIGHT {
                        $0.frame = CGRect.init(x: 0, y: offsetY, width: cv.frame.size.width, height: $0.frame.height - MAX_HEIGHT)
                        return
                    }
                    
                    $0.frame = CGRect.init(x: 0, y: offsetY, width: cv.frame.size.width, height: $0.frame.height - offsetY)
                }
            }
        }
        
        return attr
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
