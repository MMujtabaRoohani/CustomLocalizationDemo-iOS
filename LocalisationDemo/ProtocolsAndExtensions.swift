//
//  ProtocolsAndExtensions.swift
//  LocalisationDemo
//
//  Created by Mujtaba Roohani on 16/06/2021.
//

import Foundation
import UIKit

protocol LocalizableController {
    func localizeUI(withLocale locale: SupportedLanguage)
}

extension String {
    private func localizableString(locale: String) -> String {
        let path = Bundle.main.path(forResource: locale, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    var localizedString: String {
        return self.localizableString(locale: Bundle.main.locale.rawValue)
    }
}

extension UIView {
    func change(semanticAttr: UISemanticContentAttribute) {
        self.semanticContentAttribute = semanticAttr
        for subview in self.subviews {
            subview.change(semanticAttr: semanticAttr)
        }
    }
}

enum SupportedLanguage: String {
    case urdu = "ur-PK"
    case english = "en"
    
    var isLTR: Bool {
        return self == .english
    }
}

extension Bundle {
    var locale: SupportedLanguage {
        get {
            return SupportedLanguage(rawValue: UserDefaults.standard.string(forKey: "locale") ?? "") ?? .english
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: "locale")
            NotificationCenter.default.post(name: .languageChanged, object: newValue.rawValue)
        }
    }
}

extension Notification.Name {
    static var languageChanged: Notification.Name {
        return .init(rawValue: "LanguageChanged")
    }
}

extension UIImage {
    
    // Taken from https://stackoverflow.com/questions/40882487/how-to-rotate-image-in-swift
    // If for whatever reason it fails to rotate, the original image will then be returned.
    func rotate(radians: CGFloat) -> UIImage {
            let rotatedSize = CGRect(origin: .zero, size: size)
                .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
                .integral.size
            UIGraphicsBeginImageContext(rotatedSize)
            if let context = UIGraphicsGetCurrentContext() {
                let origin = CGPoint(x: rotatedSize.width / 2.0,
                                     y: rotatedSize.height / 2.0)
                context.translateBy(x: origin.x, y: origin.y)
                context.rotate(by: radians)
                draw(in: CGRect(x: -origin.y, y: -origin.x,
                                width: size.width, height: size.height))
                let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()

                return rotatedImage ?? self
            }

            return self
        }
}
