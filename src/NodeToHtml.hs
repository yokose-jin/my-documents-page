module NodeToHtml where

import NodeTypes
import System.FilePath (makeRelative)

docs :: String
docs = "docs"

type Html = String

pageTitle :: String
pageTitle = "書類"

htmlNode :: Node -> Html
htmlNode (Directory name path children) =
  if makeRelative docs path == "."
    then
      unlines
        [ "<ul>",
          concatMap htmlNode children,
          "</ul>"
        ]
    else
      unlines
        [ "<li>",
          name,
          "<ul>",
          concatMap htmlNode children,
          "</ul>",
          "</li>"
        ]
htmlNode (File name path) =
  unlines
    [ "<li>",
      "<a href=",
      docs ++ "/" ++ makeRelative docs path,
      ">",
      name,
      "</a>",
      "</li>"
    ]

nodeToHtml :: Node -> Html
nodeToHtml tree =
  unlines
    [ "<!DOCTYPE html>",
      "<html lang=\"en\">",
      "<head>",
      "    <meta charset=\"UTF-8\">",
      "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
      "    <title>"
        ++ pageTitle
        ++ "</title>",
      "    <style>",
      "        body {",
      "            max-width: 900px;",
      "            margin: 40px auto;",
      "            padding: 0 20px;",
      --   "            font-family: sans-serif;",
      "            line-height: 1.7;",
      "        }",
      "        ul {",
      "            padding-left: 30px;",
      "        }",
      "        a {",
      "            text-decoration: none;",
      "        }",
      "        a:hover {",
      "            text-decoration: underline;",
      "        }",
      "    </style>",
      "</head>",
      "<body>",
      "    <h1>" ++ pageTitle ++ "</h1>",
      htmlNode tree,
      "</body>",
      "</html>"
    ]