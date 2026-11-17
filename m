Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874532;
	b=pyF9o9pRTNtqgqk6JyHa07FUqlseOvN4AhsoM3uw9p26L5qNa1a6WeKJbjHaQMvjSwNE
	 fQ69bc1v55zLuOkdt4U/q2dDZdwKDHllqG832k3mxmk1Bt/COqC1UmJlmkE+x9kj1XZGW
	 q286/2ILjplNWYJG2DSd8jPgTMqHMDyY2qVrVj75ZrtQK5NNeu80pSvKOBGmDnrSmwJLp
	 xYwIG9J0R2/WD7By0MGLIoU99HvvdBqcq+6sspjNesIq6eGYMGhewTAnzpJMEjar9YLrh
	 r7up6CeiIGeZcszaHZoYsS/iS7+PBz8wyVDYxe/VEYYU7ECHpJsKuDaD653gs5TUEUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874532;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IvfYcUyIblSEihqaOhriqMjV0kTaYCupOHLg7fBrY8U=;
	b=k0wCJKMrsJbMDruPDZHLcCXlbjBsRi1Fo2TVrt8b2Elt++katnq7psvVFiAvW0MJBysH
	 VlviIBSr78znOe5U6XviY19zx8Ky6vJOP6t1ggcAhnqv8nXdbz4XggohzdB9EDYGEaTEP
	 nYBT8eynSjejKut72rg3paTtPah618AhXEkdO2H4u1UOComYq8+PI0lAcDCAyP5gNLO0s
	 h5Tl6/xXH31KwN/kJEWiR/W44E2pZTfzaeRxvo7C3xwskdiY/45jeeNkZAhhAyjakC9Ws
	 v9bKaweLnxiQ8RZixnY/gQ6iiDi7gjMIRSSKw2lfXw+iitIn6fpFQA9Y9f6iE3yukMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=It3pDpd+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B26606A32F;
	Tue, 17 Nov 2026 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=It3pDpd+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337C91F000C5;
	Tue, 17 Nov 2026 00:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794874532;
	bh=IvfYcUyIblSEihqaOhriqMjV0kTaYCupOHLg7fBrY8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=It3pDpd+0oN/hGSGd9B/5x1DSL3PKO10RuiMqqNo7Bp4oJAYKsu4GERu6fRYow0tK
	 Sd4PDJneF072Tg6+PLD0OaOPkoqGR+kPy0xjBrKc7X2UucvFDao4JMx6uxstsnXUGy
	 ytcMXuAa0us903P7yVRc2CuGXb5T17dM4gjnGnrsgq9N8mxcSKEQfu+L9Hl1LyTcG+
	 s2CcmogCtL8Z+b/d5mWec0fsMHXnUP8mZobjQCbiO+m2PR/CrOzFehIAiR46EwAgXW
	 Qn6CmkROUYSGqrdLkEiBHa8fpAopTyVm2f4ztXwSsLwsNLNg0LLYyW9T4qOliNXvzi
	 4WEgOO+qLo/fA==
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
Subject: [PATCH v3 4/5] rust: sync: condvar: use task::schedule_timeout()
Date: Tue, 17 Nov 2026 01:14:45 +0100
Message-ID: <20261117001507.1611984-5-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117001507.1611984-1-dakr@kernel.org>
References: <20261117001507.1611984-1-dakr@kernel.org>
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
task::schedule_timeout() wrapper. This removes the unsafe call from
CondVar.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/sync/condvar.rs | 42 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 2deeaf2038e4..dae07dc140c5 100644
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
@@ -107,11 +107,10 @@ fn wait_internal<T: ?Sized, B: Backend>(
         &self,
         wait_state: c_int,
         guard: &mut Guard<'_, T, B>,
-        timeout_in_jiffies: c_long,
-    ) -> c_long {
+        timeout: Delta<Jiffy>,
+    ) -> Delta<Jiffy> {
         self.wq.wait_once_exclusive(wait_state, || {
-            // SAFETY: Switches to another thread. The timeout can be any number.
-            guard.do_unlocked(|| unsafe { bindings::schedule_timeout(timeout_in_jiffies) })
+            guard.do_unlocked(|| task::schedule_timeout(timeout))
         })
     }
 
@@ -122,7 +121,11 @@ fn wait_internal<T: ?Sized, B: Backend>(
     /// [`CondVar::notify_one`] or [`CondVar::notify_all`]. Note that it may also wake up
     /// spuriously.
     pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
-        self.wait_internal(TASK_UNINTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
+        self.wait_internal(
+            TASK_UNINTERRUPTIBLE,
+            guard,
+            Delta::from_jiffies(task::MAX_SCHEDULE_TIMEOUT),
+        );
     }
 
     /// Releases the lock and waits for a notification in interruptible mode.
@@ -133,7 +136,11 @@ pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
     /// Returns whether there is a signal pending.
     #[must_use = "wait_interruptible returns if a signal is pending, so the caller must check the return value"]
     pub fn wait_interruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
-        self.wait_internal(TASK_INTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
+        self.wait_internal(
+            TASK_INTERRUPTIBLE,
+            guard,
+            Delta::from_jiffies(task::MAX_SCHEDULE_TIMEOUT),
+        );
         crate::current!().signal_pending()
     }
 
@@ -151,7 +158,7 @@ pub fn wait_interruptible_freezable<T: ?Sized, B: Backend>(
         self.wait_internal(
             TASK_INTERRUPTIBLE | TASK_FREEZABLE,
             guard,
-            MAX_SCHEDULE_TIMEOUT,
+            Delta::from_jiffies(task::MAX_SCHEDULE_TIMEOUT),
         );
         crate::current!().signal_pending()
     }
@@ -169,21 +176,12 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
         guard: &mut Guard<'_, T, B>,
         timeout: Delta<Jiffy>,
     ) -> CondVarTimeoutResult {
-        let jiffies = timeout.as_jiffies();
-        let res = self.wait_internal(
-            TASK_INTERRUPTIBLE,
-            guard,
-            jiffies.clamp(0, MAX_SCHEDULE_TIMEOUT),
-        );
+        let remaining = self.wait_internal(TASK_INTERRUPTIBLE, guard, timeout);
 
-        match (res, crate::current!().signal_pending()) {
-            (remainder, true) => CondVarTimeoutResult::Signal {
-                remainder: Delta::from_jiffies(remainder),
-            },
-            (0, false) => CondVarTimeoutResult::Timeout,
-            (remainder, false) => CondVarTimeoutResult::Woken {
-                remainder: Delta::from_jiffies(remainder),
-            },
+        match (remaining, current!().signal_pending()) {
+            (remainder, true) => CondVarTimeoutResult::Signal { remainder },
+            (Delta::ZERO, false) => CondVarTimeoutResult::Timeout,
+            (remainder, false) => CondVarTimeoutResult::Woken { remainder },
         }
     }
 
-- 
2.56.1

