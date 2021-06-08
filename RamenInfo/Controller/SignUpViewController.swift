//
//  SignUpViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/05/24.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var PassMess: UILabel!
    
    var provider:OAuthProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PassMess.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let name = self.nameText.text
        let mail = self.mailText.text
        let password = self.passwordText.text
        Auth.auth().createUser(withEmail: mail ?? "", password: password ?? "") { authResult, error in
            if let user = authResult?.user {
                let req = user.createProfileChangeRequest()
                req.displayName = name
                req.commitChanges() {[weak self] error in
                    guard let self = self else {return}
                    if error == nil {
                        print("OK")
                        self.performSegue(withIdentifier: "toPop", sender: nil)
                    }
                }
            }
            if error != nil {
                print("error")
                return
            }else {
                print(authResult)
            }
        }
        if passwordText.text!.count >= 6 {
            PassMess.isHidden = true
        }else {
            PassMess.isHidden = false
        }
    }
    

    @IBAction func twitterLogin(_ sender: Any) {
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["force_login":"true"]
        provider?.getCredentialWith(nil, completion: {(credential,error) in
            //            ログインの処理
            //credentialのエラー処理を実装する
            if credential != nil {
                Auth.auth().signIn(with: credential!) { (result, error) in
                    if error != nil {
                        print("エラー")
                        return
                    }
                    
                    if result != nil {
                        print("失敗")
                    }
                    //                //画面遷移
                    //                let viewVC = self.storyboard?.instantiateViewController(identifier: "viewVC") as! MypageViewController
                    //                viewVC.userName = (result?.displayName)!
                    //                self.navigationController?.pushViewController(viewVC, animated: true)
                    self.performSegue(withIdentifier: "toPop", sender: nil)
                }
            } else {
                print("nilになる")
            }
        })
    }
}
