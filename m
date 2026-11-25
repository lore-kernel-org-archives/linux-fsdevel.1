Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632586;
	b=IBv9b1Sq/8Pdol9hVTKulXte4RQUohBX3GyWwttXePSxAdc+QGjhUUG914O7roZJJUWx
	 iniAkBVDOzBgn0j2+eaz7wUsQFDpGQxGNaVGpQKPvSuqpv622ThXfOluX939luaSHaTIN
	 6UI+DfielChpZQpVcQ4/FE+a0TflBlSzgfbipeCLRzghKBY97go3g8hxCOyC5qtH0QokO
	 i/V3cjTjvEoQIMrIWTExEe6nZjOyVQVQP6Gx+E0UmHFPMoZ6qCrxmYWBqTiCSABUh6j9W
	 Yamyv7DaEHGEbm7Mu2v6UGG2teT44FguD9NCVOIcFJNGi6miWW2gIObWyMTG/WkTM/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632586;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8HqzaUnQtBkrjDFYyrYXy2MWbKn9cp7Q7enk7/mWCOw=;
	b=d7bZrAQbSQ2fqt2eovlIf51Zk5d4EQ3OG50BehvasWihBM0kUhsjGGnX883IeFbgb5oS
	 6aVupCQaI4ZyJEaR/s9r+6Ru7LXETKPOjH9P8bpM7Ik7obArPgktBZ8JKykEz/sfbonKb
	 4peH82q8Evk03loyYGQ+qo69lKVhNccRACCsL7V0Uib0j7uQhMVmNB+036Tn/tCDwNCcM
	 0UK+Bs9WqYJUqvglXYfVVGsMul7MpzdmH4q9f4JE7FKe/28GvUW5lXBWyboSWN8u1NA6B
	 fQGGUZAqGR5To0AKXRsXqosxVUZgxfd9m5WnHP2WweC9Rk7k1ydhstWW5UnheSME6dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqS1km0A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D575606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqS1km0A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5C11F000C0;
	Wed, 25 Nov 2026 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632586;
	bh=8HqzaUnQtBkrjDFYyrYXy2MWbKn9cp7Q7enk7/mWCOw=;
	h=From:To:Cc:Subject:Date;
	b=NqS1km0AjEjAi8VkT7J3HwxSwPjXJN8TUvS0oVECDnKsCs+c/Q5b5tGeYGTXKXpeV
	 7yWvYudUCHdkzgN680VkVoybkuwgNG1PR5Fhytx5OKOYc/isOptCoMmKiBgRnYozRO
	 71tkbRjq+D0hdPdQIOUvI+qWl4e05oxazOXGNw59DkKswPfEwNf86FAgRqmeEMLmgD
	 l3EnIyF6JCiFL4rRUF1V2a6c753I3wsO/vp/c82up0ZxA0LEqOdMI6/+R0edB6Ah6C
	 B9FYikTiTgb6Cu8YQpZfw00w634IFmLH5qLJzZUUWukCEJDlbBGrY4SOWspH+F/Tsn
	 spMP6wIIs9ovw==
From: hubcap@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH] orangefs: drop the write range when page_mkwrite loses the folio
Date: Wed, 25 Nov 2026 13:49:37 -0500
Message-ID: <20261125184941.431036-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.56.1
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

From: Mike Marshall <hubcap@omnibond.com>

orangefs_page_mkwrite attaches a private range for the whole folio,
then returns VM_FAULT_NOPAGE if folio->mapping is no longer this
inode's mapping. Truncate can clear that mapping before the fault
locks the folio. The new range stayed attached. The folio stayed on
the LRU with mapping NULL, so reclaim called try_to_free_buffers.
drop_buffers walked the range as a buffer_head and faulted. The word
at offset 8 was the range length, 0x1000 or 0x2000.

Detach and free the range before unlocking. The folio lock is held,
so this is the range just attached or updated.

The detatch and free has been missing since orangefs_page_mkwrite was
added. attach_page_private replaced the open-coded attach in 2020 and
this failure path was left unchanged.

A full xfstests run hit this from kswapd in generic/751, generic/694,
and generic/551. The private object was an orangefs_write_range for
the folio being freed, and mapping was already NULL.

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 04a2c928452e..7b17af735a9e 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -732,6 +732,11 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 
 	file_update_time(vmf->vma->vm_file);
 	if (folio->mapping != inode->i_mapping) {
+		/*
+		 * Truncate already dropped this folio. Drop the write
+		 * range too, or reclaim will read it as a buffer_head.
+		 */
+		kfree(folio_detach_private(folio));
 		folio_unlock(folio);
 		ret = VM_FAULT_LOCKED|VM_FAULT_NOPAGE;
 		goto out;
-- 
2.56.1

