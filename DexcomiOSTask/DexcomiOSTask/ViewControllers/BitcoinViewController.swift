//
//  BitcoinViewController.swift
//  DexcomiOSTask
//
//  Created by Bharat Kumar on 9/8/21.
//

import UIKit
import Combine
class BitcoinViewController: UIViewController {
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var timeStamp: UILabel!

    var usdViewModel = [USDViewModel]()
    
    var eurViewModel: EURViewModel?
    
    var coinListViewModel = CoinListViewModel()
    var subscriptions = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
            coinListViewModel.$usdCurrency
               .receive(on: DispatchQueue.main)
               .sink { [weak self] items in
                self?.usdViewModel = items
                self?.tableView.reloadData()
               }
               .store(in: &subscriptions)
    
        

    }

    @IBAction func segmentedControllerTapped(_ sender: UISegmentedControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
      
    }
    
}

