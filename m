Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840417;
	b=w8HlO8vNhl82IMO6IQ3GfYbGoA3Qbv3ixR0JYdH6vH3jUVUEdPXsiGjRDgEf69GRXChg
	 c9FE5nGoScZSRtIEBA+xzkrQ/WrpMeeXlXvQmCYJw4YBcfZN4EBm5p+5jl55eSj83TLM8
	 dEtP+aSIdDjpiOXM6sZ0sg15Z9sm+jCwgaAj6bKl2goSPGii4by2L2XGxTJyXjrBFrD2d
	 GxOciNlqsbcsRpubJnPi3Xy3ZQ8Xg0TD2h3A72jZ53ZcUohQ0ac5nv6JtY2LGrwy3M/b1
	 ut/dGBfsM7NjINlaH396XAepF1yZXNkkxHc21Za6GF0fDIU0h8uNNRdMShtaYnHzT8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840417;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hqngGP2EEz7LKusotDt3yULQ6cp3tts5hmv5W17xHKk=;
	b=DQRvPBHCcyazHmkv/0U7EW7+2W2qeWYY8n/yxC5v3RFYaeGZx/vPCynSJE3yrgPIxrnM
	 SGSdO8Xu9GJo/+kAkF43/VVqIzS7hyCppEenx8mot+vv1B6UwXslmIKyMndxEvGfxiODB
	 t7Ql7bNRIe6icKHcK5yzQdVrj7t18lklzt580OCC01IE2ZRC7y/aIdnWpeZgqKZtpYTEa
	 Li/l9OW7/EVnxEGqm4aig/Ost/GsYiPuO9pPVfdF1cwzbSmD/XuGP34j+ikH4/SvdkEj8
	 dRzUpmLgZgcsamUkQ1Xw3Rx0qlDL+TvwpkLoC6Bn2CnoolvJvsfJGPAASltmITmLWbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lKQl7Y2+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2096606A339;
	Thu,  5 Nov 2026 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lKQl7Y2+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C4E1F000C1;
	Thu,  5 Nov 2026 01:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840416;
	bh=hqngGP2EEz7LKusotDt3yULQ6cp3tts5hmv5W17xHKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lKQl7Y2+IZ0RUK5vX+iOrN5zcRAHLYvBVPgle5ayIzeGIR1YRnPIfDND3H4kOm9AG
	 5sCd0NSUpJuOfChrkw6O/z4Xgv6LcZyKVhVknz49uyDYkofRX/deWRp14q5aoEcxC7
	 E+xkhLm0Bq3tN5Qb5l5kHz6pGtfHF6v3/uG/P/5sSfu+TBICu6f+rU/edD8p8YbDSl
	 IwR0xNwgwVcK0XVJeABkYCdezT/kc5877iDK/elYbCeAtzMtX8oaQfGIoR+JZVr0K4
	 D0Zm3KhDtdwn3xweOuJ9KY196akGfwFj1WrE9XxxWOBmyed8SiWfiuRExd2LAvhlnz
	 y5aEwqdXL9n0g==
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
Subject: [PATCH v2 4/5] rust: sync: condvar: use task::schedule_timeout()
Date: Thu,  5 Nov 2026 01:59:41 +0100
Message-ID: <20261105005951.756157-5-dakr@kernel.org>
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

Convert CondVar::wait_internal() from calling
bindings::schedule_timeout() directly to using the safe
task::schedule_timeout() wrapper. This removes the unsafe call and the
Jiffies-to-c_long conversion from CondVar, since the wrapper handles it.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/sync/condvar.rs | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 78a5f10d68fa..fcab90f6ce34 100644
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
2.56.0

