Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752B388369;
	Sat, 18 Jul 2026 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784401452; cv=none; b=Pgr4GXr+NpL5YW5XX7BxvX2+WFmHc7bF0+ogjVDUoZSow0qnLzmAiV54Ozp9ry1d8QlIAZ4ww4r4yErGgCASJD3lxG68UfcUIlna5W7+EeAzJ4sNI9ofhKxPjjrcDDN79/eXvSozau2KMudwcEhLi+St4DF0ULpz6qFOSsE16Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784401452; c=relaxed/simple;
	bh=hohx+eI3RcwxXoLSZqoWIj4P16yZPrh6y2UzTiiH+UI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDwpXMO74kvxj1pySN2PtoOpeSZIPb4aUO3tRhTcitkyW5ni/Aja16rdxIzobxj5AsOb/KM/2+jg8cFUUb46AfdK73bHBwfxLgOyis4y+dsUsjsaY+MTKb1wdSOjYtgMPxXQjauxibJxTLvPfKg5l2SSveSEnAS23VNE4T9MULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IS+5gGTr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IS+5gGTr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8t4Zbx44suMzlTv0YaH9UaY61zMxooUh222VW4P6BJU=; b=IS+5gGTrpt4o2I3B15JFtcZjRl
	Brw6bg1KM13vhfnkPvO6ZK5OwTSrRwMr8U40a1ceEAioBRarhjXNc+bGeaEFq22ft50FkkZY/mj/3
	wcCLL6EaBThdeUUTf0Sx2bJwwpf2KdXBYGNNScMOpzbuN+4qwofZdc3byZLaanu6QQnhSubua09rg
	ZPj2UoA1YgnO12Ee/kjxguOydb66mUsZ/gM2M01yf3Y99eI38YCYLIVg06qbGc9oMh6JaoDipRSlV
	0V6ID1+nOomdOZMfUEODPmAiJtgKYjTcF2tUF/hWiWrZ5FqMHduGEqTOXmMkf8jQ0VBRHMGWVMUmL
	ZGfrrOHw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlAKK-00000004T9y-35mh;
	Sat, 18 Jul 2026 19:03:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] sysctl: repair some kernel-doc comments
Date: Sat, 18 Jul 2026 12:03:56 -0700
Message-ID: <20260718190356.1892992-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert a non-kernel-comment to use "/*" instead.
Don't use kernel-doc for the nested @type enum values since they
aren't part of the struct.

Warning: ./include/linux/sysctl.h:62 Cannot find identifier on line:
 *
Warning: ./include/linux/sysctl.h:63 Cannot find identifier on line:
 * "dir" originates from read_iter (dir = 0) or write_iter (dir = 1)
Warning: ./include/linux/sysctl.h:64 This comment starts with '/**', but isn't a kernel-doc comment.
 * in the file_operations struct at proc/proc_sysctl.c. Its value means
Warning: ./include/linux/sysctl.h:274 Excess struct member
  'type.SYSCTL_TABLE_TYPE_DEFAULT' description in 'ctl_table_header'
Warning: ./include/linux/sysctl.h:274 Excess struct member
  'type.SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY' description in 'ctl_table_header'

Note: This still leaves 7 struct members in ctl_table_header that
are not described. E.g.:
Warning: include/linux/sysctl.h:274 struct member 'unregistering' not described in 'ctl_table_header'
Warning: include/linux/sysctl.h:274 struct member 'ctl_table_arg' not described in 'ctl_table_header'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Kees Cook <kees@kernel.org>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org

 include/linux/sysctl.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20260717.orig/include/linux/sysctl.h
+++ linux-next-20260717/include/linux/sysctl.h
@@ -59,7 +59,7 @@ extern const int sysctl_vals[];
 #define SYSCTL_LONG_ONE		((void *)&sysctl_long_vals[1])
 #define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[2])
 
-/**
+/*
  *
  * "dir" originates from read_iter (dir = 0) or write_iter (dir = 1)
  * in the file_operations struct at proc/proc_sysctl.c. Its value means
@@ -245,9 +245,9 @@ struct ctl_node {
  * @nreg: When nreg drops to 0 the ctl_table_header will be unregistered.
  * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc_sysctl ->d_compare()"
  *
- * @type: Enumeration to differentiate between ctl target types
- * @type.SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
- * @type.SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Identifies a permanently empty dir
+ * @type: Enumeration to differentiate between ctl target types:
+ * type.SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
+ * type.SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Identifies a permanently empty dir
  *                                            target to serve as a mount point
  */
 struct ctl_table_header {
