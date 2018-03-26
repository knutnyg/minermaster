module View exposing (..)

import Html exposing (..)
import Model exposing (..)
import Html.Events exposing (onClick)
import Miners exposing (..)
import Messages exposing (..)



view : Model -> Html Msg
view model =
    div []
        [ div [] [ h1 [] [ text "Minermaster" ] ]
        , viewNode model.miner
        , button [ onClick Fetch ] [ text "fetch" ]
        ]


viewNode : Miners -> Html Msg
viewNode miner =
    div []
        [ div [] [ h2 [] [ text miner.name ] ]
        , p []
            [ text
                ("Up: "
                    ++ if miner.uptime == -1 then
                        "?️"
                       else if miner.uptime > 0 then
                        "👍"
                       else
                        "👎"
                )
            ]
        , p [] [ text ("Uptime: " ++ (toString miner.uptime)) ]
        ]
