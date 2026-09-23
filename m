Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF2369D56
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130313; cv=none; b=dIvjFgyWLjcDfbDbdXTB9Lnxl3BwEc4QLlu55zWyfaSsEKvVXwAdzOBZ0Foz+zbWpd2JTSQFJ/tGCdR1EodledxiynRt4kU64fNla/d2j8iIqmfBpQJKEx9Mq6dp8G+hD3SAp+0tI18JHdV+q+ICOlb1uuHG3NA3wmeUcsTRVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130313; c=relaxed/simple;
	bh=jy8mgvmzpGKOFzyvPOZqGWMmRJiQ3s6hVheMypI3Uaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJ0IxK4iscV9A9kIc/iKKf4DjJsy0Jv1085306Dg1sE21lDZPCk9YOJb7RZISm+OD8fE0CHVDXX7XLDEeAtfJUZRHjshrPwBD8YNcUgLwjszwv7oYbyAj58//YiK7iaTtAXOHQ5GvW7PDi3L1prD1PPcNaHJaUPMbLucPoWzovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0+ujz9p; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0+ujz9p"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91205165f71so3157086d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 19:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790130310; x=1790735110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CLvQRDhNdQ+386SmPeBLxsAnS2o1lMXmcOlmjU9lVHU=;
        b=M0+ujz9peXktUF5fY7twDXI6jge3I/CmgUx+tJPkhUR8BBlWiWCJvXKa2cS2f3DSPP
         L+tW77/W8D774bvrcqXTpwevukctElp2h0dxA14wUOrLkfvVE0rlCfsZRg0muKjv5MCh
         /JmQf2Hmdq1XuBrte5fWSy09gj13r0CWVFYbvkJQw4JPeGKOzEwczmQK50vAK+NhPIyf
         DDFpS/2lHVQUD0nY3nJSPkOrxv+ZKU1Z4j25q8F6bP7vt9wK2WmdviJmRdNn6Nve56rf
         iMXyh8inM6aHqy1n5zfk8DNa+NMW3PfbpPFRWGZOJNboyWbh9F2jogPday2lXADGFSvp
         p7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790130310; x=1790735110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CLvQRDhNdQ+386SmPeBLxsAnS2o1lMXmcOlmjU9lVHU=;
        b=ToV9i84xB0x/Cam5NKuizxy96ygh7/W0YkYR8fefphRU8HNm/1Ds4/60xpY6mDFnwn
         ebUci2Xk9fC1SHX2U8NOPj4isAAgugrtXJVx2hMjFTZRu7ICE1g5sX5kyC2h22op1dLt
         A/90bHGhFUdiIKksoeEuIHEN37t8HpWAnjoVDu9RTpgtp8hYLgptB1UKGvE2mLmmJBa1
         dY9w4skeePs/BIVv/QkQKJPRoioPv7PVdcbEHU7dKRR2FAunMpFUJ6lh0pcFGiNEQlFr
         xVfKzrm1FzTC1zdrWnV2iQRiDfDJt3YJLP0Xf5sETMzc1mnH1q90q6y1gDRR8YR5A8e+
         EH/A==
X-Forwarded-Encrypted: i=1; AKwUvBwCwC6depQ7AW0NHcxNyIEGSDTjOqCkYYxlbJAT7zn0n/NGlsL6YEXISQ51dxqfBpHsYvEfCP2fAKruYncz@vger.kernel.org
X-Gm-Message-State: AFuF++n7bUb+XlLkvjz0mVkQMn6Ww7BVPjaS0z95qx1Ttf6SIvLnLKZl
	h6BYFaDgoAxbMm42TRi0ZvxwmMlSIo3mCs3hF0nJpQoVnfjQhDGtHooD
X-Gm-Gg: AYBFou0j5uNgfQN2Bbm+0vW4kE3WDXWw4tFGjI5MTrphZ7GL75qMzrHi15LHOZpZ7It
	PYmtiw8hp+mYUOL1R8D/W47pZRaQ+Lca6QNaHdhgsdfLFWhtxWD4lVISHgElb5nJJOzsNN++sKi
	KKBPClmyC83TBNShLexg8dRosx+81Ur3HbmM9K8rdhlFU5zyXosDqCO/tm+JVS/FxXcaKHUsO9p
	ASRutySaqdj5LaaLdctuSv+U9mWDWZeN1cvhOoNXnHbChn9QoYblv8dTyyq+0qcMItrNXDIvV31
	s1+eGGlIr6/1S//u6vRmnKnkzXJ6LQkMF3LvznyK7D8DFkYwDWIxdS4ehVME8E1+k2zcM4phayR
	2rQR8J4HNJcfQbTPmd5CXA/zJ/vuMELsZG7JTTpmOQErAXF+WQ5eV4Jh4IzKWVRtUwj1Q04S+ZU
	4BK6gJFw2N0+XX3/TLFIsBJQVJMxRj1UC3fmJiVVMQDN1Zpko3GISphOK9k/3/+CDdKvlD3g==
X-Received: by 2002:a05:620a:17a0:b0:93b:e9db:1bab with SMTP id af79cd13be357-93c251efb88mr212666485a.56.1790130310310;
        Tue, 22 Sep 2026 19:25:10 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c24823976sm124500985a.13.2026.09.22.19.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 19:25:09 -0700 (PDT)
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
Subject: [PATCH v2] rust: file: handle fd table teardown in file descriptor APIs
Date: Tue, 22 Sep 2026 22:23:39 -0400
Message-ID: <20260923022339.3340694-1-georgeandrout13@gmail.com>
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
For `fd_install()`, warn and abandon the reservation when the fd table
is already gone. In the drop path, skip `put_unused_fd()` after the fd
table has been torn down.

This prevents NULL dereferences through these safe Rust APIs after
`exit_files()`.

Fixes: 851849824bb5 ("rust: file: add Rust abstraction for `struct file`")
Fixes: 5da9857b127e ("rust: file: add `FileDescriptorReservation`")
Closes: https://github.com/Rust-for-Linux/linux/issues/1256
Signed-off-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
---
Changes in v2:
- Use `warn_on!()` for `FileDescriptorReservation::fd_install()` and
  remove the warning from the drop path, following feedback from Gary Guo.
- Link to v1: https://lore.kernel.org/rust-for-linux/20260920200154.1194983-1-georgeandrout13@gmail.com/
---
 rust/kernel/fs/file.rs | 64 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 23ee689bd240..8b5b5ec4cd04 100644
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
 
@@ -421,13 +442,26 @@ pub fn reserved_fd(&self) -> u32 {
 
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
+        if crate::warn_on!(unsafe { (*current.as_ptr()).files.is_null() }) {
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
@@ -446,9 +480,21 @@ pub fn fd_install(self, file: ARef<File>) {
 impl Drop for FileDescriptorReservation {
     #[inline]
     fn drop(&mut self) {
+        let current = crate::current!();
+
+        // SAFETY: `current` points to the currently executing task, so it is
+        // valid to read its `files` pointer. The pointer may be null during
+        // task teardown.
+        if unsafe { (*current.as_ptr()).files.is_null() } {
+            // `put_unused_fd` uses `current->files`, so it cannot be called
+            // after the current task has torn down its fd table.
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

