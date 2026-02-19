Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098C3033F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483827; cv=none; b=Fjc0JJXXiOzoYGBL4uDuxQyl3gtEq4OZjFKJJRAlTguZaE0MLt4fALooV3OFl8uadnVEc3oqRk6UrEi/iEK1GKlRbq7vD56YBtMjkvINWmXshb25BCKeiWHWEs3+IyKeqoUxABrSOizXuzxeTHsTgwgnO/99rckW33jYFwyt0Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483827; c=relaxed/simple;
	bh=egvamw6vT6kWN3PAOZSHyRx+4rHq767Iyryo4/BfEdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhhL18vy1RYV8ixv8ish01AVNPnASO576Q09He1BM+tEbKVGYigbJJNP8DhZiF0S+7unOQ4ACr9IpEnMnnUzqI5cc1NpxFz9L1BrV0pDBMeR/U+1Pwizgxp8Qz3erZrC1Kl2luzUwuycly2ucqRANXlWMna3Cnjo6PXrUi9MvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ET26lDau; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ET26lDau"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=egwEe+uAGICExu1HFlXlPISh8z3tJBhRbemK9NPxuN8=; b=ET26lDauzOqtogqv/1lFYAtbwM
	oihM4aD7jgla53OfP0ZJv6ELSAO6effSR9vAGvJ/v4fuRAHw+MQXV9H3EaSKMRQFBfD7EsKrBvJpD
	XweFJdUlCYMOC6KT9dCAfrJUkzLmiH7bCVuJK/f7RRhe75eyRL+g/dfa297lmuto5YdRCSpA8uxMH
	5jPYsNSQMfddZk+vJKakKDEc+eyYpMzmXZEUoge94WTb0nA5iWQFIp/oUQyrA6SlivWU5j23Wd71Q
	OPTWmiP8VcVd793hjIdCEbubHGayLxpvbEbPRFRKzd5BCK2cewhpYAPNQx75bWPGk+INnKHyjWoJz
	2pf8V20Q==;
Received: from [212.185.66.17] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsxrl-0000000AzIT-42qg;
	Thu, 19 Feb 2026 06:50:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] fs: mark bool_names static
Date: Thu, 19 Feb 2026 07:50:01 +0100
Message-ID: <20260219065014.3550402-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219065014.3550402-1-hch@lst.de>
References: <20260219065014.3550402-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The bool_names array is only used in fs_parser.c so mark it static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fs_parser.c            | 3 +--
 include/linux/fs_parser.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index c092a9f79e32..46993e31137d 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -13,7 +13,7 @@
 #include <linux/namei.h>
 #include "internal.h"
 
-const struct constant_table bool_names[] = {
+static const struct constant_table bool_names[] = {
 	{ "0",		false },
 	{ "1",		true },
 	{ "false",	false },
@@ -22,7 +22,6 @@ const struct constant_table bool_names[] = {
 	{ "yes",	true },
 	{ },
 };
-EXPORT_SYMBOL(bool_names);
 
 static const struct constant_table *
 __lookup_constant(const struct constant_table *tbl, const char *name)
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 5e8a3b546033..ac8253cca2bc 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -84,8 +84,6 @@ extern int fs_lookup_param(struct fs_context *fc,
 
 extern int lookup_constant(const struct constant_table tbl[], const char *name, int not_found);
 
-extern const struct constant_table bool_names[];
-
 #ifdef CONFIG_VALIDATE_FS_PARSER
 extern bool fs_validate_description(const char *name,
 				    const struct fs_parameter_spec *desc);
-- 
2.47.3

