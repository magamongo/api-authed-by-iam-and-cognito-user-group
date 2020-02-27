package main

import (
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {

	return events.APIGatewayProxyResponse{
		Body:       "this api can be called by admin user",
		StatusCode: 200,
	}, nil
}

func main() {
	lambda.Start(handler)
}
