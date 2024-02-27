# Overview
This repository contains a React frontend, and an Express backend that the frontend connects to.

# Objective
Deploy the frontend and backend to somewhere publicly accessible over the internet. The AWS Free Tier should be more than sufficient to run this project, but you may use any platform and tooling you'd like for your solution.

Fork this repo as a base. You may change any code in this repository to suit the infrastructure you build in this code challenge.

#   Requirement for the project
+   AWS Services:- IAM, ECR, ECS, EC2 instances for the jenkins
+   Docker
+   Jenkins
+   Terraform
+   Nodejs dependencies (node version 16)

# Running the project
The backend and the frontend will need to run on separate processes. The backend should be started first.
```
cd backend
npm ci
npm start
```
The backend should response to a GET request on `localhost:8080`.

With the backend started, the frontend can be started.
```
cd frontend
npm ci
npm start
```
The frontend can be accessed at `localhost:3000`. If the frontend successfully connects to the backend, a message saying "SUCCESS" followed by a guid should be displayed on the screen.  If the connection failed, an error message will be displayed on the screen.

#   Task 1: Dockerization of both application (frontend and the backend) on our local machine
##  Backend application:
+   To dockerize the backend application, we can simply use **docker init** command to create a Dockerfile, .dockerignore, compose.yaml and a Readme file. 
+   The main Dockerfile for the backend application can be [here](./backend/Dockerfile)
+   We can spin up the docker container using the command

        docker compose up
+   Then we get to access the application at the url http://localhost:8080
![backend](./images/backend-app.png)

##  Frontend application
+   We can also go with the command **docker init** to help create our dockerfile and othe related files and putting in place best practices.
+   After the successful creation of the [Dockerfile](./frontend/Dockerfile), we can then spin up the docker container using the command

        docker compose up
+   We can also access the frontend application at the url path http://localhost:3000
![fronted-ui](./images/frontend-ui.png)

+   **NB**: We have both container running simultaneosly for the frontend and the backend to connect to each other. We can also notice we have thesame 'id value' from both screenshot above which shows they both connect.
    
#   Task 2: Creating an automated Github action to deploy both frontend and backend application to Elastic Container Registry (ECR)
##  Step 1: I utilized the GitHub action for the CI/CD for seamless integration and to demonstrate the workflow in a more visual format. Also, since am hosting my codebase on GitHub, it makes it easier to set up and work on.
##  A- GitHub Action pipeline
Pipeline for building, starting, dockerizing and pushing to Elastic Container Registry (ECR) - For this, i made sure the application builds and starts properly before dockerizing and pushing to ECR. The buildng of the app to docker image solely depend on application running and starting properly
##  B- 

# Submission
1. A github repo that has been forked from this repo with all your code.
2. Modify this README file with instructions for:
* Any tools needed to deploy your infrastructure
* All the steps needed to repeat your deployment process
* URLs to the your deployed frontend.

# Evaluation
You will be evaluated on the ease to replicate your infrastructure. This is a combination of quality of the instructions, as well as any scripts to automate the overall setup process.

# Setup your environment
Install nodejs. Binaries and installers can be found on nodejs.org.
https://nodejs.org/en/download/

For macOS or Linux, Nodejs can usually be found in your preferred package manager.
https://nodejs.org/en/download/package-manager/

Depending on the Linux distribution, the Node Package Manager `npm` may need to be installed separately.



# Configuration
The frontend has a configuration file at `frontend/src/config.js` that defines the URL to call the backend. This URL is used on `frontend/src/App.js#12`, where the front end will make the GET call during the initial load of the page.

The backend has a configuration file at `backend/config.js` that defines the host that the frontend will be calling from. This URL is used in the `Access-Control-Allow-Origin` CORS header, read in `backend/index.js#14`

# Optional Extras
The core requirement for this challenge is to get the provided application up and running for consumption over the public internet. That being said, there are some opportunities in this code challenge to demonstrate your skill sets that are above and beyond the core requirement.

A few examples of extras for this coding challenge:
1. Dockerizing the application
2. Scripts to set up the infrastructure
3. Providing a pipeline for the application deployment
4. Running the application in a serverless environment

This is not an exhaustive list of extra features that could be added to this code challenge. At the end of the day, this section is for you to demonstrate any skills you want to show that’s not captured in the core requirement.
