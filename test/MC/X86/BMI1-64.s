// RUN: llvm-mc -triple x86_64-unknown-unknown --show-encoding %s | FileCheck %s

// CHECK: andnl 485498096, %r13d, %r13d 
// CHECK: encoding: [0xc4,0x62,0x10,0xf2,0x2c,0x25,0xf0,0x1c,0xf0,0x1c]      
andnl 485498096, %r13d, %r13d 

// CHECK: andnl 64(%rdx), %r13d, %r13d 
// CHECK: encoding: [0xc4,0x62,0x10,0xf2,0x6a,0x40]      
andnl 64(%rdx), %r13d, %r13d 

// CHECK: andnl 64(%rdx,%rax,4), %r13d, %r13d 
// CHECK: encoding: [0xc4,0x62,0x10,0xf2,0x6c,0x82,0x40]      
andnl 64(%rdx,%rax,4), %r13d, %r13d 

// CHECK: andnl -64(%rdx,%rax,4), %r13d, %r13d 
// CHECK: encoding: [0xc4,0x62,0x10,0xf2,0x6c,0x82,0xc0]      
andnl -64(%rdx,%rax,4), %r13d, %r13d 

// CHECK: andnl 64(%rdx,%rax), %r13d, %r13d 
// CHECK: encoding: [0xc4,0x62,0x10,0xf2,0x6c,0x02,0x40]      
andnl 64(%rdx,%rax), %r13d, %r13d 

// CHECK: andnl %r13d, %r13d, %r13d 
// CHECK: encoding: [0xc4,0x42,0x10,0xf2,0xed]      
andnl %r13d, %r13d, %r13d 

// CHECK: andnl (%rdx), %r13d, %r13d 
// CHECK: encoding: [0xc4,0x62,0x10,0xf2,0x2a]      
andnl (%rdx), %r13d, %r13d 

// CHECK: andnq 485498096, %r15, %r15 
// CHECK: encoding: [0xc4,0x62,0x80,0xf2,0x3c,0x25,0xf0,0x1c,0xf0,0x1c]      
andnq 485498096, %r15, %r15 

// CHECK: andnq 64(%rdx), %r15, %r15 
// CHECK: encoding: [0xc4,0x62,0x80,0xf2,0x7a,0x40]      
andnq 64(%rdx), %r15, %r15 

// CHECK: andnq 64(%rdx,%rax,4), %r15, %r15 
// CHECK: encoding: [0xc4,0x62,0x80,0xf2,0x7c,0x82,0x40]      
andnq 64(%rdx,%rax,4), %r15, %r15 

// CHECK: andnq -64(%rdx,%rax,4), %r15, %r15 
// CHECK: encoding: [0xc4,0x62,0x80,0xf2,0x7c,0x82,0xc0]      
andnq -64(%rdx,%rax,4), %r15, %r15 

// CHECK: andnq 64(%rdx,%rax), %r15, %r15 
// CHECK: encoding: [0xc4,0x62,0x80,0xf2,0x7c,0x02,0x40]      
andnq 64(%rdx,%rax), %r15, %r15 

// CHECK: andnq %r15, %r15, %r15 
// CHECK: encoding: [0xc4,0x42,0x80,0xf2,0xff]      
andnq %r15, %r15, %r15 

// CHECK: andnq (%rdx), %r15, %r15 
// CHECK: encoding: [0xc4,0x62,0x80,0xf2,0x3a]      
andnq (%rdx), %r15, %r15 

// CHECK: bextrl %r13d, 485498096, %r13d 
// CHECK: encoding: [0xc4,0x62,0x10,0xf7,0x2c,0x25,0xf0,0x1c,0xf0,0x1c]      
bextrl %r13d, 485498096, %r13d 

// CHECK: bextrl %r13d, 64(%rdx), %r13d 
// CHECK: encoding: [0xc4,0x62,0x10,0xf7,0x6a,0x40]      
bextrl %r13d, 64(%rdx), %r13d 

// CHECK: bextrl %r13d, 64(%rdx,%rax,4), %r13d 
// CHECK: encoding: [0xc4,0x62,0x10,0xf7,0x6c,0x82,0x40]      
bextrl %r13d, 64(%rdx,%rax,4), %r13d 

// CHECK: bextrl %r13d, -64(%rdx,%rax,4), %r13d 
// CHECK: encoding: [0xc4,0x62,0x10,0xf7,0x6c,0x82,0xc0]      
bextrl %r13d, -64(%rdx,%rax,4), %r13d 

