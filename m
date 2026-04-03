Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3938D686;
	Fri,  3 Apr 2026 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259589; cv=none; b=QD36IeYHcfm22Nhc6mPr2MVrAzr4nlXLHXSXCtZFc6TLI5MIJT3SsbYKM3cj7os2A3+JqJMRz8ndHVERB0w3HR+9LC4471FN2NkpVZM/TgK94VfOG/mbOfEZ3ez5pnPVxOhhdl2PifxwEcLWMHg5qYiGrRzZLiLSNaB7tz7IprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259589; c=relaxed/simple;
	bh=z8XRK14chZ/G2ilABDZfNT5zRQH927xdjrd1efCRYvw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=erUYlRCKt7TtFXTkBaoxhD/EQ/1O1B073JSdK9yxhBFPbxjYXg+rKiSFgCVyo/GWD5hkRrCgVwQrxFo6uAywM3eHGLRiLW7ABi+NpuTiFJJn8Wp11L++4WUHeuL092zeXESSPYjN/yj5eZHjRLdBbvTPYY4OZKlw3HxOCZS+yHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch; spf=pass smtp.mailfrom=protonmail.ch; dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b=O1KijtZL; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="O1KijtZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1775259579; x=1775518779;
	bh=1NVpNu7BMah0Qf1mlz0OJWpGh0m7y8oGCsqBjXAicm8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=O1KijtZLwt4k2bpvTfoDaTdbAhtosCmXeYZ1APUHBm9VEGMH3+zpmPcvAT9V6M/iS
	 2QMO5h8MXLp/6EMB2KnzaL1Fz/MFom3aQdiTCHBcT/CaMJPPr+TQ0qkvxy03PFl0CL
	 WJWp/0gWB9g769IcrNpT8iOO59FK9PDjuIUjpyDlL80Ob8isyKqzWm8ykxy7QFAPsZ
	 nks2p6PNYidFWBE7vCEjqygA6WgO5mTMuAKpTKdmKIvDoHCNJTfnlJMSzselwQR3G6
	 GHoYkWA2XguJmBWIHbEJyWYnQjNMZQkhL79ktMDyFBMnekK/YByANPBLmSw8s/sqOG
	 Hy/RSfOEZQD9w==
Date: Fri, 03 Apr 2026 23:39:32 +0000
To: ojeda@kernel.org
From: Christian Benton <t1bur0n.kernel.org@protonmail.ch>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, aliceryhl@google.com, lossin@kernel.org, Christian Benton <t1bur0n.kernel.org@protonmail.ch>
Subject: [PATCH] rust: seq_file: add puts, putc, write, and hex_dump methods
Message-ID: <20260403233900.24640-1-t1bur0n.kernel.org@protonmail.ch>
Feedback-ID: 190658113:user:proton
X-Pm-Message-ID: be2b2aa40f5bea396cf4b58f8bdfce3e89f08e82
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The SeqFile abstraction currently only exposes seq_printf via the
seq_print! macro. This leaves several commonly used seq_file operations
unavailable to Rust kernel code.

Add the following methods to SeqFile:

- puts(): writes a C string using __seq_puts()
- putc(): writes a single byte using seq_putc()
- write(): writes raw bytes using seq_write()
- hex_dump(): dumps binary data as formatted hex using seq_hex_dump()

Also add HexDumpPrefix, a Rust enum wrapping the DUMP_PREFIX_NONE,
DUMP_PREFIX_ADDRESS, and DUMP_PREFIX_OFFSET constants, replacing the
raw integer interface with a type-safe alternative that makes invalid
prefix values unrepresentable.

Signed-off-by: Christian Benton <t1bur0n.kernel.org@protonmail.ch>
---
 rust/kernel/seq_file.rs | 85 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 518265558..cd4df821b 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.=
