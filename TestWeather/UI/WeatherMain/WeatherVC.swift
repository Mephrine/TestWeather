//
//  WeatherVC.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherVC: BaseVC {
    @IBOutlet weak var tableWeather: UITableView!
    
    private let headerCell      = "WeatherHeaderCell"
    private let centerCell      = "WeatherCenterCell"
    private let weekCell        = "WeatherWeekCell"
    private let descCell        = "WeatherDescCell"
    private let currentInfoCell = "WeatherCurrentInfoCell"
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func initView() {
        //tableView configuration
        tableWeather.delegate = self
        tableWeather.dataSource = self
        tableWeather.estimatedRowHeight = UITableView.automaticDimension
        tableWeather.rowHeight = UITableView.automaticDimension
        tableWeather.separatorStyle = .none
        tableWeather.backgroundColor = .clear
        
        // register
        tableWeather.register(UINib(nibName:headerCell, bundle: nil), forCellReuseIdentifier: headerCell)
        tableWeather.register(UINib(nibName:centerCell, bundle: nil), forCellReuseIdentifier: centerCell)
        tableWeather.register(WeatherWeekCell.self, forCellReuseIdentifier: weekCell)
        tableWeather.register(UINib(nibName:descCell, bundle: nil), forCellReuseIdentifier: descCell)
        tableWeather.register(UINib(nibName:currentInfoCell, bundle: nil), forCellReuseIdentifier: currentInfoCell)
    }
    
    //MARK: - e.g.
    
    
    //MARK: - Networking
    func requestWeather(_ lat: String, _ lon: String) {
        
    }
    
    //MARK: - Action
    @IBAction func tapBtnChange(_ sender: Any) {
        if let listVC = viewController(type: WeatherListVC.self) {
            self.navigationController?.present(listVC, animated: true, completion: nil)
        }
    }
}

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return headerCell(tableView, cellForRowAt: indexPath)
        case 1:
            return centerCell(tableView, cellForRowAt: indexPath)
        case 2:
            return weekCell(tableView, cellForRowAt: indexPath)
        case 3:
            return descCell(tableView, cellForRowAt: indexPath)
        case 4:
            return currentInfoCell(tableView, cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
        
    }
}

extension WeatherVC  {
    func headerCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> WeatherHeaderCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: headerCell) as! WeatherHeaderCell
        cell.configuration()
        
        return cell
    }
    
    func centerCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> WeatherCenterCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: centerCell) as! WeatherCenterCell
        cell.configuration()
        
        return cell
    }
    
    func weekCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> WeatherWeekCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: weekCell) as! WeatherWeekCell
        cell.configuration()
        
        return cell
    }
    
    func descCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> WeatherDescCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: descCell) as! WeatherDescCell
        cell.configuration()
        
        return cell
    }
    
    func currentInfoCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> WeatherCurrentInfoCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: currentInfoCell) as! WeatherCurrentInfoCell
        cell.configuration()
        
        return cell
    }
    
}
