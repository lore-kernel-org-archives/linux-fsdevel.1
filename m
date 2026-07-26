Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC33C944A;
	Sun, 26 Jul 2026 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785105406; cv=none; b=MHC+oeGnAivFKb2j3WADtR8gLoB8BnDA6T82rJrao2CXFGy13LjzEiPCjqK50Wcff6jUnwODoBf1LcSFSQweIc3bdrgsk6bB1Nn8hxyX3IVWzSEgg/fYjVCIiXuO0vODicce0rSFWU23XxdXLe7En35VUawEraTadJ+O4kc2mKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785105406; c=relaxed/simple;
	bh=I/3skvzNB4CXOZSbIi48uUMBXFSuXPQU3HH8ZSdnOq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/isc/2twIfGM2CNbv+a52r9xyHb24+s4IjQ3PvtP31jkkMFHjEQ7lnJcgrdwWkD7k3F3PYGH/6p/b1VUqqk1X/sDf1Tj3fe1Qjt3i+ZX6Dui/7DpgeU7jV8Qg7lqo0nQ5O7HgT+zEre3XNsTZGIM8mbN8CLGVtksXJXPc8rKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1VDFq20; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1VDFq20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87281F00A3A;
	Sun, 26 Jul 2026 22:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785105404;
	bh=eGQ5BxgXEIy58txNsaxSDBnOFE7cMcpHymr4qoU3+KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E1VDFq20o/td8suAl0aQZRppt6tsuVZJROTwcOynWZF5HpQFa4cpzmOrUjBru8JZd
	 32Rbjzy9sOlqTVRoUVX/piZrI77aXggbXcCVCfAiSLrZ+RNEwQyydsCRc+Dv9AlAb1
	 t1zCQJzDiW941elZ6ajUSY/v+4Wz+FWRD2SwxmpI6uEGtsH14OnyC2qhMHEBC4+JKT
	 0A+M+Wz+UjhuU8XyCxPlwVWeL3jCSqRU5BhrmhegDJHyNl7bv7xFC+/4qzMJWoDAWv
	 6K4dwvXzejUgzbABDtgWsS92Bg7+Cg0kLfGzpvvTgBTJ9iLMrYf//niEtMZV2XDOHb
	 y/hgkXJvppr4A==
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
Subject: [PATCH 3/5] rust: sync: add WaitQueue infrastructure
Date: Mon, 27 Jul 2026 00:36:09 +0200
Message-ID: <20260726223613.1242940-4-dakr@kernel.org>
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

Implement a wait queue wrapping the kernel's struct wait_queue_head,
with wait_event()-style methods that take a condition closure directly.

The API mirrors the C wait_event() family:

  - wait_event()
  - wait_event_interruptible()
  - wait_event_timeout()
  - wait_event_interruptible_timeout()
  - wake_up() / wake_up_all() / wake_up_sync()

Interruptible and timeout variants return Result<(), WaitError>, where
WaitError maps to ERESTARTSYS (signal) or ETIMEDOUT (timeout).

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/sync.rs      |   6 +
 rust/kernel/sync/wait.rs | 388 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 394 insertions(+)
 create mode 100644 rust/kernel/sync/wait.rs

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index df4f2604ff9b..31f0999e5747 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -21,6 +21,7 @@
 pub mod rcu;
 mod refcount;
 mod set_once;
+mod wait;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use completion::Completion;
@@ -38,6 +39,11 @@
 pub use locked_by::LockedBy;
 pub use refcount::Refcount;
 pub use set_once::SetOnce;
+pub use wait::{
+    new_waitqueue,
+    WaitError,
+    WaitQueue, //
+};
 
 /// Represents a lockdep class.
 ///
