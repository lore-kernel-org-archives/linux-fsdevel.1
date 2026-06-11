Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E4E3BB68F
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170163; cv=none; b=lgS6cJCbhg9Yv+oQCNOfAAYs4Xzb2PqExXG+MhtoYH+M6tQieqCti6DYBUVNbP+O69zxOqfYgrH44DcKQ1yvYuuz1VkKYuTa21YuDfD5w1TuFwM+CYtxUsCvzqobCc0co+P0GPTAj2254lKVqzrXMohMYZUiDtUhZ6mV2rxbh+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170163; c=relaxed/simple;
	bh=AoyijZYrXWJlNT7tfAdWNZxkT4dPqvu3zDJVwaV/nYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HSs12i2Q2z2QrYKS+FJXr/yzHKvw6rVyL3iRJGDTO87eWUSmHYO4QrGz4dnkTmvklAK7MNBUeZI82hI3Ay3+hewqstya4MLBkJArdpwBtQpM2ljabVsypqjVG4zRQxnrq36cqFP/FW/wVYSlaz+kaQv8LpQJQu8uNzzlwu86XWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkAXUqFK; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkAXUqFK"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-46016bedbaaso3814103f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 02:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781170159; x=1781774959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mphscAFjnFy4ybtIeT18ZIxWm8T5THYSBs/hbomTrAY=;
        b=hkAXUqFKFdLXM8uuB16p592g8tFI56MuuYGmxurzSPyCbOUaCHlcCissmqOgZVdBvZ
         jX3ulVx+OKLvxe0NXL1/eAB3++JU7/Q398+n9hXU4abAEnu8nfP/UQjJQjnOA3d+GgZ4
         X69QXpT5NKflm1JmvNpSRkkyFqYJ0a3DPhUyxJKe8bNFVtdaLmoJiXiRNK2APWUMO37z
         v+sxDVV9wOVPniXIlUgkngN9Zuj/VoHKGyyHXz7tzhIeM2i3bmX3S5ANDb2RYyT2DoQA
         Yv0qFPUCyeH2GUgyfnSCki9+rIAW3RSW4fS6Nel2w1MyTJh6lcCb5zEkf+9H91VL+INo
         rouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170159; x=1781774959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mphscAFjnFy4ybtIeT18ZIxWm8T5THYSBs/hbomTrAY=;
        b=qbnBaYyuuN8K8sJO5rT+J2pSTOfcbelGPawYPdgxw0p6u3ezphA8x1TTAiNbeZw7b6
         FJEkPolTNauM1u7V3UO8lSVqZEjBA/KiQL3jlGH8oaslMrYkFJNIFIxrc8iI0xp+vXoE
         qEI9vOvTHuhfqo+GQgezhc6YS+wDb/mh7kpxUcfeQq55uawSWX+tqvw5GT/Bg+d7f+/k
         WsDGiRxtvbZ+aa9miS/7+HL1Fe0bxkY9JEBQzmDgNMwI1X086xfi8EnJmgMgTV16ux5R
         4mnXvzCeLCs98t5aMIHNnvazMDQ+Q1HbcVGqMpKplSbTFEMBdtXHI1BUWIEtNvdK8riT
         KiRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9inoERt9y5l7XVcJWhhC/JYHJYR+87dPgN8BgAwr9D20ZplWqD2NjzhKeSYajCZnRTFPyZHfl3UxAPJZGW@vger.kernel.org
X-Gm-Message-State: AOJu0YxCU7cDNb9XzQZEGhm5BJfNrs4JFHtSmMY5kcXouAxLUR2ul+G9
	cgfS61VXCAp6JvKl9sSKu4T3lp18lHUeOkadswsA7zfPUT/msFRprnVu654RF0mTdzmCxqGOEFq
	SkMJxHUqvz5Gs3+1KvA==
