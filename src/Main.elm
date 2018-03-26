module Main exposing (..)

import Html exposing (Html, button, div, text, p, h1, h2)

import Model exposing (..)
import ApiResponses exposing (..)
import Subscriptions exposing (..)
import Update exposing (..)
import View exposing (..)

main =
    Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }