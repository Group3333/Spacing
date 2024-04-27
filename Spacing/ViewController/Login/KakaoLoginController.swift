//
//  KakaoLoginController.swift
//  Spacing
//
//  Created by TaeOuk Hwang on 4/27/24.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class KakaoLoginController: UIViewController {
    @IBOutlet weak var NickNameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    
    @IBOutlet weak var KakaoLogin: UIButton!
    @IBOutlet weak var LogoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUserInfo() {
        UserApi.shared.me {(user, error) in
            if let error = error {
                print(error)
            } else {
                print("nickname: \(user?.kakaoAccount?.profile?.nickname ?? "no nickname")")
                print("email: \(user?.kakaoAccount?.email ?? "no email")")
                
                guard let userId = user?.id else {return}
                
                print("닉네임 : \(user?.kakaoAccount?.profile?.nickname ?? "no nickname").....이메일 : \(user?.kakaoAccount?.email ?? "no nickname"). . . . .유저 ID : \(userId)")
                self.NickNameLabel.text = "Nickname : \(user?.kakaoAccount?.profile?.nickname ?? "no nickname")"
                self.EmailLabel.text = "Email : \(user?.kakaoAccount?.email ?? "no nickname")"
            }
        }
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    _ = oauthToken
                    self.setUserInfo()
                }
            }
        }
    }
    
    @IBAction func LogoutAction(_ sender: Any) {
        UserApi.shared.logout{(error) in
            if let error = error {
                print(error)
            } else {
                print("kakao logout success")
            }
        }
    }
}
