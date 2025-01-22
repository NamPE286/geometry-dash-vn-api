// @ts-types="@types/express"
import express from "express";
import user from "#src/routers/user.ts";
import func from "#src/routers/func.ts";
import userAuth from "#src/middleware/userAuth.ts";

const app = express();

app.use(express.json());
app.use((req, res, next) => {
    res.on("finish", function () {
        console.log(`[${new Date().toLocaleString()}]`, req.method, req.path, res.statusCode);
    });

    next();
});

app.get("/", (_req, res) => {
    res.send({
        timestamp: new Date(),
    });
});

app.use(userAuth);

app.use("/user", user);
app.use("/func", func);

app.listen(8000, () => {
    console.log("Server started on port 8000");
});
