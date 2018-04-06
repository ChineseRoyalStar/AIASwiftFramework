//
//  UILabel+FTDLabelExtension.swift
//  AIASwiftFramework
//
//  Created by LeGuo on 4/6/18.
//

import Foundation
import UIKit

private var characterSpaceKey = 0
private var lineSpaceKey = 0
private var keywordsKey = 0
private var keywordsFontKey = 0
private var keywordsColorKey = 0
private var underlineStrKey = 0
private var underlineColorKey = 0

public extension UILabel {
    
    var characterSpace: CGFloat {
        get {
            let characterSpace = objc_getAssociatedObject(self, &characterSpaceKey)
            if characterSpace == nil {
                objc_setAssociatedObject(self, &characterSpaceKey, 0, .OBJC_ASSOCIATION_ASSIGN)
            }
            return objc_getAssociatedObject(self, &characterSpaceKey) as! CGFloat
        }
        set {
            objc_setAssociatedObject(self, &characterSpaceKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    var lineSpace: CGFloat {
        get {
            let lineSpace = objc_getAssociatedObject(self, &lineSpaceKey)
            if lineSpace == nil {
                objc_setAssociatedObject(self, &lineSpaceKey, 0, .OBJC_ASSOCIATION_ASSIGN)
            }
            return objc_getAssociatedObject(self, &lineSpaceKey) as! CGFloat
        }
        set {
            objc_setAssociatedObject(self, &lineSpaceKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
   
    var keywords: String? {
        get {
            return objc_getAssociatedObject(self, &keywordsKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &keywordsKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    var keywordsFont: UIFont? {
        get {
            return objc_getAssociatedObject(self, &keywordsFontKey) as? UIFont
        }
        set {
            objc_setAssociatedObject(self, &keywordsFontKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var keywordsColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &keywordsColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &keywordsColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var underlineStr: String? {
        get {
            return objc_getAssociatedObject(self, &underlineStrKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &underlineStrKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    var underlineColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &underlineColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &underlineColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
     Calculate the size of label text
     - parameter maxWidth: limited maximum width of label
     - returns: The size of label text with maximum litmited
     */
    public func getLabelRect(WithMaxWidth maxWidth:CGFloat) -> CGSize{
        
        guard let _ = self.text else {
            return CGSize.init(width: 0, height: 0)
        }
        
        let attributedString = NSMutableAttributedString.init(string: self.text!)
        attributedString.addAttribute(.font, value: self.font, range: NSRange.init(location: 0, length: self.text!.count))
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.lineBreakMode = self.lineBreakMode
        
        if self.lineSpace > 0 {
            paragraphStyle.lineSpacing = lineSpace
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange.init(location: 0, length: self.text!.count))
        }
        
        if characterSpace > 0 {
            var number = self.characterSpace
            let num = CFNumberCreate(kCFAllocatorDefault, .sInt8Type, &number)
            attributedString.addAttribute(.kern, value: num!, range: NSRange.init(location: 0, length: attributedString.length))
        }
        
        if let keyword = self.keywords {
            
            let substringRange = (self.text! as NSString).range(of: keyword)

            if let _ = self.keywordsFont {
                attributedString.addAttribute(.font, value: self.keywordsFont!, range: substringRange)
            }
            if let _ = self.keywordsColor {
                attributedString.addAttribute(.foregroundColor, value: self.keywordsColor!, range: substringRange)
            }
        }
        
        if let _ = underlineStr {
            let substringRange = (self.text! as NSString).range(of: underlineStr!)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.styleSingle, range: substringRange)
        }
        
        self.attributedText = attributedString
        
        let maximumLabelSize = CGSize.init(width: maxWidth, height: CGFloat.init(MAXFLOAT))
        let expectSize = self.sizeThatFits(maximumLabelSize)
        
        return expectSize
    }
}
