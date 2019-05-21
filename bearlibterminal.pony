// Import BearLibTerminal library
use "lib:BearLibTerminal"


// Initialization and configuration
use @terminal_open[I32]()
use @terminal_close[None]()
use @terminal_set[I32](value: Pointer[U8 val] tag)


// Output state
use @terminal_color[None](color: U32)
use @terminal_bkcolor[None](color: U32)
use @terminal_composition[None](mode: I32)
use @terminal_layer[None](index: I32)
use @terminal_font[None](name: Pointer[U8 val] tag)


// Output
use @terminal_clear[None]()
use @terminal_clear_area[None](x: I32, y: I32, w: I32, h: I32)
use @terminal_crop[None](x: I32, y: I32, w: I32, h: I32)
use @terminal_refresh[None]()
use @terminal_put[None](x: I32, y: I32, code: I32)
use @terminal_put_ext[None](x: I32, y: I32, dx: I32, dy: I32, code: I32, corners: Array[U32])
use @terminal_pick[I32](x: I32, y: I32, index: I32)
use @terminal_pick_color[U32](x: I32, y: I32, index: I32)
use @terminal_pick_bkcolor[U32](x: I32, y: I32)
use @terminal_print_ext8[None](x: I32, y: I32, w: I32, h: I32, alignment: I32, s: Pointer[U8 val] tag, out_w: Pointer[I32], out_h: Pointer[I32])
use @terminal_measure_ext8[None](w: I32, h: I32, s: Pointer[U8 val] tag, out_w: Pointer[I32], out_h: Pointer[I32])

// Input
use @terminal_state[I32](code: I32)
use @terminal_check[I32](code: I32)
use @terminal_has_input[I32]()
use @terminal_read[I32]()
use @terminal_peek[I32]()
use @terminal_read_str8[I32](x: I32, y: I32, buffer: Pointer[U8 val] tag, out_w: Pointer[I32], out_h: Pointer[I32])
use @terminal_delay[None](period: I32)
use @terminal_get8[Pointer[U8 val] tag](key: Pointer[U8 val] tag, def: Pointer[U8 val] tag)
use @color_from_name8[U32](name: Pointer[U8 val] tag)
use @color_from_argb[U32](a: U8, r: U8, g: U8, b: U8)


struct Dimensions
  let width: I32
  let height: I32
  new create(width': I32, height': I32) =>
    width = width'
    height = height'


