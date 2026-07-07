Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CDC3EFD3D
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421009; cv=none; b=d9yIqUfkz1J+VzPw5f/gxg3rD2BRj2SXQAc9fRPXBlCeJ04nrb7TiTVA6g69szWhK1Ut5RqQwG2knocu8EAtjvtY8od3Kw1+ru/mt6Dc1POCzlmhzxLiN8rZ0G10549PoeVJkLIGPGKqDitVFVxubLDwAwoXgFefS+L09YCp5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421009; c=relaxed/simple;
	bh=OFeLJsljYvjUB3UXhXf026DqD5FdV24LKqsswir3/oU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fIj+r08vKZD6d0t6mD5HRILEclTn0/4ZpFJxhVKq85M3QRUpadwLXa4ZkEd1GcUtztFvHa+Sq/IU/Jz/dtbDFeDbC/ewc82G/F6Qc88FcLvLrTR5sIMfaKnk1ll5ZDi6NKh31xyi0W6F4py5Fkd5QpxSCMh0m+nPV0p0CXbq0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noOZiYi8; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noOZiYi8"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c125bdd01cbso426890466b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783421006; x=1784025806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqY3vHemYyue3yA0zHPy8OsdcBQH+OpF6kr5HkKfmmk=;
        b=noOZiYi8EoxJtYnEdTGNcmSpenSi9tDn6A8hTvSRu1SoduAt1FuA6a0odnHaXdI5DS
         5a/eWTw4EftBo/0i/UfiU6v63asR/KkbZqfuT7XpEa9aqQVW1M76iQMONh1/7TK3LVLh
         Gd3XuEHzuLKeES4n8X9CJwNWxPVQG06MRCW2oDZNovV9FB7WJScS75YcUJLO9ENAZtZ1
         pJijtegFwnjlzFGxkXKOpKTGuZI+aUtaaak4S4oulrWoen+9/vLtEPj6N0BGxQgAjKtB
         xNQ6ZvmxFAKYMaG3mk+B43nsPNhqR5mQwVij5AjTeICTo05m1tjFSmQEuiI03Vfov24D
         79QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783421006; x=1784025806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqY3vHemYyue3yA0zHPy8OsdcBQH+OpF6kr5HkKfmmk=;
        b=UNqYRzBU00vMUwMrr0NHB27CvNrmDTwfvq1KODkd1kZEmL+wehf/1FNMvCfHZ2hGLC
         Uwa28TEwEsVd65TWmPSs6jBYvVqLTvAZfW0B6ppJM82SnZATGqdh4BclU9bIsbUjvsJV
         4f9gawCWDZibU5ognIEIkqBCU3qMB4/5PfwQWt+KRjM3edN4YWdl1PExgYfY4xdybnvo
         A1X6w/+qAxsD9Y+v8bbejtg3g13bM8RTgLbo4Voyeigu5uKqjjYe4/CQE1yxjfK+rWss
         ZPCuvjNZ5oBv7iY6YK6LB1xGRxG8asNuEw7CSs/v6Fg9Zf3iWJaVrjv4NWTs+Rm456+0
         aO/w==
X-Forwarded-Encrypted: i=1; AHgh+RpWtQ/N6pFYW61+a6CeerApPsWd0gEK9wb1GO5r5zXSKz5+qj6Dls4jaS6aixjkTtI1bVMGJFQ/QCj7imJn@vger.kernel.org
X-Gm-Message-State: AOJu0YwW1QRMXTmlCtpbKRBSMJMofCOS+DqTgn4ybrlXoRC+88OSIOwd
	LnLq34lq5iIyb5t6cC+28/DsSAgtkipnzVVw5flH8boQotoChZa1r8F63SHUf5HmGUVQcApDObu
	XMnPdtEheSvHLJDPSIQ==
X-Received: from ejbha8.prod.google.com ([2002:a17:906:a888:b0:c12:aa82:e2dd])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:a087:b0:c12:b17e:f8c with SMTP id a640c23a62f3a-c15a6994b8emr179387666b.65.1783421005731;
 Tue, 07 Jul 2026 03:43:25 -0700 (PDT)
Date: Tue, 07 Jul 2026 10:43:13 +0000
In-Reply-To: <20260707-upgrade-poll-v6-0-4b8fae7bf1d9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707-upgrade-poll-v6-0-4b8fae7bf1d9@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=17931; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=OFeLJsljYvjUB3UXhXf026DqD5FdV24LKqsswir3/oU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqTNhJXMWHWf3k3RSUvxedWFUODNf8Mt7kgQffH
 khGZMQnHhqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCakzYSQAKCRAEWL7uWMY5
 RjsBD/45JtQ8Qwe09YkygkoIDgu+dLPia08mFilz+nqYQXe159Nl4pB1pgTww5coRLkC/XfK6wU
 9jzXn0srKfe6pwWEotKKV9HCK9N5xGjJ0XS2b+JNPb0L69UA6m99MUutOdhQLme+FMzYxMHDrqd
 2ii3weig9KMonPO+FuA9UFxc60uYwCB/ncnhLAkeuirUC+R9haWOgHM5oAyvV5Kt4b4EWJKey0p
 yGQAoKKJKj5PnBBpIU3ewo0DTPe6oZFWPOZgAENXjZR8J0/PFSJznHGoW6+W6qrct2lgCtfvKzM
 04tDU81iQ1M7fJIFuu28ERscj09+NIT6JIoNrF2SgSf46jG7w43A9naOyPDwR8L4Szp8+SlePud
 ngcgRqUPAcQ1t0pcTo9kqM0HTrJxXx2Slcy0ABQ7cvJ434HsTDVB/zaxcywjXickK5Wj1ZWB0U3
 hxnPXp8QC7gqRINmGXYISLBl1BqTpypuAcdQUIiAhx5iHBQjs9mPN3NsmaAJAuILMx/CmlWkDTx
 bYWg727JV1cGivYhXkGe34cOv0O+n31ZgA5C+167KpwDDImV+fQasB4PNVbF7Za+XYd1rZtRJhe
 mLAfWty4ZaqRzaiRk1bUwFeh0CpiNVz0bW89TrpJu57AAQaWQkqJ712m70QjbU3dVkhYQumn9/X inZ3bub2Py+JR8Q==
