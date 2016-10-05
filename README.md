# bg-api

This is a REST api that powers the site about our personal board game collection.

## Tech
The code is written in Haskell, using [Servant](http://haskell-servant.readthedocs.io/en/stable/index.html)

## Getting started
Download and install [Stack](https://docs.haskellstack.org/en/stable/README/#how-to-install).

Stack should take care of installing other Haskell-related dependencies including the GHC compiler.

Once Stack is installed, `cd` to the project directory and run

  stack build

which should download/configure/build all of the necessary dependencies. The first build will likely take a while.

Once built successfully, run the server locally with

  stack exec bg-api-exe

It will be served at `http://localhost:8080`. To query it

  curl http://localhost:8080/games
