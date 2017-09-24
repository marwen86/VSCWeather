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
    func startLoading()
    func finishLoading()
}
class VSCWeatherListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WeatherLisProtocol{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    var weatherList : [VSCWeatherItem]?
    var refreshControl: UIRefreshControl!
    var presenter : VSCWeatherListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Météo Paris"
        self.presenter = VSCWeatherListPresenter(view: self)
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self.presenter, action: #selector(VSCWeatherListPresenter.loadData), for: UIControlEvents.valueChanged)
        activityIndicator?.hidesWhenStopped = true
        self.tableView.addSubview(refreshControl) // not required when using UITableViewController
        
        self.presenter.loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension VSCWeatherListViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weatherList = weatherList else {
            return 0
        }
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VSCWeatherTableViewCell") as! VSCWeatherTableViewCell
        cell.weatherItem = weatherList?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension VSCWeatherListViewController {
    func refreshView(_ resultList: [VSCWeatherItem]) {
        self.weatherList = resultList
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


