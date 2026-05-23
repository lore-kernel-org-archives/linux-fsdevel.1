Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82783348875
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779521475; cv=none; b=e/rGjZZCypcTPcVwZiL2Q8+/z7b3RrkXdyKEPq2E2jnwePEkFXtoFSFlQvaDkcylhnV7fM2neBejulG2PZllAHg4laFmdo3SfHIpSIL5YA9JxtvuCb15ajssjz1Tey9ZwGwLneR0sTM8ArHOJ6QleQwWIXG4pE85EwpIH+B19ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779521475; c=relaxed/simple;
	bh=yFY7UOU204U56FFouEe4824rGLY/b4dnz9zmw97BTnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XCZcpSYpVIM6a7NAF7Oa2X9k2RyH1QFWf9TzxyDcNjf757OvNIfRGIj5jOekk5uGwDeNepstxCdmgfwvComf9CMa20bBnZEr7d9QDDBscQB+VlqmHOB6WvLvthK/eiCpjUkWmaRQKtcUThNGiiUnN5t5C0C8t/uAh+3XvqerHV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lk0GhpYB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lk0GhpYB"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so5077035e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779521472; x=1780126272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPMNyVxj4vwISQchDGotmmLEW6H9drbn28Eb6PwFhzQ=;
        b=lk0GhpYBKU+DDFCft8aJYKxA9inIzs4C8XDOy+w+KIlVPLBx0ROnIWq/ln3iAIuVpR
         S3PaBmsiXzTBugPigB/jAvHz5Jo56wbizSfsHpdufUMuj+G9uQXXVpuCFTJJM13G1Xwt
         pYXiZGuAML42+pwnBUnxrv0EURHqGpW0au8yUN+zjprJH4b8/diIVbaa5a8vjkW2Gd+V
         Fk4tZR4+ygGAYEH7xhHaYpZg/5Vq3e2egDGBawUsyLHYFoXh/enYzYb5IQ7GbmcFSx/B
         6W8FbRwdZmrxgKWSR9PaUUt787XTDBPIVmHWTiQ+77UhEw1PhPdSdBH4MYoj1RriTLSi
         Uwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779521472; x=1780126272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPMNyVxj4vwISQchDGotmmLEW6H9drbn28Eb6PwFhzQ=;
        b=oBmIQck2TxO+9Pc5E8MiifA4Xs+7hfdblaimz+CEoXLjDvWpLx6U3yfJtSdR6E5am6
         bQmIx1jWYJWmeHOkjbBqQ/X4O6vzW0nfUfKnMuuKG8OElhgkPoudKHBW4p1D81zr/qAU
         1wOfg8KXPW+oUxUIzZUGWXk5ldbsWHE8TFKqJPjYW0teZyH+Xhm0QBjtLpvBiyL8cH/y
         KLDJNcJwC7Em5Ind8lzxukkUJG8DSTYaxpNLIRNIoGdIhgcCJ9zMJYdaQmOaKAEIJ3G0
         Vp4VWHSKl41kfaVhpk/SJwH+7E1Vp75KMj9/DXb1V2R4SueiGtBnkHCee0Y8mgC/g3kh
         J8Hg==
X-Forwarded-Encrypted: i=1; AFNElJ/hIrNXhb2/yG+D0qRWf+eO8ZOTKnJlQt/ok+KsET2b6gat2vI5OY2u6A3FjLElW7r6PJUM9VBHTeg1ydQK@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRuSKCjUecMhwnRYNSAfJGvlMMNYJJTCWG1o8lAEozb87D2eE
	PYckz59FliA+L/G1zF6EnloyOXjRO5flWBvnbPlw+nR60QSSIeTahFuixNNcryNj5M5PWmcOi3G
	4eN70Nymg1RcRQ2hOFw==
