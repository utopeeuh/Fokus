//
//  NameModalVC.swift
//  Fokus
//
//  Created by Daffa Amadeo on 9/12/22.
//

import UIKit
import SnapKit

protocol NameModalDelegate {
    func refresh()
}

class NameModalVC: UIViewController {
    
    public var delegate: NameModalDelegate?
    
    private let dimmedMaxAlpha = 0.6
    
    private let dimmedView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrey
        view.layer.cornerRadius = 8
        view.alpha = 0
        return view
    }()
    
    private let headerLabel : UILabel = {
        let label = UILabel()
        label.font = .atkinsonRegular(size: 24)
        label.textColor = .white
        label.text = "Selamat datang!"
        label.sizeToFit()
        return label
    }()
    
    private let subHeaderLabel : UILabel = {
        let label = UILabel()
        label.font = .atkinsonRegular(size: 16)
        label.textColor = .turq
        label.text = "Nama anda:"
        label.sizeToFit()
        return label
    }()
    
    private let nameTextField = TitleTextField()
    
    private let saveButton : UIButton = {
        let button = UIButton()
        button.setTitle("Simpan", for: .normal)
        button.setTitleColor(.turq, for: .normal)
        button.titleLabel?.font = .atkinsonRegular(size: 18)
        button.sizeToFit()
        return button
    }()
    
    let user = UserRepository.shared.fetchUser()
    
    override func viewDidAppear(_ animated: Bool) {
        showModal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.addTarget(self, action: #selector(saveOnClick), for: .touchUpInside)
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        
        dimmedView.addGestureRecognizer(dismissGesture)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(headerLabel)
        containerView.addSubview(subHeaderLabel)
        containerView.addSubview(nameTextField)
        containerView.addSubview(saveButton)
        
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        configureConstraints()
        
        setupModal()
    }

    func configureConstraints() {

        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        var containerHeight : CGFloat = 0
        
        containerView.subviews.forEach { view in
            view.snp.makeConstraints { make in
                if view != saveButton{
                    make.width.equalToSuperview().offset(-40)
                }
                make.centerX.equalToSuperview()
            }
            containerHeight += view.bounds.height
        }
        
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-40)
            make.center.equalToSuperview()
            make.height.equalTo(containerHeight+72)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
        }
        
        subHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(14)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(subHeaderLabel.snp.bottom).offset(4)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func showModal(){
        UIView.animate(withDuration: 0.2) { [self] in
            dimmedView.alpha = dimmedMaxAlpha
            containerView.alpha = 1
        }
    }
    
    @objc private func handleCloseAction(){
        UIView.animate(withDuration: 0.2) { [self] in
            dimmedView.alpha = 0
            containerView.alpha = 0
        } completion: { completion in
            self.dismiss(animated: false)
        }
    }
    
    private func setupModal(){
        if user == nil {
            dimmedView.gestureRecognizers?.forEach(dimmedView.removeGestureRecognizer)
            nameTextField.placeholder = "Nama anda..."
        }
        else {
            headerLabel.text = "Ubah nama"
            nameTextField.placeholder = ("\(user!.name!)")
        }
    }
    
    @objc private func saveOnClick(){
        if nameTextField.text == "" {
            saveButton.shake(count: 3, for: 0.1, withTranslation: 5)
            return
        }
        
        if user == nil {
            UserRepository.shared.createUser(name: nameTextField.text!)
            UserDefaults.standard.set(false, forKey: UserDefaultsKey.firstTime)
        }
        else {
            UserRepository.shared.updateName(name: nameTextField.text!)
        }
        
        handleCloseAction()
        delegate?.refresh()
    }
}
