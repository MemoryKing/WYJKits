/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import Foundation
import UIKit

public extension WYJProtocol where T == NSAttributedString {
    /// 加粗
    func bold(_ font: CGFloat = UIFont.systemFontSize) -> NSAttributedString {
        guard let copy = obj.mutableCopy() as? NSMutableAttributedString else { return obj }
        let range = (copy.string as NSString).range(of: copy.string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font)], range: range)
        return copy
    }
    /// 下划线
    func underline() -> NSAttributedString {
        guard let copy = obj.mutableCopy() as? NSMutableAttributedString else { return obj }
        let range = (copy.string as NSString).range(of: copy.string)
        copy.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
        return copy
    }
    /// 删除线
    func strikethrough() -> NSAttributedString {
        guard let copy = obj.mutableCopy() as? NSMutableAttributedString else { return obj }
        let range = (copy.string as NSString).range(of: copy.string)
        let attributes = [
            NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)]
        copy.addAttributes(attributes, range: range)
        return copy
    }
    /// 前景色
    func color(_ color: UIColor) -> NSAttributedString {
        guard let copy = obj.mutableCopy() as? NSMutableAttributedString else { return obj }
        let range = (copy.string as NSString).range(of: copy.string)
        copy.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        return copy
    }
}
