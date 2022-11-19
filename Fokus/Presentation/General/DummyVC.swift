//
//  DummyVC.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 16/11/22.
//

import UIKit
import SnapKit

class DummyVC: UIViewController {
    
    let button: UIButton = {
        
        let container = UIButton()
        
        container.backgroundColor = .red
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 1
        container.setTitleColor(.white, for: .selected)
        
        
        container.setTitle("Not selected", for: .normal)
        container.setTitle("hello world!", for: .selected)
        
        
        container.isUserInteractionEnabled = true
        
        
        return container
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        
        view.backgroundColor = .systemBackground
        
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }

    }
    
}
