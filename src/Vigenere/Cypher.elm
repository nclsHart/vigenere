module Vigenere.Cypher exposing (decrypt, encrypt)

import String.Extra exposing (removeAccents)


alphabetSize =
    26


encrypt : String -> String -> String
encrypt key content =
    crypt encryptLetter key content


decrypt : String -> String -> String
decrypt key content =
    crypt decryptLetter key content


crypt : (Char -> Char -> Char) -> String -> String -> String
crypt cryptLetterFunc key content =
    let
        sanitizedContent =
            sanitize content

        sanitizedKey =
            sanitize key

        repeatedKey =
            String.repeat (ceiling (toFloat (String.length sanitizedContent) / toFloat (String.length sanitizedKey))) sanitizedKey
    in
    sanitizedContent
        |> String.toList
        |> List.map2 cryptLetterFunc (String.toList repeatedKey)
        |> String.fromList


encryptLetter : Char -> Char -> Char
encryptLetter keyLetter contentLetter =
    Char.toCode 'A'
        |> (+) (modBy alphabetSize (Char.toCode keyLetter + Char.toCode contentLetter))
        |> Char.fromCode


decryptLetter : Char -> Char -> Char
decryptLetter keyLetter contentLetter =
    Char.toCode 'A'
        |> (+) (modBy alphabetSize (Char.toCode contentLetter - Char.toCode keyLetter))
        |> Char.fromCode


sanitize : String -> String
sanitize content =
    content
        |> removeAccents
        |> String.toUpper
        |> String.filter (\letter -> Char.isAlpha letter)
