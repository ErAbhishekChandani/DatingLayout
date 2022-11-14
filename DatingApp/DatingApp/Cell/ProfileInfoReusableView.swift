//
//  ProfileInfoReusableView.swift
//  DatingApp
//
//  Created by Er. Abhishek Chandani on 12/11/22.
//

import UIKit

class ProfileInfoReusableView: UICollectionReusableView, ReuseIdentifiable {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.PoppinsSemiBold?.withSize(24)
        label.textColor = UIColor.black
        label.text = "Sarah, 23"
        return label
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
