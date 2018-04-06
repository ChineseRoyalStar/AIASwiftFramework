//
//  UITextFieldExtension.swift
//  AIASwiftFramework
//
//  Created by LeGuo on 4/6/18.
//

import Foundation

extension UITextField {
    
    public func selectedRange() -> NSRange? {
        let beginning = self.beginningOfDocument
        
        let selectedRange = self.selectedTextRange
        
        if let _ = selectedRange {
            let selectionStart = selectedRange!.start
            let selectionEnd = selectedRange!.end
            
            let location = self.offset(from: beginning, to: selectionStart)
            let length = self.offset(from: selectionStart, to: selectionEnd)
            
            return NSRange.init(location: location, length: length)
        }else {
            return nil
        }
    }
    
    public func selectAllText() -> Void{
        let range  = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument)
        self.selectedTextRange = range
    }
    
    public func setSelectedRange(_ range:NSRange) -> Void {
        let beginning = self.beginningOfDocument
        let startPostition = self.position(from: beginning, offset: range.location)
        let endPosition = self.position(from: beginning, offset: NSMaxRange(range))
        
        if let _ = startPostition, let _ = endPosition {
            let selectedRange = self.textRange(from: startPostition!, to: endPosition!)
            self.selectedTextRange = selectedRange
        }
    }
}
