# bg-api

This is a REST api that powers the site about our personal board game collection.

## Tech
The code is written in Haskell, using [Servant](http://haskell-servant.readthedocs.io/en/stable/index.html)

## Usage

### Download Stack
Download and install [Stack](https://docs.haskellstack.org/en/stable/README/#how-to-install).

Stack should take care of installing other Haskell-related dependencies including the GHC compiler.

### Build
Once Stack is installed, `cd` to the project directory and run
```
stack build
```
which should download/configure/build all of the necessary dependencies. The first build will likely take a while.

### Initialize the database
Assuming you have a local postgres instance, run the following
```
createdb bg
cat data/*.sql | psql -d bg
```

### Run
Once built successfully, run the server locally with
```
stack exec bg-api-exe
```
It will be served at `http://localhost:8080`. To query it
```
curl http://localhost:8080/games
```
