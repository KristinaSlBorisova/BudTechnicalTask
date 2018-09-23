//
//  TransactionTableViewCell.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 21/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import UIKit

final class TransactionTableViewCell: UITableViewCell {
    
    private static let imageSize = CGSize.init(width: 80, height: 80)
    private static let defaultMargin: CGFloat = 16.0
    
    var onButtonAction: (() -> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.infoStackView)
        self.contentView.addSubview(self.amountLabel)
        
        self.infoStackView.translatesAutoresizingMaskIntoConstraints = false
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let marginGuide = self.contentView.layoutMarginsGuide
        
        self.iconImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: TransactionTableViewCell.imageSize.height).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: TransactionTableViewCell.imageSize.width).isActive = true
        self.iconImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        self.iconImageView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        
        self.infoStackView.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: TransactionTableViewCell.defaultMargin).isActive = true
        self.infoStackView.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: TransactionTableViewCell.defaultMargin).isActive = true
        self.infoStackView.trailingAnchor.constraint(equalTo: amountLabel.leadingAnchor, constant: TransactionTableViewCell.defaultMargin).isActive = true
        self.infoStackView.bottomAnchor.constraint(lessThanOrEqualTo: marginGuide.bottomAnchor, constant: TransactionTableViewCell.defaultMargin).isActive = true
        
        self.amountLabel.centerYAnchor.constraint(equalTo: marginGuide.centerYAnchor).isActive = true
        self.amountLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.iconImageView.cancelImageDownload()
        self.iconImageView.image = nil
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
        self.categoryLabel.attributedText = nil
        self.amountLabel.text = nil
    }
    
    // MARK: Getters
    
    private lazy var infoStackView: UIStackView = {
        
        let infoStackView = UIStackView(arrangedSubviews: [
            self.titleLabel,
            self.subtitleLabel,
            self.categoryLabel
            ])
        
        infoStackView.spacing = 5
        infoStackView.axis = .vertical
        infoStackView.alignment = .leading
        
        return infoStackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 2
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: Setters
    
    func setIconWithString(_ urlString: String) {
        self.iconImageView.imageFromServerURL(urlString, placeHolder: UIImage(named: "placeholder"))
    }
    
    func setTitle(_ title: String?) {
        self.titleLabel.text = title
    }
    
    func setSubtitle(_ subtitle: String?) {
        self.subtitleLabel.text = subtitle
    }
    
    func setCategory(_ category: NSMutableAttributedString?) {
        self.categoryLabel.attributedText = category
    }
    
    func setAmount(_ amount: String?) {
        self.amountLabel.text = amount
    }
}

