Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840412;
	b=I7WTncBpRxexkEUNIUrtbjAIkHbGXCfX+4yuWZ6fVG27ExIxUlW4tYc27kh4l3NkNQ2C
	 8t0w9NM8F5ggCj5m/YMdRXdNAdOIYpH+yUHqHr2yTPM5fM4jd/QVq697pAECFw0ZjpZyp
	 l3MxiI6UXglXHzmMnu8L1ANJk5thiCHq3IEPg6oiiaQ1ihQvge0rTPQSkzq/3lY+jY3t2
	 qWGNVZT0ZmyWESf5Sntm3SuSxtxP8DRc7YNwZz255lhRxIq7wmoJdDqJ8IUqlMpPm9nGU
	 I590gxaAOM8m/GK4VzkPHceyWvLw7M/pDKRJ9wFT1WuPnrG25GURHrW+bBPv384yrsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840412;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3X2rR5lRFxuh4XkO+STb2MLln9aaDo9NNb16lI806Y4=;
	b=MZsyKpc6E9OzZs3Qwqm0eD6Fgi8BO9tr3gbJrMZibRu/yXG7Q8HF3PrjnrWvTvWnCblB
	 30YxMCc7C/gzG6f7FbmdNvxnOkGu6l1P+kFAHuWKkpJIOgsnyZA5H/MgjF5hlszOedDp1
	 KCyNxxtFeMSgInMy9XBvXqlMCKlp134fV5y+QKBtpQuOAcseQtXxKysnzEiVHxNtCg4Zi
	 FfZd+nMfBSnzIx+xgfsxtFmW4KpHFXW5zLrMBj0jpbocpfsQvwEMN0ktpSYVXyUWDvR8N
	 6BjzFVguGJOa73+TQ09B7Zn1nOc/kwauDCcPJHBnLwFok5XylX+d4RxLnoC3XImlsJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPOa8F3E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD562606A33F;
	Thu,  5 Nov 2026 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPOa8F3E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C811F00919;
	Thu,  5 Nov 2026 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840411;
	bh=3X2rR5lRFxuh4XkO+STb2MLln9aaDo9NNb16lI806Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UPOa8F3E18PSDUsG0Wk/o5+8ccmKaAZr7Y0Tki0bbSFvnspeYH8hivrgS9W6m0M4Z
	 0m+Zy/Wd+7atHSDhS0zROXJv+CJB7RkVz/o1+K6JdPhrQ7YBwZMZGc2Y323Ddenqvx
	 o/RRI7cjbSSHAie9ha4cUY6Qr6/J0F6vPIOFGFlCem5IxfwX8YiPSe6zyODBLC4pN9
	 516KzeDbywtn7LylHvfKeMx4pB3Ty1T/8LjCjfrdccRlI9BRGTmOkAsgpGoXQsBnXD
	 EX5b59lPoebSVVUAP0nAQ78tYKYtlLCk9tHxBcG/FbD/hw3gsyPXR6SrakNNuuo8TC
	 MXSHEc5TFNFow==
From: Danilo Krummrich <dakr@kernel.org>
To: boqun@kernel.org,
	gary@garyguo.net,
	aliceryhl@google.com,
	lyude@redhat.com,
	daniel.almeida@collabora.com,
	work@onurozkan.dev,
	ojeda@kernel.org,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	tamird@kernel.org,
	acourbot@nvidia.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/5] rust: sync: convert CondVar and PollCondVar to use WaitQueue
Date: Thu,  5 Nov 2026 01:59:40 +0100
Message-ID: <20261105005951.756157-4-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105005951.756157-1-dakr@kernel.org>
References: <20261105005951.756157-1-dakr@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CondVar currently wraps a raw wait_queue_head directly. Now that
WaitQueue provides the same primitive, convert CondVar to use it
instead. This removes duplicate init, pinning, Send/Sync, and wake-up
code from CondVar.

Keep the wait logic in CondVar since it needs to release and reacquire a
lock guard around the sleep, which WaitQueue's condition-based
wait_event() methods do not handle. Use wait_once_exclusive() to perform
a single prepare_to_wait_exclusive / finish_wait cycle with a
caller-provided schedule function to implement the lock-aware sleep.

Adapt PollCondVar accordingly.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/sync/condvar.rs | 89 +++++++++++--------------------------
 rust/kernel/sync/poll.rs    | 19 ++++----
 rust/kernel/sync/wait.rs    |  2 -
 3 files changed, 33 insertions(+), 77 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 69d58dfbad7b..78a5f10d68fa 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -5,18 +5,26 @@
 //! This module allows Rust code to use the kernel's [`struct wait_queue_head`] as a condition
 //! variable.
 
