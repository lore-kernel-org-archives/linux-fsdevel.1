Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197637AA8E
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223393; cv=none; b=DfZUy4qcetVrqZ6lx/ZRjSFRRM+TGb4Cs5qyHHXA9GqUBUl9FJbxlIul7Ypzg8uvBQvXj4HenppY99btuO10BisyDSnKRpac4o4aqLzNatjNB0eQG7zCBE6pewvgTpgxHja3jS4OjpzSfWHZ92qPGuod4TFbqRQOaMdTa3Ivxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223393; c=relaxed/simple;
	bh=7ggYT7Cf6g063n4K/hPOh+tKS9dcGxoYdeOPk9iTix8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=apMddpa/OHWoaFw6XidT5mkNq+n1r/gUXIxTHiO2br28ZW3L2bnjPklVhvEaTuQEmD3UgK0UCHdZr2qAVi4N7IuwBQNpY7YsEJf1+qDfIDWi0Zgpcudq0wRc74lhLu59Cvr0HgUSm6Yb1w2+uFD/Vhy7gu6UeE8HAiKXSlnQuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fm9GDUCK; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fm9GDUCK"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so1428648f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778223386; x=1778828186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyW8IIOCNsLiUtVIwDCGziMFg169iWbV1XdBe620o5g=;
        b=fm9GDUCKSjlNKgZxE8JTlmk+3wSTSuZJoU8jPBDNP/KrFvCOXPs4HprfKhLwDkiG5/
         qufaptpafN+wtcLzAPq/4kw7+YpHWakPZ8H4hJt6jvbfu2RA/Er8TPaF5OUrgilRzucH
         7zAVCCcOJEL53gHYsVwnwW4Z371OScdEd8L/ksGyDqIy0My8FN7ODj+zr4gU1YqP05Pd
         /Rw1ulfZddkSR0hXvCIg2Ui8JyI/yi7pAPNuojwaRbuC+emffxbOHpIwRTmKuUQ00R1G
         6V2+SAkPO6nXd29rzpkYu99HzTphbAF9vGfoyDQGqwSdixA8DCMgqNHxPjV6IcS+yZDr
         GdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778223386; x=1778828186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyW8IIOCNsLiUtVIwDCGziMFg169iWbV1XdBe620o5g=;
        b=O8LgdtY06ZY92n2rNIdQpbMWUzp4uFjKRoR8n1Sz+hessOT0sIy7gMAmfDsRWepUxJ
         Rk7ukbYp6ydUjPkBil7IRYgRAItj/SU2Bnjo4W2b1mrzUrAeneqt50hhg8dFtZPAxlnb
         o242GY79mlkLIg53/qCoqZ38NE3kEjqaWcJ4pPMezVYFlO3rjQPg2XQbRo9FpswL9Ce0
         jYYxzfLAe0i3cklKQ8xCqOZkiAH8+2joxuhDZ7g2fOAG8R08AgFjYxqtXhtAa9qpaUF7
         4wtmQ1ThBTafNR1nC1+vtj9jC3pX3bWTee+Hb0oaW1acsGyjnOoqioFJ2nCONCfNBdOo
         zv5w==
X-Forwarded-Encrypted: i=1; AFNElJ+bXrXA7txfOyMdR82o8X6IF+VmzbN1O2LF/zE4jLCYIJu0pIdHeS/4a0O5xihS1qpk/NBdpkKiBwqQNvT2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KDly2fmh1LrvegX+0p2hfEqkTxpEQUyuKkCagtM3timEWPvG
	XQjWUNMf+6/zvgC69/d/KLS6Tuu0pwL4uwmSc+Yh43DoHGIQ6Fn93Hkk2xGGBVn6xH9LVNQ8wIb
	iVm3W0sItQ3HnR4k3zw==
X-Received: from wrua3.prod.google.com ([2002:a5d:4d43:0:b0:449:dcfe:7e41])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4381:b0:441:247a:e98e with SMTP id ffacd0b85a97d-4515ce1c738mr17900362f8f.24.1778223385682;
 Thu, 07 May 2026 23:56:25 -0700 (PDT)
Date: Fri, 08 May 2026 06:55:12 +0000
In-Reply-To: <20260508-upgrade-poll-v3-0-0c619fe846e8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508-upgrade-poll-v3-0-0c619fe846e8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=14834; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7ggYT7Cf6g063n4K/hPOh+tKS9dcGxoYdeOPk9iTix8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp/YkVF9kjl9PXk0VnSKuyAEtWQ6InwiiCbMlBi
 yDcDHR+3z2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaf2JFQAKCRAEWL7uWMY5
 RuTOEACIlvXZMK8/IQEOLwBYKrbLUXzotxq90F7esS1PGcaoefsnQJnLqyVzr362IGOnPlKhG61
 aF8IURyNu0G2pN9IB7BCf51cHiOVS2bgMaIBfoB5xmAR/AEvXfU6/b+bQVD5oSB5Aq1PthabEvB
 PTX1RKJJckPyY2jNIICdPdHRK8NbE1/J0+qK6JARWQFgVW3J/zgM5CSCxboYzjyYVedP5QlRzgK
 RCwufetdXuT/JpeJDzfiw6jv0xlY6/oWqV3X3B1MM9IuzAyKw/g2aHlb89K4KnaUqFO2OubHyHT
 u3t+KNeZ+xIT6JYuqLSzW9/wlm+4k17P1y6LLee1VlztPxhop6UL7jKazP+0UM6sIP50kgiLtPw
 M74imUn2M/nU0ixr5l4L+O8D3VEjHwOq0dPLQFMtAT4XAaH48BfX1wwCw8aeepneppaPbTtm5qH
 rt9vBKgSWHTv0pys+yv8HcnREts9tA9Stf/TtZDlT/OVBsPLBN8uOlvcm/1+uPAqTj9yjWbA8B4
 QiKGYmQP2jGL2rRGROpnD1fNDi4Ld3yj5v7NId1qWrgw+mS8UgSVRXS51R+PQ5m3E2QW6slhQ39
 NkSidGredGE1ypCB8gOiCF5IKgQUAInyIptA9lItSZFkkYat1a2WS4uFRkMzjuHa9mdZmuhJRv9 33jzrwGhe5pDwiQ==
