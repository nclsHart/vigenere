module Test.Encryption exposing (..)

import Test exposing (..)
import Vigenere.Encryption exposing (encrypt)
import Expect

suite : Test
suite =
  describe "encrypt"
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
