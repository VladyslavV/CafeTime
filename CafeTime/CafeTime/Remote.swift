//
//  Remote.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/7/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class Remote {
    
    // MARK: Public
    private static let shared = Remote()
    
    var customer = RemoteCustomer()
    var cafe = RemoteCafe()
    var auth = RemoteAuth()
    
    class func serverAccess() -> Remote? {
        if Remote.shared.isFirebaseConnectionActive {
            return Remote.shared
        }
        return nil
    }
    
    class func anyAccess() -> Remote {
        return Remote.shared
    }
    
    // MARK: Private
//    private var dataBaseRef : FIRDatabaseReference {
//        return FIRDatabase.database().reference(fromURL: "https://cafetime-6651e.firebaseio.com/")
//    }
    
    private var stateListener: FIRAuthStateDidChangeListenerHandle?
    private var connectionStateListener: FIRDatabaseHandle?
    private var connectedRef: FIRDatabaseReference?
    private var isUserConnected = false
    private var isFirebaseConnectionActive = false
    
    private init() {
        self.setUpStateListener()
    }
    
    private func setUpStateListener() {
        
        connectedRef = FIRDatabase.database().reference(withPath: Constants.Remote.References.Connected)
        connectionStateListener = connectedRef?.observe(.value, with: { [weak self] snapshot in
            guard let weakSelf = self else { return }
            if let connected = snapshot.value as? Bool, connected {
                weakSelf.isFirebaseConnectionActive = true
                print("Connected to server")
            } else {
                weakSelf.isFirebaseConnectionActive = false
                print("Not connected to server")
            }
        })
        
        
        //        stateListener = FIRAuth.auth()?.addStateDidChangeListener({ [weak self] (auth, firUser) in
        //            guard let weakSelf = self else { return }
        //            if let user = firUser {
        //                print("connected")
        //                weakSelf.isUserConnected = true
        //            }
        //            else {
        //                print("no connection")
        //                weakSelf.isUserConnected = false
        //            }
        //        })
    }
    
    
    // MARK: Remove observers on deinit
    deinit {
        
        if let ref = connectedRef, let listener = connectionStateListener {
            ref.removeObserver(withHandle: listener)
        }
        
        if let listener = stateListener {
            FIRAuth.auth()?.removeStateDidChangeListener(listener)
        }
    }
}
