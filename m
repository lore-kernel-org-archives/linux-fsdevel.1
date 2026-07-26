Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2523CAE9B;
	Sun, 26 Jul 2026 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785105391; cv=none; b=GfnuWwnCaVd8nMHH/xAxU0Uy0WfZBZD+mnqUTg/GXJdvjytIezojueCTXLu1NfyQTRGd2Jl97fstkUyeqNerIuXvYyvqk6vEuMZKF/tsCczgIRgOzCwR/26DrXWe/atYjEJ1XaVW1CajVoQ3WM3bZ6X/h5vrgFzdi/Sui+nOc0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785105391; c=relaxed/simple;
	bh=V1rs9Lk1Ag5mozaen9gSUq/2yC3luCoG7WGgBAyK2LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obLmKBiC8+wVCupQzZasABMugR5WkRMohiQxkF+YWpu1ncpRsw1HIfGjQcZWOvOERDcGWRFQjm07cRadCNExZTQW9OSRCIOC3b/J8QK2Gx/t2bvIDMO6j/MGGoTOtC1nOUiKMnax3Tx+jbEYq5206kGk0gySmplF6TgO0gMnjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+ggoBmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+ggoBmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A83B1F00A3D;
	Sun, 26 Jul 2026 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785105390;
	bh=Y5+C++L63nTjkB/wofLpPHu2RAJwSXuIYkEJEFRJZ7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W+ggoBmXt39Q4bEO9hWKtdJEEOy1SD4Pd4y7PhcGf9q9xhU0Y6dVQzy4TGjwyShhb
	 qgDbL2GtK4eFxMquGLH86RQopYSoLutKL39tj1PV9VZOhrjznJFoO0SL0jNlck90oX
	 u5qJKRGbHEhAiqpxRBLC1yjl1tsbDhQmBgWGOWqYJs+vkTcC0nkOruCjznYi9qr3L6
	 W/JdXIU6VYkMv/vrHkm26QVioBvL69rBLgKJZ43XPJ0YNGCnsz9N1HYDQHm4a8HwID
	 7wZ7VlX9UhLJ/lsi1GoEBPmX2fONCw65LIo8UAfWnaP5KwE/9pAN/+RAxj9xdQQ9ZK
	 FDy4sR0ET6NiQ==
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
Subject: [PATCH 1/5] rust: task: add safe schedule_timeout() wrapper
Date: Mon, 27 Jul 2026 00:36:07 +0200
Message-ID: <20260726223613.1242940-2-dakr@kernel.org>
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

Add a safe wrapper around schedule_timeout() that takes and returns
Jiffies, handling the c_long conversion internally.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/task.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 38273f4eedb5..0d63beb3fb37 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -10,6 +10,7 @@
     pid_namespace::PidNamespace,
     prelude::*,
     sync::aref::ARef,
+    time::Jiffies,
     types::{NotThreadSafe, Opaque},
 };
 use core::{
@@ -20,6 +21,18 @@
 /// A sentinel value used for infinite timeouts.
 pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
 
+/// Sleeps for the given timeout in [`Jiffies`], or until woken.
+///
+/// Returns the remaining time in [`Jiffies`], or zero if the timeout expired.  The task state
+/// should be set before calling this.
+#[inline]
+pub fn schedule_timeout(timeout: Jiffies) -> Jiffies {
+    let timeout = timeout.try_into().unwrap_or(MAX_SCHEDULE_TIMEOUT);
+
+    // SAFETY: `schedule_timeout()` is always safe to call.
+    unsafe { bindings::schedule_timeout(timeout) as Jiffies }
+}
+
 /// Bitmask for tasks that are sleeping in an interruptible state.
 pub const TASK_INTERRUPTIBLE: c_int = bindings::TASK_INTERRUPTIBLE as c_int;
 /// Bitmask for tasks that are sleeping in an uninterruptible state.
-- 
2.55.0

