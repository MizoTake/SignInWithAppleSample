#import <AuthenticationServices/AuthenticationServices.h>
#import <SignInWithAppleSample-Swift.h>

extern "C" {
    void signin()
    {
        if (@available(iOS 13.0, *)) {
            UIViewController *current = UnityGetGLViewController();
            [current signin];
        }
    }

    void signout()
    {
        if (@available(iOS 13.0, *)) {
            UIViewController *current = UnityGetGLViewController();
            [current signout];
        }
    }

    void refresh()
    {
        if (@available(iOS 13.0, *)) {
            UIViewController *current = UnityGetGLViewController() ;
            [current refresh];
        }
    }
}
