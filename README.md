# pwcheck
![test](https://github.com/Hayanin/robosys2026/actions/workflows/test.yml/badge.svg)

標準入力から1行ずつ文字列を読み込み、パスワードの強度（`WEAK` / `MEDIUM` / `STRONG`）を判定して出力するコマンドです。

## インストール方法
```bash
$git clone https://github.com/Hayanin/robosys2026.git
$ cd robosys2026
```

## 使い方
標準入力からパスワード候補を渡すと、強度ラベル付きで出力します。

```bash
$ printf '12345\nAbc12345\nAbc123!@#xyz\n' | ./pwcheck
WEAK: 12345
MEDIUM: Abc12345
STRONG: Abc123!@#xyz
```

### オプション
- `-s`, `--strong-only`: `STRONG` と判定されたパスワードのみをラベルなしで出力します。
- `-m <数値>`, `--min-length <数値>`: 最低限必要な文字数を指定します（指定文字数未満は `WEAK` になります）。

```bash
$ printf '12345\nAbc12345\nAbc123!@#xyz\n' | ./pwcheck --strong-only
Abc123!@#xyz
```

```bash
$ printf 'Abc123!@#xyz\n' | ./pwcheck -m 15
WEAK: Abc123!@#xyz
```

### エラー処理
- 空行のみの入力や、`-m` に 0 以下の数値を指定した場合は、標準エラー出力にエラーメッセージを出して終了コード `1` で終了します。

## 必要なソフトウェア
- Python
  - テスト済みバージョン: 3.10〜3.14

## テスト環境
- Ubuntu 24.04 LTS

## ライセンス
- このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されます。
- © 2026 Hayato Tsunoda