X-Received: from wmbet15.prod.google.com ([2002:a05:600c:818f:b0:490:3dc3:e5bb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a402:b0:48f:e6de:1cba with SMTP id 5b1f17b1804b1-490426c5b3emr86380125e9.17.1779521471795;
 Sat, 23 May 2026 00:31:11 -0700 (PDT)
Date: Sat, 23 May 2026 07:31:00 +0000
In-Reply-To: <20260523-upgrade-poll-v4-0-f5b4c747eac2@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523-upgrade-poll-v4-0-f5b4c747eac2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=18003; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=yFY7UOU204U56FFouEe4824rGLY/b4dnz9zmw97BTnA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqEVe66TuRjeZf9MT3ej4PCWEaGa9KhbQJSVves
 ATN/ZYsJ/KJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCahFXugAKCRAEWL7uWMY5
 Ri6cD/9cOgKS4ddRZ9YhzSd76bR1laJ2jgl7B3dh0Zo5TzSpdTN9nngN4UqqPKr3vXxlrwNxmvs
 diJiH4JEu5nmAn4xk46HkNjcvcdFnIsfx1lkyTOEefmx0qC48/ZSTNEg2TNs6DDSKFYIgIexJGH
 ZhOQ8BGiFVJ7YjHwaHc0MSZu5DrjLMCbWc9PNmDSV1XheIxrv3AvO505KipZseo/J2lILD3GA82
 NX4vH48eIEiWV4r1ngA4zxyp/JlriQcNu+381vpd44oPXSJTyUrv6b36C2nIYpqW/2P1QyVINyJ
 /Rheqh4eX3d0hU6OG2/lgLYDgQmk4kGtYYEX9SwOR61gB89Om27xIIrxI4D4R/ThxHcsc04o/Qh
 PWZHXrF1QLPLFRoOtJFFDRaF1AZMQlSPTSPJOicMC08jkKizU1lLfEXwBOP/8DgNdS+U5wd8snA
 WTxF/IWVEaZ4DP+Gq1loPEU0YhaWcQk75marhr2GBn9Vsr67Cu+HcjirAj/qepK4dVXeQGZvyYn
 sS6LqxXpt5KfqvaAL0X/T1o+8XDqcObblWP406z/RaAMO2ytTsYkIqSNoMpBOJADLgGusf9YVVX
 nnbEaEHz3m2M8BouOdbrWdA+yAuSXfQGK/Ay1xUW9wdtn12ZIHmhqt6cZuo3zeVqiRR0LkM1128 ktXzH0vY7foUwog==
X-Mailer: b4 0.14.3
Message-ID: <20260523-upgrade-poll-v4-2-f5b4c747eac2@google.com>
Subject: [PATCH v4 2/2] rust_binder: move (e)poll wait queue to Process
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
 drivers/android/binder/process.rs     | 74 +++++++++++++++++++++++++--------
 drivers/android/binder/thread.rs      | 78 +++++++++++++++++------------------
 drivers/android/binder/transaction.rs |  6 ++-
 4 files changed, 102 insertions(+), 60 deletions(-)

diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
index 69f757ff7461..865be0fe72c3 100644
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
index 820cbd541435..6a1669fa8a78 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -30,7 +30,15 @@
     sync::{
         aref::ARef,
         lock::{spinlock::SpinLockBackend, Guard},
-        Arc, ArcBorrow, CondVar, CondVarTimeoutResult, Mutex, SpinLock, UniqueArc,
+        poll::PollCondVarBox,
+        Arc,
+        ArcBorrow,
+        CondVar,
+        CondVarTimeoutResult,
+        Mutex,
+        SetOnce,
+        SpinLock,
+        UniqueArc, //
     },
     task::Task,
     uaccess::{UserSlice, UserSliceReader},
@@ -172,21 +180,26 @@ fn new() -> Self {
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
@@ -194,17 +207,12 @@ pub(crate) fn push_work(
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
@@ -227,11 +235,11 @@ pub(crate) fn update_node_refcount(
 
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
@@ -457,6 +465,12 @@ pub(crate) struct Process {
     #[pin]
     node_refs: Mutex<ProcessNodeRefs>,
 
+    // Synchronizes `register_wait` calls to the `PollCondVarBox`.
+    //
+    // The `PollCondVarBox` is not stored here because synchronization is
+    // done for `register_wait` only. Wakeups do not take this lock.
+    poll: SetOnce<PollCondVarBox>,
+
     // Work node for deferred work item.
     #[pin]
     defer_work: Work<Process>,
@@ -516,6 +530,7 @@ fn new(ctx: Arc<Context>, cred: ARef<Credential>) -> Result<Arc<Self>> {
                 defer_work <- kernel::new_work!("Process::defer_work"),
                 links <- ListLinks::new(),
                 stats: BinderStats::new(),
+                poll: SetOnce::new(),
             }),
             GFP_KERNEL,
         )?;
@@ -715,7 +730,7 @@ fn get_current_thread(self: ArcBorrow<'_, Self>) -> Result<Arc<Thread>> {
 
     pub(crate) fn push_work(&self, work: DLArc<dyn DeliverToRead>) -> BinderResult {
         // If push_work fails, drop the work item outside the lock.
-        let res = self.inner.lock().push_work(work);
+        let res = self.inner.lock().push_work(self, work);
         match res {
             Ok(()) => Ok(()),
             Err((err, work)) => {
@@ -994,7 +1009,7 @@ pub(crate) fn inc_ref_done(&self, reader: &mut UserSliceReader, strong: bool) ->
         if let Ok(Some(node)) = inner.get_existing_node(ptr, cookie) {
             if let Some(node) = node.inc_ref_done_locked(strong, &mut inner) {
                 // This only fails if the process is dead.
-                let _ = inner.push_work(node);
+                let _ = inner.push_work(self, node);
             }
         }
         Ok(())
@@ -1505,6 +1520,15 @@ pub(crate) fn ioctl_freeze(&self, info: &BinderFreezeInfo) -> Result {
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
@@ -1696,7 +1720,21 @@ pub(crate) fn poll(
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
+                // Reuse our existing mutex to synchronize callers initializing.
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
index 47d5e4d88b07..475f7f7c29fb 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -322,11 +322,15 @@ pub(crate) fn submit(self: DLArc<Self>, info: &mut TransactionInfo) -> BinderRes
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
2.54.0.746.g67dd491aae-goog

