//
//  Constants.swift
//  SwiftTwitter
//
//  Created by Matheus Lima on 12/04/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

struct Constants {
    struct TwitterAPI {
        static let ConsumerAPIKey = "489sNgzZLitRyLyo66pV8A70U"
        static let ConsumerAPISecretKey = "zscFfQWTJR4BADWoLJtJSqSMtDSRVGuHWgUKLEgpOLNyZBgZ7B"
    }
    
    struct DateFormat {
        static let Twitter = "EEE MMM dd HH:mm:ss Z yyyy"
    }
    
    struct Strings {
        static let HintSearch = "Try searching for people, topics, or keywords"
    }
    
    struct DefaultErrorMessages {
        static let CannotFetch = "We could not fetch the response"
        static let CannotDecode = "We could not decode the response"
        static let UnknownReason = "An error ocurred"
        static let NoData = "Response returned with no data to decode"
    }
    
    struct Timeline {
        static let StickyHeaderHeight = 44
        static let TimelineRefreshOffsetThreshold: CGFloat = -65.0
    }
    
    static let StatusBarHeight = 44
}
