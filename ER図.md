### ER図
（ER図のスクリーンショットを貼り付けてください）
![alt text](image.png)

### 本サービスの概要（700文字以内）
※ アプリの目的・概要・想定ユーザー・主な機能をまとめてください。
すでに完成されたフォントデザインを素材としてダウンロードできる機能。

想定ユーザーはSNS運用や、youtube制作・バナー作成やLP制作をされている方を想定しています。
・いつもと違うデザインも模索している方
・デザインに取り掛かるまでの素材選びに時間がかかってしまう方
・フリーデザインの線の太さや無妙なデザインの違いでまとまりがなく困っている方

年齢層は20代〜40代のSNS運用をされている方や広告担当をされている方です。

### MVPで実装する予定の機能

- 機能①ユーザー登録機能
- 機能②ログイン機能
- 機能③画像投稿・閲覧・削除機能
- 機能④画像ダウンロード機能
- 機能⑤タグ投稿・編集・削除

### テーブル詳細
#### usersテーブル
- id : integer / usersテーブルのid(主キー)
- user_name : string /ユーザー名
- email : string / ログイン用メールアドレス（ユニーク制約）
- crypted_password: string /暗号化パスワード
- salt：string /ランダムな文字列
- created_at：datetime /作成日
- updated_at：datetime /更新日

#### font_designsテーブル
- id : integer / Font_designsテーブルのid(主キー)
- user_id : integer / 外部キー(FK → users.id)
- created_at：datetime /作成日
- updated_at：datetime /更新日

【font_designsテーブルの備考】
- 画像ファイルはActive Storageで管理
- svg_fileとpng_fileの2種類のファイルを添付可能

#### font_design_tags(中間テーブル)
- id : integer / Font_design_tagsテーブルのid(主キー)
- font_design_id : integer / 外部キー(FK → font_designs.id)
- tag_id：integer/ (FK → Tags.id)
- created_at：datetime /作成日
- updated_at：datetime /更新日

#### tagsテーブル
- id : integer / Tagsテーブルのid(主キー)
- tags_name : string/ タグ名
- created_at：datetime /作成日
- updated_at：datetime /更新日

### ER図の注意点
- [ ] 最新のER図スクリーンショットがPRに掲載されているか
- [ ] テーブル名は複数形になっているか
- [ ] カラムの型は記載されているか
- [ ] 外部キーは適切か
- [ ] リレーションは正しく描かれているか
- [ ] 多対多の関係になっていないか
- [ ] STIを使用していないか
- [ ] postsテーブルに post_name のような命名をしていないか
