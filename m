Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053FD2857FA;
	Tue, 30 Jun 2026 03:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789212; cv=none; b=OWqqY2apmjYUx/Rcq2o5fgsJd9wk9p8mQIXElA1x4f6pEPCdcz3A6qa22nzzOpKWoQX7t5Opa9UIn0H/e8OweL4PdMRJRNbVERggVJgdl3DrgqwukhLC4jDF2v9T4GE9kjjbsuRM2ktEkf90FDxqboTDHP+HIzjjK6AoZ5GWGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789212; c=relaxed/simple;
	bh=11qD8guZYpUipN0+YPuMBi13pWlm34lLpUl6JLIYSWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkkGQS/7hWFFIgsrM8WJerQ8IoG4x/KBVOI9sFQYOruT4JvIIGczyKihwWwnLApR2K+i6U5/2v3yShP3B1ORIjbippcGtpN+/9EZeWNfuJKqFXE9u1rwzPFZT3lwF/8GKPfDffjjOeTGhsv5klz/ijDW2+B3Ef9b9DPiWnM8BQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=n7i/2IHW; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="n7i/2IHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ce
	oCjYNNF3U4NL9LaVK+JffB9FyD9tajby88BFAZU1w=; b=n7i/2IHW94F0tg4FQA
	I8y7pyv+r4AJNY2qeZZPvuVMDowRZsPrAEY57SQsnUUdZfIKP/OvXXgX0OPmHYMv
	nVOF2A4jdwBX+u8UQKPz2gmRKw+wZxnH1zSS3DQpiJV+tROcrGAQsgYXVXkzooVl
	UwDTiQUWmtgWWvoKxpcLSCvNo=
Received: from yanzhen.lan (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCHQ_oaNENqtzXBEQ--.32894S2;
	Tue, 30 Jun 2026 11:12:27 +0800 (CST)
From: Zhen Yan <yanzhen20011121@163.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm: fix mapping_seek_hole_data() overflow on last page
Date: Tue, 30 Jun 2026 11:12:26 +0800
Message-Id: <20260630031226.3141360-1-yanzhen20011121@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260629164932.b91930b0497e8446a2a549d2@linux-foundation.org>
References: <20260629164932.b91930b0497e8446a2a549d2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCHQ_oaNENqtzXBEQ--.32894S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1UXF1DAFWDZr1fXF1kKrg_yoW8AF4kpr
	98Gr1IkrZ7Xw1ayrZ7G3ZrArWrC34vyF4UtFW3WryUZFn8Gr18Ka9093WY9FyxJryUCF4j
	vF4jvay2qr4UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOjjDUUUUU=
X-CM-SenderInfo: h1dq6xdhqsiiqrrrjii6rwjhhfrp/xtbC9Rx-g2pDNBw0qQAA3J

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

This violates the lseek() ABI for shmem/tmpfs: a successful seek
returns a negative offset, and SEEK_DATA can miss readable data at EOF.
Hole-aware copy, backup, and sparse-file scanners may skip the last
cached byte range.

Keep mapping_seek_hole_data() inside its documented [start, end)
search range by clamping the rounded-up position to end before passing
it to folio_seek_hole_data().

Signed-off-by: Zhen Yan <yanzhen20011121@163.com>
---
 mm/filemap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5af62e6abca5..22a1534ec8b3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3234,6 +3234,8 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,

 		seek_size = seek_folio_size(&xas, folio);
 		pos = round_up((u64)pos + 1, seek_size);
+		if (pos > end)
+			pos = end;
 		start = folio_seek_hole_data(&xas, mapping, folio, start, pos,
 				seek_data);
 		if (start < pos)
--
2.25.1

Sorry, my previous email may have been lost due to network
filtering issues.  Resending the revised patch with the
requested changes (tabs preserved, CCs added, signoff added).

