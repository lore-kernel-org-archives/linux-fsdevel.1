Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424980;
	b=e1cW2m3KTkmm9Cbv0R3AFlkH91g3w8wKSyyR4T6/ZM24q+nGnO6s4RTZRK0vfA5H4dGF
	 9Jx+apsD203cS0/BWJTI5eKZp2qpx0BeUxs3RV/qggZpCxt1eWjLNRwNCqcI2Tkvf0Ru4
	 Do+ipwugTSC+jwerOfZlbwH5iHCAMlIM+KKFo9Ys/msltDsbotheqN80MCDU4HHbqgpZt
	 r8CS9qR13K7dkV+OlXy43bPd7I+TrxLdr/4SKVTYiVYuNP/jbGbDAoQqR2MQBmyO4C9ei
	 H8n+vLpR/mMWxClPpq2iHY0RKOWKZVy5UxBEO6NAxErlRpguEvN2Nyy75pN96T6Sn7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424980;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U4ryK0uFT6LOFyuJdmAuxXhuh94KeEdmaAIvPF6s5TM=;
	b=S6f57fRBPkilfT1gUrL2nKPLY3MZc8LmZuTlLEFdxcD0k1Cpn57CuhHrzqDu3IkQ3zLB
	 zJKCaJqrg3xd2dEXmuqGx6lb1B1KplRotL2QqRllPtqcsgq0f0Q+6IAy0g35SoteyeLBE
	 iwIB3E/afjkDZupQsv/TkeHxqkLFTrO5Wz4rec89VaEv+bpL+kwg1ZVtnsFELxj+n3EyQ
	 SavmCZ3ZBSlbQ4BI98AG/iN1UEj92e9v4IYigjb9HU/hJ83qc93fTV8+mXdX5VRAB1fXd
	 1iJR+CkXkd6O/Sea/wKVo4Xl76JYx0EPxx09t8sKSM22hmTKIpyW1J/TSH5Z/vpyf6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SuW/ZU3r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873296098A18;
	Mon, 19 Oct 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuW/ZU3r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914B91F000C8;
	Mon, 19 Oct 2026 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792424980;
	bh=U4ryK0uFT6LOFyuJdmAuxXhuh94KeEdmaAIvPF6s5TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SuW/ZU3r2cVDI0MsGtAqY7lp1e4JKP84OSelU1jDLrUdnhardwOiGsL6ZdNWe/sJX
	 XxCOanD+yswhINbioTu/uBwI+GZnxfFRI7tAyVQEbaF7LAUhpvpGi0gtkUVutwsmWI
	 Ztg2U6F4nqZKClyQRTTG/zTVX6Bd3BG5GLE8vjbfXf2sC88/k5ywfQZIReR+X5UZGJ
	 uSfqezTEcgvMZ1by6DdXowbRMURfv/jElF1RmPM7DHV8kWYGN9XKZaT9n/k35Oi1+w
	 7cB+KGBMUoOzyiaVffGm4MQyuLHNbZ5T2xDigWr5J+TpZUhKDzhwSihAtl5Vuo82DX
	 f/eh0dCaUH+XA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id EABA8198003A;
	Mon, 19 Oct 2026 11:49:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 11:49:34 -0400
X-ME-Sender: <xms:CjzWavXO_Y880XZrtTCjlXdKtDqIB2QaAMwafKZch5S5npGwx5wdRg>
    <xme:CjzWas1Puk3zubKMm0tmz-Pbo9ZZYlLiZfxNQkLo_tUBKxrM9mKwpUk149-FwC6t8
    eg6ZgJbkO36lVheRIfyypG3DU3Y9_zuCOEWz6V56qBZm3_5yZkR0oQ>
X-ME-Received: <xmr:CjzWauB3TvdayaTR0qveByvk7mbHUUY_mJetq8O7G5BS5PPJo6m3KQEr63I>
X-ME-Proxy-Cause: dmFkZTFpjrG+2jfVBfklNRE95oThC60xlhUtv5sioyJrfpDDHbEB/2cXkTI411oJriXTLs
    N7RLfOUdBbmoibSFu4zT/f1BKPPyxkEYUp5eDeafGhPQjcnfJv/29ZtYwE6q77Fr7A6zQu
    C94bEu3EPqJJ50fLC5xP9PtYZOq3sS+jMfKkgkZFNUAdZxkDiyHArLijwBk9MwzijLWdvR
    4raSXvkSyIGvp9XYd2doZUGuEANzDQejgJzzg3ARZCjBL2yZfXIvLZCg0AMujDeTHEemYv
    cvWt94P7AS+P1mtikHZvyS9eAaK3Fy2/TwDlvaPXULPDsZK9f0sj0aca+uCBBoNs4d3uIW
    6UtJ41xqrTh41J9CGKF5HMdWWNPlzyNWgWQzyeIKO+iqcaYPlEF9Y5+OBdY51W8gzONadz
    MxZF+NNp24tKwLD4/n1vy2Ovyn5wcR3tpqUHyQQpOTfDPZ4IwklH+mHOUVdzlFtnjgYkaQ
    qoNdWC/Qz3DlVKJX3IEmP6IDgyqMgqiPpwb6q5YyYOFoysGo7gHd2QNO9WcnhuKVK+bLic
    /u4BPVbK5+aqDmA+vVjbOvePAVA1tvWTAf2718PxhSMiEPspjNO8JwFB57p35ewgTxBW7f
    y5dRgjXgQxXNs9kr1jbCq9G/mob8EFCcMV/U+ZRpNrKfSXjGnRlgT2m+VOxQ
