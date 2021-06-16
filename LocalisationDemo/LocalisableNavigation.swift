//
//  LocalisableNavigation.swift
//  LocalisationDemo
//
//  Created by Mujtaba Roohani on 16/06/2021.
//

import UIKit

class LocalisableNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Localise UI when the view loads and add an observer for further changes
        localizeUI(withLocale: Bundle.main.locale)
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: .init(rawValue: "LanguageChanged"), object: nil)
    }

    func localizeUI(withLocale locale: SupportedLanguage) {
        self.view.change(semanticAttr: locale.isLTR ? .forceLeftToRight : .forceRightToLeft)
    }
    
    @objc func languageChanged() {
        localizeUI(withLocale: Bundle.main.locale)
    }
}
