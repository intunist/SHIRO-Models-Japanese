# SHIRO-Models-Japanese
Japanese Multi-Speaker Models for the SHIRO Phoneme Alignment Toolkit.

[日本語訳?](#機械翻訳です)

DynamiVox's Japanese models for [SHIRO](https://github.com/Sleepwalking/SHIRO).
The initial models are based on a multi-speaker 9 hour dataset of Japanese singing and some speech.
The current dataset is mostly female vocals and a few tenor males and will not work well for baritone and bass voices.
These models were trained to work specifically with singing, speech alignment may not be as expected.
Because of how the dataset was prepared, alignment with long silences is especially decent.

These models are created using the NNSVS/ENUNU phoneme set.

There are 2 models for each voice type. Normal and a "no runs" model.
The normal model is ideal for when the index includes vowel riffs/runs from the performance. But the consonants will be less accurate.
The "no runs" model is best for when the vocal runs are not indexed and the consonant alignment is more accurate.
It is always safe to use the normal model regardless. The "no-runs" model will also work but the alignment on runs will likely to miss.

dyv_jp_generic: Generic model with a mix of both male and female vocals.

(wip, unavailable) dyv_jp_female: Model with only female vocal data, regardless of voice type.

(wip, unavailable) dyv_jp_male: Model for tenor and high-baritone male voices.

(wip, unavailable) dyv_jp_low_male: Model for low baritone and bass male voices.

The generic model will not work well for low male voices due to lack of examples in the dataset.
For baritone and bass voices, limit the length of the audio to 20 seconds for any chance of alignment.
For other voices, under 30 seconds is suggested but you can often align audio of several minutes with reasonable results.
However no more than a minute is recommended due to ram requirements.

## How to use:
Build SHIRO using the directions in the SHIRO readme. You can build inside of WSL.
ADVICE: If SHIRO doesn't build, create a "build" folder inside the SHIRO folder.

Perform feature extraction:
```
lua shiro-fextr.lua /path/to/your/index.csv -d /path/to/your/dataset -x ./extractors/extractor-xxcc-mfcc12-da-16k -r 16000
```

Create a placeholder alignment:
```
lua shiro-mkseg.lua /path/to/your/index.csv -m /path/to/phonemap.json -d /path/to/your/dataset -e .param -n 36 -L sil -R sil > /path/to/your/dataset/unaligned.json
```

Perform the first alignment:
```
./shiro-align -T -m /path/to/dyv_jp_generic.hsmm -s /path/to/your/dataset/unaligned.json -g > /path/to/your/dataset/initial-alignment.json
```

Perform the final alignment:
```
./shiro-align -T -m /path/to/dyv_jp_generic.hsmm -s /path/to/your/dataset/initial-alignment.json -p 30 -d 50 > /path/to/your/dataset/refined-alignment.json
```

Convert final alignment to audacity labels:
```
lua shiro-seg2lab.lua /path/to/your/dataset/refined-alignment.json -t 0.005
```
This will create a text file for each audio file that can be viewed in Audacity.

If you want to convert these Audacity labels to the HTK LAB format (which is required for NNSVS/ENUNU) then you can use [Lab2Audacity](https://github.com/UtaUtaUtau/nnsvslabeling) to convert them.

## (機械翻訳です)

SHIRO Phoneme Alignment Toolkit用日本語多人数話者モデル。

DynamiVoxのSHIRO用日本語音声ラベリングモデルです。
初期モデルは、9時間分の日本語歌唱コーパスに基づき作成されています。
現在のコーパスは、ほとんどが女性ボーカルで、テナー男性ボーカルも数名含まれており、バリトンや低音ボイスではうまく機能しません。
これらのモデルは歌声に特化して学習されたものであり、音声に対してはうまく機能しないかもしれません。
コーパスの特性上、長い無音部分が非常によく並びます。

これらのモデルは、NNSVS/ENUNU音素セットを用いて作成されています。

全音声タイプに2種類のラベリングモデルがあります。ノーマルと "NO RUNS "モデルです。
通常モデルは、index.csvファイルに歌唱演奏のメリスマ/ボーカルランが含まれている場合に最適です。しかし、子音のラベリングは精度が落ちます。
no-runs "と題されたモデルは、index.csvファイルにこれらの声帯装飾が含まれていない場合に最適です。子音ラベリングもこのモデルの方がより正確です。
通常モデルを使用するのが安全ですが、"no-runs "モデルも機能します。ただし、「no-runs」モデルを使用すると、声帯装飾のラベリングは失敗する可能性が高いことに注意してください。

dyv_jp_generic: 女性ボーカルと男性ボーカルの両方で学習させた一般的なモデル。

(利用不可) dyv_jp_female: 声質に関係なく、女性ボーカルのみのデータで構成されたモデル。

(利用不可) dyv_jp_male: テナー、ハイバリトンの男声用モデル。

(利用不可) dyv_jp_low_male: 低音バリトン、低音バスの男声用モデル。

一般的なモデルでは、コーパスに例がないため、低い男声のラベリングはうまくいかない。
バリトンや低音の音声の場合、ラベリングに成功する確率を上げるために、音声の長さを20秒に制限する。
その他の声質については、30秒以内を推奨しますが、数分の音声でも妥当な結果が得られることがあります。
ただし、RAMの関係で1分以内を推奨します。

## 使用方法
readmeファイルにある指示に従い、ソースコードからSHIROをビルドする。Windows Subsystem for Linux (WSL)の中でビルドすることができます。
アドバイス SHIROがビルドできない場合は、SHIROのフォルダの中にbuildフォルダを作成する。

特徴抽出を行う。
```
lua shiro-fextr.lua /path/to/your/index.csv -d /path/to/your/dataset -x ./extractors/extractor-xxcc-mfcc12-da-16k -r 16000
```

プレースホルダーアライメントを作成します。
```
lua shiro-mkseg.lua /path/to/your/index.csv -m /path/to/phonemap.json -d /path/to/your/dataset -e .param -n 36 -L sil -R sil > /path/to/your/dataset/unaligned.jsonのようなものです。
```

最初のアライメントを実行する。
```
./shiro-align -T -m /path/to/dyv_jp_generic.hsmm -s /path/to/your/dataset/unaligned.json -g > /path/to/your/dataset/initial-alignment.json
```

ファイナルアライメントを実行します。
```
./shiro-align -T -m /path/to/dyv_jp_generic.hsmm -s /path/to/your/dataset/initial-alignment.json -p 30 -d 50 > /path/to/your/dataset/refined-alignment.jsonを指定します。
```

最終的なアライメントをAudacityのラベルに変換する。
```
lua shiro-seg2lab.lua /path/to/your/dataset/refined-alignment.json -t 0.005
```
これで、各オーディオファイルに対して、Audacityで閲覧可能なテキストファイルが作成されます。

もし、これらのAudacityラベルをHTK LABフォーマット（NNSVS/ENUNUで必要）に変換したい場合は、Lab2Audacityを使って変換することができます。
