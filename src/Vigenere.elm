module Vigenere exposing (..)

import Browser
import Html exposing (Attribute, Html, button, div, h1, h2, input, label, pre, text, textarea)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onCheck)
import Vigenere.Cypher exposing (decrypt, encrypt)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { key : String
    , content : String
    , result : String
    , mode : Mode
    }


type Mode
    = EncryptMode
    | DecryptMode


init : Model
init =
    { key = ""
    , content = ""
    , result = ""
    , mode = EncryptMode
    }



-- UPDATE


type Msg
    = ChangeKey String
    | ChangeContent String
    | SwitchToEncryptMode Bool
    | SwitchToDecryptMode Bool
    | Encrypt
    | Decrypt


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeKey newKey ->
            { model | key = newKey }

        ChangeContent newContent ->
            { model | content = newContent }

        SwitchToEncryptMode checked ->
            { model | mode = EncryptMode, result = "" }

        SwitchToDecryptMode checked ->
            { model | mode = DecryptMode, result = "" }

        Encrypt ->
            { model | result = encrypt model.key model.content }

        Decrypt ->
            { model | result = decrypt model.key model.content }



-- VIEW


resultTitle : Mode -> String
resultTitle mode =
    case mode of
        EncryptMode ->
            "Encrypted content"

        DecryptMode ->
            "Decrypted content"


contentPlaceholder : Mode -> String
contentPlaceholder mode =
    case mode of
        EncryptMode ->
            "Your content to encrypt"

        DecryptMode ->
            "Your content to decrypt"


buttonText : Mode -> String
buttonText mode =
    case mode of
        EncryptMode ->
            "Encrypt"

        DecryptMode ->
            "Decrypt"


view : Model -> Html Msg
view model =
    div [ class "max-w-xl mx-auto px-4" ]
        [ h1 [] [ text "Vigenere cypher" ]
        , div [ class "form-row" ]
            [ label [] [ text "Choose your mode" ]
            , div [ class "modes" ]
                [ label [ class "mode", for "encrypt_mode" ]
                    [ input [ type_ "radio", id "encrypt_mode", name "mode", value "encrypt", checked (model.mode == EncryptMode), onCheck SwitchToEncryptMode ] []
                    , text "Encrypt"
                    ]
                , label [ class "mode", for "decrypt_mode" ]
                    [ input [ type_ "radio", id "decrypt_mode", name "mode", value "decrypt", checked (model.mode == DecryptMode), onCheck SwitchToDecryptMode ] []
                    , text "Decrypt"
                    ]
                ]
            ]
        , div [ class "form-row" ]
            [ label [] [ text "Key" ]
            , textarea [ placeholder "Your secret key", value model.key, onInput ChangeKey ] []
            ]
        , div [ class "form-row" ]
            [ label [] [ text "Content" ]
            , textarea [ placeholder (contentPlaceholder model.mode), value model.content, onInput ChangeContent ] []
            ]
        , button [ onClick (if model.mode == EncryptMode then Encrypt else Decrypt) ] [ text (buttonText model.mode) ]
        , if model.result /= "" then
            div [ class "mt-8" ]
                [ h2 [] [ text (resultTitle model.mode) ]
                , pre [] [ text model.result ]
                ]

          else
            text ""
        ]
