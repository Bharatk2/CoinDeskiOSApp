//
//  CoinListTableViewController.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import UIKit
import Combine
class CoinListTableViewController: UITableViewController {
    var list = [String]()
    var coins = [Coin]()
    var coinListViewModel = CoinListViewModel()
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        handleBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func handleBindings() {
        coinListViewModel.$coins
           .receive(on: DispatchQueue.main)
           .sink { [weak self] items in
            self?.coins = items
              self?.tableView.reloadData()
           }
           .store(in: &subscriptions)
    }
  

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoinListCell", for: indexPath) as? CoinListTableViewCell else { return UITableViewCell() }
    
        cell.coinlabel.text = coins[indexPath.row].name
      
   
        cell.symbolLabel.text = coins[indexPath.row].symbol
   
       
        return cell
    }
    

}