-use super::{lock::Backend, lock::Guard, LockClassKey};
+use super::{
+    lock::Backend,
+    lock::Guard,
+    LockClassKey,
+    WaitQueue, //
+};
+
 use crate::{
-    ffi::{c_int, c_long},
-    str::{CStr, CStrExt as _},
+    prelude::*,
+    str::CStr,
     task::{
-        MAX_SCHEDULE_TIMEOUT, TASK_FREEZABLE, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNINTERRUPTIBLE,
+        MAX_SCHEDULE_TIMEOUT,
+        TASK_FREEZABLE,
+        TASK_INTERRUPTIBLE,
+        TASK_UNINTERRUPTIBLE, //
     },
     time::Jiffies,
-    types::Opaque,
 };
-use core::{marker::PhantomPinned, pin::Pin, ptr};
-use pin_init::{pin_data, pin_init, PinInit};
+
+use core::pin::Pin;
 
 /// Creates a [`CondVar`] initialiser with the given name and a newly-created lock class.
 #[macro_export]
@@ -81,33 +89,14 @@ macro_rules! new_condvar {
 #[pin_data]
 pub struct CondVar {
     #[pin]
-    pub(crate) wait_queue_head: Opaque<bindings::wait_queue_head>,
-
-    /// A condvar needs to be pinned because it contains a [`struct list_head`] that is
-    /// self-referential, so it cannot be safely moved once it is initialised.
-    ///
-    /// [`struct list_head`]: srctree/include/linux/types.h
-    #[pin]
-    _pin: PhantomPinned,
+    pub(crate) wq: WaitQueue,
 }
 
-// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on any thread.
-unsafe impl Send for CondVar {}
-
-// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on multiple threads
-// concurrently.
-unsafe impl Sync for CondVar {}
-
 impl CondVar {
     /// Constructs a new condvar initialiser.
     pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
         pin_init!(Self {
-            _pin: PhantomPinned,
-            // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
-            // static lifetimes so they live indefinitely.
-            wait_queue_head <- Opaque::ffi_init(|slot| unsafe {
-                bindings::__init_waitqueue_head(slot, name.as_char_ptr(), key.as_ptr())
-            }),
+            wq <- WaitQueue::new(name, key),
         })
     }
 
@@ -117,23 +106,10 @@ fn wait_internal<T: ?Sized, B: Backend>(
         guard: &mut Guard<'_, T, B>,
         timeout_in_jiffies: c_long,
     ) -> c_long {
-        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
-
-        // SAFETY: `wait` points to valid memory.
-        unsafe { bindings::init_wait(wait.get()) };
-
-        // SAFETY: Both `wait` and `wait_queue_head` point to valid memory.
-        unsafe {
-            bindings::prepare_to_wait_exclusive(self.wait_queue_head.get(), wait.get(), wait_state)
-        };
-
-        // SAFETY: Switches to another thread. The timeout can be any number.
-        let ret = guard.do_unlocked(|| unsafe { bindings::schedule_timeout(timeout_in_jiffies) });
-
-        // SAFETY: Both `wait` and `wait_queue_head` point to valid memory.
-        unsafe { bindings::finish_wait(self.wait_queue_head.get(), wait.get()) };
-
-        ret
+        self.wq.wait_once_exclusive(wait_state, || {
+            // SAFETY: Switches to another thread. The timeout can be any number.
+            guard.do_unlocked(|| unsafe { bindings::schedule_timeout(timeout_in_jiffies) })
+        })
     }
 
     /// Releases the lock and waits for a notification in uninterruptible mode.
@@ -198,28 +174,13 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
         }
     }
 
-    /// Calls the kernel function to notify the appropriate number of threads.
-    fn notify(&self, count: c_int) {
-        // SAFETY: `wait_queue_head` points to valid memory.
-        unsafe {
-            bindings::__wake_up(
-                self.wait_queue_head.get(),
-                TASK_NORMAL,
-                count,
-                ptr::null_mut(),
-            )
-        };
-    }
-
     /// Calls the kernel function to notify one thread synchronously.
     ///
     /// This method behaves like `notify_one`, except that it hints to the scheduler that the
-    /// current thread is about to go to sleep, so it should schedule the target thread on the same
-    /// CPU.
+    /// current thread expects to sleep soon.
     #[inline]
     pub fn notify_sync(&self) {
-        // SAFETY: `wait_queue_head` points to valid memory.
-        unsafe { bindings::__wake_up_sync(self.wait_queue_head.get(), TASK_NORMAL) };
+        self.wq.wake_up_sync();
     }
 
     /// Wakes a single waiter up, if any.
