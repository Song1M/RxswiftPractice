//
//  CookieManager.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/14.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

struct CookieManager {
    static var shared = CookieManager()
    
    private let cookieKey: String = "userCookie"
    
    private init() {}
    
    func setCookie() {
        // 유저 쿠키정보 초기화
        UserDefaults.standard.set(nil, forKey: cookieKey)

        // set cookies
        var cookies = [Any]()
        if let newCookies = HTTPCookieStorage.shared.cookies {
            for newCookie in newCookies {
                var cookie = [HTTPCookiePropertyKey: Any]()
                cookie[.name] = newCookie.name
                cookie[.value] = newCookie.value
                cookie[.domain] = newCookie.domain
                cookie[.path] = newCookie.path
                cookie[.version] = newCookie.version
                cookie[.httpOnly] = newCookie.isHTTPOnly
                if let date = newCookie.expiresDate {
                    cookie[.expires] = date
                }
                cookies.append(cookie)
            }
        }
        
        UserDefaults.standard.set(cookies, forKey: cookieKey)
        UserDefaults.standard.synchronize()
    }
    
    func restoreCookie() {
        if let cookies = UserDefaults.standard.value(forKey: cookieKey) as? [[HTTPCookiePropertyKey: Any]] {
            for cookie in cookies {
                if let httpCookie = HTTPCookie(properties: cookie) {
                    HTTPCookieStorage.shared.setCookie(httpCookie)
                }
            }
        }
    }
}


extension HTTPCookiePropertyKey {
    static let httpOnly = HTTPCookiePropertyKey("HttpOnly")
}
