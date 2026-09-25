module NodeToHtml where

import ExchangeDate
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
          "&mdash;",
          name,
          "        <ul>",
          concatMap htmlNode children,
          "        </ul>",
          "    </li>"
        ]
    _ ->
      unlines
        [ "    <li>",
          "<span class='nodetitle'>",
          "&mdash;",
          name,
          "</span>",
          "        <ul>",
          concatMap htmlNode children,
          "        </ul>",
          "    </li>"
        ]
htmlNode (File name path modDate subject) =
  unlines
    [ "    <li>",
      "        <a class='fileLink' href=",
      docs ++ "/" ++ makeRelative docs path,
      "target='_blank'>",
      "<span class='nodetitle'>",
      name,
      "</span>",
      "        </a>",
      dateDiv modDate,
      subjectSpan subject,
      "    </li>"
    ]
  where
    dateDiv :: ModDate -> Html
    dateDiv Nothing = "<div class='modDate'>&mdash;最終更新日:</div>"
    dateDiv (Just s) = "<div class='modDate'>&mdash;最終更新日:" ++ makeDate s ++ "</div>"

    subjectSpan :: Subject -> Html
    subjectSpan Nothing = ""
    subjectSpan (Just s) = "<div class='subject'>概要：<span>" ++ s ++ " </span></div>"

nodeToHtml :: Node -> Html
nodeToHtml tree =
  unlines
    [ "<!DOCTYPE html>",
      "<html lang=\"en\">",
      "<head>",
      "    <meta charset=\"UTF-8\">",
      "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
      "    <link rel='stylesheet' href='./styles.css?v=2' />",
      "    <title>"
        ++ pageTitle
        ++ "</title>",
      "</head>",
      "<body>",
      "    <div class='contact'>",
      "<a class='gitLink' href='https://github.com/yokose-jin' target='_blank'>",
      "            <img class='gitLogo' src='./logo/GitHub_Invertocat_Black_Clearspace.svg' />",
      "</a>",
      "</div>",
      "    <div class='mainpart'>",
      htmlNode tree,
      "    </div>",
      "</body>",
      "</html>"
    ]