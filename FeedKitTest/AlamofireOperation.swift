//
//  AlamofireOperation.swift
//  FeedKitTest
//
//  Created by Danny on 11/7/16.
//  Copyright © 2016 Danny. All rights reserved.
//

import Foundation
import Alamofire

public class AlamofireOperation: ConcurrentOperation {
    
    let completionHandler: (DataResponse<Data>) -> Void
    let request:DataRequest
    
    public init(url:URL, _ completion: @escaping (DataResponse<Data>) -> Void) {
        self.request = Alamofire.request(url)
        self.completionHandler = completion
        super.init()
    }
    
    override public func main() {
        self.request.responseData { response in
            var response = response
            self.state = .finished

            if self.isCancelled {
                response = DataResponse<Data>.init(request: response.request, response: response.response, data: response.data, result: .failure(NSError.init(domain: "Cancelled", code: -1, userInfo: nil)))
            }
            
            self.completionHandler(response)
        }
    }
    
    override public func cancel() {
        super.cancel()
        request.cancel()
    }
}
