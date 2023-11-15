//
//  CreateUpdateVC.swift
//  w10c2
//
//  Created by Hyunjeong Choi on 2023-11-15.
//

import UIKit

class CreateUpdateVC: UIViewController {
  
  var emp:Emp? // based on this, we will decide it will be a create or update operation!
  
  private let nameTextField:UITextField = {
    let textField = UITextField()
    textField.placeholder = "Full Name"
    textField.textAlignment = .center
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .systemFill
    textField.autocorrectionType = .no
    return textField
  }()
  
  private let ageTextField:UITextField = {
    let textField = UITextField()
    textField.placeholder = "Age"
    textField.textAlignment = .center
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .systemFill
    return textField
  }()
  
  private let phoneTextField:UITextField = {
    let textField = UITextField()
    textField.placeholder = "Phone Number"
    textField.textAlignment = .center
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .systemFill
    return textField
  }()
  
  private let saveButton:UIButton = {
    let button = UIButton()
    button.setTitle("Save", for: .normal)
    button.backgroundColor = .systemGreen
    button.layer.cornerRadius = 6
    return button
  }()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    
    view.addSubview(nameTextField)
    view.addSubview(ageTextField)
    view.addSubview(phoneTextField)
    view.addSubview(saveButton)
    
      // if employee already exists, it already has a info about the employee
    if let emp = emp {
      nameTextField.text = emp.name
      ageTextField.text = String(emp.age)
      phoneTextField.text = emp.phone
    }
  }
  
    // set the frame
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    nameTextField.frame = CGRect(x: 40, y: view.safeTop + 40, width: view.width - 80, height: 40)
    ageTextField.frame = CGRect(x: 40, y: nameTextField.bottom + 20, width: view.width - 80, height: 40)
    phoneTextField.frame = CGRect(x: 40, y: ageTextField.bottom + 20, width: view.width - 80, height: 40)
    saveButton.frame = CGRect(x: 40, y: phoneTextField.bottom + 20, width: view.width - 80, height: 40)
  }
  
  @objc private func saveButtonTapped() {
    
    let name = nameTextField.text!
    let age = Int(ageTextField.text!)!
    let phone = phoneTextField.text!
    
    if let emp = emp {
      
      CoreDataHandler.shared.update(emp: emp, name: name, age: age, phone: phone) { [weak self] in
        self?.navigationController?.popViewController(animated: true)
      }
    } else {
      
      CoreDataHandler.shared.insert(name: name, age: age, phone: phone) { [weak self] in
        self?.navigationController?.popViewController(animated: true)
      }
    }
  }
}
