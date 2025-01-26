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

router.patch("/", async (req, res) => {
    const { user } = res.locals;

    if (!user.user_role.modify_level) {
        res.status(403).send();
        return;
    }

    const { error } = await supabase
        .from("levels")
        .update(req.body)
        .eq("id", req.body.id);

    if (error) {
        console.error(error);
        res.status(500).send();
        return;
    }

    res.status(200).send();
});

router.delete("/", async (req, res) => {
    const { user } = res.locals;

    if (!user.user_role.delete_level) {
        res.status(403).send();
        return;
    }

    const { error } = await supabase
        .from("levels")
        .delete()
        .eq("id", req.body.id);

    if (error) {
        console.error(error);
        res.status(500).send();
        return;
    }

    res.status(200).send();
});

export default router;
