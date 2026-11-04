Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797346;
	b=wBC5iFHkQzxWUv44OyoZTlu2KD1Qyb9l8SA308Le27reFn5gO/+ltp4g6yGJinBZMa0N
	 /JBWI6FbJI2FbkUCWtjeDpxXsTws+d9etSO6hgA/y1GjdGQF2dw9h7g19czEjTLncbSn7
	 Fpb6zvZjJDCHEdIstS/9laPGeSZfEiJa0Q8Ka7AMdP5kyvCdahH/t3UXTD1KJUDlyNDz0
	 pabspX0P1r7fMTnMa11vHYu9WzQNUoDuV1U8OpTjFdbZLGzP2xK6QjQHJN1L/38evvY0F
	 Uy0JMfHGtO3ohM6mn0oiKU7WMezrZjPhqUUE/H+NqHMTtfe/FJb88nPwzSU+biF0o5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797346;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R5z5YvwsAVG0TIHGlZc17HJ/f1VSVEW4yJDbx1J4Pa8=;
	b=noxc0u7JnDdDo0GSOq/C6oZy3zf2aHWTSYFylhVdg+QjNUyqWqM1bcG9vcHzLo7Y5LYB
	 qNBoEqUpum2v4B8m0C8HOhyfo+4OJZ7BsTVYUNqti3AfFl6UHuUeo6rJ6saaz04gkf4Vo
	 DWd6WjMh0MxoXig4DRHXwVT57ZVzDCklGGk+sXmaJMuzEuxRQtT4TMI3GFaEWwuXNMNNW
	 aPdS/MRXY+ZB9z8p/M3yv5XTHkQVlTsW0a3fBgOr3hWG9EEgcJ/05DnbNYMvUAcjwyqBQ
	 8X8lfUokfTv0FPMAIybtIsAzfmbvD6+fFtqtzXJ5JwkhUR/D2n6VxOVVIDNrnfAEBCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9Fv5dfL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860FD606A334;
	Wed,  4 Nov 2026 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9Fv5dfL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6481F0093A;
	Wed,  4 Nov 2026 13:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797346;
	bh=R5z5YvwsAVG0TIHGlZc17HJ/f1VSVEW4yJDbx1J4Pa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L9Fv5dfLLTMJXYbvGiF5rbr8/tlmUKq9mAbGskCz69Fepi9o0lTAiImutY7NZIf45
	 AW3AIIppWI7Y1Eo5HbZeD2RxnjIFfTTFdQ2qbxni4DrmF40JJUyKk9RCb/A0ipNnDU
	 tSiB+JybC1GLtNhXeMP75glv0L4+ccGD3PD/QqrXs6yF8TlVJFvB0Fyih/PjmCMiWd
	 fWzGlrT0iDsG6FHyb7OKql/Mc1iLPoI3eEEAOC3ly2LQ0I7AJvfTcpsI0VwiSC7eyx
	 Kj6QiqrAHTwTIcxacFzh6zliZih3y3HAvChl5X3ZHxdQf59HxQgr88PqY9lzkqZFq9
	 ZRQZs7NyVh8aw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 71C021980054;
	Wed,  4 Nov 2026 08:02:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 04 Nov 2026 08:02:21 -0500
X-ME-Sender: <xms:2CzranS2EpKURin0G4hnjEcA-XIYjizqdzj1L34C-iYhHgwjZFmlvA>
    <xme:2CzrauD6sINbifwl_EL7N6fatl-EwvW6Iz2uzGPTga-A4Kh8qaMGGrCK3veFDsFZn
    x_Q8gBrLKGaApWfCDJZHQ8Yn_8m2t6juOs9I_YQwf9nHg3HdAjeu8Y>
X-ME-Received: <xmr:2CzravdgjL5paFZN8TGaniMogwwSa4P5ITQgOD7SHvzokZT5RkAheghLneE>
X-ME-Proxy-Cause: dmFkZTGcnWxWNdwzviArTqwO8SleswujEAoF3G5cAnzgWuj9VIXYzVn8L/YtSSoCVpDQCx
    AFAjkaMBKJDECegKseyQPi3BoJ2ULdzgEWHQh0kOOdV3qcZ96T5qYw8zvnYBduU6y+7gOl
    ju1hRqdfaUd029Zpq0M1QKVfvNYpVJXA03mIXM/FVYF2n1TVZdGxcwDBil6kVRafbiJtv0
    QuPNDwYksKVrYzT4QGS7HIxmz8ayVgiPQk5G9zoQji1nSBMTr/zV+0QH6w0a9BT4L54N+d
    cRhB7KhKgiZgmWNJc1G8l9d+gvjQ75B75nEIsy2loqzEXGvtqjUcmfJ5UhZu2fDzNX4RZ+
    6oR/S6KZE3B+Oj59PydT7wq4+cy2/+Do57EyU/spfCtxf/P36vf5deC7qOxvjMAtoOJNe8
    NXXd1ZuH7iDV5jJ0bBxXLG1LqVa7P9BOmaxRW5JTT1/jF3adOCntQdSPvAU4twjqIyOJnD
    il3SYhGq0rYp1kMyeBc99l97LZnhmPCerSKBxilv0VoIbfSZ/r0kRgqeaaq8vWQFyTKMq9
    JqWfqAb8kO8+Eaq32Gnd9ghE13syUX2tJAxCvmgtCsp/xZfVlMEAx0mCJon0C/Z+o5ex05
    Jd9V0ubEBlvCJwgW+XBjmEPpFPlMDPilID7ueQ2EeSfc1TgzPHQ9hBJktdzQ