X-Mailer: b4 0.14.3
Message-ID: <20260508-upgrade-poll-v3-2-0c619fe846e8@google.com>
Subject: [PATCH v3 2/2] rust_binder: move (e)poll wait queue to Process
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
 drivers/android/binder/process.rs     | 51 +++++++++++++++++------
 drivers/android/binder/thread.rs      | 78 +++++++++++++++++------------------
 drivers/android/binder/transaction.rs |  4 ++
 3 files changed, 82 insertions(+), 51 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 820cbd541435..29fdfc964685 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -30,6 +30,7 @@
     sync::{
         aref::ARef,
         lock::{spinlock::SpinLockBackend, Guard},
+        poll::PollCondVarBox,
         Arc, ArcBorrow, CondVar, CondVarTimeoutResult, Mutex, SpinLock, UniqueArc,
     },
     task::Task,
@@ -135,6 +136,7 @@ pub(crate) struct ProcessInner {
     pub(crate) binderfs_file: Option<BinderfsProcFile>,
     /// Check for oneway spam
     oneway_spam_detection_enabled: bool,
+    poll: Option<PollCondVarBox>,
 }
 
 impl ProcessInner {
@@ -158,6 +160,7 @@ fn new() -> Self {
             async_recv: false,
             binderfs_file: None,
             oneway_spam_detection_enabled: false,
+            poll: None,
         }
     }
 
@@ -174,19 +177,23 @@ pub(crate) fn push_work(
         &mut self,
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
+                    self.notify_poll(sync);
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
@@ -194,22 +201,26 @@ pub(crate) fn push_work(
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
+            self.notify_poll(sync);
 
             Ok(())
         }
     }
 
+    pub(crate) fn notify_poll(&self, sync: bool) {
+        if let Some(poll) = &self.poll {
+            if sync {
+                poll.notify_sync();
+            }
+            poll.notify_all();
+        }
+    }
+
     pub(crate) fn remove_node(&mut self, ptr: u64) {
         self.nodes.remove(&ptr);
     }
@@ -1322,11 +1333,15 @@ fn deferred_flush(&self) {
 
     fn deferred_release(self: Arc<Self>) {
         let is_manager = {
+            // These variables contain values to be dropped after releasing spinlock.
+            let _poll;
+
             let mut inner = self.inner.lock();
             inner.is_dead = true;
             inner.is_frozen = IsFrozen::No;
             inner.sync_recv = false;
             inner.async_recv = false;
+            _poll = inner.poll.take();
             inner.is_manager
         };
 
@@ -1696,7 +1711,19 @@ pub(crate) fn poll(
         table: PollTable<'_>,
     ) -> Result<u32> {
         let thread = this.get_current_thread()?;
-        let (from_proc, mut mask) = thread.poll(file, table);
+        {
+            let mut inner = this.inner.lock();
+            let poll = if let Some(poll) = &inner.poll {
+                &**poll
+            } else {
+                drop(inner);
+                let poll = PollCondVarBox::new(c"Process::poll", kernel::static_lock_class!())?;
+                inner = this.inner.lock();
+                &**inner.poll.get_or_insert(poll)
+            };
+            table.register_wait(file, poll);
+        }
+        let (from_proc, mut mask) = thread.poll()?;
         if mask == 0 && from_proc && !this.inner.lock().work.is_empty() {
             mask |= bindings::POLLIN;
         }
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 97d5f31e8fe3..425c50298706 100644
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
+            self.process.inner.lock().notify_poll(true);
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
index 47d5e4d88b07..3c9620da3d25 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -322,6 +322,10 @@ pub(crate) fn submit(self: DLArc<Self>, info: &mut TransactionInfo) -> BinderRes
             crate::trace::trace_transaction(false, &self, Some(&thread.task));
             match thread.push_work(self) {
                 PushWorkRes::Ok => Ok(()),
+                PushWorkRes::OkNotifyPoll => {
+                    process_inner.notify_poll(true);
+                    Ok(())
+                }
                 PushWorkRes::FailedDead(me) => Err((BinderError::new_dead(), me)),
             }
         } else {

-- 
2.54.0.563.g4f69b47b94-goog

