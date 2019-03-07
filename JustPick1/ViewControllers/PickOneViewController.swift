//
//  PickOneViewController.swift
//  JustPick1
//
//  Created by Amir Afridi on 1/9/19.
//  Copyright © 2019 Amir Afridi. All rights reserved.
//

import Foundation
import UIKit
import Darwin

class PickOneViewController : UIViewController {
    
    var values : [String]
    var yourPick : String
    
    init(values: [String]) {
        self.values = values
        self.yourPick = self.values.randomElement()!
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    let resultsView : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.textAlignment = .center
        tf.isUserInteractionEnabled = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let rerunButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.lightGray
        btn.setTitle("Pick Again", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 6
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        btn.addTarget(self, action: #selector(pickOneAtRandom), for: .touchUpInside)
        
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "YOUR PICK"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(HandleDismissView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(goToRootViewController))
        
        setupView()
        pickOneAtRandom()
        
    }
    

    
    @objc func goToRootViewController() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func HandleDismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func pickOneAtRandom () {
        yourPick = values.randomElement()!
        resultsView.text = yourPick
    }
    
    func setupView () {
        view.addSubview(containerView)
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        containerView.addSubview(resultsView)
        containerView.addSubview(rerunButton)
        
        resultsView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        resultsView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -36).isActive = true
        resultsView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -24).isActive = true
        resultsView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/5).isActive = true
        
        rerunButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        rerunButton.topAnchor.constraint(equalTo: resultsView.bottomAnchor, constant: 24).isActive = true
        rerunButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -24).isActive = true
        rerunButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3).isActive = true
        
        
    }
}
