//
//  WeatherWeekCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherWeekCell: BaseTableViewCell, BaseCellProtocol {
    private lazy var tableWeek = UITableView.init(frame: CGRect.zero)
    private var weekList = [String]()
    
    private let itemCell = "WeatherWeekItemCell"
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableWeek.delegate = self
        tableWeek.dataSource = self
        tableWeek.estimatedRowHeight = 50
        tableWeek.rowHeight = UITableView.automaticDimension
        tableWeek.separatorStyle = .none
        tableWeek.backgroundColor = .clear
        
        tableWeek.register(UINib(nibName: itemCell, bundle: nil), forCellReuseIdentifier: itemCell)
        
        self.addSubview(tableWeek)
        tableWeek.makeConstSuperView()
    }
    
    func configuration() {

    }
}

extension WeatherWeekCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemCell, for: indexPath) as! WeatherWeekItemCell
        cell.configuration()
        
        return cell
    }
}
