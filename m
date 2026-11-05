Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884714;
	b=JoQIsfKSBVeZpcPxQ5yqNktUjEoHZZcliQU2CbXDoGJ+rR1y2omyfiT4+SeEsDplRSdR
	 mmyGbgc8SdlzXEm1f0/VxltOOpW19iiHbaqHkFb1laSHFMRdBNWjJsxBprzxi34XxYLgX
	 SPmWtJGOLyqCoQohknvP9bw+U5GatlsAF5Qo37/xF6XY4/1I4PHeGoaShRpYR9bZdam/G
	 Kk7OPg/4upTuc/Z83YejQrNhhwIMd0udRzfxSxXuUJ90uZI6V9nRs44xppl0fOBXCJQM9
	 tDwP1o61WYO7JucV7/rRP0+VK1RFWLWi72KtwCL/PNwyyWL52OHqOW9aT9OUEJbCQGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884714;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=a4GZC3iN185nnRTSEvNas3gufWD0FekXNVoXSbXNonE=;
	b=Ja2ZAOTOeC+vlqfqPvxiNuY2RiJts3J1QYqU/gHVwtC9taLnQ86GVqO5X5wriU86hA0i
	 xzTK0vkzpA0Boc6vyyeKn1bREmJFul/oz3BHrdWzExaSNDMW245rn0d+Cj+qiYoLxRqZs
	 SlBhEPPUp6OUy2edORUVjIOl66lKRHU0qqLkGvftkXLkZbV9AiS/cYKoHgHsAaVQmPEb5
	 qur/cA260YctzUtQJ3uIDHj+2iK/axUWTRcpDduHfNd0qR93kaAtEirWeNyJYZXeJwto9
	 b2+jdAKP1j073fabet7veT29zgIQ4qw7McefCf2o2cAvbjZVbYCeXLMD+vfncZrZizg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9mrK6Ku;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457BA606A332
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9mrK6Ku
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849671F000C1;
	Thu,  5 Nov 2026 13:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884713;
	bh=a4GZC3iN185nnRTSEvNas3gufWD0FekXNVoXSbXNonE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h9mrK6KuSeBfHVyY3Ew2sIc7Zib9/k8TdchRbQitXD1sWNBjNFC6dZs7BI91yRVSj
	 WFNUmtGIAbjNdH3lPDrz5eELInEIv8pSrSrb7I8LPtUPivqJ+XygRkXAMUqBMMsodi
	 FhSFnmWyI6yrfNpxN3S8814s+NJwkvHwRUy5i+UCG2zUFwlgbnNAHhC688K0ZrvfGl
	 5KKKotGMZj0W3QbPSY03WtW8XBqsf0BywoNnn06V6c5356ogi6tKjXpH2oCE+ZiFjE
	 ZHjmxPkiUCKWEtMpjXNQ/7ges4Agi1g0+7kPYVPdtLcYG+8/W2ounhWdjzThYIoQ38
	 ZBKHFRLAD/CIw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Nov 2026 14:18:06 +0100
Subject: [PATCH 2/5] file_ref: use acquire ordering in file_ref_get()
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
Message-Id: <20261105-work-file_ref-ordering-v1-2-8713f4876b7b@kernel.org>
References: <20261105-work-file_ref-ordering-v1-0-8713f4876b7b@kernel.org>
In-Reply-To: <20261105-work-file_ref-ordering-v1-0-8713f4876b7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4682; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Simd4VEbXjQI5ubOn8dv/9g+g/a7ipbGFEEEIYxIbrA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9aZKL7svcu+7Qvh9ttvHh5olWzczv4tS60526X19ed
 o7/d+eOjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncTGH4p83GpMvFkDJ9iv9h
 p59n7r247Htv7uwkhxrdf7m9WrNr7jIyLCpUuMW2ZarTVMt5v759FZjC9y7r92mRRSlnMwoan/5
 /zQsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

file_ref_get() is fully ordered because the fget-rcu pattern needs the
loads after it ordered after the increment. This is because
__fget_files_rcu() reloads the descriptor slot and compares and returns
the file only if the reload still matches.

