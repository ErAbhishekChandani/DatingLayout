//
//  TextCollectionViewCell.swift
//  DatingApp
//
//  Created by Er. Abhishek Chandani on 12/11/22.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    
    lazy var aboutLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.PoppinsMedium?.withSize(14)
        label.textColor = UIColor.init(hexString: "#9BA6B8")
        label.text = "Having a laugh and as much fun as physically possible is an absolute must for me! Trying not to take myself too seriously and just enjoying life 🤗"
        return label
    }()
    
    //MARK: - Initializers.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setupUI(){
        self.addSubview(aboutLabel)
        aboutLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
        }
    }

}