// Constants
class TK
  // Scan codes for events/states
  let a: I32 = 0x04
  let b: I32 = 0x05
  let c: I32 = 0x06
  let d: I32 = 0x07
  let e: I32 = 0x08
  let f: I32 = 0x09
  let g: I32 = 0x0A
  let h: I32 = 0x0B
  let i: I32 = 0x0C
  let j: I32 = 0x0D
  let k: I32 = 0x0E
  let l: I32 = 0x0F
  let m: I32 = 0x10
  let n: I32 = 0x11
  let o: I32 = 0x12
  let p: I32 = 0x13
  let q: I32 = 0x14
  let r: I32 = 0x15
  let s: I32 = 0x16
  let t: I32 = 0x17
  let u: I32 = 0x18
  let v: I32 = 0x19
  let w: I32 = 0x1A
  let x: I32 = 0x1B
  let y: I32 = 0x1C
  let z: I32 = 0x1D

  let n1: I32 = 0x1E
  let n2: I32 = 0x1F
  let n3: I32 = 0x20
  let n4: I32 = 0x21
  let n5: I32 = 0x22
  let n6: I32 = 0x23
  let n7: I32 = 0x24
  let n8: I32 = 0x25
  let n9: I32 = 0x26
  let n0: I32 = 0x27

  let return_key: I32 = 0x28
  let enter :     I32 = 0x28
  let escape:     I32 = 0x29
  let backspace:  I32 = 0x2A
  let tab:        I32 = 0x2B
  let space:      I32 = 0x2C
  let minus:      I32 = 0x2D //  -  //
  let equals:     I32 = 0x2E //  =  //
  let lbracket:   I32 = 0x2F //  [  //
  let rbracket:   I32 = 0x30 //  ]  //
  let backslash:  I32 = 0x31 //  \  //
  let semicolon:  I32 = 0x33 //  ;  //
  let apostrophe: I32 = 0x34 //  '  //
  let grave:      I32 = 0x35 //  `  //
  let comma:      I32 = 0x36 //  ,  //
  let period:     I32 = 0x37 //  .  //
  let slash:      I32 = 0x38 //  /  //

  let f1:  I32 = 0x3A
  let f2:  I32 = 0x3B
  let f3:  I32 = 0x3C
  let f4:  I32 = 0x3D
  let f5:  I32 = 0x3E
  let f6:  I32 = 0x3F
  let f7:  I32 = 0x40
  let f8:  I32 = 0x41
  let f9:  I32 = 0x42
  let f10: I32 = 0x43
  let f11: I32 = 0x44
  let f12: I32 = 0x45

  let pause:    I32 = 0x48 // Pause/Break
  let insert:   I32 = 0x49
  let home:     I32 = 0x4A
  let pageup:   I32 = 0x4B
  let delete:   I32 = 0x4C
  let end_key:  I32 = 0x4D
  let pagedown: I32 = 0x4E

  let right: I32 = 0x4F // Right arrow
  let left:  I32 = 0x50 // Left arrow
  let down:  I32 = 0x51 // Down arrow
  let up:    I32 = 0x52 // Up arrow

  let kp_divide:   I32 = 0x54 // '/' on numpad
  let kp_multiply: I32 = 0x55 // '*' on numpad
  let kp_minus:    I32 = 0x56 // '-' on numpad
  let kp_plus:     I32 = 0x57 // '+' on numpad
  let kp_enter:    I32 = 0x58

  let kp_1: I32 = 0x59
  let kp_2: I32 = 0x5A
  let kp_3: I32 = 0x5B
  let kp_4: I32 = 0x5C
  let kp_5: I32 = 0x5D
  let kp_6: I32 = 0x5E
  let kp_7: I32 = 0x5F
  let kp_8: I32 = 0x60
  let kp_9: I32 = 0x61
  let kp_0: I32 = 0x62

  let kp_period: I32 = 0x63 // '.' on numpad
  
  let shift:   I32 = 0x70
  let control: I32 = 0x71
  let alt:     I32 = 0x72

  // Mouse events/states
  let mouse_left:    I32 = 0x80 // Buttons
  let mouse_right:   I32 = 0x81
  let mouse_middle:  I32 = 0x82
  let mouse_x1:      I32 = 0x83
  let mouse_x2:      I32 = 0x84
  let mouse_move:    I32 = 0x85 // Movement event
  let mouse_scroll:  I32 = 0x86 // Mouse scroll event
  let mouse_x:       I32 = 0x87 // Curson position in cells
  let mouse_y:       I32 = 0x88
  let mouse_pixel_x: I32 = 0x89 // Curson position in pixels
  let mouse_pixel_y: I32 = 0x8A
  let mouse_wheel:   I32 = 0x8B // Scroll direction and amount
  let mouse_clocks:  I32 = 0x8C // Number of consecutive clicks

  // If key was released instead of pressed,
  // its key will be OR'ed with _key_released:
  // a) pressed 'A': 0x04
  // b) released 'A': 0x04|_key_released = 0x104
  let key_released: I32 = 0x100

  // Virtual key codes for internal terminal states/variables.
  // These can be accessed via terminal_state function.
  let width:       I32 = 0xC0
  let height:      I32 = 0xC1
  let cell_width:  I32 = 0xC2
  let cell_height: I32 = 0xC3
  let color:       I32 = 0xC4
  let bkcolor:     I32 = 0xC5
  let layer:       I32 = 0xC6
  let composition: I32 = 0xC7
  let char:        I32 = 0xC8
  let wchar:       I32 = 0xC9
  let event:       I32 = 0xCA
  let fullscreen:  I32 = 0xCB

  // Other events
  let close:   I32 = 0xE0
  let resided: I32 = 0xE1

  // Generic mode enum.
  // Right now it is used for composition option only.
  let off: I32 = 0
  let on:  I32 = 1

  // Input result codes for terminal_read function.
  let input_none:      I32 = 0
  let input_cancelled: I32 = -1

  let align_default: I32 = 0
  let align_left:    I32 = 1
  let align_right:   I32 = 2
  let align_center:  I32 = 3
  let align_top:     I32 = 4
  let align_bottom:  I32 = 8
  let align_middle:  I32 = 12
