//
//  HomeViewController.swift
//  DatingApp
//
//  Created by Er. Abhishek Chandani on 12/11/22.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    var mockData: HomeMockData = HomeMockData.init()
    var picturesMode: PictureMode = .normal
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    lazy var likeButtonHeartImage : UIImageView = {
        let iv = UIImageView.init()
        iv.image = UIImage.init(named: "like")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var confettiImage : UIImageView = {
        let iv = UIImageView.init()
        iv.isHidden = true
        iv.image = UIImage.init(named: "Confetti")
        return iv
    }()

    lazy var likeButton: UIButton = {
        let button = UIButton.init()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor.init(hexString: "#884FE5")
        button.addTarget(self, action: #selector(self.tapOnLikeButton), for: .touchUpInside)
        return button
    }()
    
    lazy var dislikeButton: UIButton = {
        let button = UIButton.init()
        button.layer.cornerRadius = 30
        button.setImage(UIImage.init(named: "dislike"), for: .normal)
        button.backgroundColor = UIColor.init(hexString: "#E4D3FF")
        button.addTarget(self, action: #selector(self.tapOnDislikeButton), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        view.backgroundColor = .red
        return view
    }()
    
    lazy var likeImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.isHidden = true
        imageView.image = UIImage.init(named: "Heart")
        return imageView
    }()
    lazy var dislikeImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.isHidden = true
        imageView.image = UIImage.init(named: "greyDislike")
        return imageView
    }()

    private var dataSource: UICollectionViewDiffableDataSource<Int, String>! = nil
    private var snapshot: NSDiffableDataSourceSnapshot<Int, String>! = nil

    //MARK: - UIView life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    
    //MARK: - Action methods
    @objc func tapOnLikeButton(){
        animateLikeDislikeImage(inputView: likeImageView)
        confettiImage.isHidden = false
        confettiImage.alpha = 1
        self.confettiImage.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 0.5) {
            self.confettiImage.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        }completion: { finished in
            UIView.animate(withDuration: 0.2) {
                self.confettiImage.alpha = 0
            }completion: { finished in
                self.confettiImage.isHidden = true
            }
        }
        setupLikeButtonAnimation()
        perform(#selector(Self.switchToNewProfile), with: nil, afterDelay: 1)
    }
    
    /// Switches to next profile from mock data.
    @objc func switchToNewProfile() {
        picturesMode = .normal
        mockData.nextProfile()
        configureDatasource()
    }
    
    /// Called when we tap on dislike buttton.
    @objc func tapOnDislikeButton(){
        animateLikeDislikeImage(inputView: dislikeImageView)
        perform(#selector(Self.switchToNewProfile), with: nil, afterDelay: 1)
        UIView.animate(withDuration: 0.3) {
            self.dislikeButton.transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
        }completion: { finished in
            UIView.animate(withDuration: 0.2) {
                self.dislikeButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }
        }
    }

    /// Animates the picture centered like or dislike image revealing the user action.
    fileprivate func animateLikeDislikeImage(inputView: UIView) {
        inputView.isHidden = false
        inputView.alpha = 1
        collectionView.bringSubviewToFront(inputView.superview ?? inputView)
        inputView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.7) {
            inputView.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        }completion: { finished in
            UIView.animate(withDuration: 0.3) {
                inputView.alpha = 0
            }completion: { finished in
                inputView.isHidden = true
            }
        }
    }

}

