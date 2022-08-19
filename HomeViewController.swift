//
//  HomeViewController.swift
//  Login_SnapKit
//
//  Created by Jayasurya on 18/08/22.
//


import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let txtFieldHeight = 35
    var contentHeightConstraint: Constraint?
    private let two_segment: UISegmentedControl = {
        let segmentItems = ["items"]
        let segmentCtrl = UISegmentedControl(items: segmentItems)
        segmentCtrl.backgroundColor = .systemGray3
        return segmentCtrl
    }()



    private let scrollView: UIScrollView = {
        let sc = UIScrollView()
        return sc
    }()
    private let contentView: UIView = {
        let v = UIView()
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemMint
        setConstraints()
        setPasswordField()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        loginBtn.addTarget(self, action: #selector(tap_login_btn(_:)), for: .touchUpInside)
    }
    
    @objc
    func tap_login_btn(_ sender: UIButton){
        
        let userID = userNameTextField.text
        let userFine = validUserID(userID: userID ?? "")

        
        let pass = passwordTextField.text
        let passFine = validPassword(password: pass ?? "")
        
        let dob = DOBTextField.text
        let dobFine = validDOB(dob: dob ?? "0")
        
        
        if (userFine && passFine && dobFine){
            dismiss(animated: true, completion: nil)
            let vc = SecondViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        else if !userFine && passFine{
            let dialogMessage = UIAlertController(title: "Username", message: "Username must contain 1 uppercase, 1 numeric and atleast 6 character", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            dialogMessage.addAction(action)
            self.present(dialogMessage, animated: true, completion: nil)
        }
        else if userFine && !passFine{
            let dialogMessage = UIAlertController(title: "Password", message: "Password Must contain 1 lowercase, 1 numeric, 1 uppercase, 1 special character and atleast 8 characters", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            dialogMessage.addAction(action)
            self.present(dialogMessage, animated: true, completion: nil)
        }
        else if !userFine && !passFine{
            let dialogMessage = UIAlertController(title: "Username and Password", message: "Username must contain 1 uppercase, 1 numeric and atleast 6 character,  Password Must contain 1 lowercase, 1 numeric, 1 uppercase, 1 special character and atleast 8 characters", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            dialogMessage.addAction(action)
            self.present(dialogMessage,animated: true, completion: nil)
        }
        else{
            let dialogMessage = UIAlertController(title: "DOB", message: "Not Valid DOB", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            dialogMessage.addAction(action)
            self.present(dialogMessage,animated: true, completion: nil)
        }
        
            
    }
    
    private func validPassword(password: String) -> Bool {
        let passwordregx = "^(?=.{8,}$)(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*[$@$#!%*?&]).*$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordregx)
        return passwordTest.evaluate(with: password)
    }
    
    private func validDOB(dob: String) -> Bool {
        let dobInt = Int(dob)
        if(dobInt ?? 0>2010 || dobInt ?? 0<1900){
            return false
        }
        return true
    }
    
    private func validUserID(userID: String) -> Bool{
        let userregx = "^(?=.{6,}$)(?=.*[A-Z])(?=.*[0-9]).*$"
        let userTest = NSPredicate(format: "SELF MATCHES %@", userregx)
        return userTest.evaluate(with: userID)
    }
    
    @objc
    func dismissKeyBoard(_ sender: UITapGestureRecognizer){
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        DOBTextField.resignFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {

    }
    private let imgInView: UIView = {
        let v = UIView()
        return v
    }()
    private let segInView: UIView = {
        let v = UIView()
        return v
    }()
    private let logoImg: UIImageView = {
        let i = UIImageView(image: UIImage(named: "image"))
        return i
    }()


    private let topLabel: UILabel = {
        let v = UILabel()
        v.text = "Sign in "
        v.numberOfLines = 0
        v.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        v.textAlignment = .center
        return v
    }()
    
    private let userNameTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter User Name"
        txt.backgroundColor = .white
        txt.layer.cornerRadius = 5
        return txt
    }()
    
    private let passwordTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter Password"
        txt.backgroundColor = .white
        txt.isSecureTextEntry = true
        txt.layer.cornerRadius = 5
        return txt
    }()
    
    private let eye: UIImage = {
        let i = UIImage(systemName: "eye.fill")
        return i ?? UIImage()
    }()
    
    private let slashEye: UIImage = {
        let i = UIImage(systemName: "eye.slash.fill")
        return i ?? UIImage()
    }()
    
    private let eyeBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    func setPasswordField(){
        passwordTextField.isSecureTextEntry = true
        eyeBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        eyeBtn.setImage(slashEye, for: .normal)
        eyeBtn.setImage(eye, for: .selected)
        eyeBtn.isUserInteractionEnabled = true
        eyeBtn.addTarget(self, action: #selector(checkPasswordVisiblity(_:)), for: .touchUpInside)
        passwordTextField.rightView = eyeBtn
        passwordTextField.rightViewMode = .always
    }
    
    @objc
    func checkPasswordVisiblity(_ sender: UIButton){
        passwordTextField.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
    }
    
    private let DOBTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter D.O.B"
        txt.backgroundColor = .white
        txt.layer.cornerRadius = 5
        txt.keyboardType = .numberPad
        return txt
    }()
    
    private let forgotPwdBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Forgot Password", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 0, weight: .semibold)
        return btn
    }()
    
    private let hepBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Help", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 0, weight: .semibold)
        btn.contentHorizontalAlignment = .right
        return btn
    }()
    
    private let loginBtn: UIButton = {
        let btn = UIButton(configuration: UIButton.Configuration.filled())
        btn.setTitle("SECURED LOGIN", for: .normal)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 0, weight: .bold)
        return btn
    }()
    
    private let openActBtn: UIButton = {
        let btn = UIButton(configuration: UIButton.Configuration.gray())
        btn.setTitle("OPEN NEW ACCOUNT", for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = .systemGray4
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 0, weight: .bold)
        return btn
    }()
    
    private let sebiBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 0, weight: .semibold)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = ""

        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    func setConstraints(){
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{
            make in
            make.left.right.equalTo(self.view)
            make.top.bottom.equalTo(self.scrollView)
//            self.contentHeightConstraint = make.height.width.equalTo(self.view).constraint
        }

        self.contentView.addSubview(imgInView)
        imgInView.snp.makeConstraints{
            make in
            make.top.equalTo(self.contentView).offset(40)
            make.centerX.equalTo(self.contentView)
            make.width.equalTo(250)
            make.height.equalTo(175)
        }
        self.imgInView.addSubview(logoImg)
        logoImg.snp.makeConstraints{
            make in
            make.edges.equalTo(self.imgInView)
        }
        
        self.contentView.addSubview(segInView)
        segInView.snp.makeConstraints{
            make in
            make.left.right.equalTo(self.imgInView)
            make.top.equalTo(self.imgInView.snp.bottom).offset(5)
            make.height.equalTo(30)
        }
        self.segInView.addSubview(two_segment)
        two_segment.snp.makeConstraints{
            make in
            make.edges.equalTo(self.segInView)
        }
        
        self.contentView.addSubview(topLabel)
        topLabel.snp.makeConstraints{
            make in
            make.left.right.equalTo(self.segInView).inset(10)
            make.top.equalTo(self.segInView.snp.bottom).offset(10)
        }
        
        self.contentView.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints{
            make in
            make.left.right.equalTo(segInView).inset(-18)
            make.top.equalTo(topLabel.snp.bottom).offset(45)
            make.height.equalTo(txtFieldHeight)
        }
        
        self.contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{
            make in
            make.left.right.equalTo(userNameTextField)
            make.top.equalTo(userNameTextField.snp.bottom).offset(30)
            make.height.equalTo(txtFieldHeight)
        }
        
        self.contentView.addSubview(DOBTextField)
        DOBTextField.snp.makeConstraints{
            make in
            make.left.right.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.height.equalTo(txtFieldHeight)
        }
        
        self.contentView.addSubview(forgotPwdBtn)
        forgotPwdBtn.snp.makeConstraints{
            make in
            make.left.equalTo(DOBTextField)
            make.top.equalTo(DOBTextField.snp.bottom).offset(10)
            make.width.equalTo(DOBTextField).multipliedBy(0.38)
            make.height.equalTo(DOBTextField).multipliedBy(0.4)
        }
        
        self.contentView.addSubview(hepBtn)
        hepBtn.snp.makeConstraints{
            make in
            make.right.equalTo(DOBTextField)
            make.top.bottom.equalTo(forgotPwdBtn)
            make.width.equalTo(DOBTextField).multipliedBy(0.3)
            make.height.equalTo(DOBTextField).multipliedBy(0.4)
        }
        
        self.contentView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints{
            make in
            make.right.left.equalTo(self.userNameTextField).inset(-20)
            make.top.equalTo(hepBtn.snp.bottom).offset(35)
            make.height.equalTo(txtFieldHeight+5)
        }
        
        self.contentView.addSubview(openActBtn)
        openActBtn.snp.makeConstraints{
            make in
            make.right.left.equalTo(self.loginBtn)
            make.top.equalTo(loginBtn.snp.bottom).offset(40)
            make.height.equalTo(txtFieldHeight+5)
        }
        
        self.contentView.addSubview(sebiBtn)
        sebiBtn.snp.makeConstraints{
            make in
            make.top.equalTo(openActBtn.snp.bottom).offset(10)
            make.centerX.equalTo(openActBtn)
            make.height.equalTo(forgotPwdBtn)
            make.width.equalTo(openActBtn).multipliedBy(0.7)
        }
        
        self.contentView.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints{
            make in
            make.left.right.equalTo(openActBtn)
            make.top.equalTo(sebiBtn.snp.bottom).offset(30)
            make.bottom.equalTo(self.scrollView.snp.bottom).offset(-20)
        }
    }
    
}
