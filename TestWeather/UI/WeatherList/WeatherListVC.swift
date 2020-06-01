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
    private var cityList = Utils.unarchiveWeatherList()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func initView() {
        tableList.delegate = self
        tableList.dataSource = self
        tableList.backgroundColor = .white
        tableList.rowHeight = 60
        tableList.separatorStyle = .none
//        tableList.setEditing(true, animated: false)
        
        tableList.register(UINib(nibName: itemCell, bundle: nil), forCellReuseIdentifier: itemCell)
    }
    
    //MARK: - e.g.
    
    //MARK: - Action
    @IBAction func tapBtnSearch(_ sender: Any) {
        // SearchViewController 실행하기.
        if let searchVC = viewController(storyboard: "Main", type: SearchVC.self) {
            searchVC.resultsHandler = { [weak self] in
                self?.cityList = Utils.unarchiveWeatherList()
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        switch editingStyle {
        case .delete:
            Utils.removeLocation(index: index)
            self.cityList = Utils.unarchiveWeatherList()
            tableView.deleteRows(at: [indexPath], with: .fade)
            break
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let index = indexPath.row
        if index == Utils.selectedIndexOfLocation() {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        if let cell = tableView.dequeueReusableCell(withIdentifier: itemCell, for: indexPath) as? WeatherListCell, let item = cityList?[index] {
            cell.configuration(item: item)
            
            return cell
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
