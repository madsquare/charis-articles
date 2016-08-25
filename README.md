# web charis articles

article 생성을 위한 repository. jekyll을 이용하여 static file 생성함.


## Requirements

* [RubyGem](https://rubygems.org/pages/download)
* [jekyll](https://jekyllrb.com/docs/installation/)


## Start

```
$ grunt
```

## Deploy site

```shell
$ grunt deploy
```

## deploy.json

deploy 위해서는 aws s3 업로드 가능한 권한을 가진 profile 정보 필요하며 정보는 담당자에게 문의.

```json
{
    "accessKeyId": "",
    "secretAccessKey": "",
    "region": ""
}
```

## charis.json
```json
{
  "endpoint": "",
  "clientId": "",
  "clientSecret": ""
}
```


## FAQ

* 터미널 >> Ctrl+C >> grunt deploy 업로드
* 서버 등록 : charis.json >> grunt sync 실서버 반영
* 오류가 날 때에는 처음과 끝이 잘 가두어져 있는지 확인하자 ''


## Copyright

Copyright(c) 2016 MADSquare Inc. All rights reserved. 
