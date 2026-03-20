Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E53A75B8
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 23:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774050859; cv=none; b=Ozk6WT1z95JUE6aiwktN9hxAGqYTpGhdKFi2e8A8/ur/7XvpWzLlTaoj+auEk9ZX4JJNJabGOnzRDVrJRXrzOK5RC/HZdP+bvaPKFgtaVc9PoXidXMwY04KupPw02vG34xqbzUuZKZudcZOGb4sgBl1CL8LngMTmSZT2IiIy6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774050859; c=relaxed/simple;
	bh=JYvHP4VIsAXqREYiu0XK9u9pgTKi09rrGHV29+buGOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0OL7/KEDxcq7Yczo3aF5e9eAJg8P3UzY8gxbnoOxs9Tz4wTNsPnpAF+jo6DEqJ/bttjh5BJSw6PbnMb7R/8GSPGdwftybHjBBSszKorzY6VRZFA/8wcvGSXWa1e5f9iRGcP7xBQDur6MdgOWlncDJW5O/z7uKyPNkGAasYLOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JuzGIycP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JuzGIycP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=l5bKs9eIZI0/n5qahcULUAMl/bk2LvCNPJFjW8/+7rI=; b=JuzGIycP2DV6qxwXxwwh3d3geZ
	0CmHNE+5Xc6FPchxacDrt1ng4mUMBlJ7QpglVbWNnWUdb3uBoIfjwX4TJb42CAKjKTXba+sRMSyXm
	UkXmSNoD3k6R+sh1olpUMC8FvvSELy9xaM4+iu+lbnDksOXSjF6Gb7NmnCvlhC6jX7Gk5DpKsgLig
	YHe1OcI+UYlFNEUWMnnHAAOadpYImz1zne97WycG3a4rpC+DbLFMDaq7P7HsOp4E0d1/KkG8aNmPo
	OIVSXoL2iH/f9mxxEYw0y05/zQvy42KpnwWBF15jH9mkcZiTH1hBPgnIKsREWjmkZoDENEfEFe8Jw
	x93npTPw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3jfS-0000000Do8r-2ImH;
	Fri, 20 Mar 2026 23:54:14 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH] fuse: {io-uring} drop kernel-doc notation for a comment
Date: Fri, 20 Mar 2026 16:54:13 -0700
Message-ID: <20260320235413.3932759-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use regular C comment syntax for a non-kernel-doc comment to avoid
a kernel-doc warning:

Warning: fs/fuse/dev_uring_i.h:104 This comment starts with '/**', but
 isn't a kernel-doc comment.
 * Describes if uring is for communication and holds alls the data needed

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Miklos Szeredi <miklos@szeredi.hu>

 fs/fuse/dev_uring_i.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260313.orig/fs/fuse/dev_uring_i.h
+++ linux-next-20260313/fs/fuse/dev_uring_i.h
@@ -101,7 +101,7 @@ struct fuse_ring_queue {
 	bool stopped;
 };
 
-/**
+/*
  * Describes if uring is for communication and holds alls the data needed
  * for uring communication
  */
