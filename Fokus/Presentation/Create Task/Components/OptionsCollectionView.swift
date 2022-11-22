//
//  OptionsCollectionView.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 19/11/22.
//

import Foundation
import UIKit
import SnapKit
import TTGTags

class OptionsCollectionView: UIView {
    
    private var title: String!
    private var source: [String] = []
    
    public var selectedOption : String?
    
    public let height = 76
    
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .atkinsonRegular(size: 18)
        label.textColor = .turq
        return label
    }()
    
    let buttonStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    required init(title: String){
        super.init(frame: .zero)
    
        titleLabel.text = title
        
        addSubview(titleLabel)
        addSubview(buttonStack)

        configureConstraints()
    }
    
    required init(title: String, options: [String]){
        super.init(frame: .zero)
        
        titleLabel.text = title
        source = options
        
        source.forEach { i in
            let button = OptionButton()
            button.setTitle(i, for: .normal)
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            buttonStack.addArrangedSubview(button)
        }

        addSubview(titleLabel)
        addSubview(buttonStack)

        configureConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(36)
        }
    }
    
    func addOption(text: String){
        let button = OptionButton()
        button.setTitle(text, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        buttonStack.addArrangedSubview(button)
    }
    
    @objc func didTapButton(_ sender: OptionButton){
        sender.select()
        selectedOption = sender.titleLabel?.text
        
        buttonStack.arrangedSubviews.forEach { view in
            if (view as! OptionButton) != sender {
                let currButton = view as! OptionButton
                
                currButton.deselect()
            }
        }
    }
    
}
