//
//  InfoFieldCells.swift
//  VeteranoPizza
//
//  Created by User on 14.09.2021.
//

import UIKit

class InfoFieldCells: UITableViewCell, ReusableCell {
    
    private lazy var labelText: UILabel = {
        let labelText = UILabel()
//        foodName.adjustsFontSizeToFitWidth = true
//        foodName.minimumScaleFactor = 0.5
        labelText.textAlignment = .left
        labelText.numberOfLines = 0
        labelText.font = FontFamily.Quicksand.bold.font(size: 13)
        return labelText
    }()
    
    private lazy var textField: UITextView = {
        let textField = UITextView()
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 2
        textField.textContainer.maximumNumberOfLines = 2
        textField.font = FontFamily.Montserrat.bold.font(size: 12.0)
        textField.textColor = UIColor.lightGray
        textField.textAlignment = NSTextAlignment.natural
        textField.delegate = self
        return textField
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpSeparation()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpViews(){
        self.addSubview(labelText)
        labelText.layout {
            $0.constraint(to: self, by:.leading(10), .top(5))
            $0.size(.width(200/375*Size.width), .height(30/375*Size.width))
        }
        
        self.addSubview(textField)
        textField.layout {
            $0.top.constraint(to: labelText, by:.bottom(5))
            $0.constraint(to: self, by: .bottom(-5), .leading(10), .trailing(-10))
        }
    }
    
    func setUp(textlabel: String){
        labelText.text = textlabel
        textField.text = self.labelText.text
    }
    
    func getTextInfo() -> String {
        return textField.text ?? " "
    }
    
    private func setUpSeparation() {
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension InfoFieldCells: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == " " {
            textView.text = self.labelText.text
            textView.textColor = UIColor.lightGray
        }
    }
}
