//
//  BaseCollectionViewCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/31.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        // 레이아웃 초기화
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
}

