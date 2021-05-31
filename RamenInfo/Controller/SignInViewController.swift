//
//  SignInViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/03/14.
//

import UIKit
import Firebase

class SignInViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passMess: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passMess.isHidden = true
    }
    
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボード閉じる
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let passWord = passwordTextField.text ?? ""
        Auth.auth().signIn(withEmail: email, password: passWord) { (result, error) in
            if let user = result?.user {
                self.performSegue(withIdentifier:"toMain" , sender: nil)
            }else {
                print("error")
                self.showErrorIfNeeded(error)
                return
            }
        }
        if passwordTextField.text!.count >= 6 {
            passMess.isHidden = true
        }else {
            passMess.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    private func showErrorIfNeeded(_ errorOrNil: Error?) {
        // エラーがなければ何もしません
        guard let error = errorOrNil else { return }
        
        let message = errorMessage(of: error) // エラーメッセージを取得
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func errorMessage(of error: Error) -> String {
        var message = "エラーが発生しました"
        guard let errcd = AuthErrorCode(rawValue: (error as NSError).code) else {
            return message
        }
        
        switch errcd {
        case .networkError: message = "ネットワークに接続できません"
        case .userNotFound: message = "ユーザが見つかりません"
        case .invalidEmail: message = "不正なメールアドレスです"
        case .emailAlreadyInUse: message = "このメールアドレスは既に使われています"
        case .wrongPassword: message = "入力した認証情報でサインインできません"
        case .userDisabled: message = "このアカウントは無効です"
        case .weakPassword: message = "パスワードが脆弱すぎます"
        // これは一例です。必要に応じて増減させてください
        default: break
        }
        return message
    }
    
    @IBAction func modoru(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textfield:UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
