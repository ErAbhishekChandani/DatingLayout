//
//  FullPictureCollectionViewCell.swift
//  DatingApp
//
//  Created by Er. Abhishek Chandani on 15/11/22.
//

import UIKit
import SnapKit

class FullPictureCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView.init()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.init()
        view.contentMode = .scaleAspectFit
        return view
    }()

    lazy var pageControl: UIPageControl = {
        let view = UIPageControl.init()
        view.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.5)
        view.currentPageIndicatorTintColor = UIColor.white
        return view
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
        self.addSubview(backgroundImageView)
        self.addSubview(imageView)
        self.addSubview(pageControl)
        backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    
    func setImage(image:UIImage) {
        imageView.image = image
        let blurImage = blurEffect(input: image)
        backgroundImageView.image = blurImage
    }
    
    func blurEffect(input: UIImage)->UIImage {
        let context = CIContext(options: nil)

        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: input)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(10, forKey: kCIInputRadiusKey)

        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")

        let output = cropFilter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        return processedImage
    }

}
