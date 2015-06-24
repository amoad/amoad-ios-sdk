using UnityEngine;
using System.Collections;

public class AMoAdUnityPluginSample : MonoBehaviour {

	private static string SID = "管理画面から発行されるsidを設定してください";

	static AMoAdUnityPluginSample () {
		AMoAdUnityPlugin.Register (
			sid:SID,
			bannerSize:AMoAdUnityPlugin.BannerSize.B320x50,
			hAlign:AMoAdUnityPlugin.HorizontalAlign.Center,
			vAlign:AMoAdUnityPlugin.VerticalAlign.Bottom,
			adjustMode:AMoAdUnityPlugin.AdjustMode.Responsive,
			rotateTrans:AMoAdUnityPlugin.RotateTransition.FlipFromLeft,
			clickTrans:AMoAdUnityPlugin.ClickTransition.Jump,
			imageName:"b640_100.gif"
			);
	}

	void Awake () {
		AMoAdUnityPlugin.Show (SID);
	}

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
