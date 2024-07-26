#![no_std]
#![no_main]

use core::{panic::PanicInfo, ffi::c_void};

#[panic_handler]
fn _handler (_info: &PanicInfo) -> ! {
    loop {}
}

#[no_mangle]
#[link_section = ".text"]
extern "C" fn _start(_r3: usize, _r4: usize, _entry: extern "C" fn(*mut c_void) -> usize) -> isize {
    loop {}
}