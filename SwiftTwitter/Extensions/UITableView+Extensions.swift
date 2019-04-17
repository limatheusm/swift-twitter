//
//  UITableView+Extensions.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 13/04/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func sizeHeaderToFit() {
        guard let headerView = tableHeaderView else { return }
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        
        tableHeaderView = headerView
    }
    
    public func startAnimating() {
        guard let refreshControl = refreshControl, !refreshControl.isRefreshing else {
            return
        }
        
        // Apply some offset so that the refresh control can actually be seen
        let contentOffset = CGPoint(x: 0, y: self.contentOffset.y - 60)
        self.setContentOffset(contentOffset, animated: true)
        
        refreshControl.beginRefreshing()
    }
    
    public func stopAnimating() {
        refreshControl?.endRefreshing()
    }
}