@@ -228,7 +189,7 @@ pub fn notify_sync(&self) {
     /// completely (as opposed to automatically waking up the next waiter).
     #[inline]
     pub fn notify_one(&self) {
-        self.notify(1);
+        self.wq.wake_up();
     }
 
     /// Wakes all waiters up, if any.
@@ -237,7 +198,7 @@ pub fn notify_one(&self) {
     /// completely (as opposed to automatically waking up the next waiter).
     #[inline]
     pub fn notify_all(&self) {
-        self.notify(0);
+        self.wq.wake_up_all();
     }
 }
 
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index dc40bfaa57e6..fbd754a0bc54 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -64,11 +64,11 @@ pub fn register_wait(&self, file: &File, cv: &PollCondVar) {
         // * `file.as_ptr()` references a valid file for the duration of this call.
         // * `self.table` is null or references a valid poll_table for the duration of this call.
         // * Since `PollCondVar` is pinned, its destructor is guaranteed to run before the memory
-        //   containing `cv.wait_queue_head` is invalidated. Since the destructor clears all
-        //   waiters and then waits for an rcu grace period, it's guaranteed that
-        //   `cv.wait_queue_head` remains valid for at least an rcu grace period after the removal
-        //   of the last waiter.
-        unsafe { bindings::poll_wait(file.as_ptr(), cv.wait_queue_head.get(), self.table) }
+        //   containing the wait queue head is invalidated. Since the destructor clears all
+        //   waiters and then waits for an rcu grace period, it's guaranteed that the wait queue
+        //   head remains valid for at least an rcu grace period after the removal of the last
+        //   waiter.
+        unsafe { bindings::poll_wait(file.as_ptr(), cv.wq.as_raw(), self.table) }
     }
 }
 
@@ -105,9 +105,7 @@ impl PinnedDrop for PollCondVar {
     #[inline]
     fn drop(self: Pin<&mut Self>) {
         // Clear anything registered using `register_wait`.
-        //
-        // SAFETY: The pointer points at a valid `wait_queue_head`.
-        unsafe { bindings::__wake_up_pollfree(self.inner.wait_queue_head.get()) };
+        self.inner.wq.wake_up_pollfree();
 
         // Wait for epoll items to be properly removed.
         synchronize_rcu();
@@ -165,14 +163,13 @@ fn drop(&mut self) {
         // SAFETY: ManuallyDrop::take ok because not already taken.
         let boxed = unsafe { ManuallyDrop::take(&mut self.inner) };
 
+        boxed.inner.inner.wq.wake_up_pollfree();
+
         // SAFETY: The code below frees the box without calling the actual destructor of the type,
         // but it's okay because it re-implements the destructor using `kfree_rcu()` in place of
         // `synchronize_rcu()`.
         let ptr = KBox::into_raw(unsafe { Pin::into_inner_unchecked(boxed) });
 
-        // SAFETY: The pointer points at a valid `wait_queue_head`.
-        unsafe { bindings::__wake_up_pollfree((*ptr).inner.inner.wait_queue_head.get()) };
-
         // SAFETY: This was allocated using `KBox::pin_init`, so it can be freed with `kvfree`.
         unsafe { bindings::kvfree_call_rcu((*ptr).rcu.get(), ptr.cast::<ffi::c_void>()) };
     }
diff --git a/rust/kernel/sync/wait.rs b/rust/kernel/sync/wait.rs
index 00120dbb4fca..92c1ae93705e 100644
--- a/rust/kernel/sync/wait.rs
+++ b/rust/kernel/sync/wait.rs
@@ -219,7 +219,6 @@ pub(super) fn wait_once<F, R>(&self, wait_state: c_int, schedule_fn: F) -> R
     /// Performs a single exclusive prepare-to-wait / finish-wait cycle, calling `schedule_fn`
     /// in between.
     #[inline]
-    #[expect(unused)]
     pub(super) fn wait_once_exclusive<F, R>(&self, wait_state: c_int, schedule_fn: F) -> R
     where
         F: FnOnce() -> R,
@@ -303,7 +302,6 @@ pub fn wake_up_sync(&self) {
     /// Used when a wait queue is about to be freed, to ensure epoll items are properly removed.
     /// Matches C's `wake_up_pollfree()`.
     #[inline]
-    #[expect(unused)]
     pub(super) fn wake_up_pollfree(&self) {
         // SAFETY: `wait_queue_head` points to valid memory.
         unsafe { bindings::__wake_up_pollfree(self.wait_queue_head.get()) };
-- 
2.56.0