X-ME-Proxy: <xmx:CjzWaqBmY1BwDTEGOsh6LrR6Iv28To4XkMFUMNKyAk2sab-xos9gkQ>
    <xmx:CjzWaqMAH5kjgYLBGev1TmLRy7ZBnpqemGYZiitesbhexZdNypHpmQ>
    <xmx:CjzWauzJYkLsAOJpqj9kc2I5QOz4s5s4MNjwAUepO8XqIFw8W6Y8RQ>
    <xmx:CjzWamk7ihrz0TkkbxoO3o-ji1NdsMy_QJIzTK2PhTorQf-yvwLfdw>
    <xmx:CjzWalDn4hPNLGniKiM4csh4s3wCtwuUcuswoCivCQdjdz4SqVZMy1ry>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:49:29 -0400 (EDT)
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
Subject: [RFC PATCH 02/18] splice: don't steal page cache folios
Date: Mon, 19 Oct 2026 16:48:55 +0100
Message-ID: <20261019154913.1765974-3-kas@kernel.org>
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

PG_rcu_free holds back the reuse of a folio's memory until a grace
period after the folio is freed.  A stolen page cache pipe buffer is
reused without being freed: remove_mapping() takes the folio out of the
page cache and the caller keeps it.  fuse_try_move_folio() puts it into
a fuse file, where writes change it under a reader that found it before
the steal.

Drop ->try_steal from page_cache_pipe_buf_ops.  fuse_try_move_folio()
and virtio_console's pipe_to_sg() then copy, as they already do when
stealing fails.  SPLICE_F_MOVE from the page cache into a fuse file or
a virtio console now copies.

Assisted-by: LLM
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[kas: rewrote the changelog]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 fs/splice.c | 51 ---------------------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1a..0133c2348da0 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -55,56 +55,6 @@ static noinline void pipe_clear_nowait(struct file *file)
 	} while (!try_cmpxchg(&file->f_mode, &fmode, fmode & ~FMODE_NOWAIT));
 }
 
-/*
- * Attempt to steal a page from a pipe buffer. This should perhaps go into
- * a vm helper function, it's already simplified quite a bit by the
- * addition of remove_mapping(). If success is returned, the caller may
- * attempt to reuse this page for another destination.
- */
-static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
-		struct pipe_buffer *buf)
-{
-	struct folio *folio = page_folio(buf->page);
-	struct address_space *mapping;
-
-	folio_lock(folio);
-
-	mapping = folio_mapping(folio);
-	if (mapping) {
-		WARN_ON(!folio_test_uptodate(folio));
-
-		/*
-		 * At least for ext2 with nobh option, we need to wait on
-		 * writeback completing on this folio, since we'll remove it
-		 * from the pagecache.  Otherwise truncate wont wait on the
-		 * folio, allowing the disk blocks to be reused by someone else
-		 * before we actually wrote our data to them. fs corruption
-		 * ensues.
-		 */
-		folio_wait_writeback(folio);
-
-		if (!filemap_release_folio(folio, GFP_KERNEL))
-			goto out_unlock;
-
-		/*
-		 * If we succeeded in removing the mapping, set LRU flag
-		 * and return good.
-		 */
-		if (remove_mapping(mapping, folio)) {
-			buf->flags |= PIPE_BUF_FLAG_LRU;
-			return true;
-		}
-	}
-
-	/*
-	 * Raced with truncate or failed to remove folio from current
-	 * address space, unlock and return failure.
-	 */
-out_unlock:
-	folio_unlock(folio);
-	return false;
-}
-
 static void page_cache_pipe_buf_release(struct pipe_inode_info *pipe,
 					struct pipe_buffer *buf)
 {
@@ -155,7 +105,6 @@ static int page_cache_pipe_buf_confirm(struct pipe_inode_info *pipe,
 const struct pipe_buf_operations page_cache_pipe_buf_ops = {
 	.confirm	= page_cache_pipe_buf_confirm,
 	.release	= page_cache_pipe_buf_release,
-	.try_steal	= page_cache_pipe_buf_try_steal,
 	.get		= generic_pipe_buf_get,
 };
 
-- 
2.54.0

