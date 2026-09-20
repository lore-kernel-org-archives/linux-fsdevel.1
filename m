Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C83DDB15
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789934641; cv=none; b=gkvAYjnnSjZMWyPmKUmcPz2YXuL3waV3Fng4bCbs2mK9Hsyj8REOloXtAeMjle/FXiFxv+RyqUHGXh1Fw6smqIRAah4Rt44zaf6wJfshWUNDHYkoY6kEpRneYjYK6Zm1BAWUW1fD8XaZTdVgl8IX+royxvrfOZuNV4xPGwaII6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789934641; c=relaxed/simple;
	bh=MUuqufV7F8li7ww/uKMPzHCm6Tj5VXKrnY7JwJN/Y2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+sfPvSr+tnUnn1Dcd/ekRMUd3XOVDqE5EylUe616EnaxJ8IqsR2ACpy1MsMtHN9W7Aw91qlENiawXZqYED2UnwpGel4LKahIwATSgmFrHDfpY3oVOgCyeMtW1kUdkZMyPEvWw8Ie8BF9tuOpTh+EJ+ZSUzG6jwYyxZXxQzHUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiSPZlUI; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiSPZlUI"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed6d6eso22711895ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789934638; x=1790539438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0cppsgBznO4lr0DL9YkMJQBoD71a+Vm1Btko6onEEI=;
        b=hiSPZlUIjNasKHY3UdDc3p1MQ7CSExzehJhW3WY8mZovm0Cusio6vA9YYkdQRAFvEh
         FSWClXemKUazyRzWdlRuhHmHWeTPt56qGTgyafEuOorgSbAsFzUBsSwm4PgVWw4E3Y/W
         Y2mBm/SggYCvC6Jxjna05NgXJJIObMXx06NsHzwgZyd0Ox6v9Hnrfg1NuCcV8KEQUI2r
         7zbxxaLv2QyB2Hwqb373T9DuB13dYHdZPN0akzoPyNQPmY+CJJ+jMEZseQiSrzv7q6jz
         z89yJha3GJJBs0ZNJFrBFXNKp70+i71sj5b0xzokub5u0kubKiF6FtsVtHa6vrufqH94
         dGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789934638; x=1790539438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0cppsgBznO4lr0DL9YkMJQBoD71a+Vm1Btko6onEEI=;
        b=H7jZTjn1yFh8QnhxdYaH1DPzMuHT6v5YaqCyYdzHhvAkRVIHoJnHGCvvZo0WPnQObK
         YsWSYL8s1kp11rHMHO6bj8iie81pbUAxl5rIW+jvSD7fofEiGOmp+qy720JxX0uxXFlm
         YeElFR8VXvQNmj7PNshX/3k8YmwW6b7Z8IKuWTlRAU9nxdowq84iyFTpRhBnDJ5Kroq4
         KrCnM2xvvNggVSPyk5VC51RKpKc0/rdklmmk8iPJqQaifWb5BvI/3oWeNG567OFHttbs
         PaIw6RJ2n3JuxNqJ0z/n2ubYCMbwuSWN+kdLAg+T/B7HoHsDISrSa1Y1DkdbiXJsXJRj
         XdZA==
X-Forwarded-Encrypted: i=1; AKwUvBzopHfS7EVXoVGnuPOrTH9sOWbCntwDBit/8LI7UycprMLdW+7SuiwV/XHHP+TEx6V+zaBx4QEAKxAw3zIm@vger.kernel.org
X-Gm-Message-State: AFuF++nIbTe7pzeBUiDZ+w3SZsb17KrIcLJZQQrMiyyjvD6SXcE1kWHT
	bKVQdkhcer8TcWk+4OVNrfbyX3kUAUa92RZtMK/tLWuCgXImrazpRnJy
X-Gm-Gg: AYBFou2O8R4ySQMF1qD1KI8Qe5zL3khdlawhIDnzOFWxKs7mYHN0zCsGW4wRLk/Q4P9
	5CqxL+Zx4b9PL3noSHNWD23QHFeRATjw+KlTCCI2fE1SSYRYwE7ZrQ5oIcUSInzy+35JnjqIzlz
	kpuSyvv8s/7VTtx+z/m7+yaQhbVRLPBHrB7R2JQwtbCAUwbejabFGkUrMAYbU27qTqpOEqZejSs
	1I2Yj1IslRamQ72G8ACRsf7Aw+xGr/OG8LhZcLaV2kaBu5rv9ATd7d8ZML6SeVtAwqVgM8y8Q1M
	JdXLJvvlhtx0z+efQadR1JAua80EdzUxz2dWZLiROX/Z0/ozIdLSykHWZ4QtO0tE54GU95ZV+Wy
	LbXnQLBk9OWJ7ja5rg6RnqnaeFhsMNoMTAv4Ra/xpBHDHzF8IeeHiPRRwU45T29LRiBjTgf43Ux
	UTbOWB25VSNl9gwBHCOM/OvDnMPf23V4gFQI7xKwsFhTcGJp1KcUQ0OAdQq/vCRRdi2W+Nrg==
X-Received: by 2002:a17:903:11cc:b0:2dd:c100:4b80 with SMTP id d9443c01a7336-2ddc1005ef1mr71490425ad.55.1789934638026;
        Sun, 20 Sep 2026 13:03:58 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d3f2csm11663492eec.28.2026.09.20.13.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 13:03:57 -0700 (PDT)
From: Georgios Androutsopoulos <georgeandrout13@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Georgios Androutsopoulos <georgeandrout13@gmail.com>
Subject: [PATCH] rust: file: handle fd table teardown in file descriptor APIs
Date: Sun, 20 Sep 2026 16:01:54 -0400
Message-ID: <20260920200154.1194983-1-georgeandrout13@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several Rust file descriptor APIs rely on `current->files` being
available. However, `exit_files()` clears it while execution may still
continue on the same task.

