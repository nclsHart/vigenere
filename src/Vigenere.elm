module Vigenere exposing (..)

import Browser
import Html exposing (Html, Attribute, button, div, textarea, label, text, h1, h2, pre)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Vigenere.Encryption exposing (encrypt)

-- MAIN

main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL

type alias Model =
  { key : String
  , content : String
  , encryptedContent: String
  }

init : Model
init =
  { key = ""
  , content = ""
  , encryptedContent = ""
  }

-- UPDATE

type Msg
  = ChangeKey String | ChangeContent String | Encrypt

update : Msg -> Model -> Model
update msg model =
  case msg of
    ChangeKey newKey ->
      { model | key = newKey }

    ChangeContent newContent ->
      { model | content = newContent }

    Encrypt ->
      { model | encryptedContent = encrypt model.key model.content}

-- VIEW

view : Model -> Html Msg
view model =
  div [ class "max-w-xl mx-auto px-4" ]
    [ h1 [] [ text "Vigenere cypher" ]
    , div [] [ label [] [ text "Key" ]
      , textarea [ placeholder "Your secret key", value model.key, onInput ChangeKey ] []
    ]
    , div [] [ label [] [ text "Content" ]
      , textarea [ placeholder "Your content to encrypt", value model.content, onInput ChangeContent ] []
    ]
    , button [ onClick Encrypt ] [ text "Encrypt" ]
    , if model.encryptedContent /= "" then div [ class "mt-8" ] [ h2 [] [ text "Encrypted content" ]
      , pre [] [ text (model.encryptedContent) ]
      ]
      else text ""
    ]
