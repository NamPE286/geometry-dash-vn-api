// @ts-types="@types/express"
import express from "express";
import { supabase } from "#src/supabase.ts";

const router = express.Router();

router.post("/", async (req, res) => {
    const { user } = res.locals;

    if (!user.user_role.add_level) {
        res.status(403).send();
        return;
    }

    const { error } = await supabase
        .from("levels")
        .insert(req.body);

    if (error) {
        console.error(error);
        res.status(500).send();

        return;
    }

    res.status(201).send();
});

export default router;
