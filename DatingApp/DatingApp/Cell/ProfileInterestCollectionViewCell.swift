//
//  ProfileInterestCollectionViewCell.swift
//  DatingApp
//
//  Created by Er. Abhishek Chandani on 12/11/22.
//

import UIKit
import SnapKit

class ProfileInterestCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    
    lazy var intrestTitleLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.PoppinsRegular?.withSize(11)
        label.textColor = UIColor.black
        label.numberOfLines = 1
        return label
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView.init()
        return imageView
    }()

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(interest: ProfileInterest){
        intrestTitleLabel.text = interest.name
        iconImageView.image = UIImage.init(named: interest.type?.rawValue ?? "")
    }
    
    //MARK: - Private methods
    private func setupUI(){
        let containerView = UIView.init()
        containerView.layer.cornerRadius = 15
        containerView.backgroundColor = UIColor.init(hexString: "#F5F6FB")
        self.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        containerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(18)
        }
        containerView.addSubview(intrestTitleLabel)
        intrestTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
    }
}
