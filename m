Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1C413D96;
	Tue, 30 Jun 2026 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823922; cv=none; b=APYzURo1PjERVG7NiZti8zDkhYjWipLTGvRpFIlMLi3b1r4AyDLWtqz9oXhoUo8/5CWkXQ/h+fcjKjBEateroaA1okgcFaCzKFyY5Y/kU2GFg5jup3W1tA5wTWELBseHkCunmhwe2taQzfQlBIo68b02ciVi2k4GbKG2pVGBTZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823922; c=relaxed/simple;
	bh=4aR45X4K3X+kTdeSmMc7tfauXD9VU6lkF+nQJQLoz44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UGG2V92rF9CseaiCwguuLzvd4EctljVywrQWGCmIVuRbBmxzaeq4QdByg76C8nCMwbDmRPDtX/dGgzzI9NvGv3BytXnKjXwYxWvii8E7lw61/wQhxDwgfBXK8xKjfMsf6QPxOu+OeMHWQHXfLIAHtXHm99XeN512tCnGvCU5hW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SlOukZyT; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SlOukZyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=y0
	vPmYUBULcu9w6m1I2L1iLW9ulxs3q8zoEGbABUjQo=; b=SlOukZyTkNunO2MBis
	N4mfiIHbCYanHitBhIBONgTnsQUjUHPnbTP/zZvO3hxAmd+yC70Vb2nmqacpoj8f
	MtwUNUZUnnFQ8qnjKkukjUrs0M3o+jrTmtN90pXELyj4LWt1P8qqPtgjuwMet+YR
	GbJEUYxOedzVLeuZnbYtqH5ZE=
Received: from yanzhen.lan (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3VyOnu0NqxxByGg--.14700S2;
	Tue, 30 Jun 2026 20:50:48 +0800 (CST)
From: Zhen Yan <yanzhen20011121@163.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH v2] mm: fix mapping_seek_hole_data() overflow on last page
Date: Tue, 30 Jun 2026 20:50:47 +0800
Message-Id: <20260630125047.703170-1-yanzhen20011121@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tikbuxxazkmz5obcf6llp342vn7bi5tlgbbnuliw4jlwndj63e@jkp5g5oj6ug7>
References: <tikbuxxazkmz5obcf6llp342vn7bi5tlgbbnuliw4jlwndj63e@jkp5g5oj6ug7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3VyOnu0NqxxByGg--.14700S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1UXF1DAFWDZr1fXF1kKrg_yoW8trWrpr
	95Cr1S9rWxXw13Ar93JwnrJa15Cw4vyF4FvFy7Gr4UZFn8GF12gF90ka45uF9rXryrGF1j
	vr1qvFWjgr47XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYKZXUUUUU=
X-CM-SenderInfo: h1dq6xdhqsiiqrrrjii6rwjhhfrp/xtbC0wiEiGpDu6gWvwAA3E

A local unprivileged process can create a shmem/tmpfs file with
i_size == LLONG_MAX using memfd_create() and fallocate().  If the last
page is present in the page cache, lseek(SEEK_HOLE) on that page
returns 0x8000000000000000 as a successful offset, which is LLONG_MIN
when stored in loff_t.

The same file has readable data at the last byte, but SEEK_DATA from
that offset returns ENXIO.

The overflow is in mapping_seek_hole_data():

  pos = round_up((u64)pos + 1, seek_size);

For the final page below LLONG_MAX, the next page boundary is
0x8000000000000000, which is then used as a signed file offset.
When assigned to the loff_t pos, this overflows to LLONG_MIN, so
a subsequent "pos > end" comparison does not catch it.

Keep mapping_seek_hole_data() inside its documented [start, end)
search range: compute round_up() into a u64 variable and compare
against (u64)end so the overflow is detected, then clamp pos to
end when the rounded-up value goes past the search limit.

Signed-off-by: Zhen Yan <yanzhen20011121@163.com>
---
 mm/filemap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5af62e6abca5..b78fd88f2638 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3225,6 +3225,7 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 	while ((folio = find_get_entry(&xas, max, XA_PRESENT))) {
 		loff_t pos = (u64)xas.xa_index << PAGE_SHIFT;
 		size_t seek_size;
+		u64 next;

 		if (start < pos) {
 			if (!seek_data)
@@ -3233,7 +3234,11 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 		}

 		seek_size = seek_folio_size(&xas, folio);
-		pos = round_up((u64)pos + 1, seek_size);
+		next = round_up((u64)pos + 1, seek_size);
+		if (next > (u64)end)
+			pos = end;
+		else
+			pos = next;
 		start = folio_seek_hole_data(&xas, mapping, folio, start, pos,
 				seek_data);
 		if (start < pos)
--
2.25.1

Sorry about the previous patch -- the `pos > end` check was wrong
because round_up() overflows loff_t to LLONG_MIN, making the
signed comparison ineffective.  Thanks to Jan Kara for pointing
this out.  This v2 uses a u64 intermediate variable so the
overflow is correctly detected.

