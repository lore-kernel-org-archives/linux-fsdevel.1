Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975402C21C5;
	Tue, 19 May 2026 04:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779164602; cv=none; b=iRWL2H/34bkhbrqteVvreGNX/HuQJqX83qFl75ehBZqDTHOp6SyWPCoaRQ98ozzGuJXFwrPQyoXySaqs71839GBSQopQqGMJqCNprAxrloXf4j8BbbP6VLdNgLFpdSLq8ZGQKYMrEN7kbinVxrDSzmJn5FZVFP0W334pzbXc1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779164602; c=relaxed/simple;
	bh=KyMa4QZGX6Sk+US3JqX6M50fWCFp3kt0MJuWOqM6k1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPZSGsBuD+lgdJg7KGhqkgmrXsy1I1Qj56NyLYoISQ+AXRzprKDQ1NtURtwziw31dKW27w/vVPkHoz/LW9rCOesxEJiEWoVBMG1PAUPunrTQEQYIwiTrb/m7zkuL6bDbLmr2+H9vaj+B6UCZBETs+L02+xSE4cUzJ11mmamhzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1fTXuKWa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1fTXuKWa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=G9PvCOBNg59DItW9ViGBX6vcZlarmAd90Kc1spCLAQE=; b=1fTXuKWaRGDMENCMs+FIetG29c
	KFQlkm0cSabbQW1MdBlfZU+nJmRrMTbkGfTp5pAZevsm6Tc8sG0ACiBs3DkCeTS/YLgGEa5XJuP/6
	y1JkUdCLaaLaoOdoQMniaZ3pszbGJctMYTmBfqsy3iDZvXs4YxY/WfkRuRPavpjrJYker22h/t9rE
	KBT2fkx//k+9Pw3kBqhq9sA388B9Xoi/SFbl4d8uhdzyXhb3WVI8514F9nsXQ+Zu/aBT7xrrIg3C/
	+L0zn9ZteKgWClB79uo1LDmpY7OsfIdyVytXNnvYVZi8iXeJbeCZkEmKHFfmWVzwEkleANk03hzv7
	D1VIp33Q==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPBz9-0000000068V-3B8O;
	Tue, 19 May 2026 04:23:15 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH] eventpoll: add missing kernel-doc for @ctx function parameters
Date: Mon, 18 May 2026 21:23:14 -0700
Message-ID: <20260519042314.124041-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing kernel-doc comments to prevent kernel-doc build
warnings while building the documentation.

WARNING: fs/eventpoll.c:1684 function parameter 'ctx' not described in 'reverse_path_check'
WARNING: fs/eventpoll.c:2349 function parameter 'ctx' not described in 'ep_loop_check_proc'

Fixes: e09c77d94003 ("eventpoll: hoist CTL_ADD scratch state into struct ep_ctl_ctx")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 fs/eventpoll.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20260518.orig/fs/eventpoll.c
+++ linux-next-20260518/fs/eventpoll.c
@@ -1677,6 +1677,7 @@ static int reverse_path_check_proc(struc
  *                      anchoring files with newly proposed links; make
  *                      sure those links don't push any path-length bucket
  *                      over its limit in path_limits[].
+ * @ctx: Per-do_epoll_ctl() scratch for the loop / path checks.
  *
  * Return: %zero if the proposed links don't create too many paths,
  *	    %-1 otherwise.
@@ -2339,6 +2340,7 @@ static int ep_poll(struct eventpoll *ep,
  *                      epoll file does not create closed loops, and
  *                      determine the depth of the subtree starting at @ep
  *
+ * @ctx: Per-do_epoll_ctl() scratch for the loop / path checks.
  * @ep: the &struct eventpoll to be currently checked.
  * @depth: Current depth of the path being checked.
  *
