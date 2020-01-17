// ==UserScript==
// @name         Don't track my clicks, reddit
// @namespace    http://reddit.com/u/OperaSona
// @author       OperaSona
// @match        *://*.reddit.com/*
// @grant        none
// ==/UserScript==

var a_col = document.getElementsByTagName('a');
var a, actual_fucking_url;
for(var i = 0; i < a_col.length; i++) {
    a = a_col[i];
    actual_fucking_url = a.getAttribute('data-href-url');
    if(actual_fucking_url) a.setAttribute('data-outbound-url', actual_fucking_url);
}
