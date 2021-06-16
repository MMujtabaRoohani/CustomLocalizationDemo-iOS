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
