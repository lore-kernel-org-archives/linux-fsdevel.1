Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C51B4138
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779521473; cv=none; b=dYIEduVXAkS1oRSWmEP3IjMnNaRNTySVLULWxkmn6tv3ju8M8kpmVbA9xxk6nTuvfkU0Mhkp1u3TGeCCPpsSKlmj2AeNfKDtS1cWgeo5dkgtmRnJforqbN5jHQOXOvCZF9iHl30bRkwcZ1gQ4+0xR1UlNSZzXaHR9Phg6J+zxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779521473; c=relaxed/simple;
	bh=tyhQG6r+bBgYPrhfWVw7lrzJDNjbNm777mEFaeqoR9c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pL+6qVMsy2XCKVvX0/nroE04L/vYaoGEQxdJc8oT+/e8rPKoBIeH3FLwBhKTq6lYY08IJXi+walGqZ5I3NqKYGtAp0PwJndVHJizuemDSKSkVdaiWVrWQel+0sqIDgH8/0YSEw0ZsUn5Vxqk9FO3WDPVXb1/HcBB7gI/g/Ssxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8+zHTvb; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8+zHTvb"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48ff0eb77b5so68663755e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779521470; x=1780126270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Id6aSpScy4pFl4oZ61cb6pWcP62ojgwGrghEMv9dsLE=;
        b=V8+zHTvbq6GdEGTQ9mlN2d1rWQ905CSmQuQKF74jj0Y2TcoGWHvSJkc4gdTMn+Kzq7
         XvB/630Y2Z7e2b3blkmbA1nU+RKx94aAPrbf9URagWWDmRdz+ZHWJ+m5PWrKc8Dm5jWu
         JBey3JtHSjHQuafHMmGkF1A9QRVwiexA/8Kh+05R2xWy3RlNxo0mFoWZeHO37XvjZLna
         h6e79HJCEnDM29aHYCqbgxwN27IMMgWZaSfq5N8NM9pu1I2rYUirR+ztEdWjrI4920nl
         S65EOujd6qJ3jv1dxF/wJAdPhYpeO8sA+E85AijgbhEPWJ8Xm+9d2vbXUzLurvzBR9UF
         qtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779521470; x=1780126270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Id6aSpScy4pFl4oZ61cb6pWcP62ojgwGrghEMv9dsLE=;
        b=BN00oxE98vjTbokXbgpvhXU50K/NOXJZLhPNM2rOA3+22yYB9+yOKe2xtW1dmdp0EY
         APumBT1hoZ81QpBnybvBWYQmzq4kY+MeotZLS5bWxiG1La+Yp939w0djW4su65v86fkj
         dzIRkQAA7LcKJGi4Qi3pDa871dudPvHs7cD8zrNNoIxXjqi5wsUaMVQWyeYBsmQjkv8S
         rp9pXY/sq7ZtX2dzVKduS4uZz975UY1lpk+zhDkEdyMY8rfZXBApeeSKQ4uvcMNPF3L8
         cnbWhbDx2N7RxFLRegG6oNQ1EC5ZcuKXPXHaVm70I8cVGx2L7x3IeJOPmohN9G0BQD39
         Kvdg==
X-Forwarded-Encrypted: i=1; AFNElJ9Kd0GvZC3CeL2wS/FFZqcW3Gjc3hmYcA/FUl9MInSmbyceuUSc2ohe7ez59XCYyHA8vtejMoCXz7iheNfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzvGAjVkX9Knc5nUgquIzH//US3XGsw2N9ZlvupOnfWBC/B6t8z
	f+YDi8bknQdWHNGGzyo4+agQyx7TJWyJ3C5Alxonenl1a0cGd4AGnb8sA/dUvh5qBRfLIU9AAOx
	ZuxV1Cboo5+YKn2EMHg==
X-Received: from wmte15.prod.google.com ([2002:a05:600c:8b2f:b0:486:fe68:2045])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4510:b0:48f:d5d7:df63 with SMTP id 5b1f17b1804b1-490428dfd36mr99366585e9.27.1779521470046;
 Sat, 23 May 2026 00:31:10 -0700 (PDT)
Date: Sat, 23 May 2026 07:30:59 +0000
In-Reply-To: <20260523-upgrade-poll-v4-0-f5b4c747eac2@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523-upgrade-poll-v4-0-f5b4c747eac2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3877; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=tyhQG6r+bBgYPrhfWVw7lrzJDNjbNm777mEFaeqoR9c=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqEVe6bHJnNgMPAxm+EAe7NpXfylUzA44aWIVef
 Xl7yHKroqCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCahFXugAKCRAEWL7uWMY5
 RvrVD/95qLsXw74/ELP3qn9OVixefPlxg0gMZKyBMEL3ZN5KKL6yqYahZuljsr/0tAGnsE7bqDm
 S2NvqHbfeXxUFx99ynzbp1Qojx6JVFgwokGZWkzy0opOU7lCSpwIfgZKaJ+IRJZU5JDx2wsVpP9
 SDRVomYe/ukKGEXv/JK2NO2I7b2AdY8G4CTlFXE8tpTvFDWcVO6YjMaaU9EXrpwAidhiaAc3wyh
 EGeZpnCXDv2BsLOp2uIGBYN5ReD8++8S2RCPhcN86YkBCEYvoJLLkQbRxc1rCAp4EGqaFEdS9CL
 /oSthZ3NCl8R+Qc9okdXIoPBzwzVtP6cVo5L1XiMKQC9s5bxFvnK94dvOpB5vK4wdZHg/lOyF7z
 oyxdwI1wQaAXTcwWOI7RzuzY6e8+voVZ+N534cCRnkHtFOifacWmCOboPmzLozVLw3onLbliSTX
 mErlBiUhEEoCnL0adE1+h4jyhIdAZaOMYuTVQE8OrtuHH1VI/wpxxqehDk541Al+9zmFMI63D8L
 jg3p5fM+MFgUSUWruTJNnlyKAPomd8ucBS/7wFN0ORDKvq6e/Teydyk3edjM55lYcgeO5sOsDNe
 Y4+y1mKNTN+S/x+zGkYwIIpQVqrig1WYIfzYL38PAnJYYRhIKK2eyKpbwrvAqGWg/8pb+9w+g4g MeoJZ4IVIsuHz6g==
X-Mailer: b4 0.14.3
Message-ID: <20260523-upgrade-poll-v4-1-f5b4c747eac2@google.com>
Subject: [PATCH v4 1/2] rust: poll: use kfree_rcu() for PollCondVar
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
2.54.0.746.g67dd491aae-goog

