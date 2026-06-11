Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB553BCD07
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170162; cv=none; b=ht9jen40K4h+unPWk1tXpNQJngbbQWirE9zMnW76YdwhAgXU5qhO7bbhdUDB1itUOPx1Jfw1eZ0Y4rUaLMSyx5iaAuIb+HrbLw8iPbu9G02uAZOKPdRwIbEXtDd6LAnbzCjOckjOVWL683yxq4fH1KLH+aSw0cGhHly87eTINrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170162; c=relaxed/simple;
	bh=Qi5DAQgATfLRz7Bnn3G/2iiJAjf5fznjFr5yRi6S/6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bs08JbMUkXVUXvfkb4E5GE8lFbsgQM+uFmsuWonQSTQRGugw3Sfimzl+xPd+7caX+UJvVk2se6Ycn4ZvYODt4z6NNASBjtFf0ujAkClkFyiRnJ0vmy52CHAzA4iKsf0UIktSrTYX8M61B/5o9tvRvYrxv8BhVNXrohHA3HVq64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHv2PY1l; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHv2PY1l"
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-5aa68daac65so4593217e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 02:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781170157; x=1781774957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tF/awWsMTV8tnH567MOX5eq9NoKU3JJoN57UzqYjc+s=;
        b=UHv2PY1lJOWFGV4SwHxCItjD15yDlH2M4QP8DvUfucwFl8Xuikd8q8J1hb8Fxo3d1t
         G+I04m25OLAEjCoeb7XTeAm8HH0O953AAkfpemxvPXihKF+WxfvUQxurJhRCthIrMNIs
         q5F863skf1GBH11bwjNCgF9T7knnIMUo3h4MKYQAjEN+X8FK9NBP2MvCtMkc5OqphMxr
         9+iBeGe8qzoRP0bWIcGHptvgr3oVvpiIU8bPbQlldzxie72XwwzlQpqi2EzMcK8fsXZx
         saAWRrmYSkoRRVLg7YR746QF/fJ/F4mEWsAY2LCiYA1tGoqaLllQhAWwG7lyhFn2Lu7n
         VIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170157; x=1781774957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tF/awWsMTV8tnH567MOX5eq9NoKU3JJoN57UzqYjc+s=;
        b=k5zEvd9xQ1oQXnfz7YJN6WCC2glNl9fm9fh3t4dJ819dSR8+VIe84RNiez2fENPiUY
         OzFYx4kOT995fk27G9F3AdGanuCPl9BroSG6devf/F7mgCfKzM63ZGjfp9h7JUWlaCxj
         t85PMa/Cj+OJyDXcf3OIzEOzZD+7jEvuHc8I9kGU88bL5ktYAFeI/nloLo34NZXxb3X/
         WlWk6CUcNcTNY+ZjgYZVxLF3JCV1IZuKjNFTLA38SbKGXim5Z3CXfSx8eHY9e3dtt3V0
         VVCJyDSAePapTrGB+Ix6HklhyR1QBPWzjpi1qxxrB0iP6Sc63pxICUD7WLBOnjxWJoB2
         jdUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gEUwOBO8qkwARAd9AmeWB1fgeUt90HRgGqhNMorf+SWws7/00cF4fs/iPGCmVOG7hAb167gG4eUiox2KF@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyoSxoFJVRHteeac36ADOnSHL/WbvVT1e6Y6u7JthQAxwVYCq
	vlrw5wNQjkyJU4zPIOKcUe/uPeTeJetydGFDCvIT/WLBXc+0Xooi6FuL/Kisj/rs9XU36cHjG8z
	6x7jxSmJLW3HjOKkXRQ==
