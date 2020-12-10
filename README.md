# Go-REST-CleanArchitecture-Example
Go x Echo x Docker x CleanArchitecture x REST API practice

## How to use?
1. Launching Docker
```
$ make docker-compose/up
```

2. DB Init
```
$ make mysql/init

$ make flyway/baseline

$ make flyway/migrate
```

3. Standint up backend
- localhost:8080
```
$ curl localhost8080/users
[]
```

## API Document
### GET All Users

request
```
GET /users
```

response
```
[
    {
        "id": number,
        "name": string,
        "age": number,
        "created_at": datetime,
        "updated_at": datetime
    }
]
```

### GET a user 

request
```
GET /user/:id
```

response
```
{
    "id": number,
    "name": string,
    "age": number,
    "created_at": datetime,
    "updated_at": datetime
}
```

### Create a user

request
```
POST /users
```


### Update a user

request
```
PUT /users/:id
```
```
{
    "name": string,
    "age": number
}
```

response
```
{
    "id": number,
    "name": string,
    "age": number,
    "created_at": datetime,
    "updated_at": datetime
}
```

### Delete a user

request
``` 
DELETE /users/:id
```

response
```
{
    "id": number,
    "name": string,
    "age": number,
    "created_at": datetime,
    "updated_at": datetime
}
```




## References
- [Go×Echo×MySQL×Docker×Clean ArchitectureでAPIサーバー構築してみた](https://qiita.com/Le0tk0k/items/c2945c260f28f7ee2d47)
- https://github.com/Le0tk0k/go-rest-api
