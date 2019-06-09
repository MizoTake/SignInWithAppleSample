using System.IO;
using UnityEngine;
using UnityEditor;
using UnityEditor.iOS.Xcode;
using UnityEditor.Callbacks;
using System.Collections;

public class XcodeSettingsPostProcesser
{
    [PostProcessBuildAttribute (0)]
    public static void OnPostprocessBuild (BuildTarget buildTarget, string pathToBuiltProject)
    {
        if (buildTarget != BuildTarget.iOS) return; 

        var projectPath = pathToBuiltProject + "/Unity-iPhone.xcodeproj/project.pbxproj";
        var pbxProject = new PBXProject ();
        pbxProject.ReadFromFile (projectPath);
        string targetGuid = pbxProject.TargetGuidByName ("Unity-iPhone");

        var entitlementsPath = "/Plugin/iOS/SignInWithAppleSample.entitlements";

        FileUtil.CopyFileOrDirectory( Application.dataPath + entitlementsPath, pathToBuiltProject + "/" + Application.productName + ".entitlements");
        pbxProject.AddFile (pathToBuiltProject + "/" + Application.productName + ".entitlements", Application.productName + ".entitlements");
        pbxProject.AddBuildProperty(targetGuid, "CODE_SIGN_ENTITLEMENTS",  Application.productName + ".entitlements");

        pbxProject.AddBuildProperty(targetGuid, "SWIFT_VERSION", "4.2");
        pbxProject.AddBuildProperty(targetGuid, "SWIFT_OBJC_BRIDGING_HEADER", "Libraries/Plugin/iOS/UnitySwift-Bridging-Header.h");
        
        pbxProject.AddFrameworkToProject(targetGuid, "AuthenticationServices.framework", false);

        File.WriteAllText (projectPath, pbxProject.WriteToString ());
    }
}