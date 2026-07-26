Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2503C9EE5;
	Sun, 26 Jul 2026 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785105399; cv=none; b=g5ZGPB1ope+D2cLp+HaDfPO6l+K5i7l8rDHKTjcM6i1c19bbSZdf/oOwYC+2nbtUptVqFE6ZvairaWP8uWJ3qrX8B/p7ovEFPfexApcBuUYIOmub6ApRlLfWIzWDoZPyNoXNvT32vgmT0rhz2Yp4lJcNOiNml3x1JUovTHyr0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785105399; c=relaxed/simple;
	bh=8pJh2Cd/QelbLlTz50jmL4awvrMiK2mgQMK9xL04AyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juJGxCfxYU6+LXmKZITiJdqKA2DFcm8UMV5y92UnyMqFc+5l3ooJEZCKahYwaHQ9h5+FwYh2b55qXN8NluvpY00MjWqfFs8dHIXHBmBxPzKC5CcQklm8rnw9i8AM8BBVcWydxMVWfW9o9+/4eHYivRDYGYZYmUv+aggEQlG6b3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRuKpf1R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRuKpf1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825A31F000E9;
	Sun, 26 Jul 2026 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785105397;
	bh=ZiYmSgDUR/mqRtUuUnBRJoDbF390Jt9loqq8rHQoIgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lRuKpf1RYW8K1LbsH26MKi1h5PLLpYKVhWGIKeqwKxW9RuGUBwceda0ngFYO++0CM
	 mLH0gXBBmRyqRkGBTUkTIOAwzPCY5duRZzrmMsDYXv9XxoGuTUn3FdW6CBhZxggClj
	 rq1RHDNWQE5sSrXjIuBKlMezkTOhe93B6kqx+866xwF6/eIufB0dzy4q9EC9OcpkVQ
	 mFbXBequYN2jH/l/A0FQQpaGLN8Nd9L7fLQhC97P62MD+Y5ojWicfL2KLQ19D8cIct
	 lUk3kRHbMUG/bF/+GNPpwAU/IznBjk8671CpfenKyp1vFXzh3WkgdERypi5Sc0tdfn
	 5xbh7HqiiWOmA==
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
Subject: [PATCH 2/5] rust: workqueue: replace deprecated system_wq with system_{percpu,dfl}_wq
Date: Mon, 27 Jul 2026 00:36:08 +0200
Message-ID: <20260726223613.1242940-3-dakr@kernel.org>
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

system_wq is deprecated and triggers a runtime warning:

	[    0.857414] workqueue: work func ...WorkItemPointerKy0_E3runB7_ enqueued on deprecated workqueue. Use system_{percpu|dfl}_wq instead.

