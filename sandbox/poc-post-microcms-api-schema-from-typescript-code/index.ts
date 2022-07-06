import { readFileSync } from "fs";
import * as ts from "typescript";

const fileName = "type.ts";

const reqBodyForPostAPISchema = ts
  .createSourceFile(fileName, readFileSync(fileName).toString(), ts.ScriptTarget.ESNext, true)
  .getChildAt(0)
  .getChildren()
  .filter((child) => child.kind === ts.SyntaxKind.TypeAliasDeclaration)
  .map((dec) => {
    const decChildren = dec.getChildren();

    const apiId = decChildren
      .find((c) => c.kind === ts.SyntaxKind.Identifier)
      ?.getText()
      .toLowerCase();

    const typeLiteral = decChildren.find((c) => c.kind === ts.SyntaxKind.TypeLiteral);

    const fields = typeLiteral
      ?.getChildren()
      .find((c) => c.kind === ts.SyntaxKind.SyntaxList)
      ?.getChildren()
      .map((f) => {
        const cs = f.getChildren();

        const fieldId = cs.find((c) => c.kind === ts.SyntaxKind.Identifier)?.getText();

        const isString = Boolean(cs.find((c) => c.kind === ts.SyntaxKind.StringKeyword));
        const isBoolean = Boolean(cs.find((c) => c.kind === ts.SyntaxKind.BooleanKeyword));

        return { fieldId, type: isString ? "string" : isBoolean ? "boolean" : "unknown" };
      });

    return { apiId, fields };
  });

console.log(JSON.stringify({ reqBodyForPostAPISchema }, null, 2));

/*
$ tsc index.ts && node index.js
{
  "reqBodyForPostAPISchema": [
    {
      "apiId": "blog",
      "fields": [
        {
          "fieldId": "title",
          "type": "string"
        },
        {
          "fieldId": "special",
          "type": "boolean"
        }
      ]
    }
  ]
}
*/
