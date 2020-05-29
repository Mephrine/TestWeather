//
//  WeatherListVC.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherListVC: BaseVC {
    @IBOutlet weak var tableList: UITableView!
    
    var resultsHandler: ((String, String) -> Void)?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - e.g.
    
    
    //MARK: - Action
    @IBAction func tapBtnSearch(_ sender: Any) {
        // SearchViewController 실행하기.
        if let searchVC = viewController(storyboard: "Main", type: SearchVC.self) {
            let navi = UINavigationController(rootViewController: searchVC)
            searchVC.resultsHandler = { [weak self] lat, lon in
                
            }
            navi.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navi, animated: true) {
                DispatchQueue.main.async {
                    searchVC.focusSearchBar()
                }
            }
        }
    }
}

