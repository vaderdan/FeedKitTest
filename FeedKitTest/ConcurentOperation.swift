//
//  ConcurentOperation.swift
//  GmailOauth
//
//  Created by Danny on 11/28/15.
//  Copyright © 2015 Danny. All rights reserved.
//

import Foundation

public class ConcurrentOperation: Operation {
    
    // MARK: - Types
    
    enum State {
        case ready, executing, finished
        func keyPath() -> String {
            switch self {
            case .ready:
                return "isReady"
            case .executing:
                return "isExecuting"
            case .finished:
                return "isFinished"
            }
        }
    }
    
    // MARK: - Properties
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath())
            willChangeValue(forKey: state.keyPath())
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath())
            didChangeValue(forKey: state.keyPath())
        }
    }
    
    // MARK: - NSOperation
    
    override public var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override public var isExecuting: Bool {
        return state == .executing
    }
    
    override public var isFinished: Bool {
        return state == .finished
    }
    
    override public var isAsynchronous: Bool {
        return true
    }
    
    override public func start() {
        //this stands when is cancelled while waiting in queue
        //mark as finished when current in queue, before that - crashes
        if self.isCancelled {
            self.state = .finished
        }
        else {
            self.state = .executing
            main()
        }
    }
    
    override public func cancel() {
        super.cancel()
        //this stands when is cancelled while waiting in queue
        //mark as finished when current in queue, before that - crashes
        self.state = .finished
    }
}
