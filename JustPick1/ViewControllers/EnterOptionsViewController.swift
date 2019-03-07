//
//  EnterOptionsViewController.swift
//  JustPick1
//
//  Created by Amir Afridi on 1/9/19.
//  Copyright © 2019 Amir Afridi. All rights reserved.
//

import Foundation
import UIKit

class EnterOptionsViewController : UIViewController, UITextFieldDelegate {
    
    var count : Int
    var textFields = [UITextField]()
    var seperators = [UIView]()
    
    let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    let inputContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    let Pick1Button : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.lightGray
        btn.setTitle("Pick 1", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 6
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        btn.addTarget(self, action: #selector(pickOne), for: UIControl.Event.touchUpInside)
        
        return btn
    }()
    
    init(count: Int) {
        self.count = count
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "ENTER OPTIONS"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(HandleDismissView))
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        setupView()
    }
    
    
    @objc func HandleDismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func pickOne () {
        var blanks = false
        var textFieldValues = [String]()
        for tf in 0...count-1 {
            if (textFields[tf].text == "") {
                blanks = true
            } else {
                textFieldValues.append(textFields[tf].text!)
            }
        }
        if (blanks == false) {
            let pickOneViewController = UINavigationController(rootViewController: PickOneViewController(values: textFieldValues))
            present(pickOneViewController, animated: true, completion: nil)
        }
    }
    
    func setupView () {
        view.addSubview(containerView)
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: 48).isActive = true
        
        containerView.addSubview(Pick1Button)
        
        Pick1Button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
        Pick1Button.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -24).isActive = true
        Pick1Button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(inputContainerView)
        inputContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -24).isActive = true
        inputContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        inputContainerView.heightAnchor.constraint(equalTo: containerView.heightAnchor, constant: -64).isActive = true
        addTextFields()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            var adj : Int
            nextField.becomeFirstResponder()
            adj = nextField.tag * -24
            containerView.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: CGFloat(adj)).isActive = true
        } else {
            // Not found, so remove keyboard.
            containerView.centerYAnchor.constraint(greaterThanOrEqualTo: view.centerYAnchor).isActive = true
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    func addTextFields() {
        
        for cnt in 1...count {
            let newTf : UITextField = {
                let tf = UITextField()
                tf.placeholder = String(cnt)
                tf.translatesAutoresizingMaskIntoConstraints = false
                tf.tag = cnt

                return tf
            }()
            
            let newSeperator: UIView = {
                let view = UIView()
                view.backgroundColor = UIColor.lightGray
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            textFields.append(newTf)
            seperators.append(newSeperator)
            
            newTf.delegate = self
        }
        
        
        
        inputContainerView.addSubview(textFields[0])
        inputContainerView.addSubview(seperators[0])
        textFields[0].widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: -24).isActive = true
        textFields[0].heightAnchor.constraint(equalToConstant: 20).isActive = true
        textFields[0].leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        textFields[0].topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 12).isActive = true
        
        seperators[0].widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        seperators[0].heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperators[0].leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        seperators[0].topAnchor.constraint(equalTo: textFields[0].bottomAnchor).isActive = true
        
        inputContainerView.addSubview(textFields[1])
        inputContainerView.addSubview(seperators[1])
        textFields[1].widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: -24).isActive = true
        textFields[1].heightAnchor.constraint(equalToConstant: 20).isActive = true
        textFields[1].leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        textFields[1].topAnchor.constraint(equalTo: textFields[0].bottomAnchor, constant: 12).isActive = true
        
        seperators[1].widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        seperators[1].heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperators[1].leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        seperators[1].topAnchor.constraint(equalTo: textFields[1].bottomAnchor).isActive = true
        
        if count > 2 {
            for tf in 2...count-1 {
                inputContainerView.addSubview(textFields[tf])
                inputContainerView.addSubview(seperators[tf])
                textFields[tf].widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: -24).isActive = true
                textFields[tf].heightAnchor.constraint(equalToConstant: 20).isActive = true
                textFields[tf].centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor).isActive = true
                textFields[tf].topAnchor.constraint(equalTo: textFields[tf-1].bottomAnchor, constant: 12).isActive = true
                
                seperators[tf].widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
                seperators[tf].heightAnchor.constraint(equalToConstant: 1).isActive = true
                seperators[tf].leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
                seperators[tf].topAnchor.constraint(equalTo: textFields[tf].bottomAnchor).isActive = true
                
            }
        }

    }
    
}
