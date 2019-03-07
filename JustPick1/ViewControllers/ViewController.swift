//
//  ViewController.swift
//  JustPick1
//
//  Created by Amir Afridi on 1/9/19.
//  Copyright © 2019 Amir Afridi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    let howManyOptions : UITextField = {
        let tf = UITextField()
        tf.placeholder = "How Many Options?"
        tf.keyboardType = UIKeyboardType.numberPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.textAlignment = .center
        return tf
    }()
    
    let enterOptionsButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.lightGray
        btn.setTitle("Enter Options", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 6
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(presentEnterOptions), for: UIControl.Event.touchUpInside)
        
        return btn
    }()
    
    let headsTailsButton : UIButton = {
       let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.lightGray
        btn.setTitle("Heads or Tails", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 6
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(presentHeadsTails), for: UIControl.Event.touchUpInside)
        
        return btn
    }()
    
    let rollDiceButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.lightGray
        btn.setTitle("Roll a Die", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 6
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(presentRollDice), for: UIControl.Event.touchUpInside)
        
        return btn
    }()
    
    let instructionView : UITextField = {
        let view = UITextField()
        view.text = "Enter the number of options between 2 - 10"
        view.font = UIFont.systemFont(ofSize: 16)
        view.textAlignment = .center
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        howManyOptions.text = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "JUST PICK 1"
                
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        setupView()
        
    }
    
    func setupView() {
        view.addSubview(containerView)
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        containerView.addSubview(instructionView)
        containerView.addSubview(howManyOptions)
        containerView.addSubview(enterOptionsButton)
        containerView.addSubview(headsTailsButton)
        containerView.addSubview(rollDiceButton)
        
        // how many options text field
        howManyOptions.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        howManyOptions.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -36).isActive = true
        howManyOptions.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -24).isActive = true
        howManyOptions.heightAnchor.constraint(equalToConstant: 36).isActive = true
        // enter options button
        enterOptionsButton.topAnchor.constraint(equalTo: howManyOptions.bottomAnchor, constant: 12).isActive = true
        enterOptionsButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
        enterOptionsButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -24).isActive = true
        enterOptionsButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        // heads tails button
        headsTailsButton.topAnchor.constraint(equalTo: enterOptionsButton.bottomAnchor, constant: 12).isActive = true
        headsTailsButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        headsTailsButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
        headsTailsButton.widthAnchor.constraint(equalTo: enterOptionsButton.widthAnchor).isActive = true
        
        // roll die button
        rollDiceButton.topAnchor.constraint(equalTo: headsTailsButton.bottomAnchor, constant: 12).isActive = true
        rollDiceButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        rollDiceButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
        rollDiceButton.widthAnchor.constraint(equalTo: enterOptionsButton.widthAnchor).isActive = true
        
        //instructions view
        instructionView.bottomAnchor.constraint(equalTo: howManyOptions.topAnchor, constant: 0).isActive = true
        instructionView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        instructionView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -24).isActive = true
        instructionView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
    }
    
    @objc func presentEnterOptions () {
        if (howManyOptions.text != "") {
            let cnt = Int(howManyOptions.text!)
            if (cnt != nil  && cnt! > 1 && cnt! < 11  ) {
                let enterOptionsViewController = UINavigationController(rootViewController: EnterOptionsViewController(count: cnt!))
                present(enterOptionsViewController, animated: true, completion: nil)
                instructionView.text = "Enter the number of options between 2 - 10"
                instructionView.textColor = UIColor.black
            } else {
                instructionView.textColor = UIColor.red
                instructionView.text = "Please enter a value between 2 and 10"
            }
        } else {
            instructionView.textColor = UIColor.red
            instructionView.text = "Please enter a value between 2 and 10"
        }
        
    }
    
    @objc func presentHeadsTails () {
        var textFieldValues = [String]()
        textFieldValues.append("Heads")
        textFieldValues.append("Tails")
        
        let pickOneViewController = UINavigationController(rootViewController: PickOneViewController(values: textFieldValues))
        present(pickOneViewController, animated: true, completion: nil)
        
    }
    
    @objc func presentRollDice () {
        var textFieldValues = [String]()
        textFieldValues.append("1")
        textFieldValues.append("2")
        textFieldValues.append("3")
        textFieldValues.append("4")
        textFieldValues.append("5")
        textFieldValues.append("6")
        
        let pickOneViewController = UINavigationController(rootViewController: PickOneViewController(values: textFieldValues))
        present(pickOneViewController, animated: true, completion: nil)
    }
    


}
