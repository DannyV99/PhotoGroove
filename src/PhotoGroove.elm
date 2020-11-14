module PhotoGroove exposing (main)
import Html exposing (div, h1, img, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Browser
import Array exposing (Array)



----------------   MODEL   -------------------

initialModel : Model
initialModel =
  { photos =
    [ { url = "1.jpeg" }
    , { url = "2.jpeg" }
    , { url = "3.jpeg" }
    ]
  , selectedUrl = "1.jpeg"
  }

main =
  Browser.sandbox
    { init = initialModel
    , view = view
    , update = update
    }

type alias Photo =
  { url : String }

type alias Model =
  { photos : List Photo, selectedUrl : String }

type alias Msg =
  { description : String, data : String}

----------------   VIEW   -------------------

view : Model -> Html Msg
view model =
  div [ class "content" ]
    [ h1 [] [ text "PhotoGroove" ]
    , button
        [ onClick { description = "ClickedSurpriseMe", data = ""}]
        [ text "Surprise Me!"]
    , div [ id "thumbnails" ]
        (List.map (viewThumbnail model.selectedUrl) model.photos
      )
    , img [ class "large", src (urlPrefix ++ "large/" ++ model.selectedUrl) ] []
    ]

viewThumbnail selectedUrl thumb =
  img [ src (urlPrefix ++ thumb.url), classList [ ("selected", selectedUrl == thumb.url )], onClick {description = "ClickedPhoto", data = thumb.url } ] []

urlPrefix =
  "http://elm-in-action.com/"

photoArray : Array Photo
photoArray =
  Array.fromList initialModel.photos


----------------   UPDATE   -------------------


update msg model =
  if msg.description == "ClickedPhoto" then
    { model | selectedUrl = msg.data }
  else if msg.description == "ClickedSurpriseMe" then
    { model | selectedUrl = "2.jpeg" }
  else
    model
