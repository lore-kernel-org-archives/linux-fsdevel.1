Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874519;
	b=nGeV69WlDQROHqtr4yv45gi5yTJERF1q0r8dmWZzO45ykjtrWMtSsy9rOn8hLkOwt9o0
	 YTaFM12TPKt0IVgNwi1N7810ka7/F/yOw65OJCQOTpz052LTQQ3MSgYqPwctyXtA18Bom
	 UFNhk9YiqFcOEUDdRcBh7hLf4GlXaYHqqkH0/KP1UDRs/skZB/NPa2uURFS6h9ldpXJFL
	 rXSoOTQ6SREC4QFr7ANKmymO6utx9JbL5uTqs5PAYOn7Ap6YDKCt4s2NcxkDOQK+tUfUg
	 DXDyxrLnJKultM2XFa7qhiTsZ4rgkPVrrRe04E/AZWaTzC8fkXkJPdnHyNdCHHJT1lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874519;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PBDxWiGA6AcfKvD7/ZqIVwxIotU42XGK8zxzQq1zv9I=;
	b=CCKp0Vy7lime/9nunUs6umuyjlUhd7UdSc/skk9XQukJzjVaX3XBCE9PC1Dlfau3Q67C
	 WzfAojiAMywoTh5miO3fskRB1AbI9P088OMc7m9lieaVGutmBuzWr3kQ+EIDNUPokCVRc
	 qdmHvhT9LcBXonTBvrs3j/UrKNqeSJbqqt0bIoqAHaPSYih+BjShoUmImwNdS1nue3vjO
	 yjkoxFw4K58by8Z1KFtkxlSbcNLhIjx5ux7HM3RpZOHBBIiBuHWDmqzlMOLnJ9aCsk1K3
	 /hOvjM3UKr0sL+Xbf2y2KiXRS59E9/ft5rSVQbUdtNmmD/QA/spIGyD4Zg730eMmXNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6gYWZMj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363A606A31C;
	Tue, 17 Nov 2026 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6gYWZMj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160751F000C4;
	Tue, 17 Nov 2026 00:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794874519;
	bh=PBDxWiGA6AcfKvD7/ZqIVwxIotU42XGK8zxzQq1zv9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d6gYWZMjpOEmAF/Ua9YEQwato/k1n+c1DYfsTWWynlobu94M1O+aBQx4946AMXFRx
	 M3L27dzDCRVIpTYGybTptP2Etx1Bi5Iu/XhKRV6r8VqliUP5qn9BkxmVUNsRzxVAAx
	 dQSzE4oqWtWoCYqNYHNDXGJF5OuFInKH86ahTfqySBkk1wlxLrGF37Nz/D79PpAZB4
	 kmEtiLOSwiQAFuMcPoLTeIv0yi4NFyL002NzImwNx6NVTtGgJhYg1WCHFI3IF2Cz7p
	 fQFzxeq42W0eAYmrj8h0XbRQuBPk6xM+yZy/WW9T06cS0tidjJQE7TxyGbEGaRqd3W
	 NI36jlBwT6Oaw==
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
Subject: [PATCH v3 1/5] rust: task: add safe schedule_timeout() wrapper
Date: Tue, 17 Nov 2026 01:14:42 +0100
Message-ID: <20261117001507.1611984-2-dakr@kernel.org>
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

Add a safe wrapper around schedule_timeout() that takes and returns
Delta<Jiffy>, treating negative durations as zero.

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/task.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 3336df493dec..2fc0607ba9b7 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -10,6 +10,10 @@
     pid_namespace::PidNamespace,
     prelude::*,
     sync::aref::ARef,
+    time::{
+        Delta,
+        Jiffy, //
+    },
     types::{NotThreadSafe, Opaque},
 };
 use core::{
@@ -20,6 +24,25 @@
 /// A sentinel value used for infinite timeouts.
 pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
 
+/// Sleeps for the given timeout, or until woken.
+///
+/// Returns the remaining time, or zero if the timeout expired. The task state should be set before
+/// calling this.
+///
+/// A negative timeout is treated as zero.
+///
+/// A timeout of [`MAX_SCHEDULE_TIMEOUT`] jiffies means an indefinite wait. In that case, the
+/// returned duration is also [`MAX_SCHEDULE_TIMEOUT`] jiffies.
+#[inline]
+pub fn schedule_timeout(timeout: Delta<Jiffy>) -> Delta<Jiffy> {
+    let timeout = timeout.as_jiffies().max(0);
+
+    // SAFETY: `schedule_timeout()` is always safe to call.
+    let remaining = unsafe { bindings::schedule_timeout(timeout) };
+
+    Delta::from_jiffies(remaining)
+}
+
 /// Bitmask for tasks that are sleeping in an interruptible state.
 pub const TASK_INTERRUPTIBLE: c_int = bindings::TASK_INTERRUPTIBLE as c_int;
 /// Bitmask for tasks that are sleeping in an uninterruptible state.
-- 
2.56.1

