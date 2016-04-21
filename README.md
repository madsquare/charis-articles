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
