import type { Tables } from "./supabase.ts";

declare global {
    namespace Express {
        interface Locals {
            user: Tables<"users"> & { user_role: Tables<"user_role"> };
            authType: "token" | "key";
            user_id: string;
        }
    }
}
