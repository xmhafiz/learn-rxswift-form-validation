//
//  SignUpViewController.swift
//  FormValidationExample
//
//  Created by Hafiz on 27/04/2021.
//

import UIKit
import RxSwift

class SignUpViewController: UIViewController {
    // 1
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    let disposeBag = DisposeBag()
    // 2
    let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.setTitleColor(.gray, for: .disabled)
        setupBindings()
    }
    
    func setupBindings() {
        // 3
        // bind textfields to viewModel for validation and process
        nameTextField.rx.text.bind(to: viewModel.nameSubject).disposed(by: disposeBag)
        emailTextField.rx.text.bind(to: viewModel.emailSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.bind(to: viewModel.passwordSubject).disposed(by: disposeBag)
        
        // 4
        // check if form has fulfil conditions to enable submit button
        viewModel.isValidForm.bind(to: submitButton.rx.isEnabled).disposed(by: disposeBag)
    }
}
