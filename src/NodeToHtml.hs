module NodeToHtml where

import NodeTypes
import System.FilePath (makeRelative, splitDirectories)

docs :: String
docs = "docs"

type Html = String

depth :: FilePath -> Int
depth = length . splitDirectories

pageTitle :: String
pageTitle = "書類"

htmlNode :: Node -> Html
htmlNode (Directory name path children) =
  case depth path of
    1 ->
      unlines
        [ "    <ul class=depth0>",
          concatMap htmlNode children,
          "    </ul>"
        ]
    2 ->
      unlines
        [ "    <li class='depth1'>",
          name,
          "        <ul>",
          concatMap htmlNode children,
          "        </ul>",
          "    </li>"
        ]
    _ ->
      unlines
        [ "    <li>",
          name,
          "        <ul>",
          concatMap htmlNode children,
          "        </ul>",
          "    </li>"
        ]
htmlNode (File name path) =
  unlines
    [ "    <li>",
      "        <a href=",
      docs ++ "/" ++ makeRelative docs path,
      ">",
      name,
      "        </a>",
      "    </li>"
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
      -- "@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+JP:wght@200..900&display=swap');",
      "        @import url('https://fonts.googleapis.com/css2?family=Shippori+Mincho&display=swap');",
      "        body {",
      "            max-width: 900px;",
      "            margin: auto;",
      "            padding: 0 20px;",
      "            line-height: 1.5;",
      "            background-color: #fdfdfd;",
      "            font-family: Shippori Mincho",
      "        }",
      "        .depth0 {",
      "            padding-top: 10px;",
      "            padding-bottom: 10px;",
      "        }",
      "        .depth1 {",
      "            padding-top: 10px;",
      "            padding-bottom: 10px;",
      "        }",
      "        a {",
      "            text-decoration: none;",
      "        }",
      "        a:hover {",
      "            text-decoration: underline;",
      "        }",
      "        .title {",
      "            text-align: center",
      "        }",
      "        .mainpart {",
      "            background-color: white;",
      "            box-shadow: 0 0 8px rgb(235, 235, 235);",
      "         }",
      "    </style>",
      "</head>",
      "<body>",
      "    <div class='mainpart'>",
      htmlNode tree,
      "    </div>",
      "</body>",
      "</html>"
    ]