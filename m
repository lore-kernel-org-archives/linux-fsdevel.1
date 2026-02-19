Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200533093B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483842; cv=none; b=foqZraJgAWCOCLFOw6R/oE7r8DZsBGNC+Q4NM+VuXeuZJOewmWoufW6zCF2vBI58s3UUuEMKyfC14T9GWDCPH+FXilIHjjwdjILFGHkUrF6UgezEiZsO3xz658FQl6kuDkC5O+G9keg2UX6vddFmtI0K3Bqjd8mdVGcHjJgKA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483842; c=relaxed/simple;
	bh=3ql4wbHoiZtYZFPEfeicGO4Usy42kcjmCcZ9/OU1ARU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwdYefPqHJq/8UIOzAu8Vqr/z4/xH/gYMp1BzPozzKq86YXJfxRcZ/XSVvvP41bf0tcWaPq8h6JFMOxuqTRhUcWp3q3bw/EtcGFnbcT++K1bITosHjFVBhIoCmyNPM17XF8Q4sncCGCRxF7E13J85ZaHhZEltfOWHASMBTUK5Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UPVQKXmq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UPVQKXmq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TLJYJtC9fFEev19iWbQSriAhf4bWE9Z0Bg0LyqpY/DU=; b=UPVQKXmqtCB58eVfBCYwsN5jfl
	JyEHGDJ7mIPILdyQzn0Rq6Ygi1w85joSnywYKIMah+kEuKnnA953idYlOOOaB/mpZOSCmmsAQYPH2
	TtdRyHHU2H2+fAZvloJvu8uennZdqJeeTAJIEiZsw8H72kFm1oGddrVykL9odgUIR73NDjEHL2bih
	yNtFFloTxg9HKpjAH1nXV1y8HZxADBVNkwppxdo6CrzL1DR2OXQWjQCp2pOWVMA1votr1R+c3l9GA
	HTOR8/jptLgqUxOcvgVMeXA9b02xkj5E2zGQYRS/2synQ4QX+O3oTVhPKOzYtmyoyvtsDxA38tKhy
	rdWO0AfQ==;
Received: from [212.185.66.17] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsxs0-0000000AzJJ-2FGL;
	Thu, 19 Feb 2026 06:50:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] fs: unexport fs_context_for_reconfigure
Date: Thu, 19 Feb 2026 07:50:04 +0100
Message-ID: <20260219065014.3550402-5-hch@lst.de>
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

fs_context_for_reconfigure is only used by core VFS code and devtmpfs,
so unexport it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fs_context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 81ed94f46cac..4a7b8fde4c5c 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -318,7 +318,6 @@ struct fs_context *fs_context_for_reconfigure(struct dentry *dentry,
 	return alloc_fs_context(dentry->d_sb->s_type, dentry, sb_flags,
 				sb_flags_mask, FS_CONTEXT_FOR_RECONFIGURE);
 }
-EXPORT_SYMBOL(fs_context_for_reconfigure);
 
 /**
  * fs_context_for_submount: allocate a new fs_context for a submount
-- 
2.47.3

