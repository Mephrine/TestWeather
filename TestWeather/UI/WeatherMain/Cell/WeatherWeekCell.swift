//
//  WeatherWeekCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherWeekCell: UICollectionViewCell {
    private let tableWeek: UITableView = { () -> UITableView in
        let tableWeek = UITableView.init(frame: CGRect.zero)
        tableWeek.rowHeight = 44
        tableWeek.separatorStyle = .none
        tableWeek.backgroundColor = .clear
        tableWeek.isScrollEnabled = false
        return tableWeek
    }()
    
    private var itemList = [Weather]()
    
    private let itemCell = "WeatherWeekItemCell"
    
    private var viewObserver: NSKeyValueObservation?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableWeek.register(UINib(nibName: itemCell, bundle: nil), forCellReuseIdentifier: itemCell)
        
        self.addSubview(tableWeek)
        
        // autolayout
        tableWeek.translatesAutoresizingMaskIntoConstraints = false
        tableWeek.makeConstTop(self.topAnchor)
        // 테이블 컨텐츠뷰 사이즈 조정 시 bottom priority가 1000인 상태로 height값을 주면 const 에러 발생하므로 999로 설정.
        tableWeek.makeConstBottom(self.bottomAnchor, priority: 999)
        tableWeek.makeConstLeft(self.leftAnchor)
        tableWeek.makeConstRight(self.rightAnchor)
        
        viewObserver = tableWeek.observe(\.contentSize, changeHandler: { [weak self] tableView, change in
            guard let self = self else { return }
            self.tableWeek.invalidateIntrinsicContentSize()
            self.tableWeek.remakeConstHeight(tableView.contentSize.height)
            self.layoutIfNeeded()
        })
        
        self.tableWeek.delegate = self
        self.tableWeek.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(item: DaysWeather) {
        if let list = item.list {
            // 0시 기준으로만 뽑기
            let filterList = list.filter{ $0.dtTxt.contains("00:00:00") }
            self.itemList = filterList
            self.tableWeek.reloadData()
        }
    }
    
    func configuration() {
        self.tableWeek.reloadData()
    }
    
    deinit {
        viewObserver = nil
    }
}

extension WeatherWeekCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count > 10 ? 10 : itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: itemCell, for: indexPath) as! WeatherWeekItemCell
        let cellModel = WeatherWeekModel(itemList[index])
        cell.configuration(item: cellModel)

        return cell
    }
}
