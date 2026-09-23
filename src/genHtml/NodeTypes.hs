module NodeTypes where

type FileName = String

type DirectoryName = String

data Node
  = Directory DirectoryName FilePath [Node]
  | File FileName FilePath (Maybe String)
  deriving (Show, Eq)
