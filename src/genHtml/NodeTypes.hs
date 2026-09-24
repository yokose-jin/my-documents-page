module NodeTypes where

type FileName = String

type DirectoryName = String

type ModDate = Maybe String

type Subject = Maybe String

data Node
  = Directory DirectoryName FilePath [Node]
  | File FileName FilePath ModDate Subject
  deriving (Show, Eq)
