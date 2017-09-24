//
//  VSCWeatherListViewController.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 23/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
protocol WeatherLisProtocol : class {
    
    func refreshView(_ resultList: [VSCWeatherItem])
    func refreshView(_ currentWeather: VSCCurrentWeather) 
    func startLoading()
    func finishLoading()
}
class VSCWeatherListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WeatherLisProtocol{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    var weatherList : [VSCWeatherItem]?
    var currentWeather : VSCCurrentWeather?
    var refreshControl: UIRefreshControl!
    var presenter : VSCWeatherListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Météo Paris"
        self.presenter = VSCWeatherListPresenter(view: self)
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self.presenter, action: #selector(VSCWeatherListPresenter.loadWeatherData), for: UIControlEvents.valueChanged)
        activityIndicator?.hidesWhenStopped = true
        self.tableView.addSubview(refreshControl)
        
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 255
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.presenter.loadWeatherData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension VSCWeatherListViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            guard let _ = currentWeather else {
                return 0
            }
            return 1
        default:
            guard let weatherList = weatherList else {
                return 0
            }
            return weatherList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VSCCurrentWeatherTableViewCell") as! VSCCurrentWeatherTableViewCell
           cell.weatherItem = self.currentWeather
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VSCWeatherTableViewCell") as! VSCWeatherTableViewCell
            cell.weatherItem = weatherList?[indexPath.row]
            return cell
        }
    }
}

extension VSCWeatherListViewController {
    func refreshView(_ resultList: [VSCWeatherItem]) {
        self.weatherList = resultList
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func refreshView(_ currentWeather: VSCCurrentWeather) {
        self.currentWeather = currentWeather
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func startLoading() {
        activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
        activityIndicator?.stopAnimating()
    }
}


