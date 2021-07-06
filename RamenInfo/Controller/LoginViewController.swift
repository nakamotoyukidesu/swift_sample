//
//  LoginViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/12.
//

import UIKit
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import PKHUD  // 必要に応じて

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var sampleButton: UIButton!
    @IBOutlet weak var backImage: UIImageView!
    
    var provider:OAuthProvider?
    
    let gradientLayer = CAGradientLayer()
    //グラデーションの開始色
    let topColor = UIColor(red:2.55, green:2.04, blue:0, alpha:1)
    //グラデーションの開始色
    let bottomColor = UIColor(red:2.55, green:2.15, blue:0, alpha:1)
    
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = 15
        LogInButton.layer.cornerRadius = 15
        sampleButton.layer.cornerRadius = 15
        
   
//        if  Auth.auth().currentUser != nil {
//            performSegue(withIdentifier: "toMain", sender: nil)
//          } else {
//
//          }

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //グラデーションの色を配列で管理
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        //グラデーションレイヤーを作成
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //グラデーションの色をレイヤーに割り当てる
        gradientLayer.colors = gradientColors
        //グラデーションレイヤーをスクリーンサイズにする
        gradientLayer.frame = self.backImage.bounds
        //グラデーションレイヤーをビューの一番下に配置
        self.backImage.layer.insertSublayer(gradientLayer, at: 0)
        //           //もしユーザー名が保存されてるなら
        //           if let username = UserDefaults.standard.object(forKey: "userName") {
        //               performSegue(withIdentifier: "toMain", sender: nil)
        //           }

        if self.checkUserVerify() {
            performSegue(withIdentifier: "toMain", sender: nil)
        }
//        else if  Auth.auth().currentUser != nil {
//            performSegue(withIdentifier: "toPop", sender: nil)
//          }

    }
    // ログイン済みかどうかと、メールのバリデーションが完了しているか確認
      func checkUserVerify()  -> Bool {
        guard let user = Auth.auth().currentUser else { return false }
        return user.isEmailVerified
      }
    
    @IBAction func trialButton(_ sender: Any) {
        Auth.auth().signInAnonymously { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                 print("匿名サインインに失敗しました:" ,error!.localizedDescription)
                 return
             }
             print("匿名サインインに成功しました", user.uid)
            self.performSegue(withIdentifier: "toPop", sender: nil)
          }
//        Auth.auth().signInAnonymously { (authResult, error) in
//            if error != nil {
//                print("Auth Error :\(error!.localizedDescription)")
//            }
//            //認証情報の取得
//            guard let user = authResult?.user else {return}
//            let isAnoymous = user.isAnonymous //true
//            let uid = user.uid
//            print(uid)
//        }
    }
    
    
    
    @IBAction func loginButton(_ sender: Any) {
//        let name = self.nameText.text
//        let mail = self.mailText.text
//        let password = self.passwordText.text
//        Auth.auth().createUser(withEmail: mail ?? "", password: password ?? "") { authResult, error in
//            if let user = authResult?.user {
//                let req = user.createProfileChangeRequest()
//                req.displayName = name
//                req.commitChanges() {[weak self] error in
//                    guard let self = self else {return}
//                    if error == nil {
//                        print("OK")
//                        self.performSegue(withIdentifier: "toMain", sender: nil)
//                    }
//                }
//            }
//            if error != nil {
//                print("error")
//                return
//            }else {
//                print(authResult)
//            }
//        }
//        if passwordText.text!.count >= 6 {
//            passMess.isHidden = true
//        }else {
//            passMess.isHidden = false
//        }
    }
    
    
    @IBAction func twiiterLogin(_ sender: Any) {
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
                self.performSegue(withIdentifier: "toMain", sender: nil)
            }
            } else {
                print("nilになる")
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