// CHECK: bextrl %r13d, 64(%rdx,%rax), %r13d 
// CHECK: encoding: [0xc4,0x62,0x10,0xf7,0x6c,0x02,0x40]      
bextrl %r13d, 64(%rdx,%rax), %r13d 

// CHECK: bextrl %r13d, %r13d, %r13d 
// CHECK: encoding: [0xc4,0x42,0x10,0xf7,0xed]      
bextrl %r13d, %r13d, %r13d 

// CHECK: bextrl %r13d, (%rdx), %r13d 
// CHECK: encoding: [0xc4,0x62,0x10,0xf7,0x2a]      
bextrl %r13d, (%rdx), %r13d 

// CHECK: bextrq %r15, 485498096, %r15 
// CHECK: encoding: [0xc4,0x62,0x80,0xf7,0x3c,0x25,0xf0,0x1c,0xf0,0x1c]      
bextrq %r15, 485498096, %r15 

// CHECK: bextrq %r15, 64(%rdx), %r15 
// CHECK: encoding: [0xc4,0x62,0x80,0xf7,0x7a,0x40]      
bextrq %r15, 64(%rdx), %r15 

// CHECK: bextrq %r15, 64(%rdx,%rax,4), %r15 
// CHECK: encoding: [0xc4,0x62,0x80,0xf7,0x7c,0x82,0x40]      
bextrq %r15, 64(%rdx,%rax,4), %r15 

// CHECK: bextrq %r15, -64(%rdx,%rax,4), %r15 
// CHECK: encoding: [0xc4,0x62,0x80,0xf7,0x7c,0x82,0xc0]      
bextrq %r15, -64(%rdx,%rax,4), %r15 

// CHECK: bextrq %r15, 64(%rdx,%rax), %r15 
// CHECK: encoding: [0xc4,0x62,0x80,0xf7,0x7c,0x02,0x40]      
bextrq %r15, 64(%rdx,%rax), %r15 

// CHECK: bextrq %r15, %r15, %r15 
// CHECK: encoding: [0xc4,0x42,0x80,0xf7,0xff]      
bextrq %r15, %r15, %r15 

// CHECK: bextrq %r15, (%rdx), %r15 
// CHECK: encoding: [0xc4,0x62,0x80,0xf7,0x3a]      
bextrq %r15, (%rdx), %r15 

// CHECK: blsil 485498096, %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x1c,0x25,0xf0,0x1c,0xf0,0x1c]       
blsil 485498096, %r13d 

// CHECK: blsil 64(%rdx), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x5a,0x40]       
blsil 64(%rdx), %r13d 

// CHECK: blsil 64(%rdx,%rax,4), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x5c,0x82,0x40]       
blsil 64(%rdx,%rax,4), %r13d 

// CHECK: blsil -64(%rdx,%rax,4), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x5c,0x82,0xc0]       
blsil -64(%rdx,%rax,4), %r13d 

// CHECK: blsil 64(%rdx,%rax), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x5c,0x02,0x40]       
blsil 64(%rdx,%rax), %r13d 

// CHECK: blsil %r13d, %r13d 
// CHECK: encoding: [0xc4,0xc2,0x10,0xf3,0xdd]       
blsil %r13d, %r13d 

// CHECK: blsil (%rdx), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x1a]       
blsil (%rdx), %r13d 

// CHECK: blsiq 485498096, %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x1c,0x25,0xf0,0x1c,0xf0,0x1c]       
blsiq 485498096, %r15 

// CHECK: blsiq 64(%rdx), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x5a,0x40]       
blsiq 64(%rdx), %r15 

// CHECK: blsiq 64(%rdx,%rax,4), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x5c,0x82,0x40]       
blsiq 64(%rdx,%rax,4), %r15 

// CHECK: blsiq -64(%rdx,%rax,4), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x5c,0x82,0xc0]       
blsiq -64(%rdx,%rax,4), %r15 

// CHECK: blsiq 64(%rdx,%rax), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x5c,0x02,0x40]       
blsiq 64(%rdx,%rax), %r15 

// CHECK: blsiq %r15, %r15 
// CHECK: encoding: [0xc4,0xc2,0x80,0xf3,0xdf]       
blsiq %r15, %r15 

// CHECK: blsiq (%rdx), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x1a]       
blsiq (%rdx), %r15 

