module Vigenere exposing (..)

import Browser
import Html exposing (Html, Attribute, button, div, input, text)
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
  div []
    [ input [ placeholder "Key", value model.key, onInput ChangeKey ] []
    , input [ placeholder "Content", value model.content, onInput ChangeContent ] []
    , button [ onClick Encrypt ] [ text "Encrypt" ]
    , div [] [ text (model.encryptedContent) ]
    ]
