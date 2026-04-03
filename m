Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED023451BA
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247607; cv=none; b=Gsy+fYJnhep7oczY21WJz4TETWLULi5EljxP7b++NgMdBDes4XxbUNw5m/ZhDpj+JKvU+Jzf+u5q8XM1OVs4UMN5JZhKdRG+rpZ5Ci/cOPCZ+z27MfpOKwopEyXGdfKuCg1ojEZBCL3N8lN7Kvj/kBiIQtbOdvU3vncqH0DY1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247607; c=relaxed/simple;
	bh=7z9ieu8CqvpWqm7mnRX42+lzsZPDr8vHpl0iV5Rh7Ws=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ok7rV4sIp4+U5kgs2074PA2fNd3A9cXmvONwJV1/CPhSPZ9kZsIRt5k3GLI6/gEz9ijOShnBJ6Jymm6sgLd2Zwr7tat8nSYK38Bn3DWEOwJNLW4XjiE6SKKw3bgZELTC8ySNx7xQnyH80GT8zbqU7AEw9hXEBFHYCvDn2GRYjaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch; spf=pass smtp.mailfrom=protonmail.ch; dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b=kDA1L6sf; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="kDA1L6sf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1775247602; x=1775506802;
	bh=gCV8hox9Kl/Oofwo8QZCV3yKtlljVX7l3r99VEuQNvc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kDA1L6sfdJLv/+76HBJ3cZsCx5U9n5+aBUnUWTo9BvHiwCYkz7YUz6k1II96snuqB
	 hIq9DjIO5zu26iZphNizgJnyvOkNEBtio6OYkbADsWEAUTZFh1ZNj/izG2r9EWZrX8
	 PBE3Ms+E7AJMYH7G+cR3Y1AU41Mc+tkSkoAg/CuyYzEboJ8KQS9b2bLBN5QLlNbMbo
	 83xzYI840MqJO8QsE1iHDBQNIymHWPc5Xn3i5LCfWjlXue5h/BtQF08yWObPXAugoU
	 iOmEK75RBpXlYXBP8hhU9Ck6CLL/VEfuNAPsVzFqQfax/DSge8nvTzSSrmMUwmz3mt
	 VZhbCiUNpeRSQ==
Date: Fri, 03 Apr 2026 20:19:56 +0000
To: ojeda@kernel.org
From: Christian Benton <t1bur0n.kernel.org@protonmail.ch>
Cc: rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, aliceryhl@google.com, lossin@kernel.org, Christian Benton <t1bur0n.kernel.org@protonmail.ch>
Subject: [PATCH] rust: fs: file: add FMODE constants and stream_open for LocalFile
Message-ID: <20260403201941.37501-1-t1bur0n.kernel.org@protonmail.ch>
Feedback-ID: 190658113:user:proton
X-Pm-Message-ID: 432bb77e413b4ae1fba06a0c4e2c8bf5d23dd79c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The C function stream_open() has no Rust equivalent, requiring Rust
drivers to manipulate f_mode directly through unsafe bindings. This adds
the necessary FMODE constants to the bindings and implements stream_open()
natively on LocalFile, giving Rust character device drivers a safe way to
mark a file as a stream.

Add the FMODE_STREAM, FMODE_LSEEK, FMODE_PREAD, FMODE_PWRITE and
FMODE_ATOMIC_POS constants to the bindings. These constants were not
previously accessible to Rust code because bindgen cannot handle the
__force cast used in their C macro definitions. They are exposed here
using the RUST_CONST_HELPER pattern already established in
bindings_helper.h.

stream_open() should be called from the open() handler of a character
device that produces data as a stream rather than supporting random
access. It clears the seek-related file mode flags and sets FMODE_STREAM,
telling the VFS layer not to validate seek positions on read_iter and
write_iter calls. This mirrors the behavior of stream_open() in
fs/open.c, which does not use the inode parameter and only manipulates
f_mode on the file struct.

The method is placed on LocalFile rather than File because stream_open()
must be called during open(), before the file descriptor is installed
into the process fd table. LocalFile is !Send, which statically
guarantees that no other thread can concurrently access f_mode at the
point this method is called, making the unsafe f_mode manipulation sound.

Signed-off-by: Christian Benton <t1bur0n.kernel.org@protonmail.ch>
---
 rust/bindings/bindings_helper.h |  5 +++++
 rust/kernel/fs/file.rs          | 30 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helpe=
r.h
index 083cc44aa..21421296c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -113,6 +113,11 @@ const gfp_t RUST_CONST_HELPER___GFP_ZERO =3D __GFP_ZER=
O;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM =3D ___GFP_HIGHMEM;
 const gfp_t RUST_CONST_HELPER___GFP_NOWARN =3D ___GFP_NOWARN;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL =3D BLK_FEAT_RO=
TATIONAL;
+const fmode_t RUST_CONST_HELPER_FMODE_ATOMIC_POS =3D FMODE_ATOMIC_POS;
+const fmode_t RUST_CONST_HELPER_FMODE_LSEEK =3D FMODE_LSEEK;
+const fmode_t RUST_CONST_HELPER_FMODE_PREAD =3D FMODE_PREAD;
+const fmode_t RUST_CONST_HELPER_FMODE_PWRITE =3D FMODE_PWRITE;
+const fmode_t RUST_CONST_HELPER_FMODE_STREAM =3D FMODE_STREAM;
 const fop_flags_t RUST_CONST_HELPER_FOP_UNSIGNED_OFFSET =3D FOP_UNSIGNED_O=
FFSET;
=20
 const xa_mark_t RUST_CONST_HELPER_XA_PRESENT =3D XA_PRESENT;
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 23ee689bd..a22200c56 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -342,6 +342,36 @@ pub fn flags(&self) -> u32 {
         // FIXME(read_once): Replace with `read_once` when available on th=
e Rust side.
         unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volati=
le() }
     }
+
+    /// Marks this file as a stream, disabling seek position validation.
+    ///
+    /// This should be called from the `open` handler of a character devic=
e that
+    /// produces data as a stream rather than supporting random access. It=
 clears
+    /// the seek-related file mode flags and sets `FMODE_STREAM`, which te=
lls the
+    /// VFS layer not to validate seek positions on `read_iter` and `write=
_iter`
+    /// calls.
+    ///
+    /// Must only be called during `open()`, before the file descriptor is
+    /// installed into the process fd table and becomes accessible to othe=
r
+    /// threads.
+    pub fn stream_open(&self) {
+        // SAFETY: The file pointer is valid for the duration of this call
+        // because `LocalFile` can only exist while the underlying `struct=
 file`
+        // is alive. Since `LocalFile` is not `Send`, this method can only=
 be
+        // called before the file is shared across threads, which means no=
 other
+        // thread can be concurrently modifying `f_mode`. The pointer is
+        // guaranteed non-null by the type invariants of `LocalFile`.
+        unsafe {
+            let file =3D self.as_ptr();
+            (*file).f_mode &=3D !(
+                bindings::FMODE_LSEEK
+                    | bindings::FMODE_PREAD
+                    | bindings::FMODE_PWRITE
+                    | bindings::FMODE_ATOMIC_POS
+            );
+            (*file).f_mode |=3D bindings::FMODE_STREAM;
+        }
+    }
 }
=20
 impl File {
--=20
2.53.0


