//
//  LoginViewController.swift
//  Loop
//
//  Created by rbuzby on 6/22/17.
//  Copyright © 2017 rbuzby. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
        
        let ref = Database.database().reference(fromURL: "https://loop-eb26e.firebaseio.com/")

        setupComponents()
    }
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.init(red: 1/255, green: 198/255, blue: 215/255, alpha: 1)
        button.setTitle("Stay in the Loop", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = usernameTextField.text else {
            /*
            change to popup
            */
            
            print("Please enter valid info")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error) in
            if error != nil {
                print(error)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
        
            let ref = Database.database().reference().child("users").child(uid)
            let values = ["name": name, "email": email]
            ref.updateChildValues(values) { (err, ref) in
                if err != nil {
                    print(err)
                    return
                }
            }
        }
    }
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let seperator: UIView = {
        let s = UIView()
        s.backgroundColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let seperator2: UIView = {
        let s = UIView()
        s.backgroundColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    

    func setupComponents() {
        view.addSubview(inputsContainerView)
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        view.addSubview(registerButton)
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerButton.layer.cornerRadius = 5
        registerButton.layer.masksToBounds = true
        
        
        inputsContainerView.addSubview(usernameTextField)
        usernameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        usernameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        

        inputsContainerView.addSubview(seperator)
        seperator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        seperator.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor).isActive = true
        seperator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        

        inputsContainerView.addSubview(emailTextField)
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true

        
        inputsContainerView.addSubview(seperator2)
        seperator2.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        seperator2.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        seperator2.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        seperator2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        

        inputsContainerView.addSubview(passwordTextField)
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: seperator2.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        
    }

}
