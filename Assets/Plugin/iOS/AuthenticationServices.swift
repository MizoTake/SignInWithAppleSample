import UIKit
import Foundation
import AuthenticationServices

@objc extension UIViewController {
    
    @available(iOS 13.0, *)
    public func signin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        authriztionRequest(requests: [request])
    }
    
    @available(iOS 13.0, *)
    public func signout() {
        KeychainItem.deleteUserIdentifierFromKeychain()
    }

    @available(iOS 13.0, *)
    public func refresh() {
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        authriztionRequest(requests: requests)
    }
    
    @available(iOS 13.0, *)
    public func check() -> Int {
        var result: ASAuthorizationAppleIDProvider.CredentialState = .notFound
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
            result = credentialState
        }
        return result.rawValue
    }
    
    @available(iOS 13.0, *)
    func authriztionRequest(requests: [ASAuthorizationRequest]) {
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

@available(iOS 13.0, *)
extension UIViewController: ASAuthorizationControllerDelegate {
    
    @available(iOS 13.0, *)
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            do {
                try KeychainItem(service: Bundle.main.bundleIdentifier!, account: "userIdentifier").saveItem(userIdentifier)
            } catch {
                print("Unable to save userIdentifier to keychain.")
            }
            DispatchQueue.main.async {
                if let givenName = fullName?.givenName, let familyName = fullName?.familyName, let email = email {
                    UnitySendMessage("AuthenticationServices", "DidCompleteWithAuthorization", userIdentifier + "," + givenName + "," + familyName + "," + email)
                }
            }
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            DispatchQueue.main.async {
                UnitySendMessage("AuthenticationServices", "DidCompleteWithAuthorization", username + "," + password)
            }
        }
    }
    
    @available(iOS 13.0, *)
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        UnitySendMessage("AuthenticationServices", "DidCompleteWithError", error.localizedDescription)
    }
}

extension UIViewController: ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
