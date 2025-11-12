//
//  UserManager.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation

class UserManager {

//    typealias OTPResponse = OTPNetworkController.OTPResponse
//    typealias Session = OTPNetworkController.Session
//    typealias User = OTPNetworkController.User


    static let shared = UserManager()

//    private var _currentSession: Session? {
//        didSet { if _currentSession != nil { saveCurrentSession() } }
//    }

//    private var _currentUser: User? {
//        didSet { if _currentUser != nil { saveCurrentUser() } }
//    }
    

    // MARK: - Public Properties

//    var currentSession: Session? {
//        if _currentSession != nil { return _currentSession }
//
//        guard let data = try? Data(contentsOf: UserManager.sessionFilePath) else { return nil }
//        let decoder = JSONDecoder()
//        _currentSession = try? decoder.decode(Session.self, from: data)
//        return _currentSession
//    }
//
//    var currentUser: User? {
//        if _currentUser != nil { return _currentUser }
//
//        guard let data = try? Data(contentsOf: UserManager.userFilePath) else { return nil }
//        let decoder = JSONDecoder()
//        _currentUser = try? decoder.decode(User.self, from: data)
//        return _currentUser
//    }


    private init() { }

//    func handleOTPResponse(_ response: OTPResponse) {
//        self._currentUser = response.data?.user
//    }


    // MARK: - Session Handling

    private func saveCurrentSession() {
//        guard let session = _currentSession else {
//            print("Error: Cannot save session, currentSession is nil!")
//            return
//        }

        let filemgr = FileManager.default
        let encoder = JSONEncoder()
        do {
            if filemgr.fileExists(atPath: UserManager.sessionFilePath.path) {
                try filemgr.removeItem(atPath: UserManager.sessionFilePath.path)
                print("Deleting previous session.")
            }
//            let data = try encoder.encode(session)
//            try data.write(to: UserManager.sessionFilePath, options: [.atomic, .completeFileProtection])
            print("Session saved successfully.")
        } catch {
            print("Failed to save session: \(error.localizedDescription)")
        }
    }


    // MARK: - User Handling

    private func saveCurrentUser() {
//        guard let user = _currentUser else {
//            print("Error: Cannot save user, currentUser is nil!")
//            return
//        }

        let filemgr = FileManager.default
        let encoder = JSONEncoder()
        do {
            if filemgr.fileExists(atPath: UserManager.userFilePath.path) {
                try filemgr.removeItem(atPath: UserManager.userFilePath.path)
                print("Deleting previous user.")
            }
//            let data = try encoder.encode(user)
//            try data.write(to: UserManager.userFilePath, options: [.atomic, .completeFileProtection])
            print("User saved successfully.")
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    private func deleteSavedSession() {
        let filemgr = FileManager.default
        do {
            if filemgr.fileExists(atPath: UserManager.sessionFilePath.path) {
                try filemgr.removeItem(atPath: UserManager.sessionFilePath.path)
                print("Deleted saved session.")
            }
        } catch {
            print("Failed to delete session: \(error.localizedDescription)")
        }
    }
    
    private func deleteSavedUser() {
        let filemgr = FileManager.default
        do {
            if filemgr.fileExists(atPath: UserManager.userFilePath.path) {
                try filemgr.removeItem(atPath: UserManager.userFilePath.path)
                print("Deleted saved user.")
            }
        } catch {
            print("Failed to delete user: \(error.localizedDescription)")
        }
    }
    

    // MARK: - Logout and Clear Session

    func logOutUser() {
        deleteSavedSession()
        deleteSavedUser()
//        _currentSession = nil
//        _currentUser = nil
    }


    // MARK: - Utility

    private static var sessionFilePath: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("session.json")
    }

    private static var userFilePath: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("user.json")
    }
}
