//
//  WeatherListVC.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) WeatherListVC.swift
 - Author: Mephrine
 - Date: 20.05.29
 - Note: 추가한 도시 리스트들을 보여주는 뷰컨트롤러
*/
class WeatherListVC: BaseVC {
    // IBOutlet
    @IBOutlet weak var tableList: UITableView!
    @IBOutlet weak var ivBg: UIImageView!
    
    // Cell
    private let itemCell = "WeatherListCell"
    
    // 반환 Closure
    var resultsHandler: ((Double, Double) -> Void)?
    
    // e.g.
    private var cityList = Utils.unarchiveWeatherList()
    
    private var blurView: UIVisualEffectView?
    var bgImageNm: String?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func initView() {
        if let imageNm = bgImageNm {
            ivBg.image = UIImage(named: imageNm)
        }
        
        tableList.delegate = self
        tableList.dataSource = self
        tableList.backgroundColor = .clear
        tableList.rowHeight = 60
        tableList.separatorStyle = .none
        
//        tableList.setEditing(true, animated: false)
        
        tableList.register(UINib(nibName: itemCell, bundle: nil), forCellReuseIdentifier: itemCell)
    }
    
    //MARK: - e.g.
    
    //MARK: - Action
    /**
     # tapBtnSearch
     - Author: Mephrine
     - Date: 20.05.29
     - Parameters:
        - sender : UIButton sender
     - Returns:
     - Note: 다른 곳의 위치를 추가하기 위해서 SearchVC를 호출하는 함수
    */
    @IBAction func tapBtnSearch(_ sender: Any) {
        // SearchViewController 실행하기.
        if let searchVC = viewController(storyboard: "Main", type: SearchVC.self) {
            // searchVC 반환 값 처리
            searchVC.resultsHandler = { [weak self] isSelected in
                
                UIView.animate(withDuration: 0.3, animations: {
                    self?.blurView?.alpha = 0.0
                }) { completion in
                    self?.blurView?.removeAllSubviews()
                    self?.blurView?.removeAllConstraints()
                    self?.blurView?.removeFromSuperview()
                    self?.blurView = nil
                }
                if isSelected {
                    self?.cityList = Utils.unarchiveWeatherList()
                    self?.tableList.reloadData()
                }
                
            }
        
            searchVC.modalPresentationStyle = .formSheet
            searchVC.view.isOpaque = false
            searchVC.view.backgroundColor = .clear
            
            // Blur 추가
            let blurEffect = UIBlurEffect(style: .regular)
            self.blurView = UIVisualEffectView(effect: blurEffect)
            
            self.view.addSubview(self.blurView!)
            self.blurView!.makeConstSuperView()
            self.blurView!.alpha = 0.0
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.blurView?.alpha = 1.0
            }
            
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
            cell.configuration(item: item, index: index)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        Utils.setSelectedIndexOfLocation(index: index)
        
        if let item = cityList?[index] {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: { [weak self] in
                    self?.resultsHandler?(item.lat, item.lon)
                })
            }
        }
    }
}
