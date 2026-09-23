module GetPdfInfo
  ( getPdfModDate,
  )
where

import Data.Char (isSpace)
import Data.List (dropWhileEnd)
import System.FilePath (takeExtension)
import System.Process (readProcess)

trim :: String -> String
trim = dropWhileEnd isSpace . dropWhile isSpace

splitOnce :: String -> Maybe (String, String)
splitOnce s =
  case break (== ':') s of
    (key, ':' : rest) -> Just (trim key, trim rest)
    _ -> Nothing

parseLines :: String -> [(String, String)]
parseLines input =
  [ kv | line <- lines input, not (null (trim line)), Just kv <- [splitOnce line]
  ]

getPdfModDate :: FilePath -> IO (Maybe String)
getPdfModDate path =
  if takeExtension path == ".pdf"
    then do
      input <- readProcess "pdfinfo" [path] []
      let parseInput = parseLines input
      return $ lookup "ModDate" parseInput
    else return Nothing

-- main :: IO ()
-- main = do
--   input <- readProcess "pdfinfo" ["main.pdf"] []
--   let result = parseLines input
--   print result