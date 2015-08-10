using UnityEngine;
using System.Collections;

public class AMoAdUnityPluginInterstitialSample : MonoBehaviour {

	private static string SID = "管理画面から発行されるsidを設定してください";
	private static string PANEL_IMAGE_NAME = "パネルに使用する画像ファイル名";

	static AMoAdUnityPluginInterstitialSample () {
		AMoAdUnityPlugin.RegisterInterstitialAd (sid:SID);
		AMoAdUnityPlugin.SetInterstitialPanel (sid:SID, imageName:PANEL_IMAGE_NAME);
	}

	void Awake () {
		AMoAdUnityPlugin.ShowInterstitialAd (SID);
	}
}
