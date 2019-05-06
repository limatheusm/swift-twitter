//
//  LoginModels.swift
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

enum Login {
    
    // MARK: - Use cases
    
    enum OAuth {
        struct Request { }
        
        struct Response {
            var error: TweetsStoreError?
            var userID: String?
        }
        
        struct ViewModel {
            var errorMessage: String?
        }
    }
}
