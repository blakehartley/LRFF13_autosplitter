# LRFF13 Autosplitter(日本語版README)

[**Read in English/英語のREADMEはこちら**](README.md)

**LIGHTNING RETURNS: FINAL FANTASY XIII**(Steam版)用のLiveSplitオートスプリッター(ASL)です。

Roostaさん([@blakehartley](https://github.com/blakehartley))が作成し、[@a-ki-yoshi](https://github.com/a-ki-yoshi)が引き継ぎました。

## 機能

- **タイマースタート**: タイミングはSpeedrun.comのルールに準じる
- **タイマーストップ**: タイミングはSpeedrun.comのルールに準じる
- **区間スプリット**: 区間の設定方法は、下記「使い方」を参照
- **LRT計測**: ローディング時間を除いた時間を計測し、Game Timeとして表示
- **Text表示**: 直前の戦闘時間・メニュー操作時間・エンカウント数をTextコンポーネントに表示

## 使い方

1. LiveSplitで**Edit Splits**を開き、ゲーム名を`Lightning Returns: Final Fantasy XIII`にして**Activate**を押す
2. **Settings**で、スプリットタイミングのチェックボックスのON/OFFを切り替える
3. ONにした数だけ区間を作り、並べる

[RTAGamers](https://rtagamers.com/rta-tools/autotimer/#toc7)さんが画像付きで解説してくれています。

Any%用のサンプルとして、そのまま使えるlssファイルも置いています。読み込んだら、**Settings**で対応するスプリットをONにしてください。

- [lrff13_any_sample.lss](lrff13_any_sample.lss)(英語)
- [lrff13_any_sample_ja.lss](lrff13_any_sample_ja.lss)(日本語)
- [lrff13_any_sample_enja.lss](lrff13_any_sample_enja.lss)(英語・日本語の併記)

スプリットが数フレーム遅れて見えるときは、LiveSplit本体のリフレッシュレート(右クリック → Settings → Refresh Rate)を60以上に上げてみてください。

ただし、タイミングの誤差はどうしても1フレーム以上になってしまうことがあります。修正しきれない仕様なので、ご了承ください。

### 戦闘時間などを表示する方法

1. LiveSplitで**Edit Layout**を開き、「+」→ Information → **Text**を、表示したい種類の数だけ追加する
2. **Edit Splits**の**Settings**で、「Textに戦闘時間を表示」「Textにメニュー操作時間を表示」「Textにエンカウント数を表示」のうち、使うものをONにする
3. ゲームを起動する(起動中なら、ゲームかLiveSplitを再起動する)
