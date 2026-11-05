Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884716;
	b=NtjO0tQiTR6y4Bt5ZIVJ5+UGd2X6/QpP5CqB8ZoJOb52sLyaYUpVXvnLvyzicMM6JjSb
	 NYBvkHiM4FockYAKb1hMiu6Khb/VVdlpj1rZ+WKfI+n9VJ4RFUVIaANHbZBOjj8HviD/2
	 p9S2RR7Avw11dauJx+Y3UqzDbu/F9zOQsZAF/U2PVpaenlVsFgpzmdyH159pgUnXauMd7
	 nqDT2gF1JNmTWUrflIxTy7JVUnh+TdQ2dT9P3MAjsP/F/1Qre0LRpuDxQQadlLNvsN3eZ
	 PUoCQhSf/rBLYOOq4+DVyZUMDLhgolYkn2Emv6BcXJV4CncKMf7CjUrqWbgfqAVEJqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884716;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ODdfeUdDFcD1XAb58nKWNjYuMR22C1MdWi/N2y9Klus=;
	b=EYUJbXuxMNPBOsIqXOt4mZdbvXDIJzmxlj5QKIqKOSezyIwORQpi0Go3hABzdO7uQcd7
	 e3MsSJMLu1CYVDoF6KJVEgPyUhG7+DYaa2RHKSRlt9VNqdXzeCLktdu7MHhqvigglU/m1
	 9emAvJ75C9LU5cS9m4gmqS/whqm4n2qlQrZjaBwHPCrR3iQQfi4rYwkKgd79N/5rICLgW
	 81k4xSTdkiHWpDfOUxe/BNx8RefkDzLPkNG8jX2+e+WTTWZKTUEx7/WPeXI8Sz2vmC8ub
	 RN7m8G/kY17LObYXAlyAC+JOdi5Cemgr+6nwmgqBzbr2WHyEg5tdU7Qx5aHA6slQXqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6hX3oMh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4074B606A332
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6hX3oMh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F141F00A1C;
	Thu,  5 Nov 2026 13:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884715;
	bh=ODdfeUdDFcD1XAb58nKWNjYuMR22C1MdWi/N2y9Klus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=e6hX3oMh5MHPRgQ6PvuFsO74TlUn4dxHy7sFC1m5t1UveAZEa+ykWB5MCVDGnOLYw
	 UziNw0nY/9nIfQ2V2FhofQtIEM6natipiqNNzfuFHa1CNYZAQmVnLjU7TiaeFTi7kw
	 6VTBrvq+K8NjPnY2WVX+yxGqLh/QzROEAAOrCDrq6YSkxTKrnFz6qF820UmKA83mq4
	 dwNjW2Dpx3w5tIwriHmDfu7e0YQhEcgN5gJIJDwz93Bh59VBhTL9TsZ0r3sfLVLmZ+
	 0BLb1D5XEonjUA2MQoddqBMc2v0xPQzb8JTslVb3oqJ7Im93OpOyAK+wvbpB2eoxTY
	 SuUeKbo21lVpw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Nov 2026 14:18:07 +0100
Subject: [PATCH 3/5] file_ref: document why file_ref_put() stays fully
 ordered
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-work-file_ref-ordering-v1-3-8713f4876b7b@kernel.org>
References: <20261105-work-file_ref-ordering-v1-0-8713f4876b7b@kernel.org>
In-Reply-To: <20261105-work-file_ref-ordering-v1-0-8713f4876b7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305; i=brauner@kernel.org;
 h=from:subject:message-id; bh=d3AAUlPQSL9FwBSJPT2dOWSlfYhZrxVV05lO+PPrAZE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9aZLnXdU85/hJxSd6axabBp9XWnGgsffMhiniF43lm
 Tuuv/pQ1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRKB+Gf8bFL2e4zQpOun56
 /vSOCXkiWkE7nrftuPtqsk3h0u+tJv8Y/lkpf/DZYbJKwopTPiNyzmlBZbGf55ZZfFzw+upZcfn
 5XhwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The comment above file_ref_put() describes release ordering on the way
in and acquire ordering on success. file_ref_put() uses the fully
ordered atomic_long_dec_return() instead. Document why we need it.

Files are SLAB_TYPESAFE_BY_RCU. When the last reference goes
synchronously, in __fput_sync() and on the fallback path of
fput_close_sync(), the file is freed right after the decrement and
another CPU can get it from the slab and reinitialize the counter at
once. The lookup that increments that recycled counter relies on seeing
the stores the closer made before its put. A release orders those stores
before the decrement, not before the slab handoff that follows it. The
full barrier does. The deferred fput() path has the cmpxchg() in
task_work_add() between the decrement and the free, the synchronous
paths have nothing else.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/file_ref.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
index 4cffb24257e2..e5fc45714fe2 100644
--- a/include/linux/file_ref.h
+++ b/include/linux/file_ref.h
@@ -133,6 +133,17 @@ static __always_inline void file_ref_inc(file_ref_t *ref)
  * are done before, and provides an acquire ordering on success such
  * that free() must come after.
  *
+ * The decrement is fully ordered though and it has to stay that way.
+ * When the last reference goes synchronously, in __fput_sync() and on
+ * the fallback path of fput_close_sync(), the full barrier is what
+ * orders the caller's earlier stores, in close(2) the cleared slot in
+ * the descriptor table, before the slab handoff that lets another CPU
+ * reallocate the file. A lookup that increments the recycled counter
+ * then sees the cleared slot and fails its recheck. The deferred
+ * fput() has the cmpxchg() of task_work_add() for that, the
+ * synchronous paths have nothing else. So this is not a candidate for
+ * atomic_long_dec_return_release().
+ *
  * Return: True if this was the last reference with no future references
  *         possible. This signals the caller that it can safely release
  *         the object which is protected by the reference counter.

-- 
2.53.0

