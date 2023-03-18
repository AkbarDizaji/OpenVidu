# OpenVidu
This repository is a sample code of OpenVidu, which includes the following features:
- Clean architecture for better development and maintenance
- Some concepts of Domain Driven Design
- CQRS to separate commands and queries (just in the application layer. separating DBs can suppose as technical debt)
- Sonarcube for static code analysis
- MongoDB for persistence
- GRPC to create a session
- REST API to create a connection
- Webhook for additional pieces of information which come after the session ends
- Integration and unit tests (should be more than what is exist)

## How to use it?
1- Run this command to pull and start the image of OpenVidu server:
> docker run -p 4443:4443 --rm -e OPENVIDU_WEBHOOK=true -e OPENVIDU_WEBHOOK_ENDPOINT=https://host.docker.internal:7270/Session/webhook -e OPENVIDU_WEBHOOK_HEADERS=["\"Authorization: Basic T1BFTlZJRFVBUFA6TVlfU0VDUkVU\""] -e OPENVIDU_WEBHOOK_EVENTS=["sessionCreated","sessionDestroyed","recordingStatusChanged"] openvidu/openvidu-dev:2.25.0

2- Start your MongoDB

3- Run my application. Pay attention that you should run both of Presentation and Presentation.GRPC . If you use Visual Studio you can use "Multiple Startup Project".

4- Enjoy it:)

## Technical Debts
- Write more unit and integration test.
- Calling external APIs should be in seprate interface and class (now they are in commands)
- Use docker compose to easier run
- resolve all SonarQube's reccommendations (now just critical tips were resolved)