This affects `LocalFile::fget()` and the
`FileDescriptorReservation` operations that call
`get_unused_fd_flags()`, `fd_install()`, and `put_unused_fd()`.
`FileDescriptorReservation` cannot cross task boundaries, but remaining
on the same task does not guarantee that `current->files` is still
available when these operations are performed.

Guard the affected operations against a missing `current->files`.
`LocalFile::fget()` returns `EBADF` and
`FileDescriptorReservation::get_unused_fd_flags()` returns `EMFILE`.
For the infallible `fd_install()` and drop paths, warn once and avoid
calling the corresponding C helper when the fd table is already gone.

This prevents NULL dereferences through these safe Rust APIs after
`exit_files()`.

Fixes: 851849824bb5 ("rust: file: add Rust abstraction for `struct file`")
Fixes: 5da9857b127e ("rust: file: add `FileDescriptorReservation`")
Closes: https://github.com/Rust-for-Linux/linux/issues/1256
Signed-off-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
---
 rust/kernel/fs/file.rs | 69 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 23ee689bd240..559f0985b12c 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -260,7 +260,17 @@ impl LocalFile {
     /// [`assume_no_fdget_pos`]: LocalFile::assume_no_fdget_pos
     #[inline]
     pub fn fget(fd: u32) -> Result<ARef<LocalFile>, BadFdError> {
-        // SAFETY: FFI call, there are no requirements on `fd`.
+        let current = crate::current!();
+
+        // SAFETY: `current` points to the currently executing task, so it is
+        // valid to read its `files` pointer. The pointer may be null during
+        // task teardown.
+        if unsafe { (*current.as_ptr()).files.is_null() } {
+            return Err(BadFdError);
+        }
+
+        // SAFETY: There are no requirements on `fd`. We checked above that the
+        // current task still has a file descriptor table, which `fget` accesses.
         let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
 
         // SAFETY: `bindings::fget` created a refcount, and we pass ownership of it to the `ARef`.
@@ -403,7 +413,18 @@ impl FileDescriptorReservation {
     /// Creates a new file descriptor reservation.
     #[inline]
     pub fn get_unused_fd_flags(flags: u32) -> Result<Self> {
-        // SAFETY: FFI call, there are no safety requirements on `flags`.
+        let current = crate::current!();
+
+        // SAFETY: `current` points to the currently executing task, so it is
+        // valid to read its `files` pointer. The pointer may be null during
+        // task teardown.
+        if unsafe { (*current.as_ptr()).files.is_null() } {
+            return Err(EMFILE);
+        }
+
+        // SAFETY: There are no safety requirements on `flags`. We checked above
+        // that the current task still has a file descriptor table, which
+        // `get_unused_fd_flags` accesses.
         let fd: i32 = unsafe { bindings::get_unused_fd_flags(flags) };
         to_result(fd)?;
 
@@ -421,13 +442,30 @@ pub fn reserved_fd(&self) -> u32 {
 
     /// Commits the reservation.
     ///
-    /// The previously reserved file descriptor is bound to `file`. This method consumes the
-    /// [`FileDescriptorReservation`], so it will not be usable after this call.
+    /// The previously reserved file descriptor is bound to `file`. If the current task no longer
+    /// has a file descriptor table, the reservation is abandoned instead. This method consumes the
+    /// [`FileDescriptorReservation`] in either case.
     #[inline]
     pub fn fd_install(self, file: ARef<File>) {
-        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`. We have not yet used
-        // the fd, so it is still valid, and `current` still refers to the same task, as this type
-        // cannot be moved across task boundaries.
+        let current = crate::current!();
+
+        // SAFETY: `current` points to the currently executing task, so it is
+        // valid to read its `files` pointer. The pointer may be null during
+        // task teardown.
+        if unsafe { (*current.as_ptr()).files.is_null() } {
+            crate::pr_warn_once!(
+                "FileDescriptorReservation::fd_install called with current->files == NULL\n"
+            );
+
+            // `put_unused_fd` also requires `current->files` to be valid, so do not run
+            // the reservation's destructor after the current task has lost its fd table.
+            core::mem::forget(self);
+            return;
+        }
+
+        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags` and has not yet been
+        // used. This type cannot be moved across task boundaries, so `current` still refers to the
+        // same task, and we checked above that it still has an fd table.
         //
         // Furthermore, the file pointer is guaranteed to own a refcount by its type invariants,
         // and we take ownership of that refcount by not running the destructor below.
@@ -446,9 +484,22 @@ pub fn fd_install(self, file: ARef<File>) {
 impl Drop for FileDescriptorReservation {
     #[inline]
     fn drop(&mut self) {
+        let current = crate::current!();
+
+        // SAFETY: `current` points to the currently executing task, so it is
+        // valid to read its `files` pointer. The pointer may be null during
+        // task teardown.
+        if unsafe { (*current.as_ptr()).files.is_null() } {
+            crate::pr_warn_once!(
+                "FileDescriptorReservation dropped with current->files == NULL\n"
+            );
+            return;
+        }
+
         // SAFETY: By the type invariants of this type, `self.fd` was previously returned by
-        // `get_unused_fd_flags`. We have not yet used the fd, so it is still valid, and `current`
-        // still refers to the same task, as this type cannot be moved across task boundaries.
+        // `get_unused_fd_flags` and has not yet been used. This type cannot be moved across task
+        // boundaries, so `current` still refers to the same task, and we checked above that it
+        // still has an fd table.
         unsafe { bindings::put_unused_fd(self.fd) };
     }
 }
-- 
2.47.3

