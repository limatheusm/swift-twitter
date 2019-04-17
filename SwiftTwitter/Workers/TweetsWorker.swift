//
//  TweetsWorker.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 12/04/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import Foundation

// MARK: - Tweets worker

class TweetsWorker {
    var tweetsStore: TweetsStoreProtocol
    
    init(tweetsStore: TweetsStoreProtocol) {
        self.tweetsStore = tweetsStore
    }
    
    func searchTweets(using searchText: String, completionHandler: @escaping (TweetsStoreResult<[Tweet]>) -> Void) {
        tweetsStore.searchTweets(searchText: searchText, completionHandler: completionHandler)
    }
    
    func fetchUserTimeline(forUserID: String, completionHandler: @escaping (TweetsStoreResult<[Tweet]>) -> Void) {
        tweetsStore.fetchUserTimeline(forUserID: forUserID, completionHandler: completionHandler)
    }
}

// MARK: - Tweets store API

protocol TweetsStoreProtocol {
    func searchTweets(searchText: String, completionHandler: @escaping (TweetsStoreResult<[Tweet]>) -> Void)
    func fetchUserTimeline(forUserID: String, completionHandler: @escaping (TweetsStoreResult<[Tweet]>) -> Void)
}

// MARK: - Tweets Store Error

enum TweetsStoreError: Equatable, Error {
    case CannotFetch(String)
    case CannotDecode(String)
    case UnknownReason(String)
    case NoData(String)
    
    public var message: String {
        switch self {
        case .CannotFetch(let message):
            return message
        case .CannotDecode(let message):
            return message
        case .UnknownReason(let message):
            return message
        case .NoData(let message):
            return message
        }
    }
}

// MARK: - Tweets Store Result

enum TweetsStoreResult<T> {
    case Success(_ result: T)
    case Failure(_ error: TweetsStoreError)
}
