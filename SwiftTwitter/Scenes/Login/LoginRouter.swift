//
//  LoginRouter.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 02/05/19.
//  Copyright (c) 2019 Matheus Lima. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol LoginRoutingLogic {
    func routeToSearch()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? {
        get
    }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    // MARK: - Routing
    
    func routeToSearch() {
        AppDelegate.shared?.rootViewController?.switchToMainScreen(
            userID: dataStore?.userID,
            userProfileImageURL: nil
        )
    }
}
