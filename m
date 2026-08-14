Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0653D7D75;
	Fri, 14 Aug 2026 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674725; cv=none; b=TahQziEjWxjv+H5yVphZ/5JxKchRRPtp200QcL0lyJuXsoIhwyVFZS7rSrOiktKKE575VtIXkMr7PXnkU119YY/xPZPwExyP6l2YuC+Uip+iKTbCUeghFuDBJcT6O72DixXDpuMzyEXP20sAcoa5gEnG8PPHsTEIwxquvuwx6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674725; c=relaxed/simple;
	bh=yZZ20gEfX/mgtu21SNsSoMy2ldceVKlooYLOCpsLcXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCXRZMs7iJ8kQiu9n6URmG3Yn9h9zPlc6BIEMBVlWheEQ/l/AOR7iA+Cusu0jtkvO38vck1sH75JBEDM1AEX11szatXSzM8WMCNXYKTS0ftalp/NIw9V6823hfp3SaxylFi7yfQHP4FxmftWlXqpu8IHYI70aofEUYT+0rrfDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpPbP8BN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpPbP8BN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786674717; x=1818210717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yZZ20gEfX/mgtu21SNsSoMy2ldceVKlooYLOCpsLcXY=;
  b=kpPbP8BN+xOfGScrG40MmLN3badO3XV4s2HE1Zyq9omHhiRPjR0fNcV+
   zXstHu7c4WbzoAqKzXghvT01lswNnqYc59pZM4/vuDDRXuHsmwomNL3HR
   1ONAXYuTRCDwGMhgviltYNYo2ORzFy4Fjs2bGHT7Dkvvy7Nuw/htD/IBm
   PTqRzl2vyisFVx4DK9qmST91MWzDpX26zEi4WxNLVZfReOkuhTj2j8A9x
   1IafY8c2ZShgB3NK/mWTx4e6rPoLHHFbOycmr5FasWxreHOczm4C+terZ
   iPg/+VFE2xgRxY3HmYx6uh6Nyhhw3ruKOSil6J9tHdWTLSn8Kgfj1HeiH
   Q==;
X-CSE-ConnectionGUID: ect4OGqGRGiAwTqkIVy/wQ==
X-CSE-MsgGUID: fN7hmp92SqKRrzwE6YLdhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87181993"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87181993"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 19:31:57 -0700
X-CSE-ConnectionGUID: U9mtIp3DSx+8I6Ua8ieTzw==
X-CSE-MsgGUID: 1o+lvJ99Qr2+wyO7dWK9nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="302339630"
Received: from tester.sh.intel.com ([10.112.106.126])
  by orviesa001.jf.intel.com with ESMTP; 13 Aug 2026 19:31:56 -0700
From: Tao Yu <tao1.yu@intel.com>
To: linux-fsdevel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-kernel@vger.kernel.org,
	syzbot+2bf21610eea63cb2ce93@syzkaller.appspotmail.com,
	Tao Yu <tao1.yu@intel.com>
Subject: [PATCH 2/2] hfs/hfsplus: stop btree allocators from reusing node 0
Date: Fri, 14 Aug 2026 10:31:50 +0800
Message-Id: <20260814023150.3482810-3-tao1.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814023150.3482810-1-tao1.yu@intel.com>
References: <20260814023150.3482810-1-tao1.yu@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The btree header node is permanently reserved as node 0. If the on-disk
bitmap ever presents node 0 as free, the filesystem is already
corrupted and the allocator must not try to instantiate it again.

Both HFS and HFS+ currently keep scanning the bitmap, set the bit, and
hand node 0 to hfs_bnode_create()/hfsplus_bnode_create(). HFS+ then
hits the "new node 0 already hashed?" warning reported by syzbot, while
HFS risks continuing after the same corruption pattern.

Teach both allocators to treat attempts to allocate node 0 as btree map
corruption. Force the filesystem read-only, emit the existing repair
hint, and abort the allocation before the code reaches the hashed-node
warning.

Reported-by: syzbot+2bf21610eea63cb2ce93@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2bf21610eea63cb2ce93
Signed-off-by: Tao Yu <tao1.yu@intel.com>
---
 fs/hfs/btree.c     | 11 +++++++++++
 fs/hfsplus/btree.c | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 14114318ec724..9b0b7418ddbd5 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -376,6 +376,17 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 			if (byte != 0xff) {
 				for (m = 0x80, i = 0; i < 8; m >>= 1, i++) {
 					if (!(byte & m)) {
+						if (unlikely(!(idx + i))) {
+							pr_warn("(%s): %s (cnid 0x%x) map record invalid or bitmap corruption detected, forcing read-only.\n",
+								tree->sb->s_id,
+								hfs_btree_name(tree->cnid),
+								tree->cnid);
+							pr_warn("Run fsck.hfs to repair.\n");
+							tree->sb->s_flags |= SB_RDONLY;
+							kunmap_local(data);
+							hfs_bnode_put(node);
+							return ERR_PTR(-EIO);
+						}
 						idx += i;
 						data[off] |= m;
 						set_page_dirty(*pagep);
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 394542a47e600..3ee92248b2409 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -561,6 +561,17 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 			if (byte != 0xff) {
 				for (m = 0x80, i = 0; i < 8; m >>= 1, i++) {
 					if (!(byte & m)) {
+						if (unlikely(!(idx + i))) {
+							pr_warn("(%s): %s (cnid 0x%x) map record invalid or bitmap corruption detected, forcing read-only.\n",
+								tree->sb->s_id,
+								hfs_btree_name(tree->cnid),
+								tree->cnid);
+							pr_warn("Run fsck.hfsplus to repair.\n");
+							tree->sb->s_flags |= SB_RDONLY;
+							kunmap_local(data);
+							hfs_bnode_put(node);
+							return ERR_PTR(-EIO);
+						}
 						idx += i;
 						data[ctx.off] |= m;
 						set_page_dirty(page);
-- 
2.34.1

