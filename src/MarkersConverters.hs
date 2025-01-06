module MarkersConverters where

import Text.Megaparsec
import Text.Megaparsec.Char
import Data.Text
import Data.Void
import Control.Monad (void)

import AbstractSyntaxTree

{- toAbntHtml :: Markers -> String
toAbntHtml (MarkersMain someString sections) = "<!DOCTYPE html>\
    \<html lang=\"pt-BR\">\
    \<head>\
    \<meta charset=\"UTF-8\">\
    \<title>" <> someString <> "</title>\
    \<style>\
    \  @page {\
    \    size: A4;\
    \    margin: 3cm 2cm 2cm 3cm;\
    \  }\
    \  body {\
    \    font-family: Arial, sans-serif;\
    \    font-size: 12pt;\
    \    line-height: 1.5;   /* Espaçamento 1,5 */\
    \    text-align: justify;\
    \    color: #000;\
    \    margin: 0;          /* Remove margens padrões do navegador */\
    \    padding: 0;\
    \  }\
    \  .container {\
    \    background-color: white;\
    \    /* Você pode remover ou ajustar margens extras aqui, se quiser */\
    \  }\
    \  p {\
    \    text-indent: 1.25cm;\
    \    margin: 0 0 1em;    /* Espaço entre parágrafos */\
    \  }\
    \  h1, h2, h3, h4, h5 {\
    \    text-align: center;\
    \    font-weight: bold;\
    \    margin: 0;\
    \    padding: 0;\
    \  }\
    \  h1 {\
    \    font-size: 14pt;    /* Título principal um pouco maior */\
    \    margin-bottom: 1em;\
    \  }\
    \  h2, h3 {\
    \    font-size: 12pt;\
    \    margin-bottom: 1em;\
    \  }\
    \  details {\
    \    margin-left: 20px;\
    \  }\
    \  summary {\
    \    cursor: pointer;\
    \  }\
    \  img {\
    \    max-width: 100%;\
    \  }\
    \  .referencias {\
    \    margin-top: 2em;\
    \  }\
    \  .referencia {\
    \    text-indent: 0;     /* Normalmente, referências não têm recuo */\
    \    margin: 0 0 0.5em 0;\
    \    line-height: 1;     /* Espaçamento simples */\
    \  }\
    \</style>\
    \</head>\
    \<body>\
    \<div class=\"container\">\
    \<h1>" <> someString <> "</h1>"
    <> Prelude.foldr (\x acc -> helper x <> acc) "" sections
    <> "</div></body></html>"
    where
        helper :: MainSection -> String
        helper (Paragraph (Default content))       = content
        helper (Paragraph (Bold content))          = "<strong>" <> content <> "</strong>"
        helper (Paragraph (Italic content))        = "<em>" <> content <> "</em>"
        helper (Paragraph (Underlined content))    = "<span style=\"text-decoration:underline\">" <> content <> "</span>"
        helper (Paragraph (Crossed content))       = "<s>" <> content <> "</s>"
        helper (Paragraph (CodeInline content))    = "<code>" <> content <> "</code>"
        helper (Ref url author title year access content) = "<a href=\"" <> url <> "\">" <> title <> "</a>"
        helper (List title content) = "<ul>" <> title <> Prelude.foldr (\x acc -> "<li>" <> helper x <> "</li>" <> acc) "" content <> "</ul>" 
        helper (Chap title content) = "<h3>" <> title <> "</h3>" 
            <> Prelude.foldr (\x acc -> helper x <> acc) "" content 
        helper (Link url content) = "<a href=\"" <> url <> "\">" 
            <> Prelude.foldr (\x acc -> helper x <> acc) "" content 
            <> "</a>"
        helper (Image url content) = "<img src=\"" <> url <> "\" alt=\"" 
            <> Prelude.foldr (\x acc -> helper x <> acc) "" content 
            <> "\">"
        helper (Code content) = "<pre>" 
            <> Prelude.foldr (\x acc -> helper x <> acc) "" content 
            <> "</pre>"
        helper (LineBreak) = "<br>"
-}

