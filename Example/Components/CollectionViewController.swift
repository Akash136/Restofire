//
//  CollectionViewController.swift
//  iWork
//
//  Created by Rahul Katariya on 08/06/16.
//  Copyright © 2015-present Restofire. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var topView: UIView!
    var _seperatorStyle: UITableViewCellSeparatorStyle!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView?.frame = view.bounds
    }
    
    func showTopView(_ topView: UIView) {
        self.topView = topView
        view.addSubview(topView)
        view.setNeedsLayout()
    }
    
    func hideTopView() {
        topView.removeFromSuperview()
        topView = nil
    }
    
}
