//
//  DummyVC.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 16/11/22.
//

import UIKit
import SnapKit

class DummyVC: UIViewController {
        
    let profileTest = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(profileTest)
        
        profileTest.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(150)
            make.top.equalTo(view.safeAreaLayoutGuide)

//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
