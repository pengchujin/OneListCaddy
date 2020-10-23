#!/bin/bash
url="$1"
type="$2"
domain="$3"
SubPath=""
RootPath=""
mail="qq@qq.com"

if  [ ! "$4" ] ;then
    SubPath=${RootPath}
    echo "可以选择文件夹名，默认根目录"
else
    RootPath="$4"
fi

if  [ ! "$5" ] ;then
    mail=${mail}
    echo "建议填写邮箱📮"
else
    mail="$5"
fi

case $type in
	a)
		./OneList -a "${url}" -s "/onedrive01"
		;;
	ms)
		./OneList -ms -a "${url}" -s "/onedrive02"
		;;
  cn)
		./OneList -cn -a "${url}" -s "/onedrive03"
		;;
	*)
		echo "请输入正确的类型 a 代表国际版 ms 代表个人版或家庭版 cn 代表世纪互联版"
    break
		;;
esac
sed -i "s/\"\/\"/\"\/${RootPath}\"/" config.json
sed -i "s/onedrive01/${SubPath}/" config.json
sed -i "s/onedrive02/${SubPath}/" config.json
sed -i "s/onedrive03/${SubPath}/" config.json
sed -i "s/example.com/${domain}/" Caddyfile
echo "------------------------ onelist Config ----------------------------"
cat config.json
echo "------------------------ Caddy ----------------------------"
cat Caddyfile
nohup caddy run --config Caddyfile --adapter caddyfile &
./OneList -bind localhost -port 8888
