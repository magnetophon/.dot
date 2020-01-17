var links,thisLink;
links = document.evaluate("//a[@href]",
                          document,
                          null,
                          XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE,
                          null);

for (var i=0;i<links.snapshotLength;i++) {
    var thisLink = links.snapshotItem(i);

    thisLink.href = thisLink.href.replace(RegExp('https?://www\\.youtube\\.com/(.*)'),
                                          'https://www\.hooktube\.com/$1');

    thisLink.href = thisLink.href.replace(RegExp('https?://youtu\\.be/(.*)'),
                                          'https://www\.hooktube\.com/watch\?v=$1');
}
