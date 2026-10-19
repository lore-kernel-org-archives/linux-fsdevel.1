Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425051;
	b=CBRD/czbvmggskxYHBzteRUDkgXZnSKd48v29lhd+OWy81cQHdadW9mB/VKnm7v+ZI/W
	 Ub9QIRgnQVOsClwg6Q82l5Pf4x3XsAqpYFLyRjXqCQ3e4PHZwezc6nDSLCDyt0zJ8IRlq
	 x/mKHQrltdPLpaDUrE517L7Yip4ggDzebIJmDAT16byNkOw9VUkgrITd33LzmWQsAV0Zj
	 yaAdsFfzNsKZBk7lABhdDJTQMcpcVYE6nW196Bdzu4l0p3o3iEB0/kdkxDS+JlgkRD2AY
	 QR05Yr2fEAfTwSTd7v4rS7Sj2ihYxVVRM1DiuY2nK3yNBvCPC6moc5LVAAgmseOjLmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425051;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1tklyEFR6gzCJ5Mm0LyngFaJuzsqMluVwnmmNtY4Bjo=;
	b=dk6tWLIYebmBSIOZZ80t+Ky8tRRhfyIrGeiFSYgri2wu5dPNDjS5KclLE+w3uBd8d55q
	 RPFJZ4fG8V3sxHYMnO+ycRIAKcfOYHpQOmAOCjJj38+SDOn2TxKUKBrioDXMJEQ8OJ9zZ
	 +UQiw01ifd4CfbJEiY9CaAlC19gWNp5nP/siGynh8oJorp/O5j9HF224vfEW/Wh4cqYTc
	 SPR9WDGjFhxFMqA2tKv5B2RAwZLAW1gYLfHLnHFrY1hEGzNW/p2l4GfjZiHBGED7WL53D
	 82fuN8wRircBCxZ2D2FpV7YV7Ce3dIdTi+mDn1mCkDfMI/xdnyL7KXgoX5wAo+KrZrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsXIhuWW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF04606AFB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsXIhuWW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777831F000CD;
	Mon, 19 Oct 2026 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425051;
	bh=1tklyEFR6gzCJ5Mm0LyngFaJuzsqMluVwnmmNtY4Bjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hsXIhuWW5cj0PTnvYiQiB6X2pHdnoes0T9srZXVcGrGCLignDLmHgupnUcoAgQ6sL
	 zNEpP2bzdCxqRAzHHta6tZqeBuB/Ybnq7NpmSLKcyxol4ZNb5HZjMVH3Fi6HN2lIa8
	 RT6361ta0KFbAm1A7d4ohT1mxTZGqmPad99jfEOBeVsQPuMb5cqHMTV/F1S2gNpWn9
	 36gbsPRKMmo/fkjzpLprlWSRnqpI4UNcBnFS2ZcF2CKMRpSARaxRs88W2d25DKTwpP
	 bYwnV06hz7rhXb4KqmlQ97hCoZQGDTLCKj1DWLvkR47g5T1eFJyfX3ZzR4maur/kXM
	 c/oH0GAq61XAg==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 4FBAE1980047;
	Mon, 19 Oct 2026 11:50:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 19 Oct 2026 11:50:47 -0400
X-ME-Sender: <xms:UjzWas8YaXxplGvXzipG6uI1sXsBInjXF9r8sbOdPBhU0BQ58KGbHA>
    <xme:UjzWarrZKeqH1_igCCu0ZWOb4ltgMBWO_uD6NCfB4eQHmLJ_7w40CKkJ7KAVxUelm
    -Zg5Paksq_0oHxs7iBvumCcbgOQrcy3BPyZhKTUsfsRTVe_jkGhP6-m>
X-ME-Received: <xmr:UjzWanLsrRLrWT2ZsFloo-00WxlBJ83FqnbM5-8y6hmXW3bX5miNo1uMnEk>
X-ME-Proxy-Cause: dmFkZTEfcY8Sedpzpe5Eju9n5oayhWKPyUV/WN4ORzd354gnHcUNRyDxnfDrVtF0Alji6y
    FwZ4Dnqmp2xFA5TRzvzZXvYk9IWIcIACK0GXlQFj7v3uEIoT3YE0GAecfgycvJObnsWgyU
    omy/lOe9Ul2f7WNFeSYzOhn9Xhyn3eRZ1/u1NlpfN8iOBPXkq7lLkPZY3eLvZtE4xL/1Z+
    12+yKL0HGegFnoIlCDAqs/SztneWlDn0ZvTxx6bOoXiDCEows+EqK1vqCcT2wFPXdzHPq0
    s7OKMwp4WgMV4JhSm776pUXmDzbWh34FJ6orb+IJbBIpKyqJoy5T7ZZsX3UOdwDn/V3zkn
    ciLaL3SK5aczqSEptHZ258YgE9enzFCIUpka6iwuWD4uOZeMrkBJzpGIh4KYoSTKKtrZvs
    4xlScy5Hvhm0g7xX4aojdn8ZeOHImmKyG4/X0NM0BEhBJZwbtMoljvktLExWcSAkjo8TeY
    M9ZgiJ4yApWw5S7yHaoM4S1qhuWXr76hmoCzlz/14P2STYv2JmsxWXbP8qgk3L+yEEfm4+
    3MerERvzt9ihX2Y+062QX7gG/Ixr1M6EPT/QUzWtcZAGVChJyuJxYkvUbIu8P8Xs/1zdh2
    jr3zr60rV2eRRKH1RKef8o1ShHXZiOm4tHdbt5LbIl8o+Sy3moybVLTrAMFg
X-ME-Proxy: <xmx:UjzWag2nrMBiBp4mlK9_Ir0PiiNluPyJXZO4HJytHTBQeoAtapKu0Q>
    <xmx:UjzWag7h7bJWxybYjWYlm3ke8BwyrXuLS3qcZHceyvKUdrzDDfvR7Q>
    <xmx:UjzWauOg48uChbEoCOpDwRAH-d8ahHPMAOzQIm1zcvkGaaR5AE2lbA>
    <xmx:UjzWakK4lkDbmwm-rOmWK-bmvHauC5bAOuFZwPpunuoyY0t2-8HEyg>
    <xmx:UjzWapq27qqMqn2japDn8szkR0NKrbTuk5ifZtw_7yBQEUVdalmiFhCi>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:50:41 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Harry Yoo <harry@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ilya Gladyshev <ilya.gladyshev@linux.dev>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: [RFC PATCH 13/18] mm/filemap: store the end of a read in f_ra only when it changes
Date: Mon, 19 Oct 2026 16:49:06 +0100
Message-ID: <20261019154913.1765974-14-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019154913.1765974-1-kas@kernel.org>
References: <20261019154913.1765974-1-kas@kernel.org>
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

filemap_read() writes the end of every read to file->f_ra.prev_pos.
Threads that read through one open file all write that cache line, on
every read.  The value often stays the same, as for reads that start at
the same offset each time.

Store it only when it changes.

Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/filemap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 53ec92279977..960d53b61d4b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2941,7 +2941,9 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
 	file_accessed(filp);
-	ra->prev_pos = last_pos;
+	/* Readers sharing the file would bounce the line for nothing */
+	if (ra->prev_pos != last_pos)
+		ra->prev_pos = last_pos;
 	return already_read ? already_read : error;
 }
 EXPORT_SYMBOL_GPL(filemap_read);
-- 
2.54.0

