module GetPdfInfo
  ( getPdfModDate,
    getPdfSubject,
  )
where

import Data.Char (isSpace)
import Data.List (dropWhileEnd)
import System.FilePath (takeExtension)
import System.Process (readProcess)

type Info = String

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

getPdfInfo :: FilePath -> Info -> IO (Maybe String)
getPdfInfo path info =
  if takeExtension path == ".pdf"
    then do
      input <- readProcess "pdfinfo" [path] []
      let parseInput = parseLines input
      return $ lookup info parseInput
    else return Nothing

getPdfModDate :: FilePath -> IO (Maybe String)
getPdfModDate path = getPdfInfo path "ModDate"

getPdfSubject :: FilePath -> IO (Maybe String)
getPdfSubject path = getPdfInfo path "Subject"