# [WIP] SignInWithAppleSample

## Environment
- 2018.4.0f1
- Xcode 11.0 beta (11M336w)

## 参考
- [Adding the Sign In with Apple Flow to Your App
](https://developer.apple.com/documentation/authenticationservices/adding_the_sign_in_with_apple_flow_to_your_app)
- [Human Interface Guidelines SignInWithApple](https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple/overview/)

## 現状
Xcodeでシミュレータビルドする際にMetal周りでエラーが出る


該当する箇所を消せばビルドは可能

パスワードを入力するのだが処理が完了せずコールバックも走らない

またボタンは公式で用意されているものに準拠しないといけないためUnityだと扱い辛いそう(今回は処理のSampleのみの予定)

[ASAuthorizationAppleIDButton](https://developer.apple.com/documentation/authenticationservices/asauthorizationappleidbutton)

KeychainItem.swiftはそのまま持ってきている(直接扱おうとすると手間な部分があるため)

## Copyright
Copyright © 2019 Apple Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

