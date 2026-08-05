Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571D16A395;
	Wed,  5 Aug 2026 02:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897761; cv=none; b=OnVgVo5w61epRkvjJD+vHmrnZ13O6MQIsuaeZ8FN2fT/vsfbEzTYKgsE+tUPdyl8rhBOSvskFr+e6TrGIdliItAqPKTjX0QIc/zPabyQoctrJ8gzYhcJOxwVjm0tV6tniYUFIShCPS/g12wqFldvl4xbdYYC7nnq+dP/6AwlHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897761; c=relaxed/simple;
	bh=LjXIAV7nPZkuWSXhN6a/uZhaN1KGXPnmflvBNRJlxas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d9bn5XW9oE5rx8Gacz1ph8rBjVr9rh2z2SyXqODiEDxfjs5TZvx4LePcSehXIpELVZl4KIH0R1F+n9QPJHpmhCSP4zdBJTi9lwhLXbw1DHWrYWMY5jUd0myeh2H4kdvvQ3uW4WuziQ9eMqLFIVAmH5/3bJvIy02rJevbJLb5MHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fv7rr/8Z; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fv7rr/8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785897730;
	bh=JII4zvZ9phqXGgtwHSRzj0yKKCoJHXOdp/Al/cjQTco=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=fv7rr/8ZvUF/FHy+0a1PwR0wWR06RUlx7X6cAUMdnzncFZp2pCVou1BOOk075N9+H
	 63WdpZ3S9tzNHWQfojszUwdD46N64SWBcElnKSgxMHi/kIFwtK1g9VOVjp9mNBQhnM
	 00D9XaSTwAWgCXbbhqtPq09r59np6jMYYR1wCaWo=
X-QQ-mid: zesmtpsz3t1785897713tde2ed6b3
X-QQ-Originating-IP: bhx5Au3CuR0NrHzV8g0DEmvteSfD6skLTlnxVGkqVNs=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Aug 2026 10:41:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12268689483967271216
EX-QQ-RecipientCnt: 6
From: Yichong Chen <chenyichong@uniontech.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH] fs: remove stale inode_insert5() kernel-doc parameter
Date: Wed,  5 Aug 2026 10:41:49 +0800
Message-Id: <20260805024149.935769-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NWpJXFcMi9uZ/Hv7Y63GUAzpx6lrska9FUitOJe56RMvOPXxYSAE68Sw
	g71AWfLc8+faJ9cn0W4qQzQzs6tKAOfz2ujY6rTBCmt08xc/nWR6qLchWAf/azIjP78qGC+
	/zVjX5dyjKMWNFqG/FSyUc+E+46g9C2hIjmcAE2VulhbIbLc1RKg+PH9CjlOiZxQmJXLhGA
	pX02TjGA/aNxIpkioSnf9Cgjf0Ynl0W87yfD8erpZAttug6uDHaTZc2AWsiAW7c1Zeb5lV4
	6Rjza+X15c1VkvSVEb9QUgMxrPiQgfrkDAYFbJ0sx5/SJBy7TQj1NH5opnaSB7b7aVQ92Bt
	7Dw6vjke80eY7nuRKJ6fdQt2EUIDD/iVChsbFTIH8iXoCz8HoG8ErAKwtvmjRz52ByJwSO8
	W3SKvc6qZ/hwHYZCU5LlJVjxD3jU/+0FANln1WV3yjhwHTn8S872DKcXJhgqs3pv2zGVxV3
	ROaNB4uf80dPgtDS583kHpVqG0lDeo4ws7MbiC7UrG4PsvEmW0yqaWslnxfKLWJKZZgQ+QA
	lQxApU4AYNcjVezlcNAZP+sxPz2F1H9T/P3WYv4UvDmjRk7aM/dU3hU5wXPF8EpaHz3B1DN
	n24XWJmXoqTUMKYCKFeD2rGMWhpoB+YdPg4/MAVLhJNIJDaIq42buQnom+A8xjvlmVS1sDS
	K7Z6R/wyhiwt3g3hbY3mDFD7SkyDrhYmHRnbxh4FjWNbvyfjZRnEfVsoG2hBfTrqgj533+w
	2cTkEM/NcLxZ4eMJ+3P5MCdPko4BRks0zXX35eQYhEGxrAYpSHU9POw4zTngwzfZnn6gkux
	Cv+ERkXupYIMLL9YJa8yw8x9cnmY9WA7Xgdj4roPi2mIzEiSw9El/Psx/12U0U6gx2ktOVY
	XHoWHfZJNUL4xaEtMLP3enpu/NgKYVaAhoYRomVXwEfrCCLWi2nsXQfUTXsyJROrRRMBi5q
	AFy8pBUKheDinaVnWx+qNytpBtKc0XYSDRh5BgsIjvS0Dz8lknG9Be9LCmQVgX2RFMIbMu5
	PwpWr7V+zLMK8ORL2+
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

inode_insert5() no longer has an isnew argument, but its
kernel-doc still documents one. This triggers a W=1 kernel-doc
warning.

Remove the stale parameter description.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index a31aa7cb47f6..ed7c8df1bfca 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1282,7 +1282,6 @@ EXPORT_SYMBOL(unlock_two_nondirectories);
  * @test:	callback used for comparisons between inodes
  * @set:	callback used to initialize a new struct inode
  * @data:	opaque data pointer to pass to @test and @set
- * @isnew:	pointer to a bool which will indicate whether I_NEW is set
  *
  * Search for the inode specified by @hashval and @data in the inode cache,
  * and if present return it with an increased reference count. This is a
-- 
2.51.0

