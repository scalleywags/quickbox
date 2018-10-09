//
//  QBCore.swift
//  sample-conference-videochat-swift
//
//  Created by Vladimir Nybozhinsky on 04.10.2018.
//  Copyright © 2018 QuickBlox. All rights reserved.
//

import UIKit
import Quickblox
import QuickbloxWebRTC
import SVProgressHUD
import SystemConfiguration

enum QBNetworkStatus: UInt {
    case QBNetworkStatusNotReachable = 0
    case QBNetworkStatusReachableViaWiFi = 1
    case QBNetworkStatusReachableViaWWAN = 2
}

enum ErrorDomain: UInt {
    case ErrorDomainSignUp = 0
    case ErrorDomainLogIn = 1
    case ErrorDomainLogOut = 2
    case ErrorDomainChat = 3
}

struct QBCoreConstants {
    static let kQBDefaultPassword = "x6Bt0VDy5"
}

typealias QBNetworkStatusBlock = ((_ status: QBNetworkStatus) -> Void)?

protocol QBCoreDelegate: class {
    /**
     *  Notifying about successful login.
     *
     *  @param core QBCore instance
     */
    func coreDidLogin(_ core: QBCore)
    
    /**
     *  Notifying about successful logout.
     *
     *  @param core QBCore instance
     */
    func coreDidLogout(_ core: QBCore)
    
    func core(_ core: QBCore, _ loginStatus: String)
    
    func core(_ core: QBCore, _ error: Error, _ domain: ErrorDomain)
}

class QBCore {
    
    // MARK: shared Instance
    static let instance = QBCore()
    
    // MARK: Variables
    var currentUser: QBUUser?
    var networkStatusBlock: QBNetworkStatusBlock?
    var multicastDelegate: QBMulticastDelegate?
    private var currentReachabilityFlags: SCNetworkReachabilityFlags?
//    private let reachability = SCNetworkReachabilityCreateWithName(nil, "com.quickblox.samplecore.reachability")
    private let reachabilitySerialQueue = DispatchQueue.main
    
//    let profile: QBProfile
    
    var reachabilityRef: SCNetworkReachability? {
        didSet {
            debugPrint("reachabilityRef didSet \(String(describing: reachabilityRef))")
        }
    }
    
    var isAutorized: Bool? {
        didSet {
            debugPrint("isAutorized didSet \(String(describing: isAutorized))")
        }
    }
    
    // MARK: Init Metods
//    init(currentUser: QBUUser, networkStatusBlock: QBNetworkStatusBlock, isAutorized: Bool = false) {
//        self.currentUser = currentUser
//        self.networkStatusBlock = networkStatusBlock
//        self.isAutorized = isAutorized
//
//    }
    
    // MARK: Multicast Delegate
    func addDelegate(_ delegate: QBCoreDelegate) {
        
    }
    
    // MARK: - SignUp / Login / Logout
    
    /**
     *  Signup and login
     *
     *  @param fullName User name
     *  @param roomName room name (tag)
     */
    public func signUpWith(_ fullName: String, _ roomName: String) {
        
    }
    
    /**
     *  login
     */
    public func loginWithCurrentUser() {
        
    }
    
    /**
     *  Clear current profile (Keychain)
     */
    public func clearProfile() {
        
    }
    
    /**
     *  Logout and remove current user from server
     */
    public func logout() {
        
    }
    
    // MARK: - Push Notifications
    /**
     *  Create subscription.
     *
     *  @param deviceToken Identifies client device
     */
    public func registerForRemoteNotificationsWithDeviceToken(_ deviceToken: Data) {
        
    }
    
    // MARK: - Common Init
    private func commonInit() {
        
        //    self.multicastDelegate = QBCoreDelegate()
        //    _profile = [QBProfile currentProfile];
        
        //    [QBSettings setAutoReconnectEnabled:YES];
        //    [[QBChat instance] addDelegate:self];
        
        self.startReachabliyty()
    }
    
    // MARK: - Reachability
    /**
     *  Cheker for internet connection
     */
    public func networkStatus() -> QBNetworkStatus {
        if let reachabilityRef = self.reachabilityRef {
            var flags: SCNetworkReachabilityFlags = []
            if SCNetworkReachabilityGetFlags(reachabilityRef, &flags) {
                return self.networkStatusForFlags(flags)
            }
        }
        return .QBNetworkStatusNotReachable;
    }
    
    private func networkStatusForFlags(_ flags: SCNetworkReachabilityFlags) -> QBNetworkStatus{
        
        if flags.contains(.reachable) == false {
            return .QBNetworkStatusNotReachable
        }
        else if flags.contains(.isWWAN) == true {
            return .QBNetworkStatusReachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            return .QBNetworkStatusReachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true
             || flags.contains(.connectionOnTraffic) == true)
            && flags.contains(.interventionRequired) == false {
            return .QBNetworkStatusReachableViaWiFi
        }
        else {
            return .QBNetworkStatusNotReachable
        }
    }
    
    private func checkReachability(flags: SCNetworkReachabilityFlags) {
        
        if currentReachabilityFlags != flags {
            currentReachabilityFlags = flags
        }
    }
    
    private func startReachabliyty() {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
    
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return
        }
        self.reachabilityRef = defaultRouteReachability
        
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = UnsafeMutableRawPointer(Unmanaged<QBCore>.passUnretained(self).toOpaque())
        
        let callbackClosure: SCNetworkReachabilityCallBack? = {
            (reachability:SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) in
            guard let info = info else { return }
            let handler = Unmanaged<QBCore>.fromOpaque(info).takeUnretainedValue()
            
            DispatchQueue.main.async {
                handler.checkReachability(flags: flags)
            }
        }
        
        if SCNetworkReachabilitySetCallback(reachabilityRef!, callbackClosure, &context) {
            if (SCNetworkReachabilitySetDispatchQueue(self.reachabilityRef!, self.reachabilitySerialQueue)) {
                
            }
            else {
                debugPrint("SCNetworkReachabilitySetDispatchQueue() failed: \(SCErrorString(SCError()))")
                SCNetworkReachabilitySetCallback(self.reachabilityRef!, nil, nil);
            }
        }
    }
}

