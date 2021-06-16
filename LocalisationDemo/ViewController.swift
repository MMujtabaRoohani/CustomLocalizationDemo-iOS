//
//  ViewController.swift
//  LocalisationDemo
//
//  Created by Mujtaba Roohani on 15/06/2021.
//

import UIKit

class ViewController: UIViewController, LocalizableController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var testTextField: UITextField!
    @IBOutlet weak var changeLanguageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Localise UI when the view loads and add an observer for further changes
        localizeUI(withLocale: Bundle.main.locale)
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: .init(rawValue: "LanguageChanged"), object: nil)
    }

    func localizeUI(withLocale locale: SupportedLanguage) {
        testLabel.text = "TEST_LABEL".localizedString
        testButton.setTitle("TEST_BUTTON".localizedString, for: .normal)
        testTextField.placeholder = "TEST_TEXT_FIELD".localizedString
        changeLanguageBtn.setTitle("CHANGE_LOCALISATION_BUTTON".localizedString, for: .normal)
        self.navigationItem.title = "MAINVIEW_TITLE".localizedString
        self.view.change(semanticAttr: locale.isLTR ? .forceLeftToRight : .forceRightToLeft)
    }
    
    @objc func languageChanged() {
        localizeUI(withLocale: Bundle.main.locale)
    }
}