Replace system() with system_percpu() and system_dfl(), to match the
previous behavior of the deprecated system() and convert doc examples
and tests to system_dfl().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/android/binder/process.rs |  4 ++--
 rust/kernel/sync/completion.rs    |  2 +-
 rust/kernel/sync/lock/spinlock.rs |  2 +-
 rust/kernel/workqueue.rs          | 40 +++++++++++++++++++------------
 4 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 96b8440ceac6..c0266fdaa598 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1632,7 +1632,7 @@ pub(crate) fn release(this: Arc<Process>, _file: &File) {
         if should_schedule {
             // Ignore failures to schedule to the workqueue. Those just mean that we're already
             // scheduled for execution.
-            let _ = workqueue::system().enqueue(this);
+            let _ = workqueue::system_percpu().enqueue(this);
         }
 
         drop(binderfs_file);
@@ -1649,7 +1649,7 @@ pub(crate) fn flush(this: ArcBorrow<'_, Process>) -> Result {
         if should_schedule {
             // Ignore failures to schedule to the workqueue. Those just mean that we're already
             // scheduled for execution.
-            let _ = workqueue::system().enqueue(Arc::from(this));
+            let _ = workqueue::system_percpu().enqueue(Arc::from(this));
         }
         Ok(())
     }
diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
index 35ff049ff078..1771bfc0ade2 100644
--- a/rust/kernel/sync/completion.rs
+++ b/rust/kernel/sync/completion.rs
@@ -38,7 +38,7 @@
 ///             done <- Completion::new(),
 ///         }), GFP_KERNEL)?;
 ///
-///         let _ = workqueue::system().enqueue(this.clone());
+///         let _ = workqueue::system_dfl().enqueue(this.clone());
 ///
 ///         Ok(this)
 ///     }
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 069fcdb58735..c6fba8d0f5b2 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -452,7 +452,7 @@ fn run(this: Arc<Self>) {
     fn spinlock_irq_condvar() -> Result {
         let testdata = Test::new()?;
 
-        let _ = workqueue::system().enqueue(testdata.clone());
+        let _ = workqueue::system_dfl().enqueue(testdata.clone());
 
         // Let the updater know when we're ready to wait
         let mut state = testdata.state.lock();
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 7e253b6f299c..3194b9c441aa 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -67,7 +67,7 @@
 //! /// This method will enqueue the struct for execution on the system workqueue, where its value
 //! /// will be printed.
 //! fn print_later(val: Arc<MyStruct>) {
-//!     let _ = workqueue::system().enqueue(val);
+//!     let _ = workqueue::system_dfl().enqueue(val);
 //! }
 //! # print_later(MyStruct::new(42).unwrap());
 //! ```
@@ -121,11 +121,11 @@
 //! }
 //!
 //! fn print_1_later(val: Arc<MyStruct>) {
-//!     let _ = workqueue::system().enqueue::<Arc<MyStruct>, 1>(val);
+//!     let _ = workqueue::system_dfl().enqueue::<Arc<MyStruct>, 1>(val);
 //! }
 //!
 //! fn print_2_later(val: Arc<MyStruct>) {
-//!     let _ = workqueue::system().enqueue::<Arc<MyStruct>, 2>(val);
+//!     let _ = workqueue::system_dfl().enqueue::<Arc<MyStruct>, 2>(val);
 //! }
 //! # print_1_later(MyStruct::new(24, 25).unwrap());
 //! # print_2_later(MyStruct::new(41, 42).unwrap());
@@ -171,13 +171,13 @@
 //! /// This method will enqueue the struct for execution on the system workqueue, where its value
 //! /// will be printed 12 jiffies later.
 //! fn print_later(val: Arc<MyStruct>) {
-//!     let _ = workqueue::system().enqueue_delayed(val, 12);
+//!     let _ = workqueue::system_dfl().enqueue_delayed(val, 12);
 //! }
 //!
 //! /// It is also possible to use the ordinary `enqueue` method together with `DelayedWork`. This
 //! /// is equivalent to calling `enqueue_delayed` with a delay of zero.
 //! fn print_now(val: Arc<MyStruct>) {
-//!     let _ = workqueue::system().enqueue(val);
+//!     let _ = workqueue::system_dfl().enqueue(val);
 //! }
 //! # print_later(MyStruct::new(42).unwrap());
 //! # print_now(MyStruct::new(42).unwrap());
@@ -1024,20 +1024,30 @@ unsafe impl<T, const ID: u64> RawDelayedWorkItem<ID> for ARef<T>
 {
 }
 
-/// Returns the system work queue (`system_wq`).
+/// Returns the system per-cpu work queue (`system_percpu_wq`).
 ///
 /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are
 /// users which expect relatively short queue flush time.
 ///
 /// Callers shouldn't queue work items which can run for too long.
-pub fn system() -> &'static Queue {
-    // SAFETY: `system_wq` is a C global, always available.
-    unsafe { Queue::from_raw(bindings::system_wq) }
+pub fn system_percpu() -> &'static Queue {
+    // SAFETY: `system_percpu_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_percpu_wq) }
+}
+
+/// Returns the system default (unbound) work queue (`system_dfl_wq`).
+///
+/// Workers are not bound to any specific CPU, not concurrency managed, and all queued work items
+/// are executed immediately as long as `max_active` limit is not reached and resources are
+/// available.
+pub fn system_dfl() -> &'static Queue {
+    // SAFETY: `system_dfl_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_dfl_wq) }
 }
 
 /// Returns the system high-priority work queue (`system_highpri_wq`).
 ///
-/// It is similar to the one returned by [`system`] but for work items which require higher
+/// It is similar to the one returned by [`system_percpu`] but for work items which require higher
 /// scheduling priority.
 pub fn system_highpri() -> &'static Queue {
     // SAFETY: `system_highpri_wq` is a C global, always available.
@@ -1046,8 +1056,8 @@ pub fn system_highpri() -> &'static Queue {
 
 /// Returns the system work queue for potentially long-running work items (`system_long_wq`).
 ///
-/// It is similar to the one returned by [`system`] but may host long running work items. Queue
-/// flushing might take relatively long.
+/// It is similar to the one returned by [`system_percpu`] but may host long running work items.
+/// Queue flushing might take relatively long.
 pub fn system_long() -> &'static Queue {
     // SAFETY: `system_long_wq` is a C global, always available.
     unsafe { Queue::from_raw(bindings::system_long_wq) }
@@ -1065,7 +1075,7 @@ pub fn system_unbound() -> &'static Queue {
 
 /// Returns the system freezable work queue (`system_freezable_wq`).
 ///
-/// It is equivalent to the one returned by [`system`] except that it's freezable.
+/// It is equivalent to the one returned by [`system_percpu`] except that it's freezable.
 ///
 /// A freezable workqueue participates in the freeze phase of the system suspend operations. Work
 /// items on the workqueue are drained and no new work item starts execution until thawed.
@@ -1078,7 +1088,7 @@ pub fn system_freezable() -> &'static Queue {
 ///
 /// It is inclined towards saving power and is converted to "unbound" variants if the
 /// `workqueue.power_efficient` kernel parameter is specified; otherwise, it is similar to the one
-/// returned by [`system`].
+/// returned by [`system_percpu`].
 pub fn system_power_efficient() -> &'static Queue {
     // SAFETY: `system_power_efficient_wq` is a C global, always available.
     unsafe { Queue::from_raw(bindings::system_power_efficient_wq) }
@@ -1097,7 +1107,7 @@ pub fn system_freezable_power_efficient() -> &'static Queue {
 
 /// Returns the system bottom halves work queue (`system_bh_wq`).
 ///
-/// It is similar to the one returned by [`system`] but for work items which
+/// It is similar to the one returned by [`system_percpu`] but for work items which
 /// need to run from a softirq context.
 pub fn system_bh() -> &'static Queue {
     // SAFETY: `system_bh_wq` is a C global, always available.
-- 
2.55.0

