import express from "express";
import awsServerlessExpress from "aws-serverless-express";
import * as lambda from "aws-lambda";
import * as http from "http";

const app: express.Express = express();

app.use(express.json());

app.post("/", (_: express.Request, res: express.Response) => {
  res.status(200).send("Hello, webhook!");
});

const server: http.Server = awsServerlessExpress.createServer(app);

export const handler = (event: lambda.APIGatewayProxyEvent, context: lambda.Context) => {
  awsServerlessExpress.proxy(server, event, context);
};
