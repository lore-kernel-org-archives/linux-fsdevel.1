Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840403;
	b=LnFJvSQU8vLo+3YbDfGBuz3XG1IQFRN8HIwgRoGn/iNaxzwZJ6flBR9VRfjGJJD1QDNb
	 fMvHAfilvsWtXSHAJR+xubX4dbPrP5g3AwpQ+E/qOjQwp7R5nV+cDD9QzgjhTEP06Z1uI
	 9ig7+X5XoYzCdTHEHYolyIQnSmXQC+pZFcR7DHz1kE3nVwufRr/gX2df21+fD4QLT+obQ
	 K2Iq2Aj0MBJbEo0RYDPkNYVO/FFNepL/fSOhkk3d+Edv3IgWwkuOxPdLMxf0UCNGUznLv
	 1mTdIWvQQyC1KjIOm+dQ383amaDdZEkKazspByc1UQXtOUpVDTMq7u/uKFh6VW60txw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840403;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bOcwL6zhtyGOHBUswyF1+2aNaITZbxKLwJZbZHfIdEs=;
	b=Chg124C8oFDqy9z9k864gy8s/ftNTl7Es28EqtAjuKgEcSMpI7i4zKjOzwYPtet5tnJb
	 3ammt57vrAy0ECbijoeyB12LGbi6Ldya/b24kYvwC3DRaBkC/WDATBOuC75w8XmQwbNeJ
	 7Ua/0F0otpDLeXQQSSgCw+yRGG6CHTlYJJKiP+ykyV2vYltJdfVotYyJ044qrP/xHdNv5
	 1TAnRlkj30GjBsnnv28wRy32Xa7a8C34iPlhQR8lqKqBbYrBc7Y/SoVmeH4Hs/cZHBGY6
	 WgFzJWz/RedPtHA1abEPioWBtouGkuLl3Nmh9xTnwh0BHeETVdYiSwrVdP0FuDArgjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WmHn/Z55";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2435606A32C;
	Thu,  5 Nov 2026 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WmHn/Z55
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343FF1F00919;
	Thu,  5 Nov 2026 00:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840402;
	bh=bOcwL6zhtyGOHBUswyF1+2aNaITZbxKLwJZbZHfIdEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WmHn/Z55HXmaQqq/YpT4MNb7PxFJ4H7cmFpM3PTSVrSrTbBRDa4TLlN+AEFR3AOo+
	 Owwwr/VRraxtuIYN4kSMGb3zu9eObJwhR+aDrVlnZqjrAgz6K2LZCzl21gqrxRjb4L
	 p0ThB3UhqX1Yf0YtMDf1oZDvksXXgg2r8cmycVn+ECcYGgDsuGRgdO1kV4O13S4mKA
	 lceKkdGmGlkOc9fbFXpdWP29Hww4IaSn6n/JVudQoHWB9efnUH72RNlGvGu29/XJer
	 G4VCo+aePUdVYXKPfhki16yl73XRquj4wuX5wHgOkShwefbBtEuFu82dqyY1NlzePu
	 P7p664+X//hMw==
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
Subject: [PATCH v2 1/5] rust: task: add safe schedule_timeout() wrapper
Date: Thu,  5 Nov 2026 01:59:38 +0100
Message-ID: <20261105005951.756157-2-dakr@kernel.org>
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

Add a safe wrapper around schedule_timeout() that takes and returns
Jiffies, handling the c_long conversion internally.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/task.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 3336df493dec..a733816fd5dd 100644
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
@@ -20,6 +21,21 @@
 /// A sentinel value used for infinite timeouts.
 pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
 
+/// Sleeps for the given timeout in [`Jiffies`], or until woken.
+///
+/// Returns the remaining time in [`Jiffies`], or zero if the timeout expired.  The task state
+/// should be set before calling this.
+///
+/// Timeouts at or above [`MAX_SCHEDULE_TIMEOUT`] mean an indefinite wait. In that case, the return
+/// value is `MAX_SCHEDULE_TIMEOUT` as [`Jiffies`].
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
2.56.0

