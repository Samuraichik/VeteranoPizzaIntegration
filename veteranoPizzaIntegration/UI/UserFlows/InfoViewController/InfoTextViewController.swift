//
//  InfoTextViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 09.02.2022.
//

import Foundation
import UIKit

class TextViewController: UIViewController {
    
    internal lazy var textView: UITextView = {
        let view = UITextView()
        return view
    }()
    
    var showCloseButton = false
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextView()
        
        if showCloseButton {
            addCloseButton()
        }
    }
    
    private func addCloseButton() {
        navigationController?.navigationBar.isTranslucent = false
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(close))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    internal func setUpTextView() {
        view.addSubview(textView)
        textView.layout {
            $0.constraint(to: view, by: .top(0), .leading(0), .bottom(0), .trailing(0))
        }
        
        textView.text = text
    }
}

class OpenLibrariesViewController: TextViewController {
    
    override var text: String {
        get {
            return OPEN_LIBRARIES_TEXT
        }
        
        set {_ = newValue}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Договір публічної оферти"
    }
    
    override func setUpTextView() {
        super.setUpTextView()
        
        textView.isEditable = false
        textView.isSelectable = false
        textView.dataDetectorTypes = []
        textView.isScrollEnabled = true
    }
    
}

private let OPEN_LIBRARIES_TEXT: String = {
    do {
        let path = Bundle.main.path(forResource: "ContractPublicOfert", ofType: "txt")
        let string = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        return string
    } catch {
        return ""
    }
}()
