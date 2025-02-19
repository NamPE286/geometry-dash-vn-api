// @ts-types="@types/express"
import express from "express";
import { supabase } from "#src/supabase.ts";

const router = express.Router();

router.patch("/refresh", async (_req, res) => {
    const { user } = res.locals;

    if (user.role != "admin") {
        res.status(403).send();
        return;
    }

    const { error } = await supabase.rpc("refresh");

    if (error) {
        console.error(error);
        res.status(500).send();
        
        return;
    }

    res.status(200).send();
});

export default router;
