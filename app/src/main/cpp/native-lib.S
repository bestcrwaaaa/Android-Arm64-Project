    .text
    .align 4

    // ============================================================================
    // ARM64 Assembly Native Library for Android
    // ============================================================================
    // This file contains pure ARM64 assembly code that implements JNI functions.
    // The code follows the AAPCS64 (ARM Architecture Procedure Call Standard)
    // calling convention used by Android NDK.
    //
    // Function: Java_com_example_assemblyhello_MainActivity_stringFromJNI
    // Purpose:  Returns a "Hello from assembly!" string to Java/Kotlin code
    // ============================================================================

    .global Java_com_example_assemblyhello_MainActivity_stringFromJNI

// =============================================================================
// JNI Function: stringFromJNI
// =============================================================================
// This function is called from MainActivity.kt via JNI.
// It creates and returns a Java String containing "Hello from assembly!"
//
// Register usage according to AAPCS64:
//   x0 - JNIEnv* (pointer to JNI function table)
//   x1 - jobject (reference to the calling object)
//   x2-x7 - scratch registers for arguments
//   x19-x29 - callee-saved registers
//   x30 - Link Register (return address)
// =============================================================================

Java_com_example_assemblyhello_MainActivity_stringFromJNI:

    // Standard ARM64 function prologue
    // Save the frame pointer (x29) and link register (x30) on the stack
    stp     x29, x30, [sp, #-16]!

    // Set up the new frame pointer
    mov     x29, sp

    // =========================================================================
    // JNI String Creation Logic
    // =========================================================================
    // To create a Java String, we need to call JNI's NewStringUTF function.
    // The JNINativeInterface structure contains function pointers at fixed
    // offsets. NewStringUTF is at index 167.
    //
    // Since each function pointer is 8 bytes (64-bit pointer):
    // Offset = 167 * 8 = 1336 bytes = 0x538 hex
    // =========================================================================

    // Save JNIEnv* in callee-saved register x19 (we need it after dereferencing)
    mov     x19, x0

    // Load the JNINativeInterface table pointer (first 8 bytes at JNIEnv*)
    ldr     x2, [x0]

    // Calculate offset to NewStringUTF function pointer
    // Offset = 0x538 (1336 in decimal)
    mov     w3, #0x538

    // Load the NewStringUTF function pointer from the interface table
    // x2 contains the table base, x3 contains offset, result in x3
    ldr     x3, [x2, x3]

    // =========================================================================
    // Prepare arguments for NewStringUTF call
    // =========================================================================
    // NewStringUTF signature: jstring NewStringUTF(JNIEnv *env, const char *utf)
    //
    // Argument 1 (x0): JNIEnv* - already in x19, move to x0
    mov     x0, x19

    // Argument 2 (x1): const char* - pointer to our message string
    // Use adrp/add to calculate the absolute address of the message label
    adrp    x1, message
    add     x1, x1, :lo12:message

    // =========================================================================
    // Call NewStringUTF via indirect branch with link
    // =========================================================================
    // This calls the JNI function which creates a Java String object
    blr     x3

    // =========================================================================
    // Function Epilogue
    // =========================================================================
    // The result (jstring) is now in x0, which is exactly what we need to return.
    // Restore the stack frame and return to the caller.

    // Restore frame pointer and link register from stack
    ldp     x29, x30, [sp], #16

    // Return to caller (x0 contains the jstring result)
    ret

    // =========================================================================
    // Data Section - Message String
    // =========================================================================
    // The message string stored as null-terminated ASCII string
    .data
    .align 3  // 8-byte alignment for efficient access

message:
    .asciz  "Hello from assembly!"

    // =========================================================================
    // Function Size Marker
    // =========================================================================
    .size Java_com_example_assemblyhello_MainActivity_stringFromJNI, .-Java_com_example_assemblyhello_MainActivity_stringFromJNI