X-ME-Proxy: <xmx:2CzramtPXpgB2FliWICvrfCmxHoDBpddpqlwsiVkAgXkl_L2UGuOFA>
    <xmx:2CzrahKBPlFz1_S-h2kDV4eQag1o75hM52YPpdAksDz-esYOivVMhQ>
    <xmx:2Czrai8zhJ2PidkxiL8I5CBOjunxDPKYeAZuTmY9ByGh0DE_oK2frQ>
    <xmx:2CzravA-GhBiS8ZZfrEuFcX1Wz4UiF357WeoQPRfuE8Y_xsXbdoslg>
    <xmx:2Szrasux01fJtrJ1m7E-uwxYNXvJvpS0zmf0fC_8GnCixRdtOO5rgn5m>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:02:16 -0500 (EST)
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Harry Yoo <harry@kernel.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Liam R. Howlett" <liam@infradead.org>,
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ilya Gladyshev <ilya.gladyshev@linux.dev>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: [RFC PATCH v2 09/18] mm/memory-failure: handle folios with PG_rcu_free
Date: Wed,  4 Nov 2026 13:01:05 +0000
Message-ID: <20261104130118.2507513-10-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104130118.2507513-1-kas@kernel.org>
References: <20261104130118.2507513-1-kas@kernel.org>
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

A page whose free waits for an RCU grace period has refcount 0 and is
neither on the LRU nor in the buddy allocator.  memory_failure() and
soft_offline_page() cannot handle such a page: get_any_page() retries a
few times and gives up.  Soft offline of the page fails, and a hard
error is ignored.  If the page is part of a large folio, the folio is
later freed with the poisoned page in it, and that page can be handed
out again.

Free the waiting pages first when the page looks like one of them, and
again on each retry in get_any_page(): the page can be freed while it
retries.  memory_failure() has to do it before it sets PG_hwpoison.  The
free of a poisoned order-0 page drops the page instead of returning it
to the buddy allocator, so a later drain would still leave the error
ignored.

A folio with PG_rcu_free that is still in use may be copied by a reader
that holds no reference.  When memory_failure() succeeds, its caller can
unmap the page from the direct map under such a reader.  Wait for a
grace period before returning success.  By then the page has left the
page cache, or is an order-0 folio with PG_hwpoison, which a reader that
starts after the grace period has to check.

Wait at the end, not right after setting PG_hwpoison.  A large folio is
split later, and until the new folios are in the page cache, a reader
can still copy the poisoned page as part of the large one.

Both callers hold mf_mutex and can wait for the grace period.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/memory-failure.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7dde7c3c9a0c..398463b2e82d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1419,6 +1419,19 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 	return 0;
 }
 
+/* A page waiting for a grace period is not in the buddy yet: free it */
+static void mf_free_rcu_pages(struct page *p)
+{
+	if (!zone_rcu_free_waiting(page_zone(p)))
+		return;
+	if (page_count(p))
+		return;
+	if (is_free_buddy_page(p))
+		return;
+
+	rcu_free_sync();
+}
+
 #define GET_PAGE_MAX_RETRY_NUM 3
 
 static int get_any_page(struct page *p, unsigned long flags)
@@ -1443,6 +1456,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 	}
 
 try_again:
+	mf_free_rcu_pages(p);
 	if (!count_increased) {
 		ret = __get_hwpoison_page(p, flags);
 		if (!ret) {
@@ -2440,6 +2454,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (res != -ENOENT)
 		goto unlock_mutex;
 
+	mf_free_rcu_pages(p);
 	if (TestSetPageHWPoison(p)) {
 		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED)
@@ -2447,6 +2462,13 @@ int memory_failure(unsigned long pfn, int flags)
 		if (flags & MF_COUNT_INCREASED)
 			put_page(p);
 		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
+		/*
+		 * The memory_failure() that set PG_hwpoison may have failed
+		 * without waiting for lockless readers, and the caller may
+		 * unmap the page once this returns 0.
+		 */
+		if (!res && folio_test_rcu_free(page_folio(p)))
+			synchronize_rcu();
 		goto unlock_mutex;
 	}
 
@@ -2612,6 +2634,13 @@ int memory_failure(unsigned long pfn, int flags)
 
 identify_page_state:
 	res = identify_page_state(pfn, p, page_flags);
+	/*
+	 * The caller may unmap the page once this returns 0.  Lockless
+	 * readers that started before the page got PG_hwpoison, or before a
+	 * split left it in a folio of its own, may still be copying it.
+	 */
+	if (!res && folio_test_rcu_free(folio))
+		synchronize_rcu();
 	mutex_unlock(&mf_mutex);
 	return res;
 unlock_page:
-- 
2.54.0

