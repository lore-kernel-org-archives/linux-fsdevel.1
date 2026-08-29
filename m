Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0929E33C1B7;
	Sat, 29 Aug 2026 04:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787978474; cv=none; b=PAOuEiUMhOgeIedTWIjbThSUb+ygOrknJmyR4WyhwcQPqAddmmQUsLpvkWVT2PN/IUSnvOtJzb4wMTz4ZN34s7aO8yp4vQwwFuHMRU8slC/Qg4Ul/sLIbq0a4no9nI/xTryjx0ynUvjc2LFNW1/rgjiGW+WrMhQH/ms+WCVIL+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787978474; c=relaxed/simple;
	bh=2JGqXWCbZ5rvViDhEt7kOXZr99HBUzTG6/6Uyla+htg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cj5aGmloHmN/6PU8aJZ17hyVkrSKM65z1N6E+hKJftlJniZ72m/aoJCA+SUpFX+2jKLI05TNKycQXDJiNWUzjBlUwfezRTVaYlpUhHydPezHABwwxlvZFypmdgmWMBhrPQFpYAOk2+vC5kkIqvrJhdAORF45kYQqju6M2i1d22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZMX4/ra; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZMX4/ra"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787978471; x=1819514471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2JGqXWCbZ5rvViDhEt7kOXZr99HBUzTG6/6Uyla+htg=;
  b=LZMX4/ra7zlIiDTXvUL8EDBB1AIVNmrYjSB4zuupJf1N0cHTv4ueokJ9
   ENKAi10cuNhhgFy1MxxKLQlnx1dry03gQDjrPXwpw3v0OTTufcdAdIUv5
   NsMmbAFo9erEw0sJFBgD7o14YGPMDUBlbDlyrzbG4Rcseq6iW8xAtDs4Z
   WmmIcusmvF9pOvGDorNv9jkQHmm9rn5wy9mKVbyq47eTXTDRprqMbSndX
   eUn31+eUirC4/pRfhmrmWlzf+nGj92z8z+IoOz6RcDMA6fYQmDUk7g3+N
   sq+U6HlKiEF5LJahCfKVaaRtguswYCJOxPRPfwjyvyvO7mZpG7+k/2Tb1
   g==;
X-CSE-ConnectionGUID: ciAfApalQ3ikRsELkbHFqQ==
X-CSE-MsgGUID: X4XMPynRQPa9ZQ/DCjtQFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88683935"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="88683935"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 21:41:11 -0700
X-CSE-ConnectionGUID: PVdNb1TbTG6lMhgtjoogew==
X-CSE-MsgGUID: MsJFC2WfSh6fGBC2zTN5zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="266533038"
Received: from pankris-x299-ud4-pro.bj.intel.com ([10.238.152.122])
  by orviesa006.jf.intel.com with ESMTP; 28 Aug 2026 21:41:08 -0700
From: Kris Pan <kris.pan@intel.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	hughd@google.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	arnd@arndb.de,
	max.kellermann@ionos.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kris Pan <kris.pan@intel.com>
Subject: [PATCH v2 2/2] drivers/char/mem: splice the zero page for /dev/zero and /dev/full
Date: Sat, 29 Aug 2026 12:37:46 +0800
Message-ID: <20260829043746.2929210-3-kris.pan@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829043746.2929210-1-kris.pan@intel.com>
References: <20260829043746.2929210-1-kris.pan@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a splice_read handler for /dev/zero and /dev/full that pushes
references to the global zero page into the pipe, instead of allocating
and zeroing a fresh page for every pipe buffer.

This is much faster than copy_splice_read() for splicing zeroes, since it
avoids the page allocation and zeroing on every pipe buffer.

Use the shared splice_zeropage_into_pipe() helper from fs/splice.c.

Signed-off-by: Kris Pan <kris.pan@intel.com>
Reviewed-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/char/mem.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 63253d1de5d70..6d3ef359b2d7b 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -471,6 +471,31 @@ static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter)
 	return written;
 }
 
+static ssize_t splice_read_zero(struct file *in, loff_t *ppos,
+				struct pipe_inode_info *pipe, size_t len,
+				unsigned int flags)
+{
+	size_t total = 0;
+	loff_t pos = 0;
+	size_t used, npages;
+
+	used = pipe_buf_usage(pipe);
+	if (used >= pipe->max_usage)
+		return -EAGAIN;
+	npages = pipe->max_usage - used;
+	len = min_t(size_t, len, npages * PAGE_SIZE);
+
+	while (len) {
+		size_t n = splice_zeropage_into_pipe(pipe, pos, len);
+
+		pos += n;
+		total += n;
+		len -= n;
+	}
+
+	return total;
+}
+
 static ssize_t read_zero(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
 {
@@ -669,7 +694,7 @@ static const struct file_operations zero_fops = {
 	.read_iter	= read_iter_zero,
 	.read		= read_zero,
 	.write_iter	= write_iter_zero,
-	.splice_read	= copy_splice_read,
+	.splice_read	= splice_read_zero,
 	.splice_write	= splice_write_zero,
 	.mmap_prepare	= mmap_zero_prepare,
 	.get_unmapped_area = get_unmapped_area_zero,
@@ -682,7 +707,7 @@ static const struct file_operations full_fops = {
 	.llseek		= full_lseek,
 	.read_iter	= read_iter_zero,
 	.write		= write_full,
-	.splice_read	= copy_splice_read,
+	.splice_read	= splice_read_zero,
 };
 
 static const struct memdev {
-- 
2.43.0

