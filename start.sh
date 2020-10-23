#!/bin/bash
url="$1"
type="$2"
domain="$3"
SubPath=""
mail="qq@qq.com"
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
sed -i "s/onedrive01/${SubPath}/" config.json
sed -i "s/onedrive02/${SubPath}/" config.json
sed -i "s/onedrive03/${SubPath}/" config.json
sed -i "s/example.com/${domain}/" Caddyfile
echo config
./OneList -bind 0.0.0.0 -port 8888
caddy run --config Caddyfile --adapter caddyfile