# Simple C/R/U/D Web Application

This portfolio entry is currently incomplete, but it is meant to eventually be a web app with the following features:
* On startup, the server instantiates a new relational database if one does not already exist in the expected location.
* The server serves a front-end UI to a client, via which the end user can:
	* non-destructively navigate the database,
	* submit requests to the server for creating, reading, updating, or destroying tables and entries in the database, and
	* see the server's responses to the requests.
* The server reacts to the requests from the end user, by 1) performing the requested action if appropriate and 2) sending an appropriate response to the client.

> Note: There are some features that a real-world system should have, but that I am regarding as beyond the scope of what this portfolio entry is meant to be. Examples of such features are efficiency, robustness against malicious agents, input validation, end-to-end encryption, and the ability to serve multiple clients at once.
