module ExchangeDate
  ( makeDate,
  )
where

data ModDate = ModDate
  { week :: String,
    month :: String,
    date :: String,
    time :: String,
    year :: String,
    jst :: String
  }

makeModDate :: String -> ModDate
makeModDate s =
  ModDate
    { week = head s',
      month = s' !! 1,
      date = s' !! 2,
      time = s' !! 3,
      year = s' !! 4,
      jst = s' !! 5
    }
  where
    s' = words s

makeDate :: String -> String
makeDate s = year s' ++ "年" ++ monthEnToJp (month s') ++ "月" ++ date s' ++ "日"
  where
    s' = makeModDate s

monthEnToJp :: String -> String
monthEnToJp s =
  case s of
    "Jan" -> "1"
    "Feb" -> "2"
    "Mar" -> "3"
    "Apr" -> "4"
    "May" -> "5"
    "Jun" -> "6"
    "Jul" -> "7"
    "Aug" -> "8"
    "Sep" -> "9"
    "Oct" -> "10"
    "Nov" -> "11"
    "Dec" -> "12"
    _ -> ""