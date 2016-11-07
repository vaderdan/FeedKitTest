//
//  ViewController.swift
//  FeedKitTest
//
//  Created by Danny on 11/7/16.
//  Copyright © 2016 Danny. All rights reserved.
//

import UIKit
import FeedKit
import Alamofire

class ViewController: UIViewController {

    var queue:OperationQueue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queue = OperationQueue()
        queue.underlyingQueue = DispatchQueue(label: "queue")
        queue.maxConcurrentOperationCount = 1
        
        case3()
    }
    
    //case1 use xmlparse init?(contentsOf url: URL)
    func case1() {
        for _ in 0..<10 {
            let operation = FeedKitOperation(url: URL(string:"http://novavarna.net/feed/")!, { result in
                print(">>>", result, self.queue.operations.count)
            })
            
            queue.addOperation(operation)
            print(operation, self.queue.operations.count)
        }
        
        print("finished add to queue")
    }
   
    //case2 use alamofire
    func case2() {
        for _ in 0..<10 {
            let operation = AlamofireOperation(url: URL(string:"http://novavarna.net/feed/")!, { response in
                print(">>>", self.queue.operations.count)
            })
            
            
            self.queue.addOperation(operation)
            print(operation, self.queue.operations.count)
        }
        
        print("finished add to queue")
    }
    
    //case3 use alamofire and cancel
    func case3() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            print("cancel!!", self.queue.operations.count)
            self.queue.cancelAllOperations()
        }
        
        for _ in 0..<10 {
            let operation = AlamofireOperation(url: URL(string:"http://novavarna.net/feed/")!, { response in
                print(">>>", self.queue.operations.count)
            })
            
            
            self.queue.addOperation(operation)
            print(operation, self.queue.operations.count)
        }
        
        print("finished add to queue")
    }
    
}

