using UnityEngine;
using System.Collections;

public class AMoAdUnityPluginInterstitialSample : MonoBehaviour {

	private static string SID = "管理画面から発行されるsidを設定してください";
	private static string PANEL_IMAGE_NAME = "パネルに使用する画像ファイル名";

	void Awake () {
		//広告準備
		AMoAdUnityPlugin.RegisterInterstitialAd (sid:SID);
		AMoAdUnityPlugin.SetInterstitialPanel (sid:SID, imageName:PANEL_IMAGE_NAME);
		
		//広告表示
		AMoAdUnityPlugin.ShowInterstitialAd (SID);
	}
}
