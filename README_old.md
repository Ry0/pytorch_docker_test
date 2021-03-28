# dockerでPytorchの環境を整える
## インストール
Docker等は検索して最新版を入れた。

nvidia-dockerやnvidia-docker2はもう古いらしい。
NVIDIA Container Toolkitを使う。

> https://blog.amedama.jp/entry/docker-nvidia-container-toolkit

## PytorchのDockerイメージを取ってくる
https://hub.docker.com/r/pytorch/pytorch/

```bash
docker pull pytorch/pytorch
```

GPU使用できる状態ならば`-gpus`オプションを使う。
作業フォルダをホスト側と共有するなら、`-v ホスト側:コンテナ側`と指定する。

```
docker run -it --gpus all -v /home/ry0/workspace/python/pytorch:/workspace/pytorch pytorch/pytorch
```

## テスト

```python
import torch

a = torch.cuda.is_available()
print(a)
```

これを実行して`True`だったらGPUが使用できている。


## 参考サイト
|   |   |
|---|---|
| PyTorch で GPU を使う |  https://qiita.com/elm200/items/46633430c456dd90f1e3 |
| Dockerで立ち上げた開発環境をVS Codeで開く! |  https://qiita.com/yoskeoka/items/01c52c069123e0298660 |
| 【Docker】Dockerでホストのディレクトリをマウントする |  https://qiita.com/Yarimizu14/items/52f4859027165a805630 |
| Dockerコンテナのおもしろい名前 |  https://deeeet.com/writing/2014/07/15/docker-container-name/ |
| docker run(コンテナ作成)する時のオプションあれこれ |  https://qiita.com/shimo_yama/items/d0c42394689132fcb4b6 |
| NVIDIA Container Toolkit を使って Docker コンテナで GPU を使う |  https://blog.amedama.jp/entry/docker-nvidia-container-toolkit |