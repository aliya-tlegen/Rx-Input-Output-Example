//
//  ViewController.swift
//  RxExampleInputOutput
//
//  Created by Алия on 23.01.2023.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    private var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 110, y: 250, width: 150, height: 30))
        //        textField.sizeToFit()
        textField.borderStyle = .line
        return textField
    }()
    
    private var validateButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 150, y: 350, width: 150, height: 20))
        button.setTitle("validate", for: .normal)
        button.layer.borderWidth = 0.5
        button.setTitleColor(.blue, for: .normal)
        button.isEnabled = true
        button.sizeToFit()
        return button
    }()
    
    private var helloLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 150, y: 450, width: 150, height: 20))
        label.textColor = .black
        return label
    }()
    
    private let viewModel = SayHelloViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(textField)
        view.addSubview(validateButton)
        view.addSubview(helloLabel)
    }
    
    private func bindViewModel() {
        let inputs = SayHelloViewModel.Input(name: textField.rx.text.orEmpty.asObservable(),
                                             validate: validateButton.rx.tap.asObservable())
        let outputs = viewModel.transform(input: inputs)
        outputs.greeting
            .drive(helloLabel.rx.text)
            .disposed(by: bag)
    }
}

