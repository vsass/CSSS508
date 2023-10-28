
# Load required packages --------------------------------------------------

library(tidyverse)
library(spotifyr)

# Need to run Spotify API -------------------------------------------------

client_id <- "a82e829ff86a415781d45506cc352d00"
client_secret <- "c14b8d317ad3433e9383b341eba93db3"


# Get Access Token --------------------------------------------------------

Sys.setenv(SPOTIFY_CLIENT_ID = client_id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = client_secret)

access_token <- get_spotify_access_token()


# Retrieve playlist data --------------------------------------------------

my_id <- "126527470"
playlists_2021 <- c("1Yj7tyXf875gxNg1JFj4P7", "1Yj7tyXf875gxNg1JFj4P7", "0yyqWbEBzq6eRnSHIzU6dQ", 
                    "3peJFLTpA7Y7z2r1v5hmPP", "081UO3J8589jFjEbDsXKOO", "0Q7HpYMHNavbq9N4HHVnRJ", 
                    "4fBNMOgsFAPJq54czXRcW6", "5CBQnnMoVVrllXJm8md8sU", "0vNOEvejF3D01aKi8aIZAz", 
                    "6siPyUBCReEaBpR13mrJpz", "6vce4nYbzdBrNhpygXNS9J", "01eQEdZDDDfD6pvvuRevAA")

songs_2021 <- playlists_2021 |> 
  map(get_playlist, authorization = access_token)

jan_21 <- get_playlist("1Yj7tyXf875gxNg1JFj4P7", authorization = access_token) 
feb_21 <- get_playlist("7359SqkSRKpwZTj1MmFiha", authorization = access_token) 


jan_songs <- jan_21$tracks$items
