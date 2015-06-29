require "./probe-stap/*"

# Generates a Systemtap probe given a name and variadic arguments the provider is 'crystal'
# to listen for an emitted probe
#
# crystal.stp
# probe process("crystal").mark("thename") {
#     printf("%s\n", user_string($arg1))
# }
macro probe_stap_emit(name, *args)
  {% for arg, index in args %}
    %argument_inner{arg} = {{ arg }}.cstr
  {% end %}

  asm("
  990:    nop
          .pushsection .note.stapsdt,\"?\",\"note\"
          .balign 4
          .4byte 992f-991f, 994f-993f, 3
  991:    .asciz \"stapsdt\"
  992:    .balign 4
  993:    .8byte 990b
          .8byte _.stapsdt.base
          .8byte 0
          .asciz \"crystal\"
          .asciz \"{{ name }}\"
          .asciz \"{% for x, i in args %} -8@${{i}}{% end %}\"
  994:    .balign 4
          .popsection
  .ifndef _.stapsdt.base
          .pushsection .stapsdt.base,\"aG\",\"progbits\",.stapsdt.base,comdat
          .weak _.stapsdt.base
          .hidden _.stapsdt.base
  _.stapsdt.base: .space 1
          .size _.stapsdt.base, 1
          .popsection
  .endif
  " : : {% for arg, index in args %}{% if index != 0 %},{% end %} "r"( %argument_inner{arg} ){% end %})
end
