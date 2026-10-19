Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425031;
	b=O1lLJiycgZ47kT7Zsp/JfTnddOAENFAmwHjGLwtr/5p1iRtE6S4gQXKM+XbQrnxt3giZ
	 LdvFw0RTpWVXwBY87QmORlRh8vcb4kH8ZPbIDqS5//hQ7WXEWqP+9lg9OWTni/fwMdJzy
	 /Lp5HJ1Pl+lBbyPCYJE1LR3tdwRkWxug4s/9WT8b3RUFq2NBPqgcETq0wmdKFsz2f/tTE
	 eHFC/gssWBPbeCoHMJr0vx/A4quWKb/J7uSQbxv33BYDpjWEmJL+8tS3BJHzQGFB2jhQS
	 UYFIRvWB72E+ws59co2jITbD5JIngKvHQIMuzzeoi8M35sN0fL5aOGRPHLaP2WBRJtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425031;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HyeMP2UW39CYOeaVl1H1MlIga1p/omRrDkZGp5zmZrQ=;
	b=ib2wPIlkyHN3kRW2RA6Tq2YcNTeAdiPVdbFFqKV5gyBloJvbSDrvYeUjqSlzbzyI3AiD
	 WJNUlkubQBukpFVUGrRy2FOmqxZyEm65FLI7UGYWSnrqLJ1yQB4b8KNjnsUzZ8Ki98Yq8
	 Cj76K1/oTaX0ZBV3LdYHPYXgZ+0tBHUwu148I921XNQRlED07hVel+tZKUYllcAI7gxId
	 OsF/tqA78fSfKmVr/Rslek8FDUUVSrk6xpwUXMN1LvO87uUbq+6gWxJ3TI2ZhTelOlIad
	 B1tGp5SRlbB24Z/um7FdA6paHH8SxQTm14uawqggQEJycMM4aq9e+4dq/Sxp6yfSc4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7Pnhbm9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD06607884D;
	Mon, 19 Oct 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7Pnhbm9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A2A1F000C4;
	Mon, 19 Oct 2026 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425030;
	bh=HyeMP2UW39CYOeaVl1H1MlIga1p/omRrDkZGp5zmZrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G7Pnhbm9grEna503QpB0IFlA0vPVhE+h9fd2PnmoBVelMGVcaKTWqn7KXh6fi7TS8
	 tT9+PV5l5TK7gSxkGHMRO/aC7aLNGbIYuBTLufEXbNalmkeTfClGbYyyj1WASWxItR
	 Dx/bQq0WLRWJF1pwLVAPO7ZmSkgjN6KVd7wYrl9ZiK16Ytk/tQ85k24FN+dzIaUrwg
	 IbplzNTTL7p0XLTCX9HFUrMTEwCAFC6qnmsHKN3SDEYoyZ/nu1/RZP7z1tiHW620P7
	 Vgcne3vtu71swZ/w/gPSDIRZGkTfYuOsSVRT3hyx9hIQsr8daF0wglWCCg8AJ2K2o7
	 UnDXOwaMvnH6w==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8D186198003A;
	Mon, 19 Oct 2026 11:50:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 19 Oct 2026 11:50:27 -0400
X-ME-Sender: <xms:PzzWapiFp5Wu7v7gkoAa4GZ9J-SekEeSXyMI3tX_37b30zMGuZEykA>
    <xme:PzzWajSFV-mfaNiSPRqBsdRSriXmJ-1eTDxHJ53VBh-3YD5TcbdEp6GRB_WGbU-Ld
    dDDiHrhT0JSf-cSG6iN4HhO0Oha-k11s5tBkktJoOJQN3OqdWuiBhlGHg>