toHtml :: Markers -> String
toHtml (MarkersMain someString sections) =
    "<!DOCTYPE html>\
    \<html lang=\"en\">\
    \<head>\
    \  <meta charset=\"UTF-8\">\
    \  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\
    \  <title>" <> someString <> "</title>\
    \  <style>\
    \    body {\
    \      margin: 0;\ 
    \      padding: 0;\ 
    \      font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, \"Helvetica Neue\", Arial, sans-serif;\
    \      background-color: #fafafa;\
    \      color: #333;\
    \    }\
    \    \
    \    .container {\
    \      max-width: 800px;\
    \      margin: 0 auto;\
    \      padding: 2em;\
    \      background-color: #fff;\
    \      box-shadow: 0 2px 5px rgba(0,0,0,0.1);\
    \    }\
    \    \
    \    .container h1, .container h2, .container h3 {\
    \      text-align: left;\
    \      margin-top: 1.2em;\
    \      margin-bottom: 0.8em;\
    \    }\
    \    \
    \    .container p {\ 
    \      text-align: justify;\
    \      line-height: 1.6;\
    \      margin: 1em 0;\
    \    } \
    \        details {\
    \            margin-left: 0px; \
    \            margin-top: 10px; \
    \            margin-bottom: 0px; \
    \        } \
    \        summary { \
    \            padding-left: -20px; \
    \            cursor: pointer; \
    \            font-weight: bold; \
    \            padding-top: 5px; \
    \            outline: none; \
    \        } \
    \        details > div, details > details, details > summary { \
    \            margin-left: 10px; \
    \            padding-top: -25px; \
    \        } \
    \    img {\
    \      max-width: 100%;\
    \      height: auto;\
    \      display: block;\
    \      margin: 1em auto;\
    \    }\
    \    \
    \    pre {\
    \      background: #272822;\
    \      color: #f8f8f2;\
    \      padding: 1em;\
    \      overflow-x: auto;\
    \      border-radius: 4px;\
    \      margin: 1em 0;\
    \    }\
    \    code {\
    \      background: #f4f4f4;\
    \      padding: 0.2em 0.4em;\
    \      border-radius: 4px;\
    \    }\
    \  </style>\
    \</head>\
    \<body>\
    \<div class=\"container\">\
    \<h1>" <> someString <> "</h1>"
    <> Prelude.foldr (\x acc -> helper x <> acc) "" sections <>
    "</div>\
    \<script>\
    \  document.addEventListener('DOMContentLoaded', () => {\
    \    const allDetails = document.querySelectorAll('details');\
    \    allDetails.forEach(det => {\
    \      det.addEventListener('toggle', () => {\
    \      });\
    \    });\
    \  });\
    \</script>\
    \</body>\
    \</html>"
    where
        helper :: MainSection -> String
        helper (Paragraph (Default content))        = content
        helper (Paragraph (Bold content))           = "<strong>" <> content <> "</strong>"
        helper (Paragraph (Italic content))         = "<em>" <> content <> "</em>"
        helper (Paragraph (Underlined content))     = "<span style=\"text-decoration:underline\">" <> content <> "</span>"
        helper (Paragraph (Crossed content))        = "<s>" <> content <> "</s>"
        helper (Paragraph (CodeInline content))     = "<code>" <> content <> "</code>"
        helper (Ref url author title year access content)
            = "<a href=\"" <> url <> "\">" <> title <> "</a>"
        helper (List title content)
            = "<details><summary>" <> title <> "</summary>"
            <> "<div>" <> Prelude.foldr (\x acc -> helper x <> acc) "" content <> "</div>"
            <> "</details>"
        helper (Chap title content)
            = "<h2>" <> title <> "</h2>"
            <> Prelude.foldr (\x acc -> helper x <> acc) "" content
        helper (Link url content)
            = "<a href=\"" <> url <> "\">"
            <> Prelude.foldr (\x acc -> helper x <> acc) "" content
            <> "</a>"
        helper (Image url content)
            = "<img src=\"" <> url <> "\" alt=\""
            <> Prelude.foldr (\x acc -> helper x <> acc) "" content
            <> "\">"
        helper (Code content)
            = "<pre>"
            <> Prelude.foldr (\x acc -> helper x <> acc) "" content
            <> "</pre>"
        helper (LineBreak)
            = "<br>"