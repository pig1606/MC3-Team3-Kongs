//
//  AuthPhoneNumberViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/30.
//

import UIKit

class AuthPhoneNumberViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호를 알려주세요."
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let textFieldContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .container
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "인증번호"
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.textColor = .white
        textField.tintColor = .label
        textField.frame.size = CGSize(width: 300, height: 50)
        textField.keyboardType = .numberPad
        textField.addDoneButtonOnKeyboard()
        return textField
    }()
    
    private let inputInfoLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let ctaButton: CTAButton = {
        let button = CTAButton(title: "시작하기")
        button.addTarget(self, action: #selector(ctaButtonTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        dismissKeyboardWhenTappedAround()

    }
    
    //MARK: - Selectors
    
    @objc func ctaButtonTap() {
        guard let phoneNumber = textField.text else {
            presentBottomAlert(message: "전화번호를 입력하세요")
            return
        }
        
        guard phoneNumber.count == 11 else {
            presentBottomAlert(message: "유효하지 않은 전화번호입니다.")
            return
        }
        
        AuthManager.shared.requestVerificationCode(phoneNumber: phoneNumber)
        let vc = AuthVerificationController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        //레이아웃 구성
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(primaryLabel)
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 60),
            primaryLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25)
        ])
        
        view.addSubview(inputInfoLabel)
        inputInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputInfoLabel.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 30),
            inputInfoLabel.leadingAnchor.constraint(equalTo: primaryLabel.leadingAnchor)
        ])
        
        view.addSubview(textFieldContainer)
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldContainer.topAnchor.constraint(equalTo: inputInfoLabel.bottomAnchor, constant: 10),
            textFieldContainer.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            textFieldContainer.heightAnchor.constraint(equalToConstant: 50),
            textFieldContainer.leadingAnchor.constraint(equalTo: inputInfoLabel.leadingAnchor),
            textFieldContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25)
        ])
        
        textFieldContainer.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: 20),
            textField.centerYAnchor.constraint(equalTo: textFieldContainer.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(ctaButton)
        ctaButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ctaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            ctaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            ctaButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            ctaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - Preview
import SwiftUI

struct AuthPhoneNumberViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = AuthPhoneNumberViewController

    func makeUIViewController(context: Context) -> AuthPhoneNumberViewController {
        return AuthPhoneNumberViewController()
    }

    func updateUIViewController(_ uiViewController: AuthPhoneNumberViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct AuthPhoneNumberViewControllerPreview: PreviewProvider {
    static var previews: some View {
        AuthPhoneNumberViewControllerRepresentable()
    }
}
