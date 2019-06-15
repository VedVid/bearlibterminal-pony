// Import BearLibTerminal library
use "lib:BearLibTerminal"


// Initialization and configuration
use @terminal_open[I32]()
use @terminal_close[None]()
use @terminal_set8[I32](value: Pointer[U8 val] tag)


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


class Terminal
  // Scan codes for events/states
  let tk_a: I32 = 0x04
  let tk_b: I32 = 0x05
  let tk_c: I32 = 0x06
  let tk_d: I32 = 0x07
  let tk_e: I32 = 0x08
  let tk_f: I32 = 0x09
  let tk_g: I32 = 0x0A
  let tk_h: I32 = 0x0B
  let tk_i: I32 = 0x0C
  let tk_j: I32 = 0x0D
  let tk_k: I32 = 0x0E
  let tk_l: I32 = 0x0F
  let tk_m: I32 = 0x10
  let tk_n: I32 = 0x11
  let tk_o: I32 = 0x12
  let tk_p: I32 = 0x13
  let tk_q: I32 = 0x14
  let tk_r: I32 = 0x15
  let tk_s: I32 = 0x16
  let tk_t: I32 = 0x17
  let tk_u: I32 = 0x18
  let tk_v: I32 = 0x19
  let tk_w: I32 = 0x1A
  let tk_x: I32 = 0x1B
  let tk_y: I32 = 0x1C
  let tk_z: I32 = 0x1D

  let tk_1: I32 = 0x1E
  let tk_2: I32 = 0x1F
  let tk_3: I32 = 0x20
  let tk_4: I32 = 0x21
  let tk_5: I32 = 0x22
  let tk_6: I32 = 0x23
  let tk_7: I32 = 0x24
  let tk_8: I32 = 0x25
  let tk_9: I32 = 0x26
  let tk_0: I32 = 0x27

  let tk_return:     I32 = 0x28
  let tk_enter :     I32 = 0x28
  let tk_escape:     I32 = 0x29
  let tk_backspace:  I32 = 0x2A
  let tk_tab:        I32 = 0x2B
  let tk_space:      I32 = 0x2C
  let tk_minus:      I32 = 0x2D //  -  //
  let tk_equals:     I32 = 0x2E //  =  //
  let tk_lbracket:   I32 = 0x2F //  [  //
  let tk_rbracket:   I32 = 0x30 //  ]  //
  let tk_backslash:  I32 = 0x31 //  \  //
  let tk_semicolon:  I32 = 0x33 //  ;  //
  let tk_apostrophe: I32 = 0x34 //  '  //
  let tk_grave:      I32 = 0x35 //  `  //
  let tk_comma:      I32 = 0x36 //  ,  //
  let tk_period:     I32 = 0x37 //  .  //
  let tk_slash:      I32 = 0x38 //  /  //

  let tk_f1:  I32 = 0x3A
  let tk_f2:  I32 = 0x3B
  let tk_f3:  I32 = 0x3C
  let tk_f4:  I32 = 0x3D
  let tk_f5:  I32 = 0x3E
  let tk_f6:  I32 = 0x3F
  let tk_f7:  I32 = 0x40
  let tk_f8:  I32 = 0x41
  let tk_f9:  I32 = 0x42
  let tk_f10: I32 = 0x43
  let tk_f11: I32 = 0x44
  let tk_f12: I32 = 0x45

  let tk_pause:    I32 = 0x48 // Pause/Break
  let tk_insert:   I32 = 0x49
  let tk_home:     I32 = 0x4A
  let tk_pageup:   I32 = 0x4B
  let tk_delete:   I32 = 0x4C
  let tk_end_key:  I32 = 0x4D
  let tk_pagedown: I32 = 0x4E

  let tk_right: I32 = 0x4F // Right arrow
  let tk_left:  I32 = 0x50 // Left arrow
  let tk_down:  I32 = 0x51 // Down arrow
  let tk_up:    I32 = 0x52 // Up arrow

  let tk_kp_divide:   I32 = 0x54 // '/' on numpad
  let tk_kp_multiply: I32 = 0x55 // '*' on numpad
  let tk_kp_minus:    I32 = 0x56 // '-' on numpad
  let tk_kp_plus:     I32 = 0x57 // '+' on numpad
  let tk_kp_enter:    I32 = 0x58

  let tk_kp_1: I32 = 0x59
  let tk_kp_2: I32 = 0x5A
  let tk_kp_3: I32 = 0x5B
  let tk_kp_4: I32 = 0x5C
  let tk_kp_5: I32 = 0x5D
  let tk_kp_6: I32 = 0x5E
  let tk_kp_7: I32 = 0x5F
  let tk_kp_8: I32 = 0x60
  let tk_kp_9: I32 = 0x61
  let tk_kp_0: I32 = 0x62

  let tk_kp_period: I32 = 0x63 // '.' on numpad
  
  let tk_shift:   I32 = 0x70
  let tk_control: I32 = 0x71
  let tk_alt:     I32 = 0x72

  // Mouse events/states
  let tk_mouse_left:    I32 = 0x80 // Buttons
  let tk_mouse_right:   I32 = 0x81
  let tk_mouse_middle:  I32 = 0x82
  let tk_mouse_x1:      I32 = 0x83
  let tk_mouse_x2:      I32 = 0x84
  let tk_mouse_move:    I32 = 0x85 // Movement event
  let tk_mouse_scroll:  I32 = 0x86 // Mouse scroll event
  let tk_mouse_x:       I32 = 0x87 // Curson position in cells
  let tk_mouse_y:       I32 = 0x88
  let tk_mouse_pixel_x: I32 = 0x89 // Curson position in pixels
  let tk_mouse_pixel_y: I32 = 0x8A
  let tk_mouse_wheel:   I32 = 0x8B // Scroll direction and amount
  let tk_mouse_clocks:  I32 = 0x8C // Number of consecutive clicks

  // If key was released instead of pressed,
  // its key will be OR'ed with _key_released:
  // a) pressed 'A': 0x04
  // b) released 'A': 0x04|_key_released = 0x104
  let tk_key_released: I32 = 0x100

  // Virtual key codes for internal terminal states/variables.
  // These can be accessed via terminal_state function.
  let tk_width:       I32 = 0xC0
  let tk_height:      I32 = 0xC1
  let tk_cell_width:  I32 = 0xC2
  let tk_cell_height: I32 = 0xC3
  let tk_color:       I32 = 0xC4
  let tk_bkcolor:     I32 = 0xC5
  let tk_layer:       I32 = 0xC6
  let tk_composition: I32 = 0xC7
  let tk_char:        I32 = 0xC8
  let tk_wchar:       I32 = 0xC9
  let tk_event:       I32 = 0xCA
  let tk_fullscreen:  I32 = 0xCB

  // Other events
  let tk_close:   I32 = 0xE0
  let tk_resided: I32 = 0xE1

  // Generic mode enum.
  // Right now it is used for composition option only.
  let tk_off: I32 = 0
  let tk_on:  I32 = 1

  // Input result codes for terminal_read function.
  let tk_input_none:      I32 = 0
  let tk_input_cancelled: I32 = -1

  let tk_align_default: I32 = 0
  let tk_align_left:    I32 = 1
  let tk_align_right:   I32 = 2
  let tk_align_center:  I32 = 3
  let tk_align_top:     I32 = 4
  let tk_align_bottom:  I32 = 8
  let tk_align_middle:  I32 = 12

  // Initialization and configuration
  fun open(): I32 =>
    @terminal_open()

  fun close() =>
    @terminal_close()

  //change it to return I8 or to use terminal_set32 ???
  fun set(value: String): I32 =>
    @terminal_set8(value.cstring())

  //Output state
  fun color(col: String) =>
    let col_u: U32 = color_from_name_8(col)
    @terminal_color(col_u)

  fun bk_color(col: U32) =>
    @terminal_bkcolor(col)

  fun composition(mode: I32) =>
    @terminal_composition(mode)

  fun layer(index: I32) =>
    @terminal_layer(index)

  fun font(name: String) =>
    @terminal_font(name.cstring())

  //Output
  fun clear() =>
    @terminal_clear()

  fun clear_area(x: I32, y: I32, w: I32, h: I32) =>
    @terminal_clear_area(x, y, w, h)

  fun crop(x: I32, y: I32, w: I32, h: I32) =>
    @terminal_crop(x, y, w, h)

  fun refresh() =>
    @terminal_refresh()

  fun put(x: I32, y: I32, code: I32) =>
    @terminal_put(x, y, code)

  //DO NOT USE: corners needs more work and are unsafe to use now
  fun put_ext(x: I32, y: I32, dx: I32, dy: I32, code: I32, corners: Array[U32]) =>
    @terminal_put_ext(x, y, dx, dy, code, corners)

  fun pick(x: I32, y: I32, index: I32): I32 =>
    @terminal_pick(x, y, index)

  fun pick_color(x: I32, y: I32, index: I32): U32 =>
    @terminal_pick_color(x, y, index)

  fun pick_bkcolor(x: I32, y: I32): U32 =>
    @terminal_pick_bkcolor(x, y)

  fun print_ext_8(x: I32, y: I32, w: I32, h: I32, alignment: I32, s: String) =>
    var out_h: I32 = 0
    var out_w: I32 = 0
    @terminal_print_ext8(x, y, w, h, alignment, s.cstring(), addressof out_h, addressof out_w)

  fun print(x: I32, y: I32, s: String) =>
    print_ext_8(x, y, 0, 0, tk_align_default, s)

  fun measure_ext_8(w: I32, h: I32, s: Pointer[U8 val] tag, out_w: Pointer[I32], out_h: Pointer[I32]) =>
    @terminal_measure_ext8(w, h, s, out_w, out_h)

  //Input
  fun state(code: I32): I32 =>
    @terminal_state(code)

  fun check(code: I32): I32 =>
    @terminal_check(code)

  fun has_input(): I32 =>
    @terminal_has_input()

  fun read(): I32 =>
    @terminal_read()

  fun peek(): I32 =>
    @terminal_peek()

  fun read_str_8(x: I32, y: I32, buffer: Pointer[U8 val] tag, out_w: Pointer[I32], out_h: Pointer[I32]): I32 =>
    @terminal_read_str8(x, y, buffer, out_w, out_h)

  fun delay(period: I32) =>
    @terminal_delay(period)

  //DO NOT USE: I don't know if string() is proper way to convert pointer
  fun get_8(key: Pointer[U8 val] tag, def: Pointer[U8 val] tag): Pointer[U8 val] tag =>
    @terminal_get8(key, def)

  fun color_from_name_8(name: String): U32 =>
    @color_from_name8(name.cstring())

  fun color_from_argb_8(a: U8, r: U8, g: U8, b: U8): U32 =>
    @color_from_argb(a, r, g, b)
