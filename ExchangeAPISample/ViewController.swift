//
//  ViewController.swift
//  ExchangeAPISample
//
//  Created by Masuhara on 2019/11/16.
//  Copyright © 2019 Ylab Inc. All rights reserved.
//

import UIKit
import KafkaRefresh

class ViewController: UIViewController {
    
    @IBOutlet weak var ratesTableView: UITableView!
    
    var rates = [ExchangeRate]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        loadRates()
    }
    
    func configureTableView() {
        ratesTableView.dataSource = self
        ratesTableView.delegate = self
        ratesTableView.tableFooterView = UIView()
        ratesTableView.estimatedRowHeight = 44.0
        ratesTableView.rowHeight = UITableView.automaticDimension
        
        let nib = UINib(nibName: "RateTableViewCell", bundle: Bundle.main)
        ratesTableView.register(nib, forCellReuseIdentifier: "RateTableViewCell")
        
        ratesTableView.bindHeadRefreshHandler({
            self.loadRates()
        }, themeColor: .lightGray, refreshStyle: .native)
    }

    func loadRates() {
        ExchangeRate.getCurrentRates(baseCountry: .JPY) { (rates, error) in
            if let rates = rates {
                self.rates = rates
                self.ratesTableView.reloadData()
            } else {
                if let error = error {
                    self.showErrorAlert(error: error)
                }
            }
            
        }
    }
    
    func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RateTableViewCell") as! RateTableViewCell
        let rate = rates[indexPath.row].rate ?? 0.00
        cell.countryLabel.text = rates[indexPath.row].name
        cell.rateLabel.text = String(format: "%.2f", rate)
        return cell
    }
}
