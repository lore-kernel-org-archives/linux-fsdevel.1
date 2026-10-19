Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425019;
	b=MdAppc35DIVMvHEGLNDZmSenIey2Cf7VjA1zeJqat/V+/6KAeEwgwZNZmpXJqWp506OL
	 NsVRXZX/cntRuoOdcNBXd0d9WS1hbcYoVHVmvq9l8HSYdl0ZVf8KQ1VxOOK9lYjw7+WAN
	 qwx521fB5/jyPpQ4lbI3S9RO8clIQEpYA8/F7nfMQxdd8tRd3M1NzLGQcab49zZ0RT4fs
	 mPIQrTcRsD3aC7CzKshoi/4xikSqOoHdrXyHGKVCtccvRGSH2/VH92IZ863vfpomlYSUG
	 LePVaIO4FsajC0VBWtYRDrW/AuncjRhx+YuPe+zCleaifhbA7tU4a86ipZJloZjUw+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425019;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PMTfPTsjqmbKCxNwaWHz1dgOx+TTOWHrc04S/ITwtbQ=;
	b=HsQ0ofBSttPBK7KaXI7GjucIkc/BP9vpF/HPfluGn/+i1fb6JyAG8+JtHh7iJ2s5eBHG
	 ZhQsVlWlSOrCtIuHrHafUnZ73Zx9FL5MULlaCGYZMBR+iwDLkAG0yXqbO5nbYd35GoQqI
	 YmzwNtTHf8etD2iROSW+wPwloTgBEKlpn7XuFXpAJWXn3BIuaRVWCLY790+qF2SpEg73z
	 idEVbFvneOEQT5evp1z8nTrJhopSEAuqE+9LShCOec5tQLhdn828HfJEyLfbM7uahkB0u
	 3pyRpl4gGpf1XkJKG7w4uXWtjKLboQ3T2zDwXOmV2QsmB2+zVjdGiDiwnTwnKwzk+TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hImCGeam;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A360A2628;
	Mon, 19 Oct 2026 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hImCGeam
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A301F000CA;
	Mon, 19 Oct 2026 15:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425018;
	bh=PMTfPTsjqmbKCxNwaWHz1dgOx+TTOWHrc04S/ITwtbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hImCGeamAmp+FYmHCgjT0+aC2HP0OJhG9IfHgF2YTc+c/Lg1JCdqfhZsR48XBx/EK
	 g3218Ry6T4ZZJTTcb04LT7FE0brELiShRrpFIUFsUjvL5LWlhY5eRutVseYHR4uQim
	 /1X7v5Yq2742O208tEu+CX/t9ehB8m3QfcjOO32lSugvlWN1qsOOKEp1WoJSBK6VCy
	 udNboFaQbCEaKpzrZxbQ40MR0luvhb8si/ivsMBy9ofJ7g7IOjCDWnW+3SAOceChHh
	 9cSsYkLERtYijtq+YdBCF4584X657Nl6PaGOoH8k+rQek3DNxzhqYyH+xBdCJ44VcS
	 hCsk8uz+r0voQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id BFEF3198003A;
	Mon, 19 Oct 2026 11:50:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 11:50:14 -0400
X-ME-Sender: <xms:MjzWaqk20WrAqHU7BWHXSIbeFWNU0KwfpFa7LosxR-uHCi6LzHBMAQ>
    <xme:MjzWaoxrSIiA58OTdCL5J-YXqxeNMGt7scVysQso_9eJSVPwOMnseTr_f7smvLVYp
    CmYWo5-uc4Jlc_S9TAuqU-IHgPF2mWBIlHYA2OY5RscVujFus_dP5d9>