X-Mailer: b4 0.14.3
Message-ID: <20260707-upgrade-poll-v6-2-4b8fae7bf1d9@google.com>
Subject: [PATCH v6 2/2] rust_binder: move (e)poll wait queue to Process
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
index 59c5ab747bf4..2b0618938a0a 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -538,7 +538,7 @@ pub(crate) fn submit_oneway(
             inner.oneway_todo.push_back(transaction);
         } else {
             inner.has_oneway_transaction = true;
-            guard.push_work(transaction)?;
+            guard.push_work(&self.owner, transaction)?;
         }
         Ok(())
     }
@@ -570,7 +570,7 @@ pub(crate) fn pending_oneway_finished(&self) {
         let transaction = inner.oneway_todo.pop_front();
         inner.has_oneway_transaction = transaction.is_some();
         if let Some(transaction) = transaction {
-            match guard.push_work(transaction) {
+            match guard.push_work(&self.owner, transaction) {
                 Ok(()) => {}
                 Err((_err, work)) => {
                     // Process is dead.
diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 0555c4bd503e..f855d8d9818c 100644
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
     task::{Pid, Task},
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
@@ -1018,7 +1026,7 @@ pub(crate) fn inc_ref_done(&self, reader: &mut UserSliceReader, strong: bool) ->
         if let Ok(Some(node)) = inner.get_existing_node(ptr, cookie) {
             if let Some(node) = node.inc_ref_done_locked(strong, &mut inner) {
                 // This only fails if the process is dead.
-                let _ = inner.push_work(node);
+                let _ = inner.push_work(self, node);
             }
         }
         Ok(())
@@ -1535,6 +1543,15 @@ pub(crate) fn ioctl_freeze(&self, info: &BinderFreezeInfo) -> Result {
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
@@ -1726,7 +1743,21 @@ pub(crate) fn poll(
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
index 33368f7fd551..541ca947cc52 100644
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
@@ -624,7 +631,14 @@ fn get_work(self: &Arc<Self>, wait: bool) -> Result<Option<DLArc<dyn DeliverToRe
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
@@ -643,7 +657,8 @@ pub(crate) fn push_work(&self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
     pub(crate) fn push_work_if_looper(&self, work: DLArc<dyn DeliverToRead>) -> BinderResult {
         let mut inner = self.inner.lock();
         if inner.is_looper() && !inner.is_dead {
-            inner.push_work(work);
+            // Not notifying: Reply to current thread.
+            let _ = inner.push_work(work);
             Ok(())
         } else {
             drop(inner);
@@ -1154,7 +1169,7 @@ fn deliver_single_reply(
             transaction.set_outstanding(&mut self.process.inner.lock());
         }
 
-        {
+        let ret = {
             let mut inner = self.inner.lock();
             if !inner.pop_transaction_replied(transaction) {
                 return false;
@@ -1171,15 +1186,16 @@ fn deliver_single_reply(
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
 
@@ -1349,7 +1365,8 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
             let process = orig.from.process.clone();
             let allow_fds = orig.flags & TF_ACCEPT_FDS != 0;
             let reply = Transaction::new_reply(self, process, info, allow_fds)?;
-            self.inner.lock().push_work(completion);
+            // Not notifying: Reply to current thread.
+            let _ = self.inner.lock().push_work(completion);
             orig.from.deliver_reply(Ok(reply), &orig, None);
             Ok(())
         })()
@@ -1387,7 +1404,8 @@ fn oneway_transaction_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> Bin
         };
         let list_completion = DTRWrap::arc_try_new(DeliverCode::new(code))?;
         let completion = list_completion.clone_arc();
-        self.inner.lock().push_work(list_completion);
+        // Not notifying: Reply to current thread.
+        let _ = self.inner.lock().push_work(list_completion);
         match transaction.submit(info) {
             Ok(()) => Ok(()),
             Err(err) => {
@@ -1589,10 +1607,9 @@ pub(crate) fn write_read(self: &Arc<Self>, data: UserSlice, wait: bool) -> Resul
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
@@ -1609,26 +1626,9 @@ pub(crate) fn exit_looper(&self) {
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
index 6cb7b745c52e..2643cca4a7d6 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -371,11 +371,15 @@ pub(crate) fn submit(self: DLArc<Self>, info: &mut TransactionInfo) -> BinderRes
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
2.55.0.rc2.803.g1fd1e6609c-goog

