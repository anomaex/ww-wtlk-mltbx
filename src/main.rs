// Prevent console window in addition to Slint window in Windows release builds when, e.g., starting the app via file manager. Ignored on other platforms.
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use anyhow::{Context, Ok, Result};
use rfd::FileDialog;
use slint::SharedString;

slint::include_modules!();


#[tokio::main]
async fn main() -> Result<()> {
    let main_window = MainWindow::new().context("Can't create main window.")?;
    
    let main_window_handle = main_window.as_weak();

    main_window.on_game_browse(move |field| {
        if let Some(path) = FileDialog::new()
            .add_filter("Executable", &["exe"])
            .pick_file()
        {
            if let Some(ui) = main_window_handle.upgrade() {
                let path_str = SharedString::from(
                    path.to_string_lossy().to_string()
                );

                match field {
                    0 => {
                        ui.set_main_game_path(path_str);
                    },
                    1 => {
                        ui.set_other_game_path(path_str);
                    },
                    _ => {}
                }
            }
        }
    });

    main_window.run().context("Can't run main window.")?;
    Ok(())
}