X-Received: from wmpi26.prod.google.com ([2002:a05:600c:4b1a:b0:48f:dc9f:6f1a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c093:b0:490:b28d:a6f9 with SMTP id 5b1f17b1804b1-490e55d4a5bmr23696565e9.8.1781170159264;
 Thu, 11 Jun 2026 02:29:19 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:29:01 +0000
In-Reply-To: <20260611-upgrade-poll-v5-0-497a11c06828@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611-upgrade-poll-v5-0-497a11c06828@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=17915; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=AoyijZYrXWJlNT7tfAdWNZxkT4dPqvu3zDJVwaV/nYY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqKn/pQFEA2XIVJlm2+LBHe6toRW9d/1TTbJhRf
 HR+vxTf+36JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaip/6QAKCRAEWL7uWMY5
 Ru1vEACjuCsEaei8rYHxznABYXouuDAHvivyvIqvG50WiJ2LsV/pFraXFR+oVassya97zFnxnns
 6a0TIvDBGYjC0OTSNL74fbRsOcVNVJqLe6Rt9CwHuJynTbdSiTHoEj+mS6jeJE4J1nlmeF6ZlF+
 uQXtwPiXvxFPud/qOEKFT7GjyH3O4tQwAf3PtIBHaXIE8Xsmm2VOvQxqvdI0GjOOuk4cSJ5DByR
 qIPoN/3G1Jo+L+ql4NEnOKrjXH8bv1mydU9WANf+Ly5szSI2jsNKt6wjQmNzlE1DZZ3Jb2yOQfq
 IhCCboBORz8OA4LlIldS+SwJ5SPCvuIk1P0ofCrST4gkgX3lAhTJG0+MZK6VPQ2CVp10C1V+q4o
 lCqU5HWIyVCMOlaU8pyNhUoPAmMSHvOeu6kDvnkbv66nq1LLoc0djpdZimH+/XFatvSZTGdty/Z
 n3WocwYSou9PB0jqFDJWd3+6wnOZZu5Fy4bOdIEWBC0ruKmCsswSbYwkUgl4VF+1qb/SHG7pRzI
 TdKmimb09Dooi773jwUmrRT0Qde8Y6OVuRG+y8oAchHa0O2OospnQdbLKGfpS+NPmRu5qPmwqAT
 RuaY8+N37AP1kkDGu2pxZ1t0hBYoXCY8t4ngJUPEEcwmFAH0PW76QMGwSXb++7G2K4dqj/XyLfi T2O+9eAnowDOo3Q==
X-Mailer: b4 0.14.3
Message-ID: <20260611-upgrade-poll-v5-2-497a11c06828@google.com>
Subject: [PATCH v5 2/2] rust_binder: move (e)poll wait queue to Process
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Christian Brauner <brauner@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Most processes do not use Rust Binder with epoll, so avoid paying the
synchronize_rcu() cost in drop for those that don't need it. For those
that do, we also manage to replace synchronize_rcu() with kfree_rcu(),
though we introduce an extra allocation.

In case the last ref to an Arc<Thread> is dropped outside of
deferred_release(), this also ensures that synchronize_rcu() is not
called in destructor of Arc<Thread> in other places. Theoretically that
could lead to jank by making other syscalls slow, which would be
problematic.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/node.rs        |  4 +-
 drivers/android/binder/process.rs     | 67 ++++++++++++++++++++++--------
 drivers/android/binder/thread.rs      | 78 +++++++++++++++++------------------
 drivers/android/binder/transaction.rs |  6 ++-
 4 files changed, 95 insertions(+), 60 deletions(-)

diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
index fb27674a8c94..8041677908fd 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -536,7 +536,7 @@ pub(crate) fn submit_oneway(
             inner.oneway_todo.push_back(transaction);
         } else {
             inner.has_oneway_transaction = true;
-            guard.push_work(transaction)?;
+            guard.push_work(&self.owner, transaction)?;
         }
         Ok(())
     }
@@ -568,7 +568,7 @@ pub(crate) fn pending_oneway_finished(&self) {
         let transaction = inner.oneway_todo.pop_front();
         inner.has_oneway_transaction = transaction.is_some();
         if let Some(transaction) = transaction {
-            match guard.push_work(transaction) {
+            match guard.push_work(&self.owner, transaction) {
                 Ok(()) => {}
                 Err((_err, work)) => {
                     // Process is dead.
diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 82c34a93660e..fd09e177f7e8 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -30,7 +30,8 @@
     sync::{
         aref::ARef,
         lock::{spinlock::SpinLockBackend, Guard},
-        Arc, ArcBorrow, CondVar, CondVarTimeoutResult, SpinLock, UniqueArc,
+        poll::PollCondVarBox,
+        Arc, ArcBorrow, CondVar, CondVarTimeoutResult, SetOnce, SpinLock, UniqueArc,
     },
     task::Task,
     uaccess::{UserSlice, UserSliceReader},
@@ -172,21 +173,26 @@ fn new() -> Self {
     /// taken while holding the inner process lock.
     pub(crate) fn push_work(
         &mut self,
+        proc: &Process,
         work: DLArc<dyn DeliverToRead>,
     ) -> Result<(), (BinderError, DLArc<dyn DeliverToRead>)> {
+        let sync = work.should_sync_wakeup();
+
         // Try to find a ready thread to which to push the work.
         if let Some(thread) = self.ready_threads.pop_front() {
             // Push to thread while holding state lock. This prevents the thread from giving up
             // (for example, because of a signal) when we're about to deliver work.
-            match thread.push_work(work) {
+            match thread.push_work_inner(work, sync) {
                 PushWorkRes::Ok => Ok(()),
+                PushWorkRes::OkNotifyPoll => {
+                    proc.notify_poll(sync);
+                    Ok(())
+                }
                 PushWorkRes::FailedDead(work) => Err((BinderError::new_dead(), work)),
             }
         } else if self.is_dead {
             Err((BinderError::new_dead(), work))
         } else {
-            let sync = work.should_sync_wakeup();
-
             // Didn't find a thread waiting for proc work; this can happen
             // in two scenarios:
             // 1. All threads are busy handling transactions
@@ -194,17 +200,12 @@ pub(crate) fn push_work(
             //    the kernel driver soon and pick up this work.
             // 2. Threads are using the (e)poll interface, in which case
             //    they may be blocked on the waitqueue without having been
-            //    added to waiting_threads. For this case, we just iterate
-            //    over all threads not handling transaction work, and
-            //    wake them all up. We wake all because we don't know whether
-            //    a thread that called into (e)poll is handling non-binder
-            //    work currently.
+            //    added to waiting_threads. For this case, we wake it up
+            //    directly.
             self.work.push_back(work);
 
             // Wake up polling threads, if any.
-            for thread in self.threads.values() {
-                thread.notify_if_poll_ready(sync);
-            }
+            proc.notify_poll(sync);
 
             Ok(())
         }
@@ -227,11 +228,11 @@ pub(crate) fn update_node_refcount(
 
         // If we decided that we need to push work, push either to the process or to a thread if
         // one is specified.
-        if let Some(node) = push {
+        if let Some(pnode) = push {
             if let Some(thread) = othread {
-                thread.push_work_deferred(node);
+                thread.push_work_deferred(pnode);
             } else {
-                let _ = self.push_work(node);
+                let _ = self.push_work(&node.owner, pnode);
                 // Nothing to do: `push_work` may fail if the process is dead, but that's ok as in
                 // that case, it doesn't care about the notification.
             }
@@ -457,6 +458,12 @@ pub(crate) struct Process {
     #[pin]
     node_refs: SpinLock<ProcessNodeRefs>,
 
+    // Synchronizes `register_wait` calls to the `PollCondVarBox`.
+    //
+    // The `PollCondVarBox` is not stored here because synchronization is
+    // done for `register_wait` only. Wakeups do not take this lock.
+    poll: SetOnce<PollCondVarBox>,
+
     // Work node for deferred work item.
     #[pin]
     defer_work: Work<Process>,
@@ -516,6 +523,7 @@ fn new(ctx: Arc<Context>, cred: ARef<Credential>) -> Result<Arc<Self>> {
                 defer_work <- kernel::new_work!("Process::defer_work"),
                 links <- ListLinks::new(),
                 stats: BinderStats::new(),
+                poll: SetOnce::new(),
             }),
             GFP_KERNEL,
         )?;
@@ -715,7 +723,7 @@ fn get_current_thread(self: ArcBorrow<'_, Self>) -> Result<Arc<Thread>> {
 
     pub(crate) fn push_work(&self, work: DLArc<dyn DeliverToRead>) -> BinderResult {
         // If push_work fails, drop the work item outside the lock.
-        let res = self.inner.lock().push_work(work);
+        let res = self.inner.lock().push_work(self, work);
         match res {
             Ok(()) => Ok(()),
             Err((err, work)) => {
@@ -1004,7 +1012,7 @@ pub(crate) fn inc_ref_done(&self, reader: &mut UserSliceReader, strong: bool) ->
         if let Ok(Some(node)) = inner.get_existing_node(ptr, cookie) {
             if let Some(node) = node.inc_ref_done_locked(strong, &mut inner) {
                 // This only fails if the process is dead.
-                let _ = inner.push_work(node);
+                let _ = inner.push_work(self, node);
             }
         }
         Ok(())
@@ -1521,6 +1529,15 @@ pub(crate) fn ioctl_freeze(&self, info: &BinderFreezeInfo) -> Result {
             }
         }
     }
+
+    pub(crate) fn notify_poll(&self, sync: bool) {
+        if let Some(poll) = self.poll.as_ref() {
+            if sync {
+                poll.notify_sync();
+            }
+            poll.notify_all();
+        }
+    }
 }
 
 fn get_frozen_status(data: UserSlice) -> Result {
@@ -1712,7 +1729,21 @@ pub(crate) fn poll(
         table: PollTable<'_>,
     ) -> Result<u32> {
         let thread = this.get_current_thread()?;
-        let (from_proc, mut mask) = thread.poll(file, table);
+        {
+            let poll = loop {
+                if let Some(poll) = this.poll.as_ref() {
+                    break poll;
+                }
+
+                let poll = PollCondVarBox::new(c"Process::poll", kernel::static_lock_class!())?;
+                // Reuse our existing lock to synchronize callers initializing.
+                let _guard = this.node_refs.lock();
+                this.poll.populate(poll);
+            };
+
+            table.register_wait(file, poll);
+        }
+        let (from_proc, mut mask) = thread.poll()?;
         if mask == 0 && from_proc && !this.inner.lock().work.is_empty() {
             mask |= bindings::POLLIN;
         }
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 97d5f31e8fe3..57016971c065 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -9,15 +9,14 @@
 
 use kernel::{
     bindings,
-    fs::{File, LocalFile},
+    fs::LocalFile,
     list::{AtomicTracker, List, ListArc, ListLinks, TryNewListArc},
     prelude::*,
     security,
     seq_file::SeqFile,
     seq_print,
     sync::atomic::{ordering::Relaxed, Atomic},
-    sync::poll::{PollCondVar, PollTable},
-    sync::{aref::ARef, Arc, SpinLock},
+    sync::{aref::ARef, Arc, CondVar, SpinLock},
     task::Task,
     uaccess::{UserPtr, UserSlice, UserSliceReader},
     uapi,
@@ -225,8 +224,10 @@ fn claim_next(&mut self, size: usize) -> Result<usize> {
     }
 }
 
+#[must_use]
 pub(crate) enum PushWorkRes {
     Ok,
+    OkNotifyPoll,
     FailedDead(DLArc<dyn DeliverToRead>),
 }
 
@@ -234,6 +235,7 @@ impl PushWorkRes {
     fn is_ok(&self) -> bool {
         match self {
             PushWorkRes::Ok => true,
+            PushWorkRes::OkNotifyPoll => true,
             PushWorkRes::FailedDead(_) => false,
         }
     }
@@ -310,27 +312,32 @@ fn pop_work(&mut self) -> Option<DLArc<dyn DeliverToRead>> {
 
     fn push_work(&mut self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
         if self.is_dead {
-            PushWorkRes::FailedDead(work)
+            return PushWorkRes::FailedDead(work);
+        }
+        self.work_list.push_back(work);
+        self.process_work_list = true;
+        if self.looper_flags & LOOPER_POLL != 0 {
+            PushWorkRes::OkNotifyPoll
         } else {
-            self.work_list.push_back(work);
-            self.process_work_list = true;
             PushWorkRes::Ok
         }
     }
 
-    fn push_reply_work(&mut self, code: u32) {
+    fn push_reply_work(&mut self, code: u32) -> PushWorkRes {
         if let Ok(work) = ListArc::try_from_arc(self.reply_work.clone()) {
             work.set_error_code(code);
-            self.push_work(work);
+            self.push_work(work)
         } else {
             pr_warn!("Thread reply work is already in use.");
+            PushWorkRes::Ok
         }
     }
 
     fn push_return_work(&mut self, reply: u32) {
         if let Ok(work) = ListArc::try_from_arc(self.return_work.clone()) {
             work.set_error_code(reply);
-            self.push_work(work);
+            // Not notifying: Reply to current thread.
+            let _ = self.push_work(work);
         } else {
             pr_warn!("Thread return work is already in use.");
         }
@@ -422,7 +429,7 @@ pub(crate) struct Thread {
     #[pin]
     inner: SpinLock<InnerThread>,
     #[pin]
-    work_condvar: PollCondVar,
+    work_condvar: CondVar,
     /// Used to insert this thread into the process' `ready_threads` list.
     ///
     /// INVARIANT: May never be used for any other list than the `self.process.ready_threads`.
@@ -453,7 +460,7 @@ pub(crate) fn new(id: i32, process: Arc<Process>) -> Result<Arc<Self>> {
                 process,
                 task: ARef::from(&**kernel::current!()),
                 inner <- kernel::new_spinlock!(inner, "Thread::inner"),
-                work_condvar <- kernel::new_poll_condvar!("Thread::work_condvar"),
+                work_condvar <- kernel::new_condvar!("Thread::work_condvar"),
                 links <- ListLinks::new(),
                 links_track <- AtomicTracker::new(),
             }),
@@ -617,7 +624,14 @@ fn get_work(self: &Arc<Self>, wait: bool) -> Result<Option<DLArc<dyn DeliverToRe
     /// Returns whether the item was successfully pushed. This can only fail if the thread is dead.
     pub(crate) fn push_work(&self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
         let sync = work.should_sync_wakeup();
+        self.push_work_inner(work, sync)
+    }
 
+    pub(crate) fn push_work_inner(
+        &self,
+        work: DLArc<dyn DeliverToRead>,
+        sync: bool,
+    ) -> PushWorkRes {
         let res = self.inner.lock().push_work(work);
 
         if res.is_ok() {
@@ -636,7 +650,8 @@ pub(crate) fn push_work(&self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
     pub(crate) fn push_work_if_looper(&self, work: DLArc<dyn DeliverToRead>) -> BinderResult {
         let mut inner = self.inner.lock();
         if inner.is_looper() && !inner.is_dead {
-            inner.push_work(work);
+            // Not notifying: Reply to current thread.
+            let _ = inner.push_work(work);
             Ok(())
         } else {
             drop(inner);
@@ -1142,7 +1157,7 @@ fn deliver_single_reply(
             transaction.set_outstanding(&mut self.process.inner.lock());
         }
 
-        {
+        let ret = {
             let mut inner = self.inner.lock();
             if !inner.pop_transaction_replied(transaction) {
                 return false;
@@ -1153,15 +1168,16 @@ fn deliver_single_reply(
             }
 
             match reply {
-                Ok(work) => {
-                    inner.push_work(work);
-                }
+                Ok(work) => inner.push_work(work),
                 Err(code) => inner.push_reply_work(code),
             }
-        }
+        };
 
         // Notify the thread now that we've released the inner lock.
         self.work_condvar.notify_sync();
+        if matches!(ret, PushWorkRes::OkNotifyPoll) {
+            self.process.notify_poll(true);
+        }
         false
     }
 
@@ -1319,7 +1335,8 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
             let process = orig.from.process.clone();
             let allow_fds = orig.flags & TF_ACCEPT_FDS != 0;
             let reply = Transaction::new_reply(self, process, info, allow_fds)?;
-            self.inner.lock().push_work(completion);
+            // Not notifying: Reply to current thread.
+            let _ = self.inner.lock().push_work(completion);
             orig.from.deliver_reply(Ok(reply), &orig);
             Ok(())
         })()
@@ -1351,7 +1368,8 @@ fn oneway_transaction_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> Bin
         };
         let list_completion = DTRWrap::arc_try_new(DeliverCode::new(code))?;
         let completion = list_completion.clone_arc();
-        self.inner.lock().push_work(list_completion);
+        // Not notifying: Reply to current thread.
+        let _ = self.inner.lock().push_work(list_completion);
         match transaction.submit(info) {
             Ok(()) => Ok(()),
             Err(err) => {
@@ -1551,10 +1569,9 @@ pub(crate) fn write_read(self: &Arc<Self>, data: UserSlice, wait: bool) -> Resul
         ret
     }
 
-    pub(crate) fn poll(&self, file: &File, table: PollTable<'_>) -> (bool, u32) {
-        table.register_wait(file, &self.work_condvar);
+    pub(crate) fn poll(&self) -> Result<(bool, u32)> {
         let mut inner = self.inner.lock();
-        (inner.should_use_process_work_queue(), inner.poll())
+        Ok((inner.should_use_process_work_queue(), inner.poll()))
     }
 
     /// Make the call to `get_work` or `get_work_local` return immediately, if any.
@@ -1571,26 +1588,9 @@ pub(crate) fn exit_looper(&self) {
         }
     }
 
-    pub(crate) fn notify_if_poll_ready(&self, sync: bool) {
-        // Determine if we need to notify. This requires the lock.
-        let inner = self.inner.lock();
-        let notify = inner.looper_flags & LOOPER_POLL != 0 && inner.should_use_process_work_queue();
-        drop(inner);
-
-        // Now that the lock is no longer held, notify the waiters if we have to.
-        if notify {
-            if sync {
-                self.work_condvar.notify_sync();
-            } else {
-                self.work_condvar.notify_one();
-            }
-        }
-    }
-
     pub(crate) fn release(self: &Arc<Self>) {
         self.inner.lock().is_dead = true;
 
-        //self.work_condvar.clear();
         self.unwind_transaction_stack();
 
         // Cancel all pending work items.
diff --git a/drivers/android/binder/transaction.rs b/drivers/android/binder/transaction.rs
index 1d9b66920a21..474f9d231f85 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -331,11 +331,15 @@ pub(crate) fn submit(self: DLArc<Self>, info: &mut TransactionInfo) -> BinderRes
             crate::trace::trace_transaction(false, &self, Some(&thread.task));
             match thread.push_work(self) {
                 PushWorkRes::Ok => Ok(()),
+                PushWorkRes::OkNotifyPoll => {
+                    process.notify_poll(true);
+                    Ok(())
+                }
                 PushWorkRes::FailedDead(me) => Err((BinderError::new_dead(), me)),
             }
         } else {
             crate::trace::trace_transaction(false, &self, None);
-            process_inner.push_work(self)
+            process_inner.push_work(&process, self)
         };
         drop(process_inner);
 

-- 
2.54.0.1099.g489fc7bff1-goog

