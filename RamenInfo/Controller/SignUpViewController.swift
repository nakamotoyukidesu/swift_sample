//
//  SignUpViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/05/24.
//

import UIKit
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import Firebase
import PKHUD  // 必要に応じて

class SignUpViewController: UIViewController, UITextFieldDelegate{
    
    
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var PassMess: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var twiiterButton: UIButton!
    
    
    var provider:OAuthProvider?
    
    fileprivate var currentNonce:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PassMess.isHidden = true
        nameText.delegate = self
        mailText.delegate = self
        passwordText.delegate = self
        
        signUpButton.layer.cornerRadius = 5.0
        twiiterButton.layer.cornerRadius = 5.0
    
        // ②レイアウトを作成する
//         IOS13以降のみ使えるので、そのように制限
        if #available(iOS 13.0, *) {
          // ここでインスタンス(ボタン)を生成
          let appleLoginButton = ASAuthorizationAppleIDButton(
              authorizationButtonType: .default,
              authorizationButtonStyle: .black
          )
          // ボタン押した時にhandleTappedAppleLoginButtonの関数を呼ぶようにセット
          appleLoginButton.addTarget(
              self,
              action: #selector(handleTappedAppleLoginButton(_:)),
              for: .touchUpInside
          )
          // ↓はレイアウトの設定
          // これを入れないと下の方で設定したAutoLayoutが崩れる
          appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
          // Viewに追加
            view.addSubview(appleLoginButton)
          // ↓はAutoLayoutの設定
          // appleLoginButtonの中心を画面の中心にセットする
          appleLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
          appleLoginButton.topAnchor.constraint(equalTo: self.signUpButton.bottomAnchor, constant: 20).isActive = true
          appleLoginButton.bottomAnchor.constraint(equalTo: self.twiiterButton.topAnchor, constant: -20).isActive = true

        
//          appleLoginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
          // appleLoginButtonの幅は、親ビューの幅の0.7倍
          appleLoginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
          // appleLoginButtonの高さは40
            appleLoginButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        }
    }
    
    // ③appleLoginButtonを押した時の挙動を設定
      @available(iOS 13.0, *)
      @objc func handleTappedAppleLoginButton(_ sender: ASAuthorizationAppleIDButton) {
          // ランダムの文字列を生成
          let nonce = randomNonceString()
          // delegateで使用するため代入
          currentNonce = nonce
          // requestを作成
          let request = ASAuthorizationAppleIDProvider().createRequest()
          // sha256で変換したnonceをrequestのnonceにセット
          request.nonce = sha256(nonce)
          // controllerをインスタンス化する(delegateで使用するcontroller)
          let controller = ASAuthorizationController(authorizationRequests: [request])
          controller.delegate = self
          controller.presentationContextProvider = self
          controller.performRequests()
      }
      
    // ④randomで文字列を生成する関数を作成
     func randomNonceString(length: Int = 32) -> String {
         precondition(length > 0)
         let charset: Array<Character> =
             Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
         var result = ""
         var remainingLength = length
         
         while remainingLength > 0 {
             let randoms: [UInt8] = (0 ..< 16).map { _ in
                 var random: UInt8 = 0
                 let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                 if errorCode != errSecSuccess {
                     fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                 }
                 return random
             }
             
             randoms.forEach { random in
                 if length == 0 {
                     return
                 }
                 
                 if random < charset.count {
                     result.append(charset[Int(random)])
                     remainingLength -= 1
                 }
             }
         }
         return result
     }
    
    // ⑤SHA256を使用してハッシュ変換する関数を用意
      @available(iOS 13, *)
      private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
          return String(format: "%02x", $0)
        }.joined()

        return hashString
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
        
        if passwordText.text!.count >= 6 {
            PassMess.isHidden = true
        }else {
            PassMess.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         // キーボードを閉じる
         textField.resignFirstResponder()
         return true
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
                    self.performSegue(withIdentifier: "toMain", sender: nil)
                }
            } else {
                print("nilになる")
            }
        })
    }
}

// ⑥extensionでdelegate関数に追記していく
extension SignUpViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
   // 認証が成功した時に呼ばれる関数
    @available(iOS 13.0, *)
    func authorizationController(controller _: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // ASAuthorizationAppleIDCredentialの場合
               if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

                   //　取得できた情報
                   let userIdentifier = appleIDCredential.user
                   let fullName = appleIDCredential.fullName
                   let email = appleIDCredential.email
                print("appleID情報\(userIdentifier),\(fullName),\(email)")
                   // 取得した情報を元にアカウントの作成などを行う

               // ASPasswordCredentialの場合（※あとで紹介します※）
               } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
                   // 既存のiCloud Keychainクレデンシャル情報
                   let username = passwordCredential.user
                   let password = passwordCredential.password
                print("appleID情報\(username),\(password)")

                   // 取得した情報を元にアカウントの作成などを行う

               }
        
       // credentialが存在するかチェック
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
    
       // nonceがセットされているかチェック
       guard let nonce = currentNonce else {
         fatalError("Invalid state: A login callback was received, but no login request was sent.")
       }
       // credentialからtokenが取得できるかチェック
       guard let appleIDToken = appleIDCredential.identityToken else {
           print("Unable to fetch identity token")
           return
       }
       // tokenのエンコードを失敗
       guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
           return
       }
       // 認証に必要なcredentialをセット
       let credential = OAuthProvider.credential(
           withProviderID: "apple.com",
           idToken: idTokenString,
           rawNonce: nonce
       )
       // Firebaseへのログインを実行
       Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
              print(error)
              // 必要に応じて
              HUD.flash(.labeledError(title: "予期せぬエラー", subtitle: "再度お試しください。"), delay: 1)
              return
          }
          if let authResult = authResult {
              print(authResult)
            //ここにログインの処理

              // 必要に応じて
              HUD.flash(.labeledSuccess(title: "ログイン完了", subtitle: nil), onView: self.view, delay: 1) { _ in
                // 画面遷移など行う
                self.performSegue(withIdentifier: "toMain", sender: nil)

              }
          }
       }
   }
    // delegateのプロトコルに設定されているため、書いておく
    @available(iOS 13.0, *)
    func presentationAnchor(for _: ASAuthorizationController) -> ASPresentationAnchor {
           return view.window!
       }
       
       // Appleのログイン側でエラーがあった時に呼ばれる
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
         // Handle error.
         print("Sign in with Apple errored: \(error)")
       }
}
