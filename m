Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7143BCD28;
	Sun, 26 Jul 2026 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785105423; cv=none; b=M4kJkmcuvZgdNNR5CTCgziVlYXCfGuWKymouJzl8cLoNGrVf1o8Jbv/oROJEd6kqofWN1EZR/RqyRkEQwXjo2hRdJax4TeE/GJuiU58bUhdoMnxBQq+Kw1eaWlvCkP7dzgfjOhgMi28FnDqT9jxswqI0zEWOA6Nc7+pwFuU4TpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785105423; c=relaxed/simple;
	bh=5vXgI+m5SgBSeuxeY3cTP4VMpV2wvLHgJktV4898ZZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwriXdsnGMPVHBaYC70MNVkd8mYGkMCGSJglo4xlhvpTGGluhFG1ozxlU/j489HxmLEw23m08Mdk1XUsfx0HauJFMp/8fFe1vzyPHK0BclTax+HAlXv0adnV8CjMDRFWTSEqzhNeMhkLE6UZ0jQSqlHzg1ykAMxILloLIhWPQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsfunnAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsfunnAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615471F00A3A;
	Sun, 26 Jul 2026 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785105419;
	bh=pg1IjrG9FGQR5IpRmFNTaphIen2dO7e5SWQcaeFog+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WsfunnAlY/iARsA0daxCFzototIG4/vaI0H/BBS3QYXEXLhdyR3UPWRKHH+uUnd8U
	 f10p8q/YREKKZ1X5voS4YaEqTytR5lXdQ5bOp/o3VQzIJoYnovC8eokYdfo0ZCeC9i
	 ZguyH+tztzqXbKWWiChOOq50KQmJiHHpv8DsY6zcb05QKFLRkAu9IdfZv5xhwmaNWD
	 X/fFfbHswzTQXQQGUtphO7U638JOBfxnHFnvEi0I/+LTB57D8N+PejbmYvzUa+8b5D
	 nka61dFRl/ATAZjNOUqWQaM4MqnxqEVcXoHyCGfDgLaHVhgYq/LkmfA4Wac2UINFZm
	 /XfmpUmbDstgg==
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
Subject: [PATCH 5/5] rust: sync: condvar: use task::schedule_timeout()
Date: Mon, 27 Jul 2026 00:36:11 +0200
Message-ID: <20260726223613.1242940-6-dakr@kernel.org>
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

Convert CondVar::wait_internal() from calling
bindings::schedule_timeout() directly to using the safe
task::schedule_timeout() wrapper. This removes the unsafe call and the
Jiffies-to-c_long conversion from CondVar, since the wrapper handles it.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/sync/condvar.rs | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index d4bfc936423e..e1bafaa69ab4 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -16,7 +16,7 @@
     prelude::*,
     str::CStr,
     task::{
-        MAX_SCHEDULE_TIMEOUT,
+        self,
         TASK_FREEZABLE,
         TASK_INTERRUPTIBLE,
         TASK_UNINTERRUPTIBLE, //
@@ -104,11 +104,10 @@ fn wait_internal<T: ?Sized, B: Backend>(
         &self,
         wait_state: c_int,
         guard: &mut Guard<'_, T, B>,
-        timeout_in_jiffies: c_long,
-    ) -> c_long {
+        timeout: Jiffies,
+    ) -> Jiffies {
         self.wq.wait_once_exclusive(wait_state, || {
-            // SAFETY: Switches to another thread. The timeout can be any number.
-            guard.do_unlocked(|| unsafe { bindings::schedule_timeout(timeout_in_jiffies) })
+            guard.do_unlocked(|| task::schedule_timeout(timeout))
         })
     }
 
@@ -119,7 +118,7 @@ fn wait_internal<T: ?Sized, B: Backend>(
     /// [`CondVar::notify_one`] or [`CondVar::notify_all`]. Note that it may also wake up
     /// spuriously.
     pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
-        self.wait_internal(TASK_UNINTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
+        self.wait_internal(TASK_UNINTERRUPTIBLE, guard, Jiffies::MAX);
     }
 
     /// Releases the lock and waits for a notification in interruptible mode.
@@ -130,7 +129,7 @@ pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
     /// Returns whether there is a signal pending.
     #[must_use = "wait_interruptible returns if a signal is pending, so the caller must check the return value"]
     pub fn wait_interruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
-        self.wait_internal(TASK_INTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
+        self.wait_internal(TASK_INTERRUPTIBLE, guard, Jiffies::MAX);
         crate::current!().signal_pending()
     }
 
@@ -145,11 +144,7 @@ pub fn wait_interruptible_freezable<T: ?Sized, B: Backend>(
         &self,
         guard: &mut Guard<'_, T, B>,
     ) -> bool {
-        self.wait_internal(
-            TASK_INTERRUPTIBLE | TASK_FREEZABLE,
-            guard,
-            MAX_SCHEDULE_TIMEOUT,
-        );
+        self.wait_internal(TASK_INTERRUPTIBLE | TASK_FREEZABLE, guard, Jiffies::MAX);
         crate::current!().signal_pending()
     }
 
@@ -164,10 +159,9 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
         guard: &mut Guard<'_, T, B>,
         jiffies: Jiffies,
     ) -> CondVarTimeoutResult {
-        let jiffies = jiffies.try_into().unwrap_or(MAX_SCHEDULE_TIMEOUT);
-        let res = self.wait_internal(TASK_INTERRUPTIBLE, guard, jiffies);
+        let remaining = self.wait_internal(TASK_INTERRUPTIBLE, guard, jiffies);
 
-        match (res as Jiffies, crate::current!().signal_pending()) {
+        match (remaining, current!().signal_pending()) {
             (jiffies, true) => CondVarTimeoutResult::Signal { jiffies },
             (0, false) => CondVarTimeoutResult::Timeout,
             (jiffies, false) => CondVarTimeoutResult::Woken { jiffies },
-- 
2.55.0

