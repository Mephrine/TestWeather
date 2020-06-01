//
//  WeatherListVC.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherListVC: BaseVC {
    // IBOutlet
    @IBOutlet weak var tableList: UITableView!
    
    // Cell
    private let itemCell = "WeatherListCell"
    
    // 반환 Closure
    var resultsHandler: ((Double, Double) -> Void)?
    
    // e.g.
    private var cityList = Defaults.array(forKey: UD_REGI_LOCATION_LIST) as? [WeatherListModel]
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func initView() {
        tableList.delegate = self
        tableList.dataSource = self
        tableList.backgroundColor = .white
        tableList.estimatedRowHeight = 80
        tableList.rowHeight = 80
        tableList.separatorStyle = .singleLine
        
        tableList.register(UINib(nibName: itemCell, bundle: nil), forCellReuseIdentifier: itemCell)
    }
    
    //MARK: - e.g.
    
    
    //MARK: - Action
    @IBAction func tapBtnSearch(_ sender: Any) {
        // SearchViewController 실행하기.
        if let searchVC = viewController(storyboard: "Main", type: SearchVC.self) {
            searchVC.resultsHandler = { [weak self] in
                self?.cityList = Defaults.array(forKey: UD_REGI_LOCATION_LIST) as? [WeatherListModel]
                self?.tableList.reloadData()
            }
        
            searchVC.modalPresentationStyle = .pageSheet
            self.navigationController?.present(searchVC, animated: true) {
                DispatchQueue.main.async {
                    searchVC.focusSearchBar()
                }
            }
        }
    }
}


extension WeatherListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        if let cell = tableView.dequeueReusableCell(withIdentifier: itemCell, for: indexPath) as? WeatherListCell, let item = cityList?[index] {
            cell.configuration(item: item)
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        Utils.setSelectedIndexOfLocation(index: index)
        
        if let item = cityList?[index] {
            self.dismiss(animated: true) { [weak self] in
                self?.resultsHandler?(item.lat, item.lon)
            }
        }
    }
}
