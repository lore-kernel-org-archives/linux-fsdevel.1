Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B23D6CDA;
	Wed, 20 May 2026 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272401; cv=none; b=qaREBkPFPXMse9o8RuZCpdxOQPDcbVOXqRGLocaKVOoyh6RNcrddTaiXl4w+I4rgGhk0Gf94rtzEO4r93k9qx74rYYVpgZSGTzt6hisupCQlbH+wfmQxk2n9RLzJdLMzkpE6w0GBwtJ7hY22iIATH4YtcMrPojvDfPWUn52UCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272401; c=relaxed/simple;
	bh=f9J+IhisTdLnLgXR7JSjhUN2PwnfX+gYzer2vCIsUE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amCHhSHHi8Oggegs3fFZ6cngsHB8qSm2eg3pTbyUqwvQA1sfJblF0KApzeLnL65r3CkSE3MdFHv3wiRGQ1S0bWFOev53Mpo4DmcDT5SrjFtdmtRnshoXYsAA6tHbvBkPMpwm9R3T6ahXLqUWKM05xDzN8GWmeIA3MWebDAP9f2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OBC51bwB; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OBC51bwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9B
	VjTk8nQGGmUxI8PCEpxJWmL7Kaf4Qp03cf8IYb8qA=; b=OBC51bwB+qfYf08FyI
	e7P8qz+PHuCddXwTbn7uKjr4zqkZU0fNQ3zSbi6dn1aUAPqtA7YCBEow+TVMt7p9
	lgTaW14EdA7BkCwq3S7lUnZykKo4W1Um4BYx0mKHKXPTXseMEG9nn+PZrYEez25h
	qfZ4rCsR5z/5lXO9nRS5Toi2w=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXbbprig1qQK31EQ--.641S3;
	Wed, 20 May 2026 18:18:25 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 1/5] mm/filemap: reduce unnecessary xarray lookups when read cached pages
Date: Wed, 20 May 2026 18:15:34 +0800
Message-ID: <20260520101538.58745-2-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520101538.58745-1-chizhiling@163.com>
References: <20260520101538.58745-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXbbprig1qQK31EQ--.641S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4Dtw48ZFyDCF4fur4kJFb_yoW5CFW3pr
	1rG3WkGrsrJw1YkrnxJay2ga4rW3s7XF45JFySg3WSvFn8Arn0kayxKF15KFyDZFy3ZF1f
	XF18Ja4vgF1Yq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jso7tUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3BGcOmoNinFzrgAA3q

From: Chi Zhiling <chizhiling@kylinos.cn>

When reading small amounts of data from the page cache, only a single
folio is typically returned from filemap_read_get_batch(). In this case,
calling xas_advance() or xas_next() after adding the folio to the batch
is unnecessary and only introduces extra branches.

The same issue exists for large reads, where one additional xarray walk
is always performed before termination.

Move the boundary check to after the folio is added to the batch so the
final redundant xarray advancement can be avoided. This significantly
reduces the branch count in the read path.

xas_next() does not update xa_index when xas->xa_node is set to
XAS_RESTART, so checking the boundary before updating xa_index is
sufficient to keep the folio within range. The warning should therefore
never trigger.

The branch count:
654.198 M/sec -> 646.444 M/sec

Performance counter stats for 'fio --ioengine=sync --rw=read --bs=4k --size=1G
--runtime=300 --time_based --group_reporting --name=seq_read_test --filename=file':

before:
READ: bw=2697MiB/s (2828MB/s), 2697MiB/s-2697MiB/s (2828MB/s-2828MB/s), io=790GiB (848GB), run=300001-300001msec
      245602051556      task-clock                       #    0.821 CPUs utilized
             78467      context-switches                 #  319.488 /sec
                40      cpu-migrations                   #    0.163 /sec
              3388      page-faults                      #   13.795 /sec
      758312319204      instructions                     #    0.74  insn per cycle
     1025881497502      cycles                           #    4.177 GHz
      160672383734      branches                         #  654.198 M/sec
         361904512      branch-misses                    #    0.23% of all branches

after:
READ: bw=2709MiB/s (2841MB/s), 2709MiB/s-2709MiB/s (2841MB/s-2841MB/s), io=794GiB (852GB), run=300000-300000msec
      243985503670      task-clock                       #    0.812 CPUs utilized
             79004      context-switches                 #  323.806 /sec
                30      cpu-migrations                   #    0.123 /sec
              3355      page-faults                      #   13.751 /sec
      747830935069      instructions                     #    0.73  insn per cycle
     1019609333322      cycles                           #    4.179 GHz
      157722976668      branches                         #  646.444 M/sec
         348984893      branch-misses                    #    0.22% of all branches

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/filemap.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..d54450e529bd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2458,12 +2458,16 @@ static void filemap_get_read_batch(struct address_space *mapping,
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	struct folio *folio;
+	pgoff_t next;
+
+	if (unlikely(index > max))
+		return;
 
 	rcu_read_lock();
 	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
 		if (xas_retry(&xas, folio))
 			continue;
-		if (xas.xa_index > max || xa_is_value(folio))
+		if (xa_is_value(folio) || WARN_ON(xas.xa_index > max))
 			break;
 		if (xa_is_sibling(folio))
 			break;
@@ -2479,7 +2483,11 @@ static void filemap_get_read_batch(struct address_space *mapping,
 			break;
 		if (folio_test_readahead(folio))
 			break;
-		xas_advance(&xas, folio_next_index(folio) - 1);
+
+		next = folio_next_index(folio);
+		if (next > max)
+			break;
+		xas_advance(&xas, next - 1);
 		continue;
 put_folio:
 		folio_put(folio);
-- 
2.43.0

