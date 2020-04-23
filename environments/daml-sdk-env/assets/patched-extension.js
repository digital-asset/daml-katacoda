var fs = require('fs');
var path = require('path');
const vscode = require('vscode');

function activate(context) {

        let onMessage = vscode.commands.registerCommand('katacodainternal.onMessage', function (message) {
                if (isMessageFromKatacoda(message)) {
                        try {
                                switch (message.type) {
                                        case "open":
                                                open(message);
                                                break;
                                        case "copyToEditor":
                                                copyToEditor(message);
                                                break;
                                        default:
                                                break;
                                }
                        } catch (e) {
                                console.error('Error processing event', e);
                        }
                }
        });

        context.subscriptions.push(onMessage);

        let aboutDialog = vscode.commands.registerCommand('katacodaeditor.aboutKatacoda', function (message) {
                const panel = vscode.window.createWebviewPanel(
                        'aboutKatacoda', // Identifies the type of the webview. Used internally
                        'About Katacoda', // Title of the panel displayed to the user
                        vscode.ViewColumn.One, // Editor column to show the new webview panel in.
                        {} // Webview options. More on these later.
                );
                panel.webview.html = getWebviewContent();
        });

        context.subscriptions.push(aboutDialog);
}
exports.activate = activate;

function deactivate() {}

module.exports = {
        activate,
        deactivate
}

var isMessageFromKatacoda = function(message) {
        return message && message.creator && message.creator === "katacoda";
}

var copyToEditor = function(message) {
        var filePath = getPath(message);
        if(message.target === "replace") {
                fs.writeFile(filePath, message.contents, function(err) { console.log("[Katacoda] Unable to write file", err); });
        } else if(message.target === "append") {
                fs.appendFile(filePath, message.contents, function(err) { console.log("[Katacoda] Unable to write file", err); });
        } else if(message.target === "prepend") {
                fs.writeFile(filePath, message.contents, function(err) { console.log("[Katacoda] Unable to write file", err); });
        } else {
                fs.appendFile(filePath, message.contents, function(err) { console.log("[Katacoda] Unable to write file", err); });
        }
        open(message);
}

var open = function(message) {
        var filePath = getPath(message);
        console.log("Opening Path", filePath);
        var vsFilePath = vscode.Uri.file(filePath);

        ensureFileExists(filePath, function() {
                vscode.workspace.openTextDocument(vsFilePath).then(doc => {
                        vscode.window.showTextDocument(doc);
                });
        });
}

var getPath = function(message) {
        var filePath = path.join(vscode.workspace.rootPath, message.file);
        return filePath;
}

var ensureFileExists = function(path, cb) {
        fs.open(path, 'a', function(err, fd) {
                if (err) throw err;
                fs.close(fd, cb);
        });
}


function getWebviewContent() {
        return `<!DOCTYPE html>
  <html lang="en">
  <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>About Katacoda Editor</title>
  </head>
  <body>
          <img src="https://media.giphy.com/media/JIX9t2j0ZTN9S/giphy.gif" width="300" />
  </body>
  </html>`;
  }