//MARK: - Private methods
fileprivate extension HomeViewController {
    
    func setupUI(){
        view.backgroundColor = .white
        //Created Shadow views for like and dislike button
        let likeButtonShadowView = UIView.init()
        likeButtonShadowView.backgroundColor = .white
        likeButtonShadowView.layer.cornerRadius = 30
        view.addSubview(likeButtonShadowView)

        let dislikeButtonShadowView = UIView.init()
        dislikeButtonShadowView.backgroundColor = .white
        dislikeButtonShadowView.layer.cornerRadius = 30
        view.addSubview(dislikeButtonShadowView)

        view.addSubview(likeButton)
        view.addSubview(dislikeButton)
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
            make.height.width.equalTo(60)
        }
        
        likeButton.addSubview(likeButtonHeartImage)
        likeButton.addSubview(confettiImage)
        likeButtonHeartImage.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerY.centerX.equalToSuperview()
        }
        confettiImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        dislikeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(likeButton)
            make.height.width.equalTo(likeButton)
        }
        
        likeButtonShadowView.snp.makeConstraints { make in
            make.centerX.centerY.height.width.equalTo(likeButton)
        }
        
        dislikeButtonShadowView.snp.makeConstraints { make in
            make.centerX.centerY.height.width.equalTo(dislikeButton)
        }
        //This functions add shadow on view.
        addShadow(view: likeButtonShadowView)
        addShadow(view: dislikeButtonShadowView)
        
        configureCollectionView(layout: homePageLayout())
        configureDatasource()
    }
    
    /// Adding pulsating animation on hear image.
    func setupLikeButtonAnimation(){
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 0.6
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.12
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.8

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = 0
        animationGroup.animations = [pulse1]

        likeButtonHeartImage.layer.add(animationGroup, forKey: "pulse")
    }
    
    func addShadow(view: UIView) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: CGRect.init(x: 0, y: 0, width: 60, height: 60),
                                        cornerRadius: 30).cgPath
        shadowLayer.fillColor = view.backgroundColor?.cgColor
        shadowLayer.shadowColor = UIColor(red: 0.345, green: 0.306, blue: 0.514, alpha: 0.7).cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 1.05)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 5
        view.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    /// Registering all collectionview cell and reusable views class.
    private func registerCollectionViewCellAndViews() {
        collectionView.register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: PictureCollectionViewCell.reuseIdentifier)
        collectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: TextCollectionViewCell.reuseIdentifier)
        collectionView.register(ProfileInterestCollectionViewCell.self, forCellWithReuseIdentifier: ProfileInterestCollectionViewCell.reuseIdentifier)
        collectionView.register(FullPictureCollectionViewCell.self, forCellWithReuseIdentifier: FullPictureCollectionViewCell.reuseIdentifier)
        collectionView.register(AboutSectionReusableView.self, forSupplementaryViewOfKind: AboutSectionReusableView.reuseIdentifier, withReuseIdentifier: AboutSectionReusableView.reuseIdentifier)
        collectionView.register(ProfileInfoReusableView.self, forSupplementaryViewOfKind: ProfileInfoReusableView.reuseIdentifier, withReuseIdentifier: ProfileInfoReusableView.reuseIdentifier)
    }
    
    private func configureCollectionView(layout: UICollectionViewLayout) {
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        registerCollectionViewCellAndViews()
        //Add Collection View for Home Page content.
        view.insertSubview(collectionView, at: 0)
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(60);
        }
        setupCollectionViewAccessories()
    }
    
    /// adds like and dislike image inside of collectionview to animate the respective user action.
    func setupCollectionViewAccessories(){
        let heartContainer = UIView.init()
        heartContainer.isUserInteractionEnabled = false
        heartContainer.backgroundColor = .clear
        collectionView.addSubview(heartContainer)
        heartContainer.addSubview(likeImageView)
        heartContainer.addSubview(dislikeImageView)

        heartContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.67)
            make.width.equalToSuperview()
        }
        likeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        dislikeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    //MARK: - Datasource methods
    private func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, imageName: String) -> UICollectionViewCell? in
            
            // Get a cell of the desired kind.
            if indexPath.section == 0 {
                if self.picturesMode == .normal {
                    return self.pictureCellAt(indexPath: indexPath, imageName: imageName)
                }else{
                    return self.fullPictureCellAt(indexPath: indexPath)
                }
            }else if indexPath.section == 1 {
                return self.profileInterestCellAt(indexPath: indexPath)
            } else{
                return self.textCellAt(indexPath: indexPath)
            }
        }
        //Header Supplementry View Provider.
        dataSource.supplementaryViewProvider = {
            (
                collectionView: UICollectionView,
                kind: String,
                indexPath: IndexPath)
            -> UICollectionReusableView? in
            
            if kind == AboutSectionReusableView.reuseIdentifier,let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: AboutSectionReusableView.reuseIdentifier,
                for: indexPath) as? AboutSectionReusableView {
                return view
            }else if let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ProfileInfoReusableView.reuseIdentifier,
                for: indexPath) as? ProfileInfoReusableView {
                let matchProfile = self.mockData.getProfile()
                let profileName = matchProfile.name + ", " + matchProfile.age
                view.titleLabel.text = profileName
                return view
            }else{
                    return nil
            }
                
        }

        // initial data
        snapshot = getSnapshot()
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func getSnapshot()->Snapshot{
        // initial data
        var snapshot = Snapshot()
        let matchProfile = mockData.getProfile()
        let numberOfSections = 3
        for section in 0..<numberOfSections {
            snapshot.appendSections([section])
            if section == 0 {
                snapshot.appendItems(matchProfile.images.map({ image in
                    return UUID.init().uuidString + "_" + image
                }))
            }else if section == 1 {
                snapshot.appendItems(matchProfile.interests.map({ interest in
                    return interest.name ?? ""
                }))
            }else{
                snapshot.appendItems([matchProfile.about])
            }
        }
        return snapshot
    }
    
    //MARK: - UICollectionView cells
    private func pictureCellAt(indexPath: IndexPath, imageName: String)-> UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PictureCollectionViewCell.reuseIdentifier,
            for: indexPath) as? PictureCollectionViewCell else { fatalError("Could not create new cell") }
        cell.clipsToBounds = true
        cell.imageView.image = UIImage.init(named: mockData.getProfile().images[indexPath.row])
        cell.layer.cornerRadius = 10
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        return cell
    }
    
    //MARK: - UICollectionView cells
    private func fullPictureCellAt(indexPath: IndexPath)-> UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FullPictureCollectionViewCell.reuseIdentifier,
            for: indexPath) as? FullPictureCollectionViewCell else { fatalError("Could not create new cell") }
        cell.clipsToBounds = true
        if let image = UIImage.init(named: mockData.getProfile().images[indexPath.row]) {
            cell.setImage(image: image)
        }
        cell.pageControl.numberOfPages = mockData.getProfile().images.count
        cell.pageControl.currentPage = indexPath.row
        cell.layer.cornerRadius = 10
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        return cell
    }

    private func textCellAt(indexPath: IndexPath)->UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TextCollectionViewCell.reuseIdentifier,
            for: indexPath) as? TextCollectionViewCell else { fatalError("Could not create new cell") }
        let matchProfile = mockData.getProfile()
        cell.aboutLabel.text = matchProfile.about
        return cell
    }
    
    private func profileInterestCellAt(indexPath: IndexPath)->UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfileInterestCollectionViewCell.reuseIdentifier,
            for: indexPath) as? ProfileInterestCollectionViewCell else { fatalError("Could not create new cell") }
        let matchProfile = mockData.getProfile()
        cell.setData(interest: matchProfile.interests[indexPath.item])
        return cell
    }

}

//MARK: UICollectionview delegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if picturesMode == .normal {
                picturesMode = .full
            }else{
                picturesMode = .normal
            }
            dataSource.apply(getSnapshot(), animatingDifferences: true)
            if picturesMode == .full {
                collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
            }
        }
    }
}

enum PictureMode {
    case normal
    case full
}