X-ME-Received: <xmr:PzzWaru-LAQJxkJ0JSQEt8ZHYunmcbesOUnPjoSZx60XF-vhE-4drLkTgJQ>
X-ME-Proxy-Cause: dmFkZTFIZYy10wotytG+4dUkb/TrOx7ODFzNTx6LAAAJtb9SdlnEFJwy1XcImD4gyhna2/
    zAC+EEqvmQ9OD1vfTU8mvYiDS0ghuns47Q4+ryXmkVilrv+pqFomIC1gUoiZOfFCnK2t+P
    9O9avF7uz974hExF8BDh4AlkO2Kz5b3etknTZfQTy3eRHnd2C5TvNt8woK5q07pcssriFF
    0X7YzIQRQ9gOQcIZd4ixgjAJQuYNSGk/RFHFd5/NuxCtenwYPdQO132Kw78QGPjvUTnfF3
    VZ20iGzDVcdiQzqlFcp/qqA68rjIK9UtFNtsCnjCSpXpVKtOfu4ZJHZy8EM6a32BgsvOLv
    GTts5CoIR3ht4mxHxWO6GedS/BYYQFbtcXgGZZZ3koz+37rksmGM/qSKHSSY4u7hGUQHmQ
    rAidDUTvlwtc5G79J2GHONIeDMRXVPObyUry2h6EpUB/+Vk/YU4fyni8LK0vUQdhhBy2E2
    wmoClH/DVozueqSCqPryKyW6Mr6WC/UsdiI/R+v2Rm+6VeTFfrHiMhVAOfWNly4VJkyS6V
    1FqCqwaj3etyYvizowlf8vKHJR0w6sN3HwndbOlAo1xYgonV/h4TLvQbqE5aC/TMsWEFVA
    cL7rCb4wFu7n08oVJvqB68O0OYR7d5RXtC6OBk0vSwV+oN7+WFP8nCzHwLVQ
X-ME-Proxy: <xmx:PzzWat9TlLp2tVW-q8vJ0qfUANgsvZp5SwhMDDlAIo_ETCB7XEypmg>
    <xmx:PzzWanaeLh0IZVbvFBwMRe0LrIh3Gpr2iKIpR6cBTlP8G1bDiQWQzg>
    <xmx:PzzWasOOWP1GNW6BJQoakAP2_ynGKahQgJpD28KD5xH9wF4pEmAEHQ>
    <xmx:PzzWavQ0PGzc7cP82JZnszEaOvhnfPLyXh-cOBIS-LBhMjU_MJHKtw>
    <xmx:PzzWan8JAVlxSRKlk6Ml12K0X-VVpUI7gqCEfPaELBHywtIpmVJFCocZ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:50:22 -0400 (EDT)
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
Cc: Miklos Szeredi <miklos@szeredi.hu>,
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
	kernel-team@meta.com,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [RFC PATCH 10/18] mm/filemap: mark a folio accessed in one place in filemap_read()
Date: Mon, 19 Oct 2026 16:49:03 +0100
Message-ID: <20261019154913.1765974-11-kas@kernel.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

filemap_read() calls folio_mark_accessed() in two places.  Before the
copy loop it marks the first folio of the batch, unless the previous
read through the file ended in that folio.  In the loop it marks every
later folio.

The test made for the first folio also says "mark" for every later
one.  The loop gets to a later folio only after the folio before it was
copied to its end, so last_pos is at the later folio's first byte and
pos_same_folio() is false.

Do both in one helper, filemap_read_accessed(), called for each folio
in the loop.  For the first folio the call moves below the test of
end_offset against the folio's start, which is false for it: the folio
holds ki_pos, and end_offset is beyond ki_pos.

No change in behaviour intended.  Preparation for deciding in the
helper which folios are worth reading without a reference.

Assisted-by: LLM
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[kas: shorter changelog]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/filemap.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 00fd89cf6f55..3508eea44ad9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2759,6 +2759,20 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
 	return (pos1 >> shift == pos2 >> shift);
 }
 
+/*
+ * filemap_read() is about to copy from @folio at @pos.  @last_pos is where
+ * the previous read of this open file ended, or how far this one has got.
+ *
+ * Reading on in the folio that the last read ended in is not another access
+ * to it: a folio read in small pieces is marked accessed once.
+ */
+static void filemap_read_accessed(struct folio *folio, loff_t pos,
+				  loff_t last_pos)
+{
+	if (!pos_same_folio(pos, last_pos - 1, folio))
+		folio_mark_accessed(folio);
+}
+
 static void filemap_end_dropbehind_read(struct folio *folio)
 {
 	if (!folio_test_dropbehind(folio))
@@ -2844,14 +2858,6 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		 */
 		writably_mapped = mapping_writably_mapped(mapping);
 
-		/*
-		 * When a read accesses the same folio several times, only
-		 * mark it as accessed the first time.
-		 */
-		if (!pos_same_folio(iocb->ki_pos, last_pos - 1,
-				    fbatch.folios[0]))
-			folio_mark_accessed(fbatch.folios[0]);
-
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 			size_t fsize = folio_size(folio);
@@ -2862,8 +2868,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 
 			if (end_offset < folio_pos(folio))
 				break;
-			if (i > 0)
-				folio_mark_accessed(folio);
+			filemap_read_accessed(folio, iocb->ki_pos, last_pos);
 			/*
 			 * If users can be writing to this folio using arbitrary
 			 * virtual addresses, take care of potential aliasing
-- 
2.54.0