X-ME-Received: <xmr:MjzWatyuTGbpQEsZRkT2D7pUnoeJk6tql9SNTEoObpborfq4zLpiqnIG09M>
X-ME-Proxy-Cause: dmFkZTFpjrG+2jfVBfklNRE95oThC60xlhUtv5sioyJrfpDDHbEB/2cXkTI411oJriXTLs
    N7RLfOUdBbmoibSFu4zT/f1BKPPyxkEYUp5eDeafGhPQjcnfJv/29ZtYwE6q77Fr7A6zQu
    C94bEu3EPqJJ50fLC5xP9PtYZOq3sS+jMfKkgkZFNUAdZxkDiyHArLijwBk9MwzijLWdvR
    4raSXvkSyIGvp9XYd2doZUGuEANzDQejgJzzg3ARZCjBL2yZfXIvLZCg0AMujDeTHEemYv
    cvWt94P7AS+P1mtikHZvyS9eAaK3Fy2/TwDlvaPXULPDsZK9f0sj0aca+uCBBoNs4d3uHs
    jMUJ1Iozqk5UdmIvSWusRKiLxZJibibQQ4io5vi2zZE/MO/E51//OOpVWfhv0zTt87YwNC
    iT4vrAPyd6Zw38/TgZPAZuDM5MOQ5uy92jrk9+kPwi9FArfqH5nSplQoca7j1ODXWJuKjo
    Dzl3htmBf/kiSZk95GYec6x/otNAVITvtIg8Nf+oD+dUiJA4EkTHkc1Gpwfmk27qWoZJfQ
    yFrAjVY2J4RzUnQGa94QZsGOXiqq3U5awoY8NMbMgVRjboeQ00T7MEBaY6re66zsU4Ec9D
    0R4U/ITBWynGFo5znxlH1QA0ft/B0hdJAgXaFWzh6VKsSmugq2I9X73PmpLw
X-ME-Proxy: <xmx:MjzWai-qqCOJpGJhRbQV4nXeaainxxPUu5R9TpfLw5p8v-YvAMAIGQ>
    <xmx:MjzWaojCY6I4q2rujQLWLvRQJjOsEVPcpkCiCGXwBGqdMdyaw0Du_Q>
    <xmx:MjzWatU9IFKq5no1medm5OSxy82CGnApGBkARZ9zPJx5kPLb2uA3DQ>
    <xmx:MjzWakz3fmhsJGVzIS0Qv7-erXcB1GyLj21qXl1v3ISN0yaIUJUNvw>
    <xmx:MjzWatyJrBoAPWcxh0-1FEhlmxpkyQIR-0xbar9-2i-RsXPINpStpUzG>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:50:09 -0400 (EDT)
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
Subject: [RFC PATCH 08/18] mm/memory-failure: handle folios with PG_rcu_free
Date: Mon, 19 Oct 2026 16:49:01 +0100
Message-ID: <20261019154913.1765974-9-kas@kernel.org>
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

A page whose free waits for an RCU grace period has refcount 0 and is
neither on the LRU nor in the buddy allocator.  memory_failure() and
soft_offline_page() cannot handle such a page: get_any_page() retries a
few times and gives up.  Soft offline of the page fails, and a hard
error is ignored.  If the page is part of a large folio, the folio is
later freed with the poisoned page in it, and that page can be handed
out again.

Free the waiting pages first when the page looks like one of them.
memory_failure() has to do it before it sets PG_hwpoison.  The free of a
poisoned order-0 page drops the page instead of returning it to the
buddy allocator, so a later drain would still leave the error ignored.

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

Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/memory-failure.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7dde7c3c9a0c..dc66cac05b1f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1565,6 +1565,21 @@ static int get_hwpoison_page(struct page *p, unsigned long flags)
 	return ret;
 }
 
+/* A page waiting for a grace period is not in the buddy yet: free it */
+static void mf_free_rcu_pages(struct page *p)
+{
+	if (!IS_ENABLED(CONFIG_PAGE_RCU_FREE))
+		return;
+	if (page_count(p))
+		return;
+	if (!zone_page_state_snapshot(page_zone(p), NR_FREE_RCU_PAGES))
+		return;
+	if (is_free_buddy_page(p))
+		return;
+
+	rcu_free_sync();
+}
+
 /*
  * The caller must guarantee the folio isn't large folio, except hugetlb.
  * try_to_unmap() can't handle it.
@@ -2440,6 +2455,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (res != -ENOENT)
 		goto unlock_mutex;
 
+	mf_free_rcu_pages(p);
 	if (TestSetPageHWPoison(p)) {
 		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED)
@@ -2612,6 +2628,13 @@ int memory_failure(unsigned long pfn, int flags)
 
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
@@ -3003,6 +3026,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 retry:
 	get_online_mems();
+	mf_free_rcu_pages(page);
 	ret = get_hwpoison_page(page, flags | MF_SOFT_OFFLINE);
 	put_online_mems();
 
-- 
2.54.0

