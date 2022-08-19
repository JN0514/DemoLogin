//
//  TableViewCell.swift
//  Login_SnapKit
//
//  Created by Jayasurya on 16/08/22.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    static let idenitfier: String = "cell"
    var heightconstraint: Constraint?
    let raisedView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 15
        v.layer.shadowOffset = CGSize(width: 2, height: 0)
        v.layer.shadowRadius = 3
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.6
        v.backgroundColor = .init(white: 1, alpha: 1)
        return v
    }()
    
    let compLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    let timeLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.text = "17 Aug 2022, 9:59 AM"
        l.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    let priceLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        l.textAlignment = .right
        l.text = "5000"
        return l
    }()
    
    let exchangeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 1, height: 0)
        btn.layer.shadowOpacity = 0.4
        btn.setTitle("EXC", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        btn.backgroundColor = .init(white: 1, alpha: 0.9)
        btn.layer.shadowRadius = 5
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    let sentimentBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 1, height: 0)
        btn.layer.shadowOpacity = 0.4
        btn.layer.shadowRadius = 5
        btn.setTitle("BULLISH", for: .normal)
        btn.backgroundColor = .init(white: 1, alpha: 0.9)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    let shareBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.setTitle("SHARE", for: .normal)
        btn.layer.shadowRadius = 3
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 1, height: 0)
        btn.layer.shadowOpacity = 0.4
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        btn.backgroundColor = .init(white: 1, alpha: 0.9)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    private let img: UIImageView = {
        let i = UIImageView()
        return i
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    func configureCell(comp: String, time: String, price: String, exchange: String, sentiment: String, imgURL: String){
        compLabel.text = comp
        timeLabel.text = time
        priceLabel.text = price
        exchangeBtn.setTitle(exchange, for: .normal)
        sentimentBtn.setTitle(sentiment, for: .normal)
        img.loadImg(url: imgURL)
    }
    func setConstrains(){
        self.addSubview(raisedView)
        raisedView.snp.makeConstraints{
            make in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 8, bottom: 15, right: 8))
        }
        self.addSubview(compLabel)
        compLabel.snp.makeConstraints{
            make in
            make.height.equalTo(self.raisedView).multipliedBy(0.07)
            make.width.equalTo(self.raisedView).multipliedBy(0.4)
            make.top.equalTo(self.raisedView).offset(10)
            make.left.equalTo(self.raisedView).offset(10)
        }
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints{
            make in
            make.top.equalTo(self.compLabel.snp.bottom).offset(3)
            make.left.equalTo(self.compLabel)
            make.width.equalTo(self.raisedView).multipliedBy(0.3)
            make.height.equalTo(self.raisedView).multipliedBy(0.044)
        }
        self.addSubview(priceLabel)
        priceLabel.snp.makeConstraints{
            make in
            make.top.equalTo(self.compLabel)
            make.right.equalTo(self.raisedView).offset(-10)
            make.height.equalTo(self.compLabel.snp.height)
            make.width.equalTo(self.timeLabel.snp.width)
        }
        self.addSubview(exchangeBtn)
        exchangeBtn.snp.makeConstraints{
            make in
            make.left.equalTo(self.compLabel)
            make.bottom.equalTo(self.raisedView).offset(-10)
            make.width.equalTo(self.raisedView).multipliedBy(0.2)
            make.height.equalTo(self.raisedView).multipliedBy(0.06)
        }
        self.addSubview(sentimentBtn)
        sentimentBtn.snp.makeConstraints{
            make in
            make.top.equalTo(self.exchangeBtn)
            make.bottom.equalTo(self.exchangeBtn)
            make.centerX.equalTo(self.raisedView)
            make.width.equalTo(self.raisedView).multipliedBy(0.2)
        }
        self.addSubview(shareBtn)
        shareBtn.snp.makeConstraints{
            make in
            make.top.equalTo(self.exchangeBtn)
            make.bottom.equalTo(self.exchangeBtn)
            make.right.equalTo(self.priceLabel.snp.right)
            make.width.equalTo(self.raisedView).multipliedBy(0.2)
        }
        self.addSubview(img)
        img.snp.makeConstraints{
            make in
            make.top.equalTo(self.timeLabel.snp.bottom).offset(5)
            make.bottom.equalTo(self.sentimentBtn.snp.top).offset(-5)
            make.left.equalTo(self.raisedView).offset(30)
            make.right.equalTo(self.raisedView).offset(-30)
            //make.center.equalTo(self.raisedView)
//            make.centerX.equalTo(self.raisedView)
        }
    }
}

extension UIImageView {
    func loadImg(url: String){
        guard let url = URL(string: url) else{
            return
        }
        if let imageData = try? Data(contentsOf: url){
            if let loadedImage = UIImage(data: imageData){
                self.image = loadedImage
            }
        }
    }
}
