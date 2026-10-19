Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425045;
	b=yWushCv0OZGVjZxAz7qnSmXFW6azyMUR5gMjhdVARJAXlv7lRaZ6Ne2yyYd/gNsoXWiP
	 8RfzHddu1f3k2qJADbQbxqZbZObKoCsy65njxKN+BwhORLWtV9SlX/bArFUefUNvppMLU
	 4GTjZ+0NJRDPfeajdgXJevQ1Mj9W+Sd5lm2ppLhfTv0mHAhbm+ax693ERs2JuvkKA27Ll
	 c/mbGHSt3sqCqxEkRwtaA6/8uGYZQNi1SSMM3pUSFpQwz09hkFGnlM3H2x22l4PVa2mdL
	 nGh3An3SjxkDR8vJ33tvlunQVBdzCFLSgEvQC6lXQomNis0l5lwVOZDaScWuRC50seg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425045;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=84kciOlrBZyXkODv4mERfw9QO7WVRKrOSp1zoHtEMTA=;
	b=12m+4SoWbvA5Nk7l/2vgaNrYWkvWC2LPMp7ShAO0HUVmqzgMvWNA3UuVwdMUk1s8np8o
	 2l8+9PzUnglNRD2uY/IRYS7lXrboM0QTr1zcmVEM4ZlFdv4iwk1jPbS26/HGb+Q3XcYBY
	 CSMq4U5qXkKLYwcYlMQSatMRLoYOhHV4/f7J0oBg66VamE9laoWlhbISN09FSY53MVlkJ
	 MCTS/ueMiG4FqFIUoDVNblmItNYH94YnKpppV5eXSETJG4o+5GtjJtnEUGO77K5L8rhuw
	 K8WY1IHBkheW/bFcPQiGPyoeOjBq7fcTzjASX/a6/bNDa2XkZ3VslxP+RMvVF0dvLpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FcFoz3t/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE7606C900;
	Mon, 19 Oct 2026 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcFoz3t/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15511F000C8;
	Mon, 19 Oct 2026 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425044;
	bh=84kciOlrBZyXkODv4mERfw9QO7WVRKrOSp1zoHtEMTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FcFoz3t/L7qTPpklFErAcrar3ZSEdD4kbcutljvZlQbdPPmrbEwganGTEy/F0rOdm
	 w/rxlzz2CqfPX9ErUCt6kVObwU6fHmiXNtqC8HAfibJx6H94LUxiF3Huq71bteGC7n
	 15j8fJFXNUdfQ5mQJiGLiWIyRhacwAwqLFxZg8bcEDl59VSBXRPurf7y9hgPvIVv2K
	 aLgjlMBP6NFkrHNqL0BOt1NtBV/sWdDCcEg1pBnqz4UON78dFNQIMOv7eR7pW4j6Aa
	 hUPBLCG2K+fw1mYnLuJy59gQYV6YaduyCCjEqS5SsRRjY8aa8zswNYkbbyi3sWpsOp
	 3sehmCa9MVXpw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id E2028198003A;
	Mon, 19 Oct 2026 11:50:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 11:50:40 -0400
X-ME-Sender: <xms:TDzWasO60PQvntzS9366fCY95rDVfKeIR3NJ7ADs4wV6sTUJjpwbGw>
    <xme:TDzWaoPKS8FIYC618DvlO3pyALvXKjKQhn2vx3rhkDA0tTDewfl-I4kdm13kD98Tc
    23RDfK5vMlPpiz-hsQaC_cfvN6_gIjd9p4KxXJBbaQSouuBtIMJHAplpQ>
X-ME-Received: <xmr:TDzWal47R9QK2HPBOM5PFWfyKY1_XY1VmGEp4Lzi0bNCigy9R2QEHqVo-HA>
X-ME-Proxy-Cause: dmFkZTE+kjgISKw/D5xbtovMvE/5+MXw9OAGtDBfqR9Zk5dZNOqhNWGTcEGO5Lmn7qsaMJ
    P+2+K5eT4SfShSSEvxMo9+0NhMtUrbV4W6Uy0A3XpuEB672w8089GbqFaxEF0wWgdpl5Mt
    ZGUplA1E9XDXzNgkO2MrFgMfcNS4u61SieDRP0v46gjH0l2eZ2DL9zme+jYfCIiYlLA1YJ
    nvbn1HssXPAJFHKdL+OCiEp78jaTWZC2fJHjA4vCnfghQrymIXyUGAHupLMJJEm2bjt0nv
    kEsuBoXYnW/I4u0Q3SZjAxl07Y4ERxrcHOAeD/N6wYko4+jO11wXgs98kOmjLgJ2rMOJsz
    18DGIkmN8sCfzQCV7sEJC2pxZj7RC8eMNg1UeU3okF34a7lwK/lwdys+qzGdOtcOrJ/aTC
    NyiQb2ojE9CGVMmdY3XRIUnsiIK+vh2Qp4y529vGZS2ky5yIHL3l90Z6GWGm/WOIIfg5oK
    Xg26A/pynhkh6hF6E3O78PaDtNLzaswXz7QJDAJiscbJuWQaSXJGKaFS8MYUIp92Gs9Bqi
    sxgAWUCcGgxBqOARvxJ8DYrqTKwa3N7LrLH3zC2I6q2SQjdzl3j6BRuxDXQTf9D/aeV5Nz
    GTRyl5naroztNsJRmBnZqOQ+gKUFxhFup+Qqs7PCujlpUVIZc9ZejZctTQDA
