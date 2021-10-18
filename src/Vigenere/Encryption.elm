module Vigenere.Encryption exposing (encrypt)

import String.Extra exposing (removeAccents)

encrypt : String -> String -> String
encrypt key content =
  let
    sanitizedContent = sanitize content
    sanitizedKey = sanitize key
    repeatedKey = String.repeat (ceiling ((toFloat (String.length sanitizedContent)) / (toFloat (String.length sanitizedKey)))) sanitizedKey
  in
  sanitizedContent
    |> String.toList
    |> List.map2 encryptLetter (String.toList repeatedKey)
    |> String.fromList

encryptLetter : Char -> Char -> Char
encryptLetter keyLetter contentLetter =
  let
    alphabetSize = 26
  in
  Char.toCode 'A'
    |> (+) (remainderBy alphabetSize ((Char.toCode keyLetter) + (Char.toCode contentLetter)))
    |> Char.fromCode

sanitize : String -> String
sanitize content =
  content
    |> removeAccents
    |> String.toUpper
    |> String.filter (\letter -> Char.isAlpha letter)
