//
//  UIGestureRecognizer+BinAdd.swift
//  AIAFramework
//
//  Created by LeGuo on 4/4/18.
//  Copyright © 2018 LeGuo. All rights reserved.
//

import Foundation
import UIKit

fileprivate class UIGestureRecognizerTarget {
    
    var closure:((_ sender:AnyObject)->Void)
    
    init(withClosure closure:@escaping (_ sender:AnyObject)->Void) {
        self.closure = closure
    }
    
    @objc public func invoke(sender:AnyObject) {
        closure(sender)
    }
}

private var targetKey: UInt8 = 8;

public extension UIGestureRecognizer {
    
    fileprivate var targets:[UIGestureRecognizerTarget] {
        get {
            
            let targets = objc_getAssociatedObject(self, &targetKey)
            if targets == nil {
                objc_setAssociatedObject(self, &targetKey, Array<UIGestureRecognizerTarget>.init(), .OBJC_ASSOCIATION_RETAIN)
            }
            return objc_getAssociatedObject(self, &targetKey) as! [UIGestureRecognizerTarget]
        }
        set {
            objc_setAssociatedObject(self, &targetKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    convenience init(withActionClosure actionClosure:@escaping (_ sender:AnyObject) -> Void) {
        self.init()
        self.add(actionClosure: actionClosure)
    }
    
    public func add(actionClosure closure:@escaping (_ sender:AnyObject) -> Void) {
        let target: UIGestureRecognizerTarget = UIGestureRecognizerTarget.init(withClosure:closure)
        self.addTarget(target, action: #selector(target.invoke(sender:)))
        self.targets.append(target);
    }
    
    private func removeAllActionBlocks() -> Void {
        for target in self.targets {
            self.removeTarget(target, action: #selector(target.invoke(sender:)))
        }
        targets.removeAll()
    }
}
