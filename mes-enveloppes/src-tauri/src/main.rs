// Pas de fenêtre de console en plus de l'appli sous Windows
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

fn main() {
    mes_enveloppes_lib::run()
}