X-Received: from lfgy11.prod.google.com ([2002:ac2:55ab:0:b0:5aa:6526:560d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:ac2:4f0c:0:b0:5aa:659b:2a95 with SMTP id 2adb3069b0e04-5ad27fbfc16mr684231e87.36.1781170157095;
 Thu, 11 Jun 2026 02:29:17 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:29:00 +0000
In-Reply-To: <20260611-upgrade-poll-v5-0-497a11c06828@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611-upgrade-poll-v5-0-497a11c06828@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3878; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Qi5DAQgATfLRz7Bnn3G/2iiJAjf5fznjFr5yRi6S/6c=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqKn/pOwzsWAIqWxAYuIbRBEORuNHtM1nvq3sSS
 DpJcr2OGCmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaip/6QAKCRAEWL7uWMY5
 RgEHD/43JtOfQhqZf0qn88EkxissaAcYHd/Tfm7JdUSLqfLb4UZSmYMLp+wGf5eZDSGewq7VQX6
 CWGBlmtBbvlmzwts5AUeBlKIc4FKfRTuPrQS1EQnQC78VH9FPrqJz+FkjrYNY/U94IZC/hT/9ye
 oWEX1R3JKBvEoOjWhz7w3csjF+rM/3OLNNcqsMMe5JysPD9CZ1HT5Kz3mW7rhJpilTKfG4f9bPU
 m6u2DYHqGfd1fM7OGD0kBuM/GFvgSGJk24mE2Ylceyy0JnNK0ndLl81g2cR17+8GySIr3ZiGnHs
 /mUroOqgpXUdGnMzGLBiaRnQYun2Su26wuC+tUGqqof9kQTnLXmuPj0m/uwHzoFNV6N0f7sgCG3
 XUSmI0QeYe1IvZf8smFIt6geTv2ns9zIe23ibGabdpmEMYbz7rCMqWnf4B+v6nSMtFysF6CBYD/
 BgmW1r188PiRUZTBojqu7uXVWXDW9D25VEjyFKUi41zuKmKUOOVdDT5Dg238LZsd6a7/9Y5qX2o
 R0sol5gdlL0CtMO35RbCMr4fdwXaFYhQF9RzQ2cPf4BpR7b8PGh3bUgpgu98tQfLJLjEhpE1LUs
 Ef00WItBO95UPWO2SPslhMsPB8OtpW+iiFlcwqKX42kdYNcVNETOdYqye16U5mLnHA4cRmvL4hl WZ/LHqaD2EuN09Q==
X-Mailer: b4 0.14.3
Message-ID: <20260611-upgrade-poll-v5-1-497a11c06828@google.com>
Subject: [PATCH v5 1/2] rust: poll: use kfree_rcu() for PollCondVar
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

Rust Binder currently uses PollCondVar, but it calls synchronize_rcu()
in the destructor, which we would like to avoid. Add a variation of
PollCondVar that kfree_rcu() instead.

One could avoid the `rcu` field and allocate the rcu_head on drop using
a fallback to synchronize_rcu() on ENOMEM. However, I'd prefer to avoid
the potential for synchronize_rcu(), and Binder will only use this for a
small fraction of processes, so even if it changes which kmalloc bucket
it falls into, the extra memory is not a problem.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/poll.rs | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index 0ec985d560c8..684dfa242b1a 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -5,12 +5,18 @@
 //! Utilities for working with `struct poll_table`.
 
 use crate::{
+    alloc::AllocError,
     bindings,
     fs::File,
     prelude::*,
     sync::{CondVar, LockClassKey},
+    types::Opaque, //
+};
+use core::{
+    marker::PhantomData,
+    mem::ManuallyDrop,
+    ops::Deref, //
 };
-use core::{marker::PhantomData, ops::Deref};
 
 /// Creates a [`PollCondVar`] initialiser with the given name and a newly-created lock class.
 #[macro_export]
@@ -66,6 +72,7 @@ pub fn register_wait(&self, file: &File, cv: &PollCondVar) {
 ///
 /// [`CondVar`]: crate::sync::CondVar
 #[pin_data(PinnedDrop)]
+#[repr(transparent)]
 pub struct PollCondVar {
     #[pin]
     inner: CondVar,
@@ -104,3 +111,67 @@ fn drop(self: Pin<&mut Self>) {
         unsafe { bindings::synchronize_rcu() };
     }
 }
+
+/// A [`KBox<PollCondVar>`] that uses `kfree_rcu`.
+///
+/// [`KBox<PollCondVar>`]: PollCondVar
+pub struct PollCondVarBox {
+    inner: ManuallyDrop<Pin<KBox<PollCondVarBoxInner>>>,
+}
+
+#[pin_data]
+#[repr(C)]
+struct PollCondVarBoxInner {
+    #[pin]
+    inner: PollCondVar,
+    rcu: Opaque<bindings::callback_head>,
+}
+
+// SAFETY: PollCondVar is Send
+unsafe impl Send for PollCondVarBoxInner {}
+// SAFETY: PollCondVar is Sync
+unsafe impl Sync for PollCondVarBoxInner {}
+
+impl PollCondVarBox {
+    /// Constructs a new boxed [`PollCondVar`].
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> Result<Self, AllocError> {
+        let b = KBox::pin_init(
+            pin_init!(PollCondVarBoxInner {
+                inner <- PollCondVar::new(name, key),
+                rcu: Opaque::uninit(),
+            }),
+            GFP_KERNEL,
+        )
+        .map_err(|_| AllocError)?;
+
+        Ok(PollCondVarBox {
+            inner: ManuallyDrop::new(b),
+        })
+    }
+}
+
+impl Deref for PollCondVarBox {
+    type Target = PollCondVar;
+    fn deref(&self) -> &PollCondVar {
+        &self.inner.inner
+    }
+}
+
+impl Drop for PollCondVarBox {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: ManuallyDrop::take ok because not already taken.
+        let boxed = unsafe { ManuallyDrop::take(&mut self.inner) };
+
+        // SAFETY: The code below frees the box without calling the actual destructor of the type,
+        // but it's okay because it re-implements the destructor using `kfree_rcu()` in place of
+        // `synchronize_rcu()`.
+        let ptr = KBox::into_raw(unsafe { Pin::into_inner_unchecked(boxed) });
+
+        // SAFETY: The pointer points at a valid `wait_queue_head`.
+        unsafe { bindings::__wake_up_pollfree((*ptr).inner.inner.wait_queue_head.get()) };
+
+        // SAFETY: This was allocated using `KBox::pin_init`, so it can be freed with `kvfree`.
+        unsafe { bindings::kvfree_call_rcu((*ptr).rcu.get(), ptr.cast::<ffi::c_void>()) };
+    }
+}

-- 
2.54.0.1099.g489fc7bff1-goog

