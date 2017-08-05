module Parser where

import qualified Types as T

import Text.Megaparsec
import Text.Megaparsec.String
import qualified Text.Megaparsec.Lexer as L

move :: Parser T.Command
move = string' "MOVE" >> return T.Move

left :: Parser T.Command
left = string' "LEFT" >> return T.Left

right :: Parser T.Command
right = string' "RIGHT" >> return T.Right

direction :: Parser T.Direction
direction = (string' "NORTH" >> return T.North)
        <|> (string' "EAST" >> return T.East)
        <|> (string' "SOUTH" >> return T.South)
        <|> (string' "WEST" >> return T.West)

place :: Parser T.Command
place = do
  string' "PLACE"
  space
  x <- L.integer
  char ','
  y <- L.integer
  char ','
  d <- direction
  return $ T.Place (fromIntegral x) (fromIntegral y) d

commandParser :: Parser T.Command
commandParser = move <|> left <|> right <|> place

parseCommand :: String -> Maybe T.Command
parseCommand = parseMaybe commandParser