//
//  RDAGoalViewController.swift
//  fitgram
//
//  Created by boyuan lin on 18/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class RDAGoalViewController: UIViewController {
    var rootView: RDAGoalView!
    
    override func viewDidLoad() {
        self.title = "Goal"
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
    }
    
    override func loadView() {
        rootView = RDAGoalView()
        self.view = rootView
        rootView.RDATableView.delegate = self
        rootView.RDATableView.dataSource = self
    }
    
    
}

extension RDAGoalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // goal, weight, date, currentBS, targetBS
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RDAGoalCell", for: indexPath) as? RDAGoalCell else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Goal"
        case 1:
            cell.titleLabel.text = "Target Weight"
        case 2:
            cell.titleLabel.text = "Target Date"
        case 3:
            cell.titleLabel.text = "Current BodyShape"
        case 4:
            cell.titleLabel.text = "Target BodyShape"
        default:break
        }
        return cell
    }
    
    
}
