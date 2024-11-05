# ポケモンアプリ

Flutterで開発したシンプルなポケモンアプリです。RiverpodとIsarを活用して、ポケモンAPIからデータを取得し、ポケモンの一覧表示、詳細確認、お気に入り登録、お気に入りリストの表示ができます。

## 機能

- ポケモンの一覧表示（ページネーション対応）
- ポケモンの詳細情報（名前、高さ、重さ、画像）を表示
- ポケモンをお気に入りに追加/解除
- お気に入りリストの表示
- ローカルデータベース（Isar）を使ったお気に入りリストの永続化
- ライトモードとダークモードの切り替え対応

## デモ



https://github.com/user-attachments/assets/2815c9a6-c411-4536-ba5d-f65257e69310



## 技術スタック

- **Flutter** - UIフレームワーク
- **Riverpod** - 状態管理
- **Isar** - ローカルデータベース
- **Dio** - ネットワークリクエスト
- **Retrofit** - APIクライアント
- **Freezed** - イミュータブルクラスとJSONシリアライズのコード生成
- **Flutter Hooks** - 関数型アプローチのためのフック

## プロジェクト構成

```plaintext
lib/
├── data/
│   ├── models/               # データモデル (例: Pokemon, PokemonDetail, FavoritePokemon)
│   ├── repositories/         # データアクセスロジック用のリポジトリ
│   └── services/             # RetrofitによるAPIサービス
│
├── controllers/              # 状態管理とコントローラー (例: FavoritePokemonController)
│
├── screens/                  # 各画面 (PokemonListScreen, PokemonDetailScreen, FavoriteListScreen)
│
└── widgets/                  # 再利用可能なUIコンポーネント (例: ローディングインジケーター、エラーハンドリングウィジェット)
```

## 動作環境

- Flutter 3.0 以上
- Dart 2.17 以上

## セットアップ

ローカル環境でプロジェクトをセットアップする手順です。

### 前提条件

1. **Flutterのインストール**：[Flutterの公式サイト](https://flutter.dev/docs/get-started/install)に従ってインストールしてください。
2. **リポジトリをクローン**：

    ```bash
    git clone https://github.com/your-username/flutter-pokemon-app.git
    cd flutter-pokemon-app
    ```

3. **依存パッケージのインストール**：

    ```bash
    flutter pub get
    ```

4. **アプリの実行**：

    ```bash
    flutter run
    ```

5. **FreezedおよびRetrofitのファイルを生成**（必要に応じて）：

    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

## 使用方法

- **ポケモン一覧の閲覧**：アプリを開くと、ページネーション付きのポケモン一覧が表示されます。
- **ポケモン詳細の確認**：ポケモンをタップすると、詳細情報が表示されます。
- **お気に入り追加**：詳細画面の星アイコンをタップして、お気に入りに追加します。
- **お気に入り管理**：「お気に入り」タブで、お気に入りのポケモンを一覧表示し、削除することができます。

## 依存パッケージ

- [Flutter](https://flutter.dev/)
- [Riverpod](https://pub.dev/packages/riverpod)
- [Isar](https://pub.dev/packages/isar)
- [Dio](https://pub.dev/packages/dio)
- [Retrofit](https://pub.dev/packages/retrofit)
- [Freezed](https://pub.dev/packages/freezed)
- [Flutter Hooks](https://pub.dev/packages/flutter_hooks)

## APIリファレンス

- **ポケモンデータ**：[PokéAPI](https://pokeapi.co/)からポケモンの情報（詳細、画像など）を取得しています。
