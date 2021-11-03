module Test.Cypher exposing (..)

import Expect
import Test exposing (..)
import Vigenere.Cypher exposing (decrypt, encrypt)


suite : Test
suite =
    describe "Cypher module"
        [ describe "encrypt"
            [ test "without spaces" <|
                \_ ->
                    Expect.equal "MSLDILD" (encrypt "key" "content")
            , test "with spaces" <|
                \_ ->
                    Expect.equal "YWMSLFCXX" (encrypt "my key" "my content")
            , test "with key longer than content" <|
                \_ ->
                    Expect.equal "OMIXVLE" (encrypt "my very long key" "content")
            , test "with uppercase in key" <|
                \_ ->
                    Expect.equal "MSLDILD" (encrypt "KeY" "content")
            , test "with uppercase in content" <|
                \_ ->
                    Expect.equal "MSLDILD" (encrypt "key" "CoNtEnT")
            , test "with accents in key" <|
                \_ ->
                    Expect.equal "MSLDILD" (encrypt "kèy" "content")
            , test "with accents in content" <|
                \_ ->
                    Expect.equal "MSLDILD" (encrypt "key" "côntént")
            , test "with special chars in key" <|
                \_ ->
                    Expect.equal "MSLDILD" (encrypt "k-e_y%'" "content")
            , test "with special chars in content" <|
                \_ ->
                    Expect.equal "MSLDILD" (encrypt "key" "c#o~n&te@nt")
            ]
        , describe "decrypt"
            [ test "without spaces" <|
                \_ ->
                    Expect.equal "CONTENT" (decrypt "key" "MSLDILD")
            , test "with spaces" <|
                \_ ->
                    Expect.equal "MYCONTENT" (decrypt "my key" "YW MSLFCXX")
            , test "with key longer than content" <|
                \_ ->
                    Expect.equal "CONTENT" (decrypt "my very long key" "OMIXVLE")
            , test "with uppercase in key" <|
                \_ ->
                    Expect.equal "CONTENT" (decrypt "KeY" "MSLDILD")
            , test "with uppercase and lowercase in content" <|
                \_ ->
                    Expect.equal "CONTENT" (decrypt "key" "MsLDiLD")
            , test "with accents in key" <|
                \_ ->
                    Expect.equal "CONTENT" (decrypt "kèy" "MSLDILD")
            , test "with accents in content" <|
                \_ ->
                    Expect.equal "CONTENT" (decrypt "key" "MSLDÎLD")
            , test "with special chars in key" <|
                \_ ->
                    Expect.equal "CONTENT" (decrypt "k-e_y%'" "MSLDILD")
            , test "with special chars in content" <|
                \_ ->
                    Expect.equal "CONTENT" (decrypt "key" "M&SL#DI~L@D")
            ]
        ]
