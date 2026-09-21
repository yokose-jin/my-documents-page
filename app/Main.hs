module Main where

import DirToNode
import NodeToHtml

main :: IO ()
main = do
  dirNode <- dirToNode docs
  writeFile "index.html" $ nodeToHtml dirNode