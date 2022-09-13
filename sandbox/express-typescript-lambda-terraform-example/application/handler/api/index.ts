import express from "express";
import awsServerlessExpress from "aws-serverless-express";
import * as lambda from "aws-lambda";
import * as http from "http";

const app: express.Express = express();

app.use(express.json());

app.get("/", (_: express.Request, res: express.Response) => {
  res.status(200).send({
    message: "Hello api!",
  });
});

app.get("/random", (_: express.Request, res: express.Response) => {
  res.status(200).send({
    random: Math.random(),
  });
});

app.get("/error", (_: express.Request, res: express.Response) => {
  process.exit(1);
});

const server: http.Server = awsServerlessExpress.createServer(app);

export const handler = (event: lambda.APIGatewayProxyEvent, context: lambda.Context) => {
  awsServerlessExpress.proxy(server, event, context);
};
