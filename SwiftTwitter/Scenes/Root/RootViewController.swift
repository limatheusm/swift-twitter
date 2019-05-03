//
//  RootViewController.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 03/05/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var currentViewController: UIViewController
    
    init() {
        self.currentViewController = SplashViewController.instanceFromStoryboard()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showCurrentViewController()
    }
    
    // MARK: - Navigation
    
    private func showCurrentViewController() {
        addChild(self.currentViewController)
        self.currentViewController.view.frame = self.view.bounds
        view.addSubview(self.currentViewController.view)
        self.currentViewController.didMove(toParent: self)
    }
    
    func switchToMainScreen(userID: String?, userProfileImageURL: URL?) {
        let mainViewController = SearchViewController.instanceFromStoryboard(
            userID: userID,
            userProfileImageURL: userProfileImageURL
        )
        let new = UINavigationController(rootViewController: mainViewController)
        
        self.animateFadeTransition(to: new)
    }
    
    func switchToLogout() {
        let loginViewController = LoginViewController.instanceFromStoryboard()
        
        self.animateDismissTransition(to: loginViewController)
    }
    
    // MARK: - Animations
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        self.currentViewController.willMove(toParent: nil)
        self.addChild(new)
        self.transition(
            from: self.currentViewController,
            to: new,
            duration: 0.3,
            options: [.transitionCrossDissolve, .curveEaseOut],
            animations: nil) { [weak self] completed in
                guard let strongSelf = self else {
                    completion?()
                    return
                }
                strongSelf.currentViewController.removeFromParent()
                new.didMove(toParent: strongSelf)
                strongSelf.currentViewController = new
                completion?()
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        self.currentViewController.willMove(toParent: nil)
        self.addChild(new)
        new.view.frame = initialFrame
        self.view.subviews.isEmpty ? self.view.addSubview(new.view) : nil
        self.transition(from: self.currentViewController, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { [weak self] completed in
            guard let strongSelf = self else {
                completion?()
                return
            }
            strongSelf.currentViewController.removeFromParent()
            new.didMove(toParent: strongSelf)
            strongSelf.currentViewController = new
            completion?()
        }
    }
}
