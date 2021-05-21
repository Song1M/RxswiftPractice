//
//  Constant.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/13.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import UIKit
//import Firebase
//import FirebaseMessaging


struct Constant {
    
    enum BuildType {
        case release
        case debug
    }
    
    static let `default` = Constant(type: .release)
    
    let domain: Domain
    
    let webRTC: WebRTC
    
    
    init(type: BuildType = .release) {
        domain = Domain.init(type: type)
        webRTC = WebRTC.init(type: type)
    }
    
    
    struct Domain {
        
        let appleLookup: String             // apple lookup api url
        
        let url: String                     // server url
        
        let storeIdentifier: String         // Iamport 가맹적 식별 코드
        
        
        init(type: BuildType = .release) {
            appleLookup = "http://itunes.apple.com/lookup"
            
            switch type {
            case .release:
//                url = "http://ec2-3-36-42-169.ap-northeast-2.compute.amazonaws.com"
                url = "http://api.5678.studio"
                storeIdentifier = "imp67313224"
                
            case .debug:
                url = "http://test-erp.1milliondance.com"
                storeIdentifier = "imp37858072"
            }
        }
    }
    
    
    struct WebRTC {

        let socketUrl = URL(string: "wss://api.5678.studio/ws/websocket")
        
        let webRTCIceServers: [String] = [
            "stun:stun.services.mozilla.com",
            "stun:stun.l.google.com:19302",
            "turn:3.35.235.123:3478?transport=tcp"
        ]
        
        let connectionHeaders: [String:String]      // webRTC 연결시 header 정보
        
        
        init(type: BuildType = .release) {
            switch type {
            case .release:
                connectionHeaders = [
                    "heart-beat": "10000,20000"
                ]
                
            case .debug:
                connectionHeaders = [
                    "heart-beat": "10000,20000",
                    "Env": "test"                   // Test DB 바라보기 위한 설정값
                ]
                
            }
            
        }
    }
    
    enum AppScheme: String {
        case IAMPort = "FiveSix78"
    }
    
}