// CHECK: blsmskl 485498096, %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x14,0x25,0xf0,0x1c,0xf0,0x1c]       
blsmskl 485498096, %r13d 

// CHECK: blsmskl 64(%rdx), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x52,0x40]       
blsmskl 64(%rdx), %r13d 

// CHECK: blsmskl 64(%rdx,%rax,4), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x54,0x82,0x40]       
blsmskl 64(%rdx,%rax,4), %r13d 

// CHECK: blsmskl -64(%rdx,%rax,4), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x54,0x82,0xc0]       
blsmskl -64(%rdx,%rax,4), %r13d 

// CHECK: blsmskl 64(%rdx,%rax), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x54,0x02,0x40]       
blsmskl 64(%rdx,%rax), %r13d 

// CHECK: blsmskl %r13d, %r13d 
// CHECK: encoding: [0xc4,0xc2,0x10,0xf3,0xd5]       
blsmskl %r13d, %r13d 

// CHECK: blsmskl (%rdx), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x12]       
blsmskl (%rdx), %r13d 

// CHECK: blsmskq 485498096, %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x14,0x25,0xf0,0x1c,0xf0,0x1c]       
blsmskq 485498096, %r15 

// CHECK: blsmskq 64(%rdx), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x52,0x40]       
blsmskq 64(%rdx), %r15 

// CHECK: blsmskq 64(%rdx,%rax,4), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x54,0x82,0x40]       
blsmskq 64(%rdx,%rax,4), %r15 

// CHECK: blsmskq -64(%rdx,%rax,4), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x54,0x82,0xc0]       
blsmskq -64(%rdx,%rax,4), %r15 

// CHECK: blsmskq 64(%rdx,%rax), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x54,0x02,0x40]       
blsmskq 64(%rdx,%rax), %r15 

// CHECK: blsmskq %r15, %r15 
// CHECK: encoding: [0xc4,0xc2,0x80,0xf3,0xd7]       
blsmskq %r15, %r15 

// CHECK: blsmskq (%rdx), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x12]       
blsmskq (%rdx), %r15 

// CHECK: blsrl 485498096, %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x0c,0x25,0xf0,0x1c,0xf0,0x1c]       
blsrl 485498096, %r13d 

// CHECK: blsrl 64(%rdx), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x4a,0x40]       
blsrl 64(%rdx), %r13d 

// CHECK: blsrl 64(%rdx,%rax,4), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x4c,0x82,0x40]       
blsrl 64(%rdx,%rax,4), %r13d 

// CHECK: blsrl -64(%rdx,%rax,4), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x4c,0x82,0xc0]       
blsrl -64(%rdx,%rax,4), %r13d 

// CHECK: blsrl 64(%rdx,%rax), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x4c,0x02,0x40]       
blsrl 64(%rdx,%rax), %r13d 

// CHECK: blsrl %r13d, %r13d 
// CHECK: encoding: [0xc4,0xc2,0x10,0xf3,0xcd]       
blsrl %r13d, %r13d 

// CHECK: blsrl (%rdx), %r13d 
// CHECK: encoding: [0xc4,0xe2,0x10,0xf3,0x0a]       
blsrl (%rdx), %r13d 

// CHECK: blsrq 485498096, %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x0c,0x25,0xf0,0x1c,0xf0,0x1c]       
blsrq 485498096, %r15 

// CHECK: blsrq 64(%rdx), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x4a,0x40]       
blsrq 64(%rdx), %r15 

// CHECK: blsrq 64(%rdx,%rax,4), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x4c,0x82,0x40]       
blsrq 64(%rdx,%rax,4), %r15 

// CHECK: blsrq -64(%rdx,%rax,4), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x4c,0x82,0xc0]       
blsrq -64(%rdx,%rax,4), %r15 

// CHECK: blsrq 64(%rdx,%rax), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x4c,0x02,0x40]       
blsrq 64(%rdx,%rax), %r15 

// CHECK: blsrq %r15, %r15 
// CHECK: encoding: [0xc4,0xc2,0x80,0xf3,0xcf]       
blsrq %r15, %r15 

// CHECK: blsrq (%rdx), %r15 
// CHECK: encoding: [0xc4,0xe2,0x80,0xf3,0x0a]       
blsrq (%rdx), %r15 

// CHECK: tzcntl %r13d, %r13d 
// CHECK: encoding: [0xf3,0x45,0x0f,0xbc,0xed]       
tzcntl %r13d, %r13d 

