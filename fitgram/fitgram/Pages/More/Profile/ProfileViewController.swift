//
//  ProfileViewController.swift
//  fitgram
//
//  Created by boyuan lin on 18/10/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit
import Stevia

class ProfileViewController:UIViewController{
    var rootView = ProfileView()
    var profile = ProfileModel()
    let profileFieldList = ["性别","出生年份","身高","体重","日常运动量"]
    let sectionTitle = "个人信息"
    
    override func loadView() {
        rootView = ProfileView()
        rootView.profileTableView.delegate = self
        rootView.profileTableView.dataSource = self
        rootView.profileTableView.allowsSelection = false
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.loadView()
        }
    }
}

extension ProfileViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //gender,birth,height,weight,activitylvl
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.rootView.profileTableView.dequeueReusableCell(withIdentifier: "ProfileTableCell") as? ProfileTableCell else {
            return UITableViewCell()
        }
        cell.profileInfoLabel.text = profileFieldList[indexPath.row]
        switch indexPath.row {
        case 0://gender
            
            break
        case 1://birthYear
            
            break
        case 2://height
            
            break
        case 3://weight
            
            break
        case 4://actvity level
            
            break
        default:
            break
        }
        return cell
    }
    
    
}
