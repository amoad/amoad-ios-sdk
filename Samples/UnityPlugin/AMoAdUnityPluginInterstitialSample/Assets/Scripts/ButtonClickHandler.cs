using UnityEngine;
using System.Collections;

public class ButtonClickHandler : MonoBehaviour {
    private static string SID = "管理画面から発行されるsidを設定してください";
    private static string PANEL_IMAGE_NAME = "パネルに使用する画像ファイル名";

    public void Register() {
        Debug.Log("Register()");
        AMoAdUnityPlugin.RegisterInterstitialAd(SID);
        //縦画面の広告の背景画像を設定する
        //AMoAdUnityPlugin.SetInterstitialPortraitPanel (sid:SID, imageName:PANEL_IMAGE_NAME);
        //横画面の広告の背景画像を設定する
        //AMoAdUnityPlugin.SetInterstitialLandscapePanel (sid:SID, imageName:PANEL_IMAGE_NAME);
    }

    public void Load(){
        Debug.Log("Load()");
        //広告をロードする
        AMoAdUnityPlugin.LoadInterstitialAd (SID);
    }

    public void Show() {
        Debug.Log("Show()");
        //広告がロードされているかを確認する
        if(AMoAdUnityPlugin.IsLoadedInterstitialAd (SID)){
            //広告を表示する
            AMoAdUnityPlugin.ShowInterstitialAd (SID);
        }
    }

    public void AutoReloadDisable(){
        Debug.Log("AutoReloadDisable()");
        //広告の自動リロードフラグをfalseに設定する
        AMoAdUnityPlugin.SetInterstitialAutoReload(SID, false);
    }

    public void AutoReload(){
        Debug.Log("AutoReload()");
        //広告の自動リロードフラグをtrueに設定する
        AMoAdUnityPlugin.SetInterstitialAutoReload(SID, true);
    }
}
