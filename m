Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581773C944A;
	Sun, 26 Jul 2026 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785105413; cv=none; b=rPf+v4EXInEwpAXFcWz7h+njeT+R0OOVv4zDAk8JsC7Q5guijr+VIzLP/mM6Tw0gMJJjkpifQt32XP/uMWXznUBGskit/CgmkA+R79nk7g1XbT4/08W+wWx5mQi32xNGsk8uDLe80qW4ku4G5sZObpkeNw1g1pVuTZYhKcCJHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785105413; c=relaxed/simple;
	bh=RwOcHRHOPuUNMTe8LSKZax+JAOOueAwIt6Y1bv0ZSPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsSofKJFxKdxX4bsXMMkjOIRCWkFewNd5pEEG32qNskzNOv5vN/FeyczsUaKwIOrFf6SQk2syjjXZvp06xDGwqJ1g1H6Cps8BMc4qKLBv0d6oLZGne2bkVAHOR13QomYu43CmdCsdH2uDnRktsAQU45CZUqHa+EESoyMI5dJaUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfOso9Nk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfOso9Nk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE531F000E9;
	Sun, 26 Jul 2026 22:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785105412;
	bh=BuuMHcwwHoQYeNARgV7jNOjm3OKkZafF367tiODag74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kfOso9Nkql9kDMfdZN9BZNLZboJw/fvxcAgqrmktwtqv1LPAO/laqHn4NzG34AdE9
	 ELd16YR89O17wA4muuUEKKKXpm2a2A4tleq8rBs22vj9z2YspMYQ5oJwUlc/2PvwIF
	 e5vQhxPcMRw4E3JTpjqCWwwdCmytyWEYIuhLsKZ6r0iFNSubZtImU2s0pAGRDIQkqW
	 ncDzwFB7EWVipwputd7ZEI7F5oCQSvqrVU+/TPAdZAJxJxQKS44I/08fzHgliwtssK
	 dqR/eRcu7enWAku4vD5QvKVrXZKxZPAZ8NL/LHtDcN1zY+RZSSz4Wl6ZE1j1ri4o6Z
	 wLuvcAzkb9URQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	brauner@kernel.org,
	cmllamas@google.com,
	aliceryhl@google.com,
	boqun@kernel.org,
	gary@garyguo.net,
	lyude@redhat.com,
	daniel.almeida@collabora.com,
	work@onurozkan.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	ojeda@kernel.org,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	tamird@kernel.org,
	acourbot@nvidia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	tj@kernel.org,
	jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 4/5] rust: sync: convert CondVar and PollCondVar to use WaitQueue
Date: Mon, 27 Jul 2026 00:36:10 +0200
Message-ID: <20260726223613.1242940-5-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726223613.1242940-1-dakr@kernel.org>
References: <20260726223613.1242940-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
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
 rust/kernel/sync/condvar.rs | 86 +++++++++++--------------------------
 rust/kernel/sync/poll.rs    | 14 +++---
 rust/kernel/sync/wait.rs    |  3 --
 3 files changed, 30 insertions(+), 73 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 69d58dfbad7b..d4bfc936423e 100644
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
@@ -198,19 +174,6 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
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
@@ -218,8 +181,7 @@ fn notify(&self, count: c_int) {
     /// CPU.
     #[inline]
     pub fn notify_sync(&self) {
-        // SAFETY: `wait_queue_head` points to valid memory.
-        unsafe { bindings::__wake_up_sync(self.wait_queue_head.get(), TASK_NORMAL) };
+        self.wq.wake_up_sync();
     }
 
     /// Wakes a single waiter up, if any.
@@ -228,7 +190,7 @@ pub fn notify_sync(&self) {
     /// completely (as opposed to automatically waking up the next waiter).
     #[inline]
     pub fn notify_one(&self) {
-        self.notify(1);
+        self.wq.wake_up();
     }
 
     /// Wakes all waiters up, if any.
@@ -237,7 +199,7 @@ pub fn notify_one(&self) {
     /// completely (as opposed to automatically waking up the next waiter).
     #[inline]
     pub fn notify_all(&self) {
-        self.notify(0);
+        self.wq.wake_up_all();
     }
 }
 
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index 5aa0ce9ba01b..405fb814cc3c 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -58,11 +58,11 @@ pub fn register_wait(&self, file: &File, cv: &PollCondVar) {
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
 
@@ -98,9 +98,7 @@ impl PinnedDrop for PollCondVar {
     #[inline]
     fn drop(self: Pin<&mut Self>) {
         // Clear anything registered using `register_wait`.
-        //
-        // SAFETY: The pointer points at a valid `wait_queue_head`.
-        unsafe { bindings::__wake_up_pollfree(self.inner.wait_queue_head.get()) };
+        self.inner.wq.wake_up_pollfree();
 
         // Wait for epoll items to be properly removed.
         synchronize_rcu();
diff --git a/rust/kernel/sync/wait.rs b/rust/kernel/sync/wait.rs
index ba4ee0f8d4d4..1fd07b03d6ba 100644
--- a/rust/kernel/sync/wait.rs
+++ b/rust/kernel/sync/wait.rs
@@ -102,7 +102,6 @@ pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit
     }
 
     /// Returns a raw pointer to the underlying `wait_queue_head`.
-    #[expect(unused)]
     #[inline]
     pub(super) fn as_raw(&self) -> *mut bindings::wait_queue_head {
         self.wait_queue_head.get()
@@ -213,7 +212,6 @@ fn wait_event_timeout_internal(
 
     /// Performs a single exclusive prepare-to-wait / finish-wait cycle, calling `schedule_fn`
     /// in between.
-    #[expect(unused)]
     pub(super) fn wait_once_exclusive<F, R>(&self, wait_state: c_int, schedule_fn: F) -> R
     where
         F: FnOnce() -> R,
@@ -269,7 +267,6 @@ pub fn wake_up_sync(&self) {
     /// Used when a wait queue is about to be freed, to ensure epoll items are properly removed.
     /// Matches C's `wake_up_pollfree()`.
     #[inline]
-    #[expect(unused)]
     pub(super) fn wake_up_pollfree(&self) {
         // SAFETY: `wait_queue_head` points to valid memory.
         unsafe { bindings::__wake_up_pollfree(self.wait_queue_head.get()) };
-- 
2.55.0

