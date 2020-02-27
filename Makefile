.PHONY: deps clean build

deps:
	go get -u ./...

clean: 
	rm -rf ./functions/admin_only/admin_only
	rm -rf ./functions/all_members/all_members
	
build:
	GOOS=linux GOARCH=amd64 go build -gcflags='-N -l' -o functions/admin_only ./functions/admin_only
	GOOS=linux GOARCH=amd64 go build -gcflags='-N -l' -o functions/all_members ./functions/all_members