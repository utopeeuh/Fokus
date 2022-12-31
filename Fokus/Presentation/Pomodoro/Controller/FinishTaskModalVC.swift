//
//  FinishTaskModal.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 20/12/22.
//

import Foundation
import UIKit
import SnapKit

protocol FinishTaskModalDelegate {
    func onModalClosed()
}

class FinishTaskModalVC: UIViewController {
    
    public var delegate: FinishTaskModalDelegate?
    
    var xp = 0
    
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
    
    private let thumbImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "thumbIcon"))
        return imageView
    }()
    
    private let headerLabel : UILabel = {
        let label = UILabel()
        label.font = .atkinsonBold(size: 24)
        label.textColor = .whiteFokus
        label.text = "Tugas Selesai!"
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let subHeaderLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-100, height: 0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let backToHomeButton : UIButton = {
        let button = UIButton()
        button.setTitle("Kembali ke halaman utama", for: .normal)
        button.setTitleColor(.turq, for: .normal)
        button.titleLabel?.font = .atkinsonRegular(size: 18)
        button.sizeToFit()
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        showModal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = NSMutableAttributedString()
        
        text.append(NSAttributedString(string: "Kamu mendapatkan ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.whiteFokus]));
        
        text.append(NSAttributedString(string: "\(xp) XP ", attributes: [.foregroundColor: UIColor.turq, .font: UIFont.atkinsonBold(size:  18)!]))
        
        text.append(NSAttributedString(string: "karena berhasil fokus! Selamat! 😍", attributes: [NSAttributedString.Key.foregroundColor: UIColor.whiteFokus]))
        
        subHeaderLabel.attributedText = text
        subHeaderLabel.sizeToFit()
        
        backToHomeButton.addTarget(self, action: #selector(backToHomeOnClick), for: .touchUpInside)
        
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(thumbImageView)
        containerView.addSubview(headerLabel)
        containerView.addSubview(subHeaderLabel)
        containerView.addSubview(backToHomeButton)
        
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        configureConstraints()
    }

    func configureConstraints() {

        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        var containerHeight : CGFloat = 0
        
        containerView.subviews.forEach { view in
            containerHeight += view.bounds.height
        }
        
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-40)
            make.center.equalToSuperview()
            make.height.equalTo(containerHeight+104)
        }
        
        thumbImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbImageView.snp.bottom).offset(12)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        subHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(12)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        backToHomeButton.snp.makeConstraints { make in
            make.top.equalTo(subHeaderLabel.snp.bottom).offset(40)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
    }
    
    private func showModal(){
        UIView.animate(withDuration: 0.2) { [self] in
            dimmedView.alpha = CGFloat(dimmedMaxAlpha)
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
    
    @objc private func backToHomeOnClick(){
        handleCloseAction()
        delegate?.onModalClosed()
    }
}
