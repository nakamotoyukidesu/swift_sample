//
//  LoginViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/12.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var provider:OAuthProvider?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["lang":"ja"]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
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
                        self.performSegue(withIdentifier: "toMain", sender: nil)
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
    }
    
    
    @IBAction func twiiterLogin(_ sender: Any) {
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["force_login":"true"]
        provider?.getCredentialWith(nil, completion: {(credential, error) in
            //            ログインの処理
            //credentialのエラー処理を実装する
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
                self.performSegue(withIdentifier: "toMain", sender: nil)
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
