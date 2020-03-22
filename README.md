# books

## Database setup

* install docker
* install docker-compose
* install python >= 3.7
* install python tool to load data into ES ```pip install elasticsearch-loader```

### start docker images
First time will download images.
```
docker-compose -f es/compose.yml up
```
Now you should have
- Elasticsearch running on port 9200 with CORS from localhost enabled
- Kibana running on port 6501 to inspect the Elasticsearch instance

### create the index and load the data
Put data as file or link `./es/books.json`.
```
scripts/recreate-index.sh
scripts/load-data.sh
```

## Project setup
```
yarn install
```

### Compiles and hot-reloads for development
```
yarn serve
```

### Compiles and minifies for production
```
yarn build
```

### Lints and fixes files
```
yarn lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
