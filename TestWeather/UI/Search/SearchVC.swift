//
//  SearchVC.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/28.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit
import MapKit

class SearchVC: BaseVC {
    @IBOutlet weak var tableSearch: UITableView!
    
    var resultsHandler: ((String, String) -> Void)?

    private var searchCompleter = MKLocalSearchCompleter()
    private var searchList = [MKLocalSearchCompletion]()
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MapKit 검색 자동완성 관련
        searchCompleter.delegate = self
        searchCompleter.filterType = .locationsOnly
    }
    
    override func initView() {
        self.addNaviItem()
        
        //tableView
        tableSearch.delegate = self
        tableSearch.dataSource = self
        tableSearch.estimatedRowHeight = 50
        tableSearch.rowHeight = UITableView.automaticDimension
        tableSearch.separatorStyle = .singleLine
        tableSearch.backgroundColor = .white
    }
    
    //MARK: - e.g.
    private func addNaviItem() {
        // SearchBar 네비게이션에 추가
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = STR_SEARCH_PLACEHOLDER
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        // 닫기 버튼 네비게이션에 추가
        let naviItem = UIBarButtonItem.init(barButtonSystemItem: .stop, target: self, action: #selector(self.finishFlow))
        naviItem.tintColor = .black
        navigationItem.rightBarButtonItem = naviItem
    }
    
    func focusSearchBar() {
        searchController.searchBar.becomeFirstResponder()
    }
    
    //MARK: - Action
    @objc func finishFlow() {
        self.dismiss(animated: true)
    }
    
}

//MARK: - Extension
extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        if searchText.isEmpty {
            searchList.removeAll()
            tableSearch.reloadData()
        }
        // 자동완성에 텍스트 넣기
        searchCompleter.queryFragment = searchText
    }
}

extension SearchVC: MKLocalSearchCompleterDelegate {
    // 자동완성 성공 시, 결과
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchList = completer.results
        tableSearch.reloadData()
    }
    
    // 자동완성 실패 시,
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        p("search AutoComplete Error : \(error.localizedDescription)")
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)

        if let lbSearch = cell.viewWithTag(100) as? UILabel {
            lbSearch.text = searchList[indexPath.row].title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = MKLocalSearch.Request(completion: searchList[indexPath.row])
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard error == nil else {
                p("search error : \(error?.localizedDescription)")
                return
            }
            
            if let response = response {
                p("result : response : \(response)")
                for (index, item) in response.mapItems.enumerated() {
                    p("mapItem\(index) : \(item)")
                }
            }
//            guard let placeMark = response?.mapItems.first?.placemark else {
//                return
//            }
//            let coordinate = Coordinate(coordinate: placeMark.coordinate)
//            self.delegate?.userAdd(newLocation: Location(coordinate: coordinate, name: "\(placeMark.locality ?? selectedResult.title)"))
//            self.finishFlow()
        }
        

    }
    
    
    
}

