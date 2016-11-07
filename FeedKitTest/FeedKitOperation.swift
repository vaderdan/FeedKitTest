//
//  MoyaNSOperation.swift
//  GmailOauth
//
//  Created by Danny on 11/28/15.
//  Copyright © 2015 Danny. All rights reserved.
//

import Foundation
import FeedKit



public class FeedKitOperation: ConcurrentOperation {
    let parser:FeedParser?
    let completionHandler: (Result) -> Void


    public init(url:URL, _ completion: @escaping (Result) -> Void) {
        self.parser = FeedParser(URL: url)
        self.completionHandler = completion
        super.init()
    }
    
    override public func main() {
        self.parser?.parse({ result in
            var result = result
            self.state = .finished
            
            if self.isCancelled {
                result = .failure(NSError.init(domain: "Cancelled", code: -1, userInfo: nil))
            }
            
            self.completionHandler(result)
        })
    }
    
    override public func cancel() {
        super.cancel()
        parser?.abortParsing()
    }
}
