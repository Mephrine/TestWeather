//
//  HeaderFlowLayout.swift
//  TestWeather
//
//  Created by Mephrine on 2020/06/01.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (P) HeaderFlowLayoutScrollDelegate.swift
 - Author: Mephrine
 - Date: 20.06.01
 - Note: UICollectionView의 contentOffset.y를 헤더뷰에서 이용하기 위한 delegate 프로토콜
*/
protocol HeaderFlowLayoutScrollDelegate: NSObject {
    func moveOffsetY(offsetY: CGFloat)
}

/**
 # (C) HeaderFlowLayout.swift
 - Author: Mephrine
 - Date: 20.06.01
 - Note: UICollectionVIewFlowLayout 프레임 조정을 위한 커스텀 FlowLayout
*/
class HeaderFlowLayout: UICollectionViewFlowLayout {
    weak var delegate: HeaderFlowLayoutScrollDelegate?
    
    // 헤더 뷰의 최고 높이 = 450 + SAFE_AREA_TOP. -> SAFE_AREA_TOP은 헤더 상단 높이에 연관되므로 450으로만 계산.
    // 헤더 상단 최소 높이 = 80 + SAFE_AREA_TOP, 헤더 하단 고정 높이 100
    // 최소로 보이게 하려는 높이 = 80 + SAFE_AREA_TOP + 100
    // -> 450 - (80 + SAFE_AREA_TOP + 100)
    private let MAX_HEIGHT: CGFloat = 450 - (80 + 100)
    
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
                    
                    if offsetY > (MAX_HEIGHT - Utils.SAFE_AREA_TOP) {
                        $0.frame = CGRect.init(x: 0, y: offsetY, width: cv.frame.size.width, height: $0.frame.height - (MAX_HEIGHT - Utils.SAFE_AREA_TOP))
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
