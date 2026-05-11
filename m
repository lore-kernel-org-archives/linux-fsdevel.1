Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360D37C912
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484173; cv=none; b=Rk//q1O3qKN5oJwt6UoByKhq3qTvwZz2D+5VRymvAIzyIKqMkosfe0EFQurRah67kbXyLypLO1d/PKgLufk6hMabjex0oE46kSN7pHu0aJxiEAvujbpeGrKP+hDmAZmxldXuwgCewXqR9otza1zEEdhXoVEHuWOWfYqcVECmdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484173; c=relaxed/simple;
	bh=etXYBN7DThN+7kEy/QGabadTxHowEfZqiJneMCT80fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW7TBfrAz5wIncVk/t2sICgbkbcbCqPjuAE0C9m4vNpOz+iZs51wm5aRe4L7Xy/dusQRFKQIvsLup8UipxMmQHZCpqwrkMGEpArSA601pjJgltpRGXu35lN0YPXiMEIA17JeA0yJ+9YCxdctqIDzGUtKjQbOcMVcCwkpVEQyqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hrgIMPP8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hrgIMPP8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=V+Z/5Y7lcMRor0CQsxCoQiaNGD5Q91KR0NM9eObD2VI=; b=hrgIMPP8RoC9W1b4GsU2yOaL6i
	rWE194I9zEMAPJQNBTdogjebt1d/P/xsViqqXyP3s00MvX+tzYK9o4cRnQwg4efPUknjZ9fMNupRI
	o79s2QzylrJ2/S9QGPy5UoLReufwMWXwcOaobA4/9f51CeKCv3l73Siz2GRD2YPtysUrknHQRqqiD
	QanXU02pNwsQE1CXyRgtbUpNvbC3b0caZ0oQKhea9l1YgymolSPQ59M0v4RqhCK7mbF9ja+ji1dn1
	xlVyvr5R8CEfEwAVi1h1Wy+TaMh+PLhQPZ6vDU2ompoIn2XNktF0ep82GjAwKEx7iaHaXoOt6TJLm
	U3YloCgQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKyZ-0000000Cajq-3X5v;
	Mon, 11 May 2026 07:22:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] fs: unexport drop_super_exclusive
Date: Mon, 11 May 2026 09:22:28 +0200
Message-ID: <20260511072239.2456725-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511072239.2456725-1-hch@lst.de>
References: <20260511072239.2456725-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

drop_super_exclusive is only used by the built-in quota code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 378e81efe643..5d46a0d5b616 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -882,7 +882,6 @@ void drop_super_exclusive(struct super_block *sb)
 	super_unlock_excl(sb);
 	put_super(sb);
 }
-EXPORT_SYMBOL(drop_super_exclusive);
 
 enum super_iter_flags_t {
 	SUPER_ITER_EXCL		= (1U << 0),
-- 
2.53.0