If the reload could be satisfied before the increment, the lookup would
pass its recheck on a file that was closed, freed and reallocated in
between and hand the caller the wrong file.

This is satisfied by acquire ordering. The load of the pointer the
reference is taken through is ordered before the increment by the
address dependency of &file->f_ref on it.

The release part isn't needed. Someone getting a reference never has
stores before it that the put side has to see.

The comment in __fget_files_rcu() references that fact. But it's no
longer true since we're not using atomic_long_inc_not_zero() anymore.
file_ref has one so we can use it.

So I had a version of this within in the form of a relaxed increment
with an smp_load_acquire() on the reload. Linus rightly pointed out that
this doesn't work in [1].

Let's use atomic_long_add_negative_acquire(). That's a nop change for x86.
On arm64 and power this is an improvement.

Link: https://lore.kernel.org/all/CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com/ [1]
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c                | 17 ++++++++---------
 include/linux/file_ref.h | 10 +++++++---
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 052da9409874..fc4b81328ae2 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1096,13 +1096,13 @@ static struct file *__get_file_rcu(struct file __rcu **f)
 	OPTIMIZER_HIDE_VAR(file_reloaded_cmp);
 
 	/*
-	 * file_ref_get() above provided a full memory barrier when we
-	 * acquired a reference.
+	 * file_ref_get() above is an acquire, so the reload of the
+	 * pointer is ordered after the increment.
 	 *
-	 * This is paired with the write barrier from assigning to the
-	 * __rcu protected file pointer so that if that pointer still
-	 * matches the current file, we know we have successfully
-	 * acquired a reference to the right file.
+	 * This is paired with the release of the rcu_assign_pointer()
+	 * that published the __rcu protected file pointer so that if
+	 * that pointer still matches the current file, we know we have
+	 * successfully acquired a reference to the right file.
 	 *
 	 * If the pointers don't match the file has been reallocated by
 	 * SLAB_TYPESAFE_BY_RCU.
@@ -1197,9 +1197,8 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 		 * We need to confirm it by incrementing the refcount
 		 * and then check the lookup again.
 		 *
-		 * file_ref_get() gives us a full memory barrier. We
-		 * only really need an 'acquire' one to protect the
-		 * loads below, but we don't have that.
+		 * file_ref_get() is an acquire, which is what orders
+		 * the loads below after the increment.
 		 */
 		if (unlikely(!file_ref_get(&file->f_ref)))
 			continue;
diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
index 31551e4cb8f3..4cffb24257e2 100644
--- a/include/linux/file_ref.h
+++ b/include/linux/file_ref.h
@@ -69,7 +69,11 @@ bool __file_ref_put(file_ref_t *ref, unsigned long cnt);
  *
  * Similar to atomic_inc_not_zero() but saturates at FILE_REF_MAXREF.
  *
- * Provides full memory ordering.
+ * Provides acquire memory ordering: loads after a successful get are
+ * ordered after the increment. That is what the pointer recheck of the
+ * fget-rcu pattern needs, the load of the pointer the reference is
+ * taken through is ordered before the increment by its address
+ * dependency.
  *
  * Return: False if the attempt to acquire a reference failed. This happens
  *         when the last reference has been put already. True if a reference
@@ -78,7 +82,7 @@ bool __file_ref_put(file_ref_t *ref, unsigned long cnt);
 static __always_inline __must_check bool file_ref_get(file_ref_t *ref)
 {
 	/*
-	 * Unconditionally increase the reference count with full
+	 * Unconditionally increase the reference count with acquire
 	 * ordering. The saturation and dead zones provide enough
 	 * tolerance for this.
 	 *
@@ -105,7 +109,7 @@ static __always_inline __must_check bool file_ref_get(file_ref_t *ref)
 	 * FILE_REF_ONEREF. It would need 2305843009213693952/2^61
 	 * file_ref_get()s to resurrect such a dead file.
 	 */
-	return !atomic_long_add_negative(1, &ref->refcnt);
+	return !atomic_long_add_negative_acquire(1, &ref->refcnt);
 }
 
 /**

-- 
2.53.0

