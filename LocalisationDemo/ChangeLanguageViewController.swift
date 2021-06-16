//
//  ChangeLanguageViewController.swift
//  LocalisationDemo
//
//  Created by Mujtaba Roohani on 16/06/2021.
//

import UIKit

class ChangeLanguageViewController: UIViewController, LocalizableController {

    @IBOutlet weak var chooseLanguageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Localise UI when the view loads and add an observer for further changes
        localizeUI(withLocale: Bundle.main.locale)
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: .init(rawValue: "LanguageChanged"), object: nil)
    }

    func localizeUI(withLocale locale: SupportedLanguage) {
        chooseLanguageLabel.text = "CHOOSE_LANGUAGE_INSTRUCTION".localizedString
        self.view.change(semanticAttr: locale.isLTR ? .forceLeftToRight : .forceRightToLeft)
    }
    
    @objc func languageChanged() {
        localizeUI(withLocale: Bundle.main.locale)
    }

    @IBAction func languageBtnTapped(_ sender: UIButton) {
        Bundle.main.locale = sender.tag == 0 ? .english : .urdu
    }
}
