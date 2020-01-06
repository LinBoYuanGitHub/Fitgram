//
//  BodyMeasurementInputViewController.swift
//  fitgram
//
//  Created by boyuan lin on 20/12/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class BodyMeasurementInputViewController: UIViewController {
    public var inputTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
    public var bodyMeasurementList = [Apisvr_BodyMeasurementLog]()
    
    override func viewDidLoad() {
        self.view.addSubview(inputTableView)
        inputTableView.register(BodyMeasurementInputCell.self, forCellReuseIdentifier: "BodyMeasurementInputCell")
        inputTableView.delegate = self
        inputTableView.dataSource = self
        self.title = "围度记录"
    }
    
    
}

extension BodyMeasurementInputViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bodyMeasurementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BodyMeasurementInputCell", for: indexPath) as? BodyMeasurementInputCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = bodyMeasurementList[indexPath.row].title
        cell.valTextField.placeholder = bodyMeasurementList[indexPath.row].unit
//        cell.valTextField.text = bodyMeasurementList[indexPath.row].value
        return cell
    }
    
    
}
