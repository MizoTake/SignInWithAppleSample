using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.Events;

public class AuthenticationServices : MonoBehaviour
{

    [System.Serializable]
    class AuthResult : UnityEngine.Events.UnityEvent<string> { }

    [SerializeField]
    private AuthResult completeCall = new AuthResult();

    [SerializeField]
    private AuthResult errorCall = new AuthResult();

#if UNITY_IOS
    [DllImport("__Internal")]
    private static extern void signin();

    [DllImport("__Internal")]
    private static extern void signout();

    [DllImport("__Internal")]
    private static extern void refresh();

    public void SigninRequest() {
        signin();
    }

    public void SignoutRequest() {
        signout();
    }

#endif

    void Start() {
        gameObject.name = "AuthenticationServices";
#if UNITY_IOS
        refresh();
#endif
    }
    public void DidCompleteWithAuthorization(string appleIDCredential) {
        completeCall.Invoke(appleIDCredential);
    }

    public void DidCompleteWithError(string error) {
        errorCall.Invoke(error);
    }
}
