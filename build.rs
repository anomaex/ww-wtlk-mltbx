fn main() {
    let mut res = winres::WindowsResource::new();
    res.set_icon("ui/assets/icon.ico");
    res.compile().unwrap();

    slint_build::compile("ui/main_window.slint").expect("Slint build failed");
}
