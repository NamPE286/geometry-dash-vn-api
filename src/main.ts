// @ts-types="@types/express"
import express from "express";
import user from "#src/routers/user.ts";
import level from "#src/routers/level.ts";
import func from "#src/routers/func.ts";
import userAuth from "#src/middleware/userAuth.ts";
import { supabase } from "#src/supabase.ts";

const app = express();

app.use(express.json());
app.use((req, res, next) => {
    res.on("finish", function () {
        console.log(`[${new Date().toLocaleString()}]`, req.method, req.path, res.statusCode);
    });

    next();
});

app.get("/health", async (_req, res) => {
    const result = {
        timestamp: new Date(),
        supabase: true,
    };
    const { error } = await supabase
        .from("user_role")
        .select("*");

    if (error) {
        result.supabase = false;
    }

    res.send(result);
});

app.use(userAuth);

app.use("/user", user);
app.use("/level", level);
app.use("/func", func);

app.listen(8000, () => {
    console.log("Server started on port 8000");
});
