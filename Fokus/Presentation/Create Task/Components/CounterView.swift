//
//  CounterView.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 22/11/22.
//

import UIKit

class CounterView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public let height : CGFloat = 134
    
    public var counter : Int = 4 {
        didSet {
            if counter < 1 {
                counter = 1
            }
            numberLabel.text = String(counter)
        }
    }
    
    private let numberLabel : UILabel = {
        let label = UILabel()
        label.font = .atkinsonRegular(size: 48)
        label.textColor = .turq
        label.text = "0"
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private let counterTitle : UILabel = {
        let label = UILabel()
        label.font = .atkinsonRegular(size: 20)
        label.textColor = .whiteFokus
        label.text = "Siklus"
        label.isUserInteractionEnabled = false
        label.sizeToFit()
        return label
    }()
    
    private let addButton : UIButton = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "addCounter")
        
        let button = UIButton()
        button.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }
        
        return button
    }()
    
    private let minButton : UIButton = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "minusCounter")
        
        let button = UIButton()
        button.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }
        
        return button
    }()
    
    private var addGesture : UITapGestureRecognizer!
    
    private var minGesture : UITapGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: height))
        
        self.isUserInteractionEnabled = true
        backgroundColor = .darkGrey
        layer.cornerRadius = 8
        
        numberLabel.text = String(describing: counter)
        numberLabel.sizeToFit()
        
        addGesture = UITapGestureRecognizer(target: self, action: #selector(add))
        
        minGesture = UITapGestureRecognizer(target: self, action: #selector(min))
        
        addButton.addGestureRecognizer(addGesture)
        minButton.addGestureRecognizer(minGesture)
        
        addSubview(numberLabel)
        addSubview(counterTitle)
        addSubview(addButton)
        addSubview(minButton)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints(){
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        
        minButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(counterTitle.snp.left).offset(-48)
            make.size.equalTo(40)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(counterTitle.snp.right).offset(48)
            make.size.equalTo(40)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(28)
        }
        
        counterTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-28)
        }
    }
    
    @objc private func add(){
        counter += 1
        if counter == 2 {
            minButton.addGestureRecognizer(minGesture)
            minButton.subviews.forEach { view in
                if let imageView = view as? UIImageView{
                    imageView.image = UIImage(named: "minusCounter")
                }
            }
        }
        numberLabel.text = String(describing: counter)
    }
    
    @objc private func min(){
        counter -= 1
        if counter == 1 {
            minButton.removeGestureRecognizer(minGesture)
            minButton.subviews.forEach { view in
                if let imageView = view as? UIImageView{
                    imageView.image = UIImage(named: "minusCounterDisabled")
                }
            }
        }
        numberLabel.text = String(describing: counter)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            let hitView = super.hitTest(point, with: event)
            if hitView == self {
                return nil
            } else {
                return hitView
            }
        }
}
