import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
  Html.program { init = init, view = view, update = update, subscriptions = subscriptions }


-- MODEL

type alias Model =
  { nodes : List Node
  , name : String
  }

type alias Node =
  { name : String
  , gpus : List Gpu
  }

type alias Gpu =
  { name : String
  , temp : Float
  }

-- UPDATE

type Msg = Change

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Change ->
       ({ model | name = model.name ++ "test" }, Cmd.none)



-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Change ] [ text "test"]
    , div [] [ text (model.name) ]
    ]



-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- INIT
init : (Model, Cmd none)
init =
    ({ nodes = [], name = "test" }, Cmd.none)


