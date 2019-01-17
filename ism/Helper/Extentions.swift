
import Foundation
import UIKit

// проверка окончания
extension Int {
    func ending(outputStrings:[String]) -> String { // outputStrings = [отзыв, отзыва, отзывов]
        let n = self
        if self == 0 { return outputStrings[2]}
        let titleInt = ((n % 10 == 1 && n % 100 != 11) ? 0 : n % 10 >= 2 && n % 10 <= 4 && (n % 100 < 10 || n % 100 >= 20) ? 1 : 2) // return 0,1,2
        switch titleInt {
        case 0:
            return outputStrings[0]
        case 1:
            return outputStrings[1]
        case 2:
            return outputStrings[2]
        default:
            return ""
        }
    }
}

// string splitter

extension Array {
    func stringMergeFromArray(mergeBySymbol symbol:String, arrayOfStrings:[String]) -> String {
        var mergedString = ""
        for i in 0..<arrayOfStrings.count {
            mergedString.append(arrayOfStrings[i])
            if i < arrayOfStrings.count - 1 {
                mergedString.append(symbol)
            }
        }
        return mergedString
    }
}

// string (label) height

extension String {
    func constraintHeight(iphoneLabelSize:CGFloat, ipadLabelSize:CGFloat, labelString:String, labelWidth: CGFloat) -> CGFloat {
        
        var attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: iphoneLabelSize)]
        if UIDevice.current.userInterfaceIdiom == .pad {
            attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: ipadLabelSize)]
        }
        func setSize(str:String) -> CGFloat {
            return NSString(string: str).boundingRect(
                with: CGSize(width: labelWidth, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin,
                attributes: attributes,
                context: nil).height
        }
        return setSize(str: labelString)
    }
}

// alert false internet connect

extension UIViewController {
    func internetErrorAlert(message:String?, reloadable:Reloadable) {
        var mes = "ErRoR"
        if message != nil {
            mes = message!
        }
        let alert = UIAlertController.init(title: nil, message: mes, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "Repeat", style: UIAlertAction.Style.default, handler: { ( _) in
            reloadable.reloadAfterInternetConnectionEstablished()
        }))
        alert.addAction(UIAlertAction.init(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
// view round desing
extension UIView {
    func roundView(borderWidth:CGFloat = 0.1, borderColor:UIColor) {
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}

//Create layout constraints programmatically
extension UIView {
    
    public func addConstaintsToSuperview(leftOffset: CGFloat, topOffset: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .leading,
                           multiplier: 1,
                           constant: leftOffset).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .top,
                           multiplier: 1,
                           constant: topOffset).isActive = true
    }
    
    public func addConstaints(height: CGFloat, width: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: height).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: width).isActive = true
    }
    
   
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
