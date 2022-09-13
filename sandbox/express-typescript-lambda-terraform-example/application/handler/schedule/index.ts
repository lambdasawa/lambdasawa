import * as lambda from "aws-lambda";

export const handler = (event: lambda.EventBridgeEvent<string, unknown>, context: lambda.Context) => {
  console.log(JSON.stringify(event));
};
