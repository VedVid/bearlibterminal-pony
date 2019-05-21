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
use @terminal_read_str8[I32](x: I32, y: I32, buffer: Pointer[U8 val] tag, max: I32)
use @terminal_delay[None](period: I32)
use @terminal_get8[Pointer[U8 val] tag](key: Pointer[U8 val] tag, def: Pointer[U8 val] tag)
use @color_from_name8[U32](name: Pointer[U8 val] tag)
use @color_from_argb[U32](a: U8, r: U8, g: U8, b: U8)


// Constants
class TK
  // Scan codes for events/states
  let _a: I32 = 0x04
  let _b: I32 = 0x05
  let _c: I32 = 0x06
  let _d: I32 = 0x07
  let _e: I32 = 0x08
  let _f: I32 = 0x09
  let _g: I32 = 0x0A
  let _h: I32 = 0x0B
  let _i: I32 = 0x0C
  let _j: I32 = 0x0D
  let _k: I32 = 0x0E
  let _l: I32 = 0x0F
  let _m: I32 = 0x10
  let _n: I32 = 0x11
  let _o: I32 = 0x12
  let _p: I32 = 0x13
  let _q: I32 = 0x14
  let _r: I32 = 0x15
  let _s: I32 = 0x16
  let _t: I32 = 0x17
  let _u: I32 = 0x18
  let _v: I32 = 0x19
  let _w: I32 = 0x1A
  let _x: I32 = 0x1B
  let _y: I32 = 0x1C
  let _z: I32 = 0x1D

  let _n1: I32 = 0x1E
  let _n2: I32 = 0x1F
  let _n3: I32 = 0x20
  let _n4: I32 = 0x21
  let _n5: I32 = 0x22
  let _n6: I32 = 0x23
  let _n7: I32 = 0x24
  let _n8: I32 = 0x25
  let _n9: I32 = 0x26
  let _n0: I32 = 0x27

  let _return:     I32 = 0x28
  let _enter :     I32 = 0x28
  let _escape:     I32 = 0x29
  let _backspace:  I32 = 0x2A
  let _tab:        I32 = 0x2B
  let _space:      I32 = 0x2C
  let _minus:      I32 = 0x2D //  -  //
  let _equals:     I32 = 0x2E //  =  //
  let _lbracket:   I32 = 0x2F //  [  //
  let _rbracket:   I32 = 0x30 //  ]  //
  let _backslash:  I32 = 0x31 //  \  //
  let _semicolon:  I32 = 0x33 //  ;  //
  let _apostrophe: I32 = 0x34 //  '  //
  let _grave:      I32 = 0x35 //  `  //
  let _comma:      I32 = 0x36 //  ,  //
  let _period:     I32 = 0x37 //  .  //
  let _slash:      I32 = 0x38 //  /  //

  let _f1:  I32 = 0x3A
  let _f2:  I32 = 0x3B
  let _f3:  I32 = 0x3C
  let _f4:  I32 = 0x3D
  let _f5:  I32 = 0x3E
  let _f6:  I32 = 0x3F
  let _f7:  I32 = 0x40
  let _f8:  I32 = 0x41
  let _f9:  I32 = 0x42
  let _f10: I32 = 0x43
  let _f11: I32 = 0x44
  let _f12: I32 = 0x45

  let _pause:    I32 = 0x48 // Pause/Break
  let _insert:   I32 = 0x49
  let _home:     I32 = 0x4A
  let _pageup:   I32 = 0x4B
  let _delete:   I32 = 0x4C
  let _end:      I32 = 0x4D
  let _pagedown: I32 = 0x4E

  let _right: I32 = 0x4F // Right arrow
  let _left:  I32 = 0x50 // Left arrow
  let _down:  I32 = 0x51 // Down arrow
  let _up:    I32 = 0x52 // Up arrow

  let _kp_divide:   I32 = 0x54 // '/' on numpad
  let _kp_multiply: I32 = 0x55 // '*' on numpad
  let _kp_minus:    I32 = 0x56 // '-' on numpad
  let _kp_plus:     I32 = 0x57 // '+' on numpad
  let _kp_enter:    I32 = 0x58

  let _kp_1: I32 = 0x59
  let _kp_2: I32 = 0x5A
  let _kp_3: I32 = 0x5B
  let _kp_4: I32 = 0x5C
  let _kp_5: I32 = 0x5D
  let _kp_6: I32 = 0x5E
  let _kp_7: I32 = 0x5F
  let _kp_8: I32 = 0x60
  let _kp_9: I32 = 0x61
  let _kp_0: I32 = 0x62

  let _kp_period: I32 = 0x63 // '.' on numpad
  
  let _shift:   I32 = 0x70
  let _control: I32 = 0x71
  let _alt:     I32 = 0x72

  // Mouse events/states
  let _mouse_left:    I32 = 0x80 // Buttons
  let _mouse_right:   I32 = 0x81
  let _mouse_middle:  I32 = 0x82
  let _mouse_x1:      I32 = 0x83
  let _mouse_x2:      I32 = 0x84
  let _mouse_move:    I32 = 0x85 // Movement event
  let _mouse_scroll:  I32 = 0x86 // Mouse scroll event
  let _mouse_x:       I32 = 0x87 // Curson position in cells
  let _mouse_y:       I32 = 0x88
  let _mouse_pixel_x: I32 = 0x89 // Curson position in pixels
  let _mouse_pixel_y: I32 = 0x8A
  let _mouse_wheel:   I32 = 0x8B // Scroll direction and amount
  let _mouse_clocks:  I32 = 0x8C // Number of consecutive clicks

  // If key was released instead of pressed,
  // its key will be OR'ed with _key_released:
  // a) pressed 'A': 0x04
  // b) released 'A': 0x04|_key_released = 0x104
  let _key_released: I32 = 0x100

  // Virtual key codes for internal terminal states/variables.
  // These can be accessed via terminal_state function.
  let _width:       I32 = 0xC0
  let _height:      I32 = 0xC1
  let _cell_width:  I32 = 0xC2
  let _cell_height: I32 = 0xC3
  let _color:       I32 = 0xC4
  let _bkcolor:     I32 = 0xC5
  let _layer:       I32 = 0xC6
  let _composition: I32 = 0xC7
  let _char:        I32 = 0xC8
  let _wchar:       I32 = 0xC9
  let _event:       I32 = 0xCA
  let _fullscreen:  I32 = 0xCB

  // Other events
  let _close:   I32 = 0xE0
  let _resided: I32 = 0xE1

  // Generic mode enum.
  // Right now it is used for composition option only.
  let _off: I32 = 0
  let _on:  I32 = 1

  // Input result codes for terminal_read function.
  let _input_none:      I32 = 0
  let _input_cancelled: I32 = -1

  let _align_default: I32 = 0
  let _align_left:    I32 = 1
  let _align_right:   I32 = 2
  let _align_center:  I32 = 3
  let _align_top:     I32 = 4
  let _align_bottom:  I32 = 8
  let _align_middle:  I32 = 12
