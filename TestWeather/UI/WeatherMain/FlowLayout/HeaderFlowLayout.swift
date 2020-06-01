//
//  HeaderFlowLayout.swift
//  TestWeather
//
//  Created by Mephrine on 2020/06/01.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

protocol HeaderFlowLayoutScrollDelegate: NSObject {
    func moveOffsetY(offsetY: CGFloat)
}

class HeaderFlowLayout: UICollectionViewFlowLayout {
    weak var delegate: HeaderFlowLayoutScrollDelegate?
    // 헤더 상단 최소 높이 150 + 하단 고정 높이 100
    private let MAX_HEIGHT: CGFloat = 250 + Utils.SAFE_AREA_TOP
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attr = super.layoutAttributesForElements(in: rect)
        
        attr?.forEach {
            if $0.representedElementKind == UICollectionView.elementKindSectionHeader,
            $0.indexPath.section == 0 {
                if let cv = collectionView {
                    // 스크롤 관련 처리.
                    let offsetY = cv.contentOffset.y
                    
                    if offsetY < 0 {
                        return
                    }
                    
                    delegate?.moveOffsetY(offsetY: offsetY)
                    
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
