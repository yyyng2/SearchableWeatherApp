//
//  SearchViewController.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit

import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {
    let mainView = SearchView()
    
    let viewModel = MainViewModel()
    
    let disposeBag = DisposeBag()
    
    var cityList: CityModel?
    
    var city: CityModel?
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 28, height: 0))
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
        let vc = MainViewController()
        vc.mainView.collectionView.reloadData()
    }
    
    override func setNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        searchBar.setValue("Cancel", forKey: "cancelButtonText")
        searchBar.tintColor = .systemGray2

        mainView.searchBar.searchResultsUpdater = self
        self.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    override func binding() {
        decodeJson()
        city = cityList
        
        searchBar.rx.textDidBeginEditing
            .subscribe(onNext: { [unowned self] in
      
                viewModel.decodeJson()
                viewModel.city = viewModel.cityList
                
                self.searchBar.setShowsCancelButton(true, animated: true)
                
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [unowned self] in
                self.searchBar.searchTextField.text = ""
                self.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        
        searchBar.searchTextField.rx.value.changed
            .subscribe { _ in
                let vc = SearchViewController()
                let text = self.searchBar.searchTextField.text!
                vc.filterJson(text: text)
            }
            .disposed(by: disposeBag)
        
     
    }
    
    public func filterJson(text: String) {
        guard let data = cityList else { return }
        city? = data.filter{ $0.name.hasPrefix(text) || $0.country.hasPrefix(text) }
    }
    
    public func decodeJson() {
        guard let cityData = loadCity() else { return }
        print("cityDataSuccess")
        print(cityData)
        do {
            cityList = try JSONDecoder().decode(CityModel.self, from: cityData)
            print("cityListSuccess")
            guard let cityOne = cityList?[0] else { return }
            print(cityOne.coord)
        } catch {
            print("cityListError")
        }
    }
    
    private func loadCity() -> Data? {
        let fileName = "CityList"
        let fileType = "json"
        
        guard let path = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
            print("pathError")
            return nil
        }
        print("pathSuccess")
        
        do {
            let data = try Data(contentsOf: path)
            print("cityListSuccess")
            return data
        } catch {
            print("cityListError")
            return nil
        }
    }
    
}
