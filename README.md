# Pet Store Api

API based in this [OpenAPi example][open_api_example]

## Features

- List all Pets
- Create a Pet
- Show a Pet

## Tech
 - Ruby 2.7.2
 - Rails 6.1.4.1
 - Postgres 13.1
 - Docker version 20.10.8
 - Docker compose 1.29.2

## Endpoints

 - [POST] api/v1/token
 - [GET] api/v1/pets
 - [POST] api/v1/pets
 - [GET] api/v1/pets/{petId}

# Development

## Dependencies
 - Docker
 - Docker compose

## Make everything run for the first time

First of all, clone or download the zip code, you can find the [source code here][source_code].

Position yourself in the root directory of the project.

To build
```sh
docker-compose build
```

To up all containers
```sh
docker-compose up #you can use the flag -d to run the containers in background
```

Enter to the api container
```sh
docker-compose exec api bash
```

Create the development database
```sh
rails db:create
```

Create the test database
```sh
rails db:create RAILS_ENV=test
```

Run all migrations
```sh
rails db:migrate
```

For tests purposes, if you want you can run a seed
```sh
rails db:seed
```

## Testing with Rspec

Once all of the above have been executed for the first time

Enter to the api container
```sh
docker-compose exec api bash
```

Run all tests
```sh
rspec
```

## Using the Endpoinds

First of all, you need to generate a JWT. Use the endpoint `api/v1/token` to generate the JWT.

This is a simple example of the usage, `curl` will be used, but the simplest option is to use Postman.

```sh
curl --location --request POST 'localhost:3000/api/v1/token'
```

This is going to output a response like this.
> {"token":"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJJRmVhMXhlOSIsImV4cCI6MTYzMTIyNjk5N30.kpfrUxzv5vOqmN1hlaW47Cu8296Hh524ji3rQuMEL0Q"}

You need to set this token in the Authorization Header to be able to use the endpoints.
An example with curl.

```sh
curl --location --request GET 'localhost:3000/api/v1/pets' -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJJRmVhMXhlOSIsImV4cCI6MTYzMTIyNjQ1OH0.AbMbjeFVfhy8sMSrEjnaBchIh1A9V2CgW8rJaebGXjQ"
```

## Testing with Postman
You can find the [Postman Collection here][postman_collection]

## License

Apache License


[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [open_api_example]: https://github.com/OAI/OpenAPI-Specification/blob/master/examples/v3.0/petstore.yaml 
   [source_code]: https://github.com/cIvanrc/pet-store-api
   [postman_collection]: https://documenter.getpostman.com/view/5036414/U16jNmBx
