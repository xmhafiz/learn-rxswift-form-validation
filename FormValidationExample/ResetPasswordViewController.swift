//
//  ViewController.swift
//  FormValidationExample
//
//  Created by Hafiz on 24/04/2021.
//

import UIKit
// 2
import RxSwift
import RxCocoa

class ResetPasswordViewController: UIViewController {
    // Outlets
    // 1
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    // Rx variables
    // 2
    var emailSubject = BehaviorRelay<String?>(value: "")
    // 3
    let disposeBag = DisposeBag()
    
    var isValidEmail: Observable<Bool> {
        return emailSubject.map { $0!.validateEmail() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    // 4
    func setupBindings() {
        // bind textfield value to emailSubject
        // then dispose in disposeBag (created at step 3)
        emailTextField.rx.text.bind(to: emailSubject).disposed(by: disposeBag)
        
        // 5
        isValidEmail
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

extension String {
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}