h)
=20
-use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, types:=
:Opaque};
+use crate::{bindings, ffi, fmt, str::CStr, str::CStrExt as _, types::NotTh=
readSafe, types::Opaque};
=20
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -13,6 +13,26 @@ pub struct SeqFile {
     _not_send: NotThreadSafe,
 }
=20
+/// The prefix type for [`SeqFile::hex_dump`].
+pub enum HexDumpPrefix {
+    /// No prefix.
+    None,
+    /// Prefix with the memory address.
+    Address,
+    /// Prefix with the offset within the buffer.
+    Offset,
+}
+
+impl HexDumpPrefix {
+    fn as_c_int(self) -> ffi::c_int {
+        match self {
+            Self::None =3D> bindings::DUMP_PREFIX_NONE as ffi::c_int,
+            Self::Address =3D> bindings::DUMP_PREFIX_ADDRESS as ffi::c_int=
,
+            Self::Offset =3D> bindings::DUMP_PREFIX_OFFSET as ffi::c_int,
+        }
+    }
+}
+
 impl SeqFile {
     /// Creates a new [`SeqFile`] from a raw pointer.
     ///
@@ -41,6 +61,69 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
             );
         }
     }
+
+    /// Prints a C string to the seq file.
+    pub fn puts(&self, s: &CStr) {
+        // SAFETY: `self.inner.get()` is valid because `&self` guarantees =
the
+        // `SeqFile` is alive and was properly initialized via `from_raw`.
+        // `s.as_char_ptr()` is valid because `CStr` is always a valid
+        // null-terminated C string.
+        unsafe { bindings::__seq_puts(self.inner.get(), s.as_char_ptr()) }
+    }
+
+    /// Prints a single char to the seq file.
+    pub fn putc(&self, c: u8) {
+        // SAFETY: `self.inner.get()` is valid because `&self`
+        // guarantees `SeqFile` is alive and was properly initialized via =
`from_raw`
+        unsafe { bindings::seq_putc(self.inner.get(), c as ffi::c_char) }
+    }
+
+    /// Writes raw bytes to the seq file.
+    pub fn write(&self, data: &[u8]) {
+        // SAFETY: `self.inner.get()` is valid because `&self` guarantees =
the
+        // `SeqFile` is alive and was properly initialized via `from_raw`.
+        // `data.as_ptr()` is valid and non-dangling because it comes from=
 a
+        // `&[u8]`, which guarantees the memory is valid for `data.len()` =
bytes
+        // and will not be modified during the call due to the shared refe=
rence.
+        unsafe {
+            bindings::seq_write(
+                self.inner.get(),
+                data.as_ptr().cast::<ffi::c_void>(),
+                data.len(),
+            )
+        };
+    }
+
+    /// Prints a hex dump of `buf` to the seq file.
+    pub fn hex_dump(
+        &self,
+        prefix_str: &CStr,
+        prefix_type: HexDumpPrefix,
+        rowsize: u8,
+        groupsize: u8,
+        buf: &[u8],
+        ascii: bool,
+    ) {
+        // SAFETY: `self.inner.get()` is valid because `&self` guarantees =
the
+        // `SeqFile` is alive and was properly initialized via `from_raw`.
+        // `prefix_str.as_char_ptr()` is valid because `CStr` is always a =
valid
+        // null-terminated C string. `buf.as_ptr()` is valid and non-dangl=
ing
+        // because it comes from a `&[u8]`, which guarantees the memory is=
 valid
+        // for `buf.len()` bytes and will not be modified during the call =
due to
+        // the shared reference.
+        unsafe {
+            bindings::seq_hex_dump(
+                self.inner.get(),
+                prefix_str.as_char_ptr(),
+                prefix_type.as_c_int(),
+                rowsize as ffi::c_int,
+                groupsize as ffi::c_int,
+                buf.as_ptr().cast::<ffi::c_void>(),
+                buf.len(),
+                ascii,
+            )
+        }
+    }
 }
=20
 /// Write to a [`SeqFile`] with the ordinary Rust formatting syntax.
--=20
2.53.0