X-ME-Proxy: <xmx:TDzWakbXGWKb0c3p3qtVBjmRHsel7_XO7EfjIjy1thc7dBUfGuN9jw>
    <xmx:TDzWalEbCtrJtH572tDLhZDb3-jkcyazOMqru97D2XXJRJYZZP1pjw>
    <xmx:TDzWagJ63Zx6R_4aGY5kpVgF0g9Bk1oj1YxX5n5-KI92AYhlhs7V6g>
    <xmx:TDzWasf4QkPNubBlQgrobPTuLwGYevPvVymd_nKbfx0w0xeNw8_t-Q>
    <xmx:TDzWalb8VXuZsly1wZFHr7B_OCOMH-ACacB-wGS81awYqeXdWE6YfBfS>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:50:35 -0400 (EDT)
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
Subject: [RFC PATCH 12/18] mm/filemap: don't defer the free of folios of an inode being evicted
Date: Mon, 19 Oct 2026 16:49:05 +0100
Message-ID: <20261019154913.1765974-13-kas@kernel.org>
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

A hot folio keeps PG_rcu_free until it is freed.  Deleting a file that
was read a lot, or evicting its inode under memory pressure or at
umount, then defers the free of all of its hot folios.

No lockless reader can be in the page cache of an inode being evicted:
the read holds the file open, and the open file holds the inode.  Clear
the flag when the final truncate removes the folio, which
mapping_exiting() tells apart.  A truncate of a file that may still be
open keeps the deferral.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 include/linux/page-flags.h | 5 ++++-
 mm/filemap.c               | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a1e52a1f8a52..4916b5713a74 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -608,17 +608,20 @@ FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
 /*
  * A lockless lookup that sees PG_rcu_free and then still finds the folio
  * where it looked may read it until rcu_read_unlock().  Set under a
- * reference, cleared only by the free.  Not for hugetlb or
+ * reference.  Cleared by the free, or when the folio's inode is evicted:
+ * no lockless lookup can reach it then.  Not for hugetlb or
  * free_pages_nolock().
  */
 #ifdef CONFIG_PAGE_RCU_FREE
 FOLIO_TEST_FLAG(rcu_free, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_SET_FLAG(rcu_free, FOLIO_HEAD_PAGE)
+	FOLIO_CLEAR_FLAG(rcu_free, FOLIO_HEAD_PAGE)
 	__FOLIO_CLEAR_FLAG(rcu_free, FOLIO_HEAD_PAGE)
 #define __PG_RCU_FREE (1UL << PG_rcu_free)
 #else
 FOLIO_TEST_FLAG_FALSE(rcu_free)
 	FOLIO_TEST_SET_FLAG_FALSE(rcu_free)
+	FOLIO_CLEAR_FLAG_NOOP(rcu_free)
 	__FOLIO_CLEAR_FLAG_NOOP(rcu_free)
 #define __PG_RCU_FREE 0
 #endif
diff --git a/mm/filemap.c b/mm/filemap.c
index b732ecaa78a9..53ec92279977 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -138,6 +138,9 @@ static void page_cache_delete(struct address_space *mapping,
 	nr = folio_nr_pages(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	/* No lockless reader can be in an evicted inode */
+	if (folio_test_rcu_free(folio) && mapping_exiting(mapping))
+		folio_clear_rcu_free(folio);
 
 	xas_store(&xas, shadow);
 	xas_init_marks(&xas);
@@ -306,6 +309,9 @@ static void page_cache_delete_batch(struct address_space *mapping,
 		}
 
 		WARN_ON_ONCE(!folio_test_locked(folio));
+		/* No lockless reader can be in an evicted inode */
+		if (folio_test_rcu_free(folio) && mapping_exiting(mapping))
+			folio_clear_rcu_free(folio);
 
 		folio->mapping = NULL;
 		/* Leave folio->index set: truncation lookup relies on it */
-- 
2.54.0

