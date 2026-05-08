Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E61375F88
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223389; cv=none; b=P1cLAKkb4Gk5z1kBpQxLl/xfqOXi9djWbiKcZkUBLE2JIk2vaQkcrlJ+6UBOd88iJVOuVNRl6TkRLZGgt2UQDAmLxV5UqLWGb+uk/SFakLBq8nf2R87wgBuG+9t6QcuuCQ8wZc3rVUDZsHqHdFPRNrPPReGx7zKopLfy0kFZehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223389; c=relaxed/simple;
	bh=CLtHpbaS1mKle8E88YQIhhMZXFuxKBPqK83vNenbugs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qjweK5XHj6NeSitQAwemqDUX9JbZ4qXHVDnD1g/5EmRAhoQdeIGAplPZDbFr3z3mCUc1dYwo95xa+KUjHyzqA4llqtsEx494ILEId8oo7OqTDthgi7rP7O8W0tzK1G5ZwxJOtcSLOTUpUKHW/VmViR4UqIH9BC2zbmzMq7s1NAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ScwoWPlW; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScwoWPlW"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so15125175e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 23:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778223384; x=1778828184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwR5zUblvdpSOLiS9fu4K+/lNRVrhgwROb1hUxq0umc=;
        b=ScwoWPlWjWp2AwDH+knW6mKO/88bWlvFG12uvon34qZ4d6ZkzYlprUB6kBlwyRn93J
         wm3lJgic8puwNHrpBFcGpsm6lAAvX1xn0xPMeH5aixkWpYxsabxeThkvW4TpEqsgwA5I
         XR6gAiD3pUWkOt0mOsaC4fGpk3nw+QZ7JmiYFOsFvnYCy383kYHmJ/mimmsyeA75OEMd
         izDppb3AILTQhIHOv4d4vyoM7jwIeLS8k8ZvqYa2P1ElGcD+gAWO6PYS/ZswNWBJSNny
         FCyrJZjLxxsehrHVweu6AxmLLlyaEoPmMfADzZmL8Vx3iQicGaWKPJAoFw8qR44HaXa4
         f+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778223384; x=1778828184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwR5zUblvdpSOLiS9fu4K+/lNRVrhgwROb1hUxq0umc=;
        b=RE7ATaA3TnFwmEFBRbi1QxaRSnBK4kbZjYpLGKxWgtdNOGKCa0vd3Loy+sbeR1qtYn
         HeiyHeoGCCuqrBHTKw/hTCQOfDOwRTuwv2yJ15wjsFJXVGxBPnfgAHzdVHofwXLffNfS
         5049N8VwC6K5Qw1pydJpadYwKX8x9nlraL6e5c07W9HcvpvA4v/4ekZx0sTMjl6JnSGf
         JVsWP6SmQ1z9uuPsktRj69j5KbRoVu0CJ5ERqGIqgyTYGBHMzA7rpobBbaAk/8UKvAJl
         bSb60pf60fSc2Tlst51C0VHS5cVRyMtBY+NLudZK32zPvEdXds0gsqXeuNXlEjgvY2DO
         Twew==
X-Forwarded-Encrypted: i=1; AFNElJ/I3c4zi/UMtuTL7d9YLv5ehorgAevHMOjF2ODj8rdF5AfJjgkuwI4YwkCfpO04EJGM3p9TyWT4+JE/itEp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Un6z/Ockkb9NEC5u6kGCfwLgTrQizKCUfNCpK2NHFsndMufi
	356QWsX4uU+fvqrepJWLM3EFm0fgIGW7iLknSuKOukBF4XuAER624iwmPeI54wU28mF9N41mEYG
	lDM7Gvo+JgyDmmeZ75Q==
X-Received: from wmco5.prod.google.com ([2002:a05:600c:a305:b0:48a:6051:b5af])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:871b:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-48e51f4652fmr182535775e9.29.1778223384122;
 Thu, 07 May 2026 23:56:24 -0700 (PDT)
Date: Fri, 08 May 2026 06:55:11 +0000
In-Reply-To: <20260508-upgrade-poll-v3-0-0c619fe846e8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508-upgrade-poll-v3-0-0c619fe846e8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3877; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=CLtHpbaS1mKle8E88YQIhhMZXFuxKBPqK83vNenbugs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp/YkVE+D4eBTnrKBD7RpNEkaLJYcGJN9FVMPVA
 tpjeihBSDmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaf2JFQAKCRAEWL7uWMY5
 RjLnD/4qe7AUfbmAav2TJeIzh0lJeGXw+I6OP8Tq2TCTVjiPv3qlWfj8oCy1my4vgtAbTdqaODG
 WZsvmVoE5jwKnjjsMSHqpyHtX1WwduCAb+PlEdEplDn5Z9e0bXM2nXoJ82uPMU3daSgvSoUJein
 8mtr4xdHo05M2flIbnkxtI6emRljXVo48raQ1A6wkxgJ0Y/m8HGDSAZjUBo7Wo8HZ7EkAxSJxFL
 JOMcp+14P11ZiQdcVH/yIZ82trhm5x6zdDvFXyAy6duRH6SrcQ3D2Ersf/kQTUXGZDMwKVQjKfi
 y6dk2AoALrQbVpwMAF+8eXpLKsq39iO1wbjgJCr0VBM/3ZNrLWxuS3doO3Rynfv2YdTNttNutK0
 8FNBS5rq+CWglBg6kJfabbMGtVQuaCot+qET7tg7pH8+zMuta3OVXoOfhhv/QMSZzbJKqdcrv+D
 zn95oZTU4TfSrMnwdLO7y5QjMIEAmAg1yP3abXMjN5GxCUvs7P+otDBePN2RAfH9BNMxHdDOQrO
 dp9f+JekhMyD+SzUASjvJJJVC5FlBPTkOz5tUx1nd167Fv3c4C9UhTSazmsjrci7572lzndzRgF
 xluguRFQIJ/Y9r22t3uugsBXAhJIr5g96tPgTOqMDSesq0HiMBFcPeaG0DHKIitkvDSSE0gO6qA yR3x5CXSjKhhGZQ==
X-Mailer: b4 0.14.3
Message-ID: <20260508-upgrade-poll-v3-1-0c619fe846e8@google.com>
Subject: [PATCH v3 1/2] rust: poll: use kfree_rcu() for PollCondVar
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
2.54.0.563.g4f69b47b94-goog

