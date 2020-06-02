//
//  BaseTableViewCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) BaseTableViewCell.swift
 - Author: Mephrine
 - Date: 20.05.28
 - Note: 모든 UITableView Cell에 공통적으로 적용하기 위한 부모 셀
*/
class BaseTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.separatorInset = .zero
    }
}
