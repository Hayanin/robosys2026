# robosys2026
![test](https://github.com/Hayanin/robosys2026/actions/workflows/test.yml/badge.svg)

ロボットシステム学の課題用リポジトリです。標準入出力を利用したLinuxコマンドを収録しています。

## インストール方法
```bash
git clone [https://github.com/Hayanin/robosys2026.git](https://github.com/Hayanin/robosys2026.git)
cd robosys2026
```

## コマンド一覧と使い方

### 1. `pwcheck`（パスワード強度チェッカー）
標準入力から1行ずつ文字列を読み込み、パスワードの強度（`WEAK` / `MEDIUM` / `STRONG`）を判定して出力します。

- **基本的な使い方**
```bash
printf '12345\nAbc12345\nAbc123!@#xyz\n' | ./pwcheck
WEAK: 12345
MEDIUM: Abc12345
STRONG: Abc123!@#xyz
```

- **オプション**
  - `-s`, `--strong-only`: `STRONG` と判定されたパスワードのみをラベルなしで出力します。
  - `-m <数値>`, `--min-length <数値>`: 最低限必要な文字数を指定します（指定文字数未満は `WEAK` になります）。

```bash
# STRONGのパスワードのみ抽出する例
printf '12345\nAbc12345\nAbc123!@#xyz\n' | ./pwcheck --strong-only
Abc123!@#xyz

# 最小文字数を15文字に指定する例
printf 'Abc123!@#xyz\n' | ./pwcheck -m 15
WEAK: Abc123!@#xyz
```

- **エラー処理**
  - 空行のみの入力や、`-m` に0以下の数値を指定した場合は、標準エラー出力にエラーメッセージを出して終了コード `1` で終了します。

### 2. `plus`（加算コマンド）
標準入力から読み込んだ数値を足し合わせて出力します。

```bash
seq 5 | ./plus
15
```

## 必要なソフトウェア
- Python
  - テスト済みバージョン: 3.10〜3.14

## テスト環境
- Ubuntu 24.04 LTS

## ライセンス
- このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されます。
- © 2026 Hayato Tsunoda
