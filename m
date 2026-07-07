Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40313ED5BE
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421007; cv=none; b=P2VAOje30Xvky+A1P0kfJ1iB2gnoYeOWOFF7P65r/5HDXajnXNOfRhKjGScJfza36oLOzIUxxQ5sa7iaAwjf8cvJUS1mSzVynSF99bC/gEB+3ivl7MhWYeY6gYthm5i7Bea0UzxRGH487/cHkfgEuNSmm9chZ+ss70Y//KM9jTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421007; c=relaxed/simple;
	bh=B+9UJ973MDJs1aI01+m9qaZzBUwN2xhSoESHS9M7gWE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q9dztV4VeUb67RGPNV25fIf87rpcuKi9BVRpC1rwq2eDUh1EL2JXiTL4ILgSVAxxp+zKPeTT3R9VSTbnxX4zxcXsQ0+4BZypXyAcJJrdIYpgLLmrwIPbNTfHxQ+/gTZ/qy197J8LRm+imynz7OgT68Gl35D3LL06ajcwq4btIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n8UXq59T; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n8UXq59T"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c127ff955c7so292052666b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783421004; x=1784025804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iil9TSgLwa079DMiK+8HOiWXNeJ9GnDpK46M7X5pIvM=;
        b=n8UXq59T/1xjCj0CkCYh9dnI4a/UNemGH/4RixEWYm0A+VwAxVU7EwSjqJhpXiAgeP
         Ll5/jkHdvZGWQABxpAhohOyEwwusuJ0SJryAvhFMH8Z9Rx5DeO7O0PAhgv63IDABoXXX
         2uGU6A9QbTne9emwf2JspCtkGZ1rkzK5jKv/YOQya6ZAm8L8GzUjYuA2ASiTF+pzzR4D
         Y56oj3GixMgHBQTudBou16wNIoh96W924htoAaI+LkcDrTgDeuFjehyjWBn3y4pp1/FS
         SmOQ+T6xV4BsrkEAsL8sMCVBXhh95q/yS+RA92nqBzv/rxvb9ISh5pYgcf4TmY7Ej6fv
         WiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783421004; x=1784025804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iil9TSgLwa079DMiK+8HOiWXNeJ9GnDpK46M7X5pIvM=;
        b=cQkZWC9MY79d5JRxjmh2qeajsICvbIg/fi8K2B3muidpSp54jxAijfc7RyQvwiIP3H
         ftzY9qV6mdL64PdaNtKp/bKRmOC4kghceSbdPu3gAXTvktUf5vVVTXfas6K6IdsTz4Fy
         wGlPROBY7JGwCDkQGxvCLzjr/sO/84EeY+Am4cDAgbBYfGcHzvC2SmjaDRON5XDDSRX6
         An12UTnJX/Zd8JKQG+vQU8ZOEGC8ItOLFhP1JGZpGzpDDSS/jebF0uLbYWPswppfqYpU
         EkTOSCzoB54wHvlNIooVyka42uRcQfpLSfP1gb49vHMNiH9YG8yPwxnaJQ2DHrzD1/DL
         cQrg==
X-Forwarded-Encrypted: i=1; AFNElJ8AcsZX9oLUtWJ7hKx0Fd8znz2UmMtQLco1pp3+Yse3NQXErMOxpIBWt+CWyqX68Pa4zXPXOK+1VGOKStSa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/j+qW0TALaEtPIrzN2UfHJD86RZWE49Y+fFmxKqFbPQRv4+hh
	F2eb11f19mYm8mPdq3J+WZcxiC5E41uoOOigTxMQ4aMwd5cg6lCAtazwTh+zZXAcwr4L6A6umIr
	keANki2NNuVjzrYzHjA==
X-Received: from ejbjt12.prod.google.com ([2002:a17:906:ca0c:b0:c15:bbfb:94fb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:e298:b0:c12:a212:5d25 with SMTP id a640c23a62f3a-c15a66edc33mr183755066b.19.1783421003616;
 Tue, 07 Jul 2026 03:43:23 -0700 (PDT)
Date: Tue, 07 Jul 2026 10:43:12 +0000
In-Reply-To: <20260707-upgrade-poll-v6-0-4b8fae7bf1d9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707-upgrade-poll-v6-0-4b8fae7bf1d9@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3881; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=B+9UJ973MDJs1aI01+m9qaZzBUwN2xhSoESHS9M7gWE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqTNhJlNKdIUa84plwUVHzM0oyZikvPVTfeqyZq
 NzsTjeJf5uJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCakzYSQAKCRAEWL7uWMY5
 Rmr4D/9u+dl7l0skfiK1TwZgZ4FbOHQgpgJbUhkpSz80NNAoSYD3blLCdM/SWTt/01T1UCE9r0c
 zjPTpfA0uvXt68WHUh5HqnBmJbJ17/ChiOzk10DwUt0Nrq2q04kdjnv6QbrTIWhHshOls49X2/N
 YjhYCy51GcZp0JExl8h6uayEzomcP+2Lma6zpLZ5de4gauQV6ZCObBAyVKd21YNKHIOm+rzGxXT
 /A+MZvdc9UEKnl1UWT1oL8sJ6LewD3RGJyLavZpKnbJIyvw2fXuF5J8jLHhF5DfME4DE8MUhwvf
 oNBRfF/1w60zJGKVzdI5w7MP4EQTsBFYOpyni64TDkB0+LRo0kSEoLTA05OeT/GdQleIgIRl3Ur
 UaAI6xn21GfY39xw0do7TR+wajqJj6HnWEKlVrSivOurtKir5/s1iMGS3KoFJyRcHfZTPl6aUGp
 +hgeReD7EciPiS4//ysBm+FQL8enhU1JnK7NK0SfMzK6oy7lIdo8KoVwF5i/82LAuzJMJ3Ss9Of
 mE6GHLIHOLypx6QsoRJwIMhCL6iVwT+eErHx7a+8g4Q+NDKWqOKmf3OuQk2cfF/IUSscC9TaRRK
 3/y8gTl+cXilowbEPoYIC+mBg7JlYwSkiX2eia2mF/YTojKz14HfqOPqUk1gnPSQXCkYgcY92II RmTM/oFsO25bZ0w==
X-Mailer: b4 0.14.3
Message-ID: <20260707-upgrade-poll-v6-1-4b8fae7bf1d9@google.com>
Subject: [PATCH v6 1/2] rust: poll: use kfree_rcu() for PollCondVar
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
2.55.0.rc2.803.g1fd1e6609c-goog

