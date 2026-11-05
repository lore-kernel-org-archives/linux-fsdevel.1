Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840421;
	b=eJ5NRZ1+DgkV+o/Iw3Ha/XOJR0agWrIXsH6N/qahmccYrI/WC3IWLvTf2sI5Zu7RjenA
	 F6tOlCfAb3+XsJTFpq55uia9coIMz56dp991Y32k250sINmJy1gmj6TjCjKJBi210bJTK
	 g+YF3AxchWVkfU8Nr/avTvyH4Vl+mus3oJdr6tsw10ndE9Mr+XPalLfGZ1MK9zGhWNbw/
	 nSEMu9IoKZRsSVYF7uwRy3lez6dQDlG8xCKT4+PbDO/HRtTFoGoD+7IuDv9lhhDMua0Sb
	 A5XIAm8OAL+63NMq1VQeFfNkGqgx5gZExUwz8KFkMA74SFKTLgti5xyvaozkYg/XvTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ALCOpOR4cXaDQBg4za7AxElTmQ/fzRRwIpkHNVH1zTY=;
	b=XHBIHPIxtqicO9heyWzn3RTX4GJ2TSiodKget5Aj5hAgTt7Yq3uinBkWUz+IX4NJolQp
	 f9GkUECrE/S746AkhKik9aDBymhNvpoQ9cYCnM10FsOrUWVMADANuvWyr0fVoc1WeZyLh
	 PjNpjtqFzCtZodBQmh1Yjvja4XvZ0EWLTcKeL+zqErLgmoPAN0BaWzASdZO4J8982qOoN
	 /L6MJhP2uI2bAurxNEi2zWls0nB7apmlv6F3zyRPcaBhGg2eF6odExQ44NDrQQTfJvlXN
	 RhZZgkwKg9emq6UIY/NhATKLLa1v1pdIyf3RfNFp5mbMa0x//DXEOmwzh8FVO4GeQNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZbJh3EE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6D606A32F;
	Thu,  5 Nov 2026 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZbJh3EE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76EC1F00919;
	Thu,  5 Nov 2026 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840420;
	bh=ALCOpOR4cXaDQBg4za7AxElTmQ/fzRRwIpkHNVH1zTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oZbJh3EEEJvuYshmsV1Z1vMWaFnW7Y4I9DE1h4tni4YgXpmHi2ykmZTpJZ4XpWiiY
	 hQcHDMsAq+Kper7T85jgN/NApD5K8k80rQRKGW5AArRr7tVP5bLaVFBkijTZ+lHIks
	 Clun82tWngs4NwJgqwnpikJbcVquErEfgM6KFZ+fO47HcQH/mf1o0bYiA86qNG35VR
	 e1lxuhw3+mTqeylaSJpAOuCevb41WDyO9kwPUqW/MwoA/DFuBfmAtxYmIMzn6ewR08
	 8PQ89uhfDaPbfsF7JY3TNLzqa6J2mW8wvKee2KgOoS/T+tXWWHbq2y+T/Y/s+rR9T2
	 6UF+P9UXkSFig==
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
Subject: [PATCH v2 5/5] rust: sync: condvar: add non-exclusive freezable waiting
Date: Thu,  5 Nov 2026 01:59:42 +0100
Message-ID: <20261105005951.756157-6-dakr@kernel.org>
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

CondVar currently registers all sleeping tasks as exclusive waiters.
Add wait_interruptible_freezable_nonexclusive() for callers that need
non-exclusive waits, using WaitQueue::wait_once().

Document that notify_one() and notify_sync() also wake all non-exclusive
waiters.

This provides non-exclusive waiting support for a subsequent Binder
conversion.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/sync/condvar.rs | 27 +++++++++++++++++++++++++--
 rust/kernel/sync/wait.rs    |  1 -
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index fcab90f6ce34..cbc543de214f 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -148,6 +148,29 @@ pub fn wait_interruptible_freezable<T: ?Sized, B: Backend>(
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
+            guard.do_unlocked(|| task::schedule_timeout(Jiffies::MAX))
+        });
+        crate::current!().signal_pending()
+    }
+
     /// Releases the lock and waits for a notification in interruptible mode.
     ///
     /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
@@ -168,7 +191,7 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
         }
     }
 
-    /// Calls the kernel function to notify one thread synchronously.
+    /// Wakes all non-exclusive waiters and one exclusive waiter synchronously.
     ///
     /// This method behaves like `notify_one`, except that it hints to the scheduler that the
     /// current thread expects to sleep soon.
@@ -177,7 +200,7 @@ pub fn notify_sync(&self) {
         self.wq.wake_up_sync();
     }
 
-    /// Wakes a single waiter up, if any.
+    /// Wakes all non-exclusive waiters and one exclusive waiter, if any.
     ///
     /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
     /// completely (as opposed to automatically waking up the next waiter).
diff --git a/rust/kernel/sync/wait.rs b/rust/kernel/sync/wait.rs
index 92c1ae93705e..942f96b5cf17 100644
--- a/rust/kernel/sync/wait.rs
+++ b/rust/kernel/sync/wait.rs
@@ -208,7 +208,6 @@ fn wait_event_timeout_internal<F: FnMut() -> bool>(
     /// Performs a single non-exclusive prepare-to-wait / finish-wait cycle, calling `schedule_fn`
     /// in between. Non-exclusive waiters are all woken by [`wake_up()`](Self::wake_up).
     #[inline]
-    #[expect(unused)]
     pub(super) fn wait_once<F, R>(&self, wait_state: c_int, schedule_fn: F) -> R
     where
         F: FnOnce() -> R,
-- 
2.56.0

