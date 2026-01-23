Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2536CDFB;
	Fri, 23 Jan 2026 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132739; cv=none; b=UwV1havyvekMWRMpLtS8V8dVyBYDC8/eWN1mFHa+cwfrNkHC5XfFHihw3mXz9U7+vafzKm89EV5+ZKBzsVy5FDE71lV48FnCH+zSwQCYxz0l6bBzxX5Md+izpbSYlkf0txPRLKgrD0EpNR9ZJ4AQuWvbJ7x8AtNl8DoVZTtMgPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132739; c=relaxed/simple;
	bh=QoXfgAbGNUQiQj1f2aRExtgVmE/mWpc0tyqc/O344lI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTufgH4S98D/7Pd5zbLhK8RCecj5UHOLsspG5u0sj3JEJSBKukXd/9Qgj8/QNyxxtScqow6h/I0Ba0rcEhqO2O8S2iGLF59xYe3hNLRnJ6APg/2bZoxmFH+TIwv6fhGUSG4g3jE9gwHdtgHxo3aw/LCgXLEf59ApehhSQiHCZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZSFqI/eL; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZSFqI/eL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j6kl+aNNrzyjMKF8SjtxTwU6f9KRILQcLr8ULQnojpQ=;
	b=ZSFqI/eL8SkZkha+KVfw4O1daKwpmPXrJHkt4VIZy7RqDziP4M3b26lurC9oWQb4xEkoRMwF7
	Rx0GyuiyyZFUPRB8EwtOwz3Gm5FPYcfoydiffhkwDsmDApHzd6lHcG4G3/0z67w0SKB36Z6sAPR
	KPvfG+EO7YjzG4bNch88GYo=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dy0z71kTNzRhV6;
	Fri, 23 Jan 2026 09:41:55 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 43B4F40363;
	Fri, 23 Jan 2026 09:45:20 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 09:45:19 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v18 07/10] erofs: pass inode to trace_erofs_read_folio
Date: Fri, 23 Jan 2026 01:31:29 +0000
Message-ID: <20260123013132.662393-8-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260123013132.662393-1-lihongbo22@huawei.com>
References: <20260123013132.662393-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)

The trace_erofs_read_folio accesses inode information through folio,
but this method fails if the real inode is not associated with the
folio(such as in the upcoming page cache sharing case). Therefore,
we pass the real inode to it so that the inode information can be
printed out in that case.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c              |  6 ++----
 fs/erofs/fileio.c            |  2 +-
 fs/erofs/zdata.c             |  2 +-
 include/trace/events/erofs.h | 10 +++++-----
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 71e23d91123d..ea198defb531 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -385,8 +385,7 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 	};
 	struct erofs_iomap_iter_ctx iter_ctx = {};
 
-	trace_erofs_read_folio(folio, true);
-
+	trace_erofs_read_folio(folio_inode(folio), folio, true);
 	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
 	return 0;
 }
@@ -400,8 +399,7 @@ static void erofs_readahead(struct readahead_control *rac)
 	struct erofs_iomap_iter_ctx iter_ctx = {};
 
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
-					readahead_count(rac), true);
-
+			      readahead_count(rac), true);
 	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
 }
 
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 932e8b353ba1..d07dc248d264 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -161,7 +161,7 @@ static int erofs_fileio_read_folio(struct file *file, struct folio *folio)
 	struct erofs_fileio io = {};
 	int err;
 
-	trace_erofs_read_folio(folio, true);
+	trace_erofs_read_folio(folio_inode(folio), folio, true);
 	err = erofs_fileio_scan_folio(&io, folio);
 	erofs_fileio_rq_submit(io.rq);
 	return err;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3d31f7840ca0..93ab6a481b64 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1887,7 +1887,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
 	int err;
 
-	trace_erofs_read_folio(folio, false);
+	trace_erofs_read_folio(inode, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_scan_folio(&f, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index dad7360f42f9..def20d06507b 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -82,9 +82,9 @@ TRACE_EVENT(erofs_fill_inode,
 
 TRACE_EVENT(erofs_read_folio,
 
-	TP_PROTO(struct folio *folio, bool raw),
+	TP_PROTO(struct inode *inode, struct folio *folio, bool raw),
 
-	TP_ARGS(folio, raw),
+	TP_ARGS(inode, folio, raw),
 
 	TP_STRUCT__entry(
 		__field(dev_t,		dev	)
@@ -96,9 +96,9 @@ TRACE_EVENT(erofs_read_folio,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= folio->mapping->host->i_sb->s_dev;
-		__entry->nid	= EROFS_I(folio->mapping->host)->nid;
-		__entry->dir	= S_ISDIR(folio->mapping->host->i_mode);
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->nid	= EROFS_I(inode)->nid;
+		__entry->dir	= S_ISDIR(inode->i_mode);
 		__entry->index	= folio->index;
 		__entry->uptodate = folio_test_uptodate(folio);
 		__entry->raw = raw;
-- 
2.22.0

