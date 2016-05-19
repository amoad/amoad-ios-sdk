package com.amoad.cocos2dx;

import android.app.Activity;
import android.content.Context;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.FrameLayout.LayoutParams;

import com.amoad.AMoAdView;
import com.amoad.AMoAdView.ClickTransition;
import com.amoad.AMoAdView.RotateTransition;
import com.amoad.InterstitialAd;

import org.cocos2dx.lib.Cocos2dxActivity;

public final class AMoAdCocos2dxModule {
    /**
     * 広告ビューを表示状態にする.
     * 
     * @param sid 管理画面から取得したID
     * @param bannerSize 広告サイズの定数
     * @param hAlign 幅位置の定数
     * @param vAlign 縦位置の定数
     * @param adjustMode 広告サイズ調整の定数
     * @param x 広告の表示するx座標
     * @param y 広告の表示するy座標
     */
    public static void registerInlineAd(final String sid,
            final int bannerSize,
            final int hAlign,
            final int vAlign,
            final int adjustMode,
            final int x,
            final int y) {

        registerInlineAd(sid, bannerSize, hAlign, vAlign, adjustMode, x, y, 30 * 1000);
    }

    /**
     * 広告ビューを表示状態にする.
     *
     * @param sid 管理画面から取得したID
     * @param bannerSize 広告サイズの定数
     * @param hAlign 幅位置の定数
     * @param vAlign 縦位置の定数
     * @param adjustMode 広告サイズ調整の定数
     * @param x 広告の表示するx座標
     * @param y 広告の表示するy座標
     * @param networkTimeoutMillis ネットワーク接続時間
     */
    public static void registerInlineAd(final String sid,
                                        final int bannerSize,
                                        final int hAlign,
                                        final int vAlign,
                                        final int adjustMode,
                                        final int x,
                                        final int y,
                                        final int networkTimeoutMillis) {

        if (TextUtils.isEmpty(sid)) {
            return;
        }

        getCurrentActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                AMoAdView adView = createAdView(sid, bannerSize, adjustMode, networkTimeoutMillis);
                adView.setVisibility(View.GONE);
                addView(adView, hAlign, vAlign, x, y);
            }
        });
    }

    /**
     * 広告が取れるまで表示する画像を設定する.
     * 
     * @param sid 管理画面から取得したID
     * @param imageName 広告が取れるまで表示する画像の拡張子除外のファイル名
     */
    public static void setDefaultImageName(String sid, String imageName) {
        AMoAdView adView = findViewBySid(sid);
        if (adView != null) {
            adView.setBackgroundResource(toResId(imageName));
        }
    }

    /**
     * 広告板の更新時のアニメーションを指定する.
     * 
     * @param sid 管理画面から取得したID
     * @param rotateTrans 広告板の更新時のアニメーションの定数
     */
    public static void setRotateTransition(String sid, int rotateTrans) {
        AMoAdView adView = findViewBySid(sid);
        if (adView != null) {
            adView.setRotateTransition(toRotateTransition(rotateTrans));
        }
    }

    /**
     * 広告板のクリック時のアニメーションを指定する.
     * 
     * @param sid 管理画面から取得したID
     * @param clickTrans 広告板のクリック時のアニメーションの定数
     */
    public static void setClickTransition(String sid, int clickTrans) {
        AMoAdView adView = findViewBySid(sid);
        if (adView != null) {
            adView.setClickTransition(toClickTransition(clickTrans));
        }
    }

    /**
     * 広告ビューを表示状態にする
     * 
     * @param sid 管理画面から取得したID
     */
    public static void show(final String sid) {
        if (TextUtils.isEmpty(sid)) {
            return;
        }

        getCurrentActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                AMoAdView view = findViewBySid(sid);
                if (view != null) {
                    view.setVisibility(View.VISIBLE);
                }
            }
        });

    }

    /**
     * 広告ビューを非表示状態にする
     * 
     * @param sid 管理画面から取得したID
     */
    public static void hide(final String sid) {
        if (TextUtils.isEmpty(sid)) {
            return;
        }

        getCurrentActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                AMoAdView view = findViewBySid(sid);
                if (view != null) {
                    view.setVisibility(View.GONE);
                }
            }
        });

    }

    /**
     * 広告ビューの資源を解放する
     * 
     * @param sid 管理画面から取得したID
     */
    public static void dispose(final String sid) {
        if (TextUtils.isEmpty(sid)) {
            return;
        }

        getCurrentActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                removeViewBySid(sid);
            }
        });
    }

    private static AMoAdView createAdView(final String sid, final int bannerSize, final int adjustMode, int networkTimeoutMillis) {
        AMoAdView adView = new AMoAdView(getCurrentActivity());
        adView.setNetworkTimeoutMillis(networkTimeoutMillis);
        adView.setSid(sid);
        adView.setResponsiveStyle(adjustMode == 1);

        int[] size = toViewSize(bannerSize);
        adView.setMinimumWidth(size[0]);
        adView.setMinimumHeight(size[1]);
        return adView;
    }

    private static AMoAdView findViewBySid(String sid) {
        FrameLayout parent = getContentView();
        if (parent != null) {
            int n = parent.getChildCount();
            for (int i = 0; i < n; i++) {
                View child = parent.getChildAt(i);
                if (child instanceof AMoAdView) {
                    AMoAdView adView = ((AMoAdView) child);
                    if (sid.equals(adView.getSid())) {
                        return adView;
                    }
                }
            }
        }
        return null;
    }

    private static void removeViewBySid(String sid) {
        FrameLayout parent = getContentView();
        View child = findViewBySid(sid);
        if (parent != null && child != null) {
            parent.removeView(child);
        }
    }

    private static void addView(AMoAdView adView, int hAlign, int vAlign, int x, int y) {
        FrameLayout content = getContentView();
        if (content == null) {
            return;
        }

        LayoutParams lp = new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
        int gravity = toGravity(hAlign, vAlign);
        if (gravity != Gravity.NO_GRAVITY) {
            lp.gravity = gravity;
        } else {
            lp.gravity = (Gravity.TOP | Gravity.LEFT);
            lp.topMargin = x;
            lp.leftMargin = y;
        }
        content.addView(adView, lp);
    }

    private static FrameLayout getContentView() {
        View view = getCurrentActivity().findViewById(android.R.id.content);
        if (view instanceof FrameLayout) {
            return (FrameLayout) view;
        }
        return null;
    }

    private static int[] toViewSize(int bannerSize) {
        switch (bannerSize) {
        case 4:
            return new int[] { 300, 100 };
        case 3:
            return new int[] { 728, 90 };
        case 2:
            return new int[] { 300, 250 };
        case 1:
            return new int[] { 320, 100 };
        }
        return new int[] { 320, 50 };
    }

    private static RotateTransition toRotateTransition(int rotateTrans) {
        switch (rotateTrans) {
        case 4:
            return RotateTransition.TRANSLATE;
        case 3:
            return RotateTransition.SCALE;
        case 2:
            return RotateTransition.ROTATE;
        case 1:
            return RotateTransition.ALPHA;
        }
        return RotateTransition.NONE;
    }

    private static ClickTransition toClickTransition(int clickTransition) {
        if (clickTransition == 1) {
            return ClickTransition.JUMP;
        }
        return ClickTransition.NONE;
    }

    private static int toResId(String name) {
        if (TextUtils.isEmpty(name)) {
            return 0;
        }

        int dot = name.indexOf(".");
        if (dot >= 0) {
            // xxx.gif --> xxx
            name = name.substring(0, dot);
        }

        Context context = getCurrentActivity();
        return context.getResources().getIdentifier(name, "drawable", context.getPackageName());
    }

    private static int toGravity(int horizontal, int vertical) {
        int gravity = Gravity.NO_GRAVITY;
        switch (horizontal) {
        case 3:
            gravity |= Gravity.RIGHT;
            break;
        case 2:
            gravity |= Gravity.CENTER_HORIZONTAL;
            break;
        case 1:
            gravity |= Gravity.LEFT;
        }

        switch (vertical) {
        case 3:
            gravity |= Gravity.BOTTOM;
            break;
        case 2:
            gravity |= Gravity.CENTER_VERTICAL;
            break;
        case 1:
            gravity |= Gravity.TOP;
        }
        return gravity;
    }

    /**
     * インタースティシャル広告を読み込みする
     * 
     * @param sid 管理画面から取得したID
     */
    public static void registerInterstitialAd(String sid) {
        registerInterstitialAd(sid, 30 * 1000);
    }

    /**
     * インタースティシャル広告を読み込みする
     *
     * @param sid 管理画面から取得したID
     * @param networkTimeoutMillis ネットワーク接続制限時間(ミリ秒)
     */
    public static void registerInterstitialAd(String sid, int networkTimeoutMillis) {
        InterstitialAd.register(sid);
        InterstitialAd.setNetworkTimeoutMillis(sid, networkTimeoutMillis / 2);
    }

    /**
     * 画像をクリック領域にするかどうかを設定する
     *
     * @param sid       管理画面より取得したID
     * @param clickable 画像をクリック領域にするかどうか、(defaultはtrue)
     */
    public static void setInterstitialDisplayClickable(String sid, boolean clickable) {
        InterstitialAd.setDisplayClickable(sid, clickable);
    }

    /**
     * 広告をクリックすると遷移確認のダイアログを表示するかどうかを設定する
     *
     * @param sid   管理画面より取得したID
     * @param shown ダイアログを表示するかどうか
     */
    public static void setInterstitialDialogShown(String sid, boolean shown) {
        InterstitialAd.setDialogShown(sid, shown);
    }

    /**
     * インタースティシャル広告の背景を設定する
     *
     * @param sid 管理画面から取得したID
     * @param imageName 画像ファイル名
     */
    @Deprecated
    public static void setInterstitialPanel(String sid, String imageName) {
        InterstitialAd.setPanel(sid, toResId(imageName));
    }

    /**
     * インタースティシャル広告の背景を設定する
     * 
     * @param sid 管理画面から取得したID
     * @param imageName 縦画面の画像ファイル名
     */
    public static void setInterstitialPortraitPanel(String sid, String imageName) {
        InterstitialAd.setPortraitPanel(sid, toResId(imageName));
    }

    /**
     * インタースティシャル広告の背景を設定する
     *
     * @param sid 管理画面から取得したID
     * @param imageName 横画面の画像ファイル名
     */
    public static void setInterstitialLandscapePanel(String sid, String imageName) {
        InterstitialAd.setLandscapePanel(sid, toResId(imageName));
    }

    /**
     * インタースティシャル広告のリンクボタンの背景を設定する
     * 
     * @param sid 管理画面から取得したID
     * @param imageName 画像ファイル名
     * @param imageName タッチされたときの画像ファイル名
     */
    public static void setInterstitialLinkButton(String sid, String imageName, String highlighted) {
        InterstitialAd.setLinkButton(sid, toResId(imageName), toResId(highlighted));
    }

    /**
     * インタースティシャル広告の閉じるボタンの背景を設定する
     * 
     * @param sid 管理画面から取得したID
     * @param imageName 画像ファイル名
     * @param imageName タッチされたときの画像ファイル名
     */
    public static void setInterstitialCloseButton(String sid, String imageName, String highlighted) {
        InterstitialAd.setCloseButton(sid, toResId(imageName), toResId(highlighted));
    }

    /**
     * 自動ロードのフラグを設定する
     *
     * @param sid 管理画面から取得したID
     * @param autoReload falseの場合は毎回load()を呼ぶ必要があります(default:true)
     */
    public static void setInterstitialAutoReload(String sid, boolean autoReload) {
        InterstitialAd.setAutoReload(sid, autoReload);
    }

    /**
     * インタースティシャル広告をロードする
     *
     * @param sid 管理画面から取得したID
     */
    public static void loadInterstitialAd(String sid) {
        InterstitialAd.load(getCurrentActivity(), sid, null);
    }

    /**
     * インタースティシャル広告がロードされているかどうかを判定する
     *
     * @param sid 管理画面から取得したID
     * @return インタースティシャル広告がロードされているかどうか
     */
    public static boolean isLoadedInterstitialAd(String sid) {
        return InterstitialAd.isLoaded(sid);
    }

    /**
     * インタースティシャル広告を表示する
     * 
     * @param sid 管理画面から取得したID
     */
    public static void showInterstitialAd(String sid) {
        InterstitialAd.show(sid, null);
    }

    /**
     * インタースティシャル広告を閉じる
     * 
     * @param sid 管理画面から取得したID
     */
    public static void closeInterstitialAd(String sid) {
        InterstitialAd.close(sid);
    }

    private static int toResId(Context context, String name) {
        if (TextUtils.isEmpty(name)) {
            return 0;
        }

        int dot = name.indexOf(".");
        if (dot >= 0) {
            // xxx.gif --> xxx
            name = name.substring(0, dot);
        }

        return context.getResources().getIdentifier(name, "drawable", context.getPackageName());
    }

    private static Activity getCurrentActivity() {
        return (Activity) Cocos2dxActivity.getContext();
    }
}
