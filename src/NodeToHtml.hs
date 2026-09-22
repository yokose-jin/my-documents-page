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
        [ "    <ul class='depth0'>",
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
      "        <a class='fileLink' href=",
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
      "    <link rel='stylesheet' href='./styles.css' />",
      "    <title>"
        ++ pageTitle
        ++ "</title>",
      "</head>",
      "<body>",
      "    <div class='contact'>",
      "<img class='gitLogo' src='./logo/GitHub_Invertocat_Black_Clearspace.svg' width='30px' height='30px'></img>",
      "<a class='gitLink' href='https://github.com/yokose-jin' target='_blank'>GitHub</a>",
      "</div>",
      "    <div class='mainpart'>",
      htmlNode tree,
      "    </div>",
      "</body>",
      "</html>"
    ]