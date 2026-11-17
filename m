Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874537;
	b=ixn4t1Ffng5CeHuWbHrlb2NWaCWG7Bpx6edekEH+PKbSJgNgQP2NbhoGmqYIJrlseYIV
	 4nkP22uQH3O4dZRD4Mh8GUiclHfHZDblQFDNqlRH13D2RsTVopMlG776lHgtpzSGG08Kl
	 dr4QgC/7xkvrnkTQy4LS6vK418awVqk+1lgBtkb1MTNWrnH5viBXybmNYlzBtDHHDcOj+
	 hn08gHHFu+FxFHNqetOqkyLqp9Uy22ok2cUwaXhmf67YlUs0p8jM7ICZS66k0fo6GkQ/8
	 8EWp+lEzD7ULX7E6D3o2xTBxLkUrufqDSEU1SW8I2rDnpcgoBW0rlGbRPl6W7wKJyRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874537;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j9xUHwF2AggMFvcnTZZ+sJUO/Ib8IkqDN6jGp1qclP0=;
	b=oDI10Kf47F+okicTzL/PrxjNBJhJL48kkAcUzTcI4fPNNfiShuGLxpA3/N2ocxTvwZsS
	 J7l3d6+8Hmrzd5DURUZZ1s3vlPmt3sBiR08KrLbNpT0sUdoss0p+mE8lUIpSM4ZvcYLok
	 rO51CpsLhF9RxC67+11Z+Q+eW3OQzyz2kRAd2CocOMBYp8oSIzVbsAS1qcf0/+0uq6MkY
	 cCWQ+W0bLwI1DFWHWF2Vg+LZOZMHNYUkENvu5t6KEI7EjqzqkX5JOWIGujkMyGNWyMKnV
	 Zu86y51NIhze3GHQPz+r6UQUt1S1Oqazg6ln5NJwwY53e8d42BwveWPU3OBVEykLiJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/gZab3W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C0606A31C;
	Tue, 17 Nov 2026 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/gZab3W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC881F000C4;
	Tue, 17 Nov 2026 00:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794874536;
	bh=j9xUHwF2AggMFvcnTZZ+sJUO/Ib8IkqDN6jGp1qclP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f/gZab3Wp5USI2n16Plk7ix9hfff0E+tIEYXCwzzEc4B1FrLaQWb85t2R80gBswhm
	 DUS/mU1+GpeLdWaveuUPknKaOTZlz9ra6g4VZF6Qxbkn62WvXyN0dIKpLbhuK7Fgmn
	 IktAEGBAR7qG2hfpmRuEmaWWy9jHxGioUVLrahcn2BzTdA+rIZG4/sRd+FqDzE8/43
	 VSE3YEvN1ra0FKaUfUi3kij2JmrEI23XPpbSF4aMXJS1pLrPaO6aUpn8Hvg7igrRUt
	 0XFLhmDJG0TPKt/P5LKh8lDA7qbcgO53g9jNRXIb8IpNLKcdVvy9+MchqY1J7dCCn7
	 BT1F2VeH7h4vA==
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
Subject: [PATCH v3 5/5] rust: sync: condvar: add non-exclusive freezable waiting
Date: Tue, 17 Nov 2026 01:14:46 +0100
Message-ID: <20261117001507.1611984-6-dakr@kernel.org>
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

CondVar currently registers all sleeping tasks as exclusive waiters.
Add wait_interruptible_freezable_nonexclusive() for callers that need
non-exclusive waits, using WaitQueue::wait_once().

Document that notify_one() and notify_sync() also wake all non-exclusive
waiters.

This provides non-exclusive waiting support for a subsequent Binder
conversion.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/sync/condvar.rs | 29 +++++++++++++++++++++++++++--
 rust/kernel/sync/wait.rs    |  1 -
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index dae07dc140c5..89f1a31afb89 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -163,6 +163,31 @@ pub fn wait_interruptible_freezable<T: ?Sized, B: Backend>(
         crate::current!().signal_pending()
     }
 
+    /// Releases the lock and waits non-exclusively in interruptible and freezable mode.
+    ///
+    /// Like [`CondVar::wait_interruptible_freezable`], but registers the current task as a
+    /// non-exclusive waiter.
+    ///
+    /// The lock is reacquired before returning. The wait may also end due to a signal or a
+    /// spurious wakeup.
+    ///
+    /// No lock other than the one released through `guard` should be held, since the task may
+    /// be frozen while sleeping.
+    ///
+    /// Returns whether there is a signal pending.
+    #[must_use = "the caller must check whether a signal is pending"]
+    pub fn wait_interruptible_freezable_nonexclusive<T: ?Sized, B: Backend>(
+        &self,
+        guard: &mut Guard<'_, T, B>,
+    ) -> bool {
+        self.wq.wait_once(TASK_INTERRUPTIBLE | TASK_FREEZABLE, || {
+            guard.do_unlocked(|| {
+                task::schedule_timeout(Delta::from_jiffies(task::MAX_SCHEDULE_TIMEOUT))
+            })
+        });
+        crate::current!().signal_pending()
+    }
+
     /// Releases the lock and waits for a notification in interruptible mode.
     ///
     /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
@@ -185,7 +210,7 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
         }
     }
 
-    /// Calls the kernel function to notify one thread synchronously.
+    /// Wakes all non-exclusive waiters and one exclusive waiter synchronously.
     ///
     /// This method behaves like `notify_one`, except that it hints to the scheduler that the
     /// current thread expects to sleep soon.
@@ -194,7 +219,7 @@ pub fn notify_sync(&self) {
         self.wq.wake_up_sync();
     }
 
-    /// Wakes a single waiter up, if any.
+    /// Wakes all non-exclusive waiters and one exclusive waiter, if any.
     ///
     /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
     /// completely (as opposed to automatically waking up the next waiter).
diff --git a/rust/kernel/sync/wait.rs b/rust/kernel/sync/wait.rs
index 819dbd0eb3a0..8de7aed89e0c 100644
--- a/rust/kernel/sync/wait.rs
+++ b/rust/kernel/sync/wait.rs
@@ -227,7 +227,6 @@ fn wait_event_timeout_internal<F: FnMut() -> bool>(
     /// Performs a single non-exclusive prepare-to-wait / finish-wait cycle, calling `schedule_fn`
     /// in between. Non-exclusive waiters are all woken by [`wake_up()`](Self::wake_up).
     #[inline]
-    #[expect(unused)]
     pub(super) fn wait_once<F, R>(&self, wait_state: c_int, schedule_fn: F) -> R
     where
         F: FnOnce() -> R,
-- 
2.56.1