diff --git a/rust/kernel/sync/wait.rs b/rust/kernel/sync/wait.rs
new file mode 100644
index 000000000000..ba4ee0f8d4d4
--- /dev/null
+++ b/rust/kernel/sync/wait.rs
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Wait queue.
+//!
+//! C header: [`include/linux/wait.h`](srctree/include/linux/wait.h)
+
+use super::LockClassKey;
+use crate::{
+    prelude::*,
+    str::CStr,
+    task::{
+        self,
+        TASK_INTERRUPTIBLE,
+        TASK_NORMAL,
+        TASK_UNINTERRUPTIBLE, //
+    },
+    time::Jiffies,
+    types::Opaque,
+};
+
+use core::{
+    pin::Pin,
+    ptr, //
+};
+
+/// Creates a [`WaitQueue`] initialiser with the given name and a newly-created lock class.
+#[macro_export]
+macro_rules! new_waitqueue {
+    ($($name:literal)?) => {
+        $crate::sync::WaitQueue::new(
+            $crate::optional_name!($($name)?),
+            $crate::static_lock_class!(),
+        )
+    };
+}
+pub use new_waitqueue;
+
+/// Exposes the kernel's [`struct wait_queue_head`] as a Rust wait queue.
+///
+/// A `WaitQueue` allows a thread to sleep until a caller-supplied condition becomes true,
+/// re-checking the condition on each wake-up. This matches the C `wait_event()` family of macros.
+///
+/// For waiting with a lock guard (the condition variable pattern), use [`CondVar`](super::CondVar)
+/// instead.
+///
+/// Instances of `WaitQueue` need a lock class and to be pinned. The recommended way to create such
+/// instances is with the [`pin_init!`] and [`new_waitqueue!`] macros.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::sync::{
+///     atomic::{
+///         Atomic,
+///         Relaxed,
+///     },
+///     new_waitqueue,
+///     WaitQueue,
+/// };
+///
+/// #[pin_data]
+/// pub struct Example {
+///     value: Atomic<i32>,
+///     #[pin]
+///     queue: WaitQueue,
+/// }
+///
+/// fn wait_for_value(e: &Example, v: i32) {
+///     e.queue.wait_event(|| e.value.load(Relaxed) == v);
+/// }
+///
+/// fn set_value(e: &Example, v: i32) {
+///     e.value.store(v, Relaxed);
+///     e.queue.wake_up();
+/// }
+/// ```
+///
+/// [`struct wait_queue_head`]: srctree/include/linux/wait.h
+#[pin_data]
+pub struct WaitQueue {
+    #[pin]
+    wait_queue_head: Opaque<bindings::wait_queue_head>,
+}
+
+// SAFETY: `WaitQueue` only uses a `struct wait_queue_head`, which is safe to use on any thread.
+unsafe impl Send for WaitQueue {}
+
+// SAFETY: `WaitQueue` only uses a `struct wait_queue_head`, which is safe to use on multiple
+// threads concurrently.
+unsafe impl Sync for WaitQueue {}
+
+impl WaitQueue {
+    /// Constructs a new wait queue initialiser.
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
+        pin_init!(Self {
+            // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
+            // static lifetimes so they live indefinitely.
+            wait_queue_head <- Opaque::ffi_init(|slot| unsafe {
+                bindings::__init_waitqueue_head(slot, name.as_char_ptr(), key.as_ptr())
+            }),
+        })
+    }
+
+    /// Returns a raw pointer to the underlying `wait_queue_head`.
+    #[expect(unused)]
+    #[inline]
+    pub(super) fn as_raw(&self) -> *mut bindings::wait_queue_head {
+        self.wait_queue_head.get()
+    }
+
+    /// Sleeps until the condition returns `true`.
+    ///
+    /// The condition is checked before each sleep and after each wake-up. The wait is
+    /// uninterruptible.
+    #[inline]
+    pub fn wait_event<F: Fn() -> bool>(&self, condition: F) {
+        self.wait_event_timeout_internal(TASK_UNINTERRUPTIBLE, &condition, Jiffies::MAX);
+    }
+
+    /// Sleeps until the condition returns `true` or a signal is received.
+    ///
+    /// Returns `Ok(())` when the condition is met, or `Err(WaitError::Signal)` if interrupted
+    /// by a signal.
+    #[inline]
+    pub fn wait_event_interruptible<F: Fn() -> bool>(&self, condition: F) -> Result<(), WaitError> {
+        self.wait_event_timeout_internal(TASK_INTERRUPTIBLE, &condition, Jiffies::MAX);
+        if !condition() && current!().signal_pending() {
+            Err(WaitError::Signal)
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Sleeps until the condition returns `true` or the timeout expires.
+    ///
+    /// Returns `Ok(())` when the condition is met, or `Err(WaitError::Timeout)` if the timeout
+    /// elapsed first.
+    #[inline]
+    pub fn wait_event_timeout<F: Fn() -> bool>(
+        &self,
+        condition: F,
+        jiffies: Jiffies,
+    ) -> Result<(), WaitError> {
+        let remaining = self.wait_event_timeout_internal(TASK_UNINTERRUPTIBLE, &condition, jiffies);
+        if remaining == 0 && !condition() {
+            Err(WaitError::Timeout)
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Sleeps until the condition returns `true`, a signal is received, or the timeout expires.
+    ///
+    /// Returns `Ok(())` when the condition is met, or `Err(WaitError)` on signal or timeout.
+    #[inline]
+    pub fn wait_event_interruptible_timeout<F: Fn() -> bool>(
+        &self,
+        condition: F,
+        jiffies: Jiffies,
+    ) -> Result<(), WaitError> {
+        let remaining = self.wait_event_timeout_internal(TASK_INTERRUPTIBLE, &condition, jiffies);
+        if condition() {
+            Ok(())
+        } else if current!().signal_pending() {
+            Err(WaitError::Signal)
+        } else if remaining == 0 {
+            Err(WaitError::Timeout)
+        } else {
+            Ok(())
+        }
+    }
+
+    fn wait_event_timeout_internal(
+        &self,
+        wait_state: c_int,
+        condition: &dyn Fn() -> bool,
+        jiffies: Jiffies,
+    ) -> Jiffies {
+        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
+
+        // SAFETY: `wait` points to valid memory.
+        unsafe { bindings::init_wait(wait.get()) };
+
+        let mut remaining = jiffies;
+
+        loop {
+            // SAFETY: Both `wait` and `wait_queue_head` point to valid memory, and `wait` was
+            // initialised by `init_wait()` above.
+            let ret = unsafe {
+                bindings::prepare_to_wait_event(self.wait_queue_head.get(), wait.get(), wait_state)
+            };
+
+            if condition() {
+                break;
+            }
+
+            if ret != 0 || remaining == 0 {
+                break;
+            }
+
+            remaining = task::schedule_timeout(remaining);
+
+            if condition() {
+                break;
+            }
+        }
+
+        // SAFETY: Both `wait` and `wait_queue_head` point to valid memory.
+        unsafe { bindings::finish_wait(self.wait_queue_head.get(), wait.get()) };
+
+        remaining
+    }
+
+    /// Performs a single exclusive prepare-to-wait / finish-wait cycle, calling `schedule_fn`
+    /// in between.
+    #[expect(unused)]
+    pub(super) fn wait_once_exclusive<F, R>(&self, wait_state: c_int, schedule_fn: F) -> R
+    where
+        F: FnOnce() -> R,
+    {
+        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
+
+        // SAFETY: `wait` points to valid memory.
+        unsafe { bindings::init_wait(wait.get()) };
+
+        // SAFETY: Both `wait` and `wait_queue_head` point to valid memory.
+        unsafe {
+            bindings::prepare_to_wait_exclusive(self.wait_queue_head.get(), wait.get(), wait_state)
+        };
+
+        let ret = schedule_fn();
+
+        // SAFETY: Both `wait` and `wait_queue_head` point to valid memory.
+        unsafe { bindings::finish_wait(self.wait_queue_head.get(), wait.get()) };
+
+        ret
+    }
+
+    /// Wakes up waiters.
+    ///
+    /// Wakes all non-exclusive waiters and one exclusive waiter, if any.  Matches C's `wake_up()`.
+    #[inline]
+    pub fn wake_up(&self) {
+        // SAFETY: `wait_queue_head` points to valid memory.
+        unsafe { bindings::__wake_up(self.wait_queue_head.get(), TASK_NORMAL, 1, ptr::null_mut()) };
+    }
+
+    /// Wakes up all waiters.
+    ///
+    /// Wakes all non-exclusive and all exclusive waiters, if any.
+    /// Matches C's `wake_up_all()`.
+    #[inline]
+    pub fn wake_up_all(&self) {
+        // SAFETY: `wait_queue_head` points to valid memory.
+        unsafe { bindings::__wake_up(self.wait_queue_head.get(), TASK_NORMAL, 0, ptr::null_mut()) };
+    }
+
+    /// Like [`wake_up()`](Self::wake_up), but hints to the scheduler that the current task is
+    /// about to sleep, so the woken task should be scheduled on the same CPU to avoid unnecessary
+    /// migration. Matches C's `wake_up_sync()`.
+    #[inline]
+    pub fn wake_up_sync(&self) {
+        // SAFETY: `wait_queue_head` points to valid memory.
+        unsafe { bindings::__wake_up_sync(self.wait_queue_head.get(), TASK_NORMAL) };
+    }
+
+    /// Wakes up all waiters and clears poll registrations.
+    ///
+    /// Used when a wait queue is about to be freed, to ensure epoll items are properly removed.
+    /// Matches C's `wake_up_pollfree()`.
+    #[inline]
+    #[expect(unused)]
+    pub(super) fn wake_up_pollfree(&self) {
+        // SAFETY: `wait_queue_head` points to valid memory.
+        unsafe { bindings::__wake_up_pollfree(self.wait_queue_head.get()) };
+    }
+}
+
+/// Error returned by [`WaitQueue`] wait functions.
+#[derive(Debug, PartialEq)]
+pub enum WaitError {
+    /// Interrupted by a signal.
+    Signal,
+    /// The timeout elapsed without the condition being met.
+    Timeout,
+}
+
+impl From<WaitError> for Error {
+    #[inline]
+    fn from(e: WaitError) -> Error {
+        match e {
+            WaitError::Signal => ERESTARTSYS,
+            WaitError::Timeout => ETIMEDOUT,
+        }
+    }
+}
+
+#[macros::kunit_tests(rust_waitqueue)]
+mod tests {
+    use super::*;
+    use crate::{
+        sync::{
+            atomic::{
+                Atomic,
+                Relaxed, //
+            },
+            Arc,
+        },
+        time::{
+            delay::fsleep,
+            Delta, //
+        },
+        workqueue,
+    };
+
+    #[pin_data]
+    struct State {
+        value: Atomic<i32>,
+        #[pin]
+        wq: WaitQueue,
+    }
+
+    impl State {
+        fn new() -> Result<Arc<Self>> {
+            Arc::pin_init(
+                pin_init!(Self {
+                    value: Atomic::new(0),
+                    wq <- new_waitqueue!(),
+                }),
+                GFP_KERNEL,
+            )
+        }
+    }
+
+    #[test]
+    fn wait_event_from_work() {
+        let s = State::new().unwrap();
+
+        let s2 = s.clone();
+        workqueue::system_dfl()
+            .try_spawn(GFP_KERNEL, move || {
+                s2.value.store(1, Relaxed);
+                s2.wq.wake_up();
+            })
+            .unwrap();
+
+        s.wq.wait_event(|| s.value.load(Relaxed) == 1);
+        assert_eq!(s.value.load(Relaxed), 1);
+    }
+
+    #[test]
+    fn wait_event_condition_already_true() {
+        let s = State::new().unwrap();
+        s.value.store(1, Relaxed);
+
+        s.wq.wait_event(|| s.value.load(Relaxed) == 1);
+        assert_eq!(s.value.load(Relaxed), 1);
+    }
+
+    #[test]
+    fn wait_event_condition_not_yet_met() {
+        let s = State::new().unwrap();
+
+        let s2 = s.clone();
+        workqueue::system_dfl()
+            .try_spawn(GFP_KERNEL, move || {
+                s2.value.store(1, Relaxed);
+                s2.wq.wake_up_all();
+
+                fsleep(Delta::from_millis(50));
+
+                s2.value.store(2, Relaxed);
+                s2.wq.wake_up_all();
+            })
+            .unwrap();
+
+        s.wq.wait_event(|| s.value.load(Relaxed) == 2);
+        assert_eq!(s.value.load(Relaxed), 2);
+    }
+
+    #[test]
+    fn wait_event_timeout_expires() {
+        let s = State::new().unwrap();
+
+        let ret = s.wq.wait_event_timeout(|| s.value.load(Relaxed) == 1, 1);
+        assert_eq!(ret, Err(WaitError::Timeout));
+    }
+}
-- 
2.55.0

