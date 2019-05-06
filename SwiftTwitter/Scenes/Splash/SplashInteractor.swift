//
//  SplashInteractor.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 03/05/19.
//  Copyright (c) 2019 Matheus Lima. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SplashBusinessLogic {
    func verifyCredentials()
}

protocol SplashDataStore {
    var userID: String? { get }
    var userProfileImageURL: URL? { get }
}

class SplashInteractor: SplashBusinessLogic, SplashDataStore {
    let kUserProfileImageURL = "userProfileImageURL"
    let kUserID = "userID"
    let worker = TweetsWorker(tweetsStore: TwitterAPI())
    var presenter: SplashPresentationLogic?
    var userID: String?
    var userProfileImageURL: URL?
    
    func verifyCredentials() {
        self.worker.verifyCredentials { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .Failure(_):
                self.presenter?.presentLoginScreen()
            case .Success(let result):
                self.userID = result[self.kUserID] ?? nil
                if let profileImage = result[self.kUserProfileImageURL] ?? nil {
                    self.userProfileImageURL = URL(string: profileImage)
                }
                let response = Splash.VerifyCredentials.Response(
                    userID: self.userID,
                    userProfileImageURL: self.userProfileImageURL
                )
                self.presenter?.presentMainScreen(response: response)
            }
        }
    }
}