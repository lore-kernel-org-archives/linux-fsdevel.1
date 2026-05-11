Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130337C930
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484176; cv=none; b=u6Ea0PoZtklnWhGYLDoVVPQeFVzj7k+WnrND7nhHdkCgT+KeXKVRGMXX/q2ghtsvm7h41gKzzmBMA95/OMWQFke6kuLuj7tv9sVRBlNASpDJGe9kQ93A6Ihj+M1rdUccDzQPXY/So6RLG0cKVN2wJO9O/ll6wJsbe2tCpEnv2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484176; c=relaxed/simple;
	bh=FmYFW+cvuvRUZc7kU+DheO77JH/C446rXTKXJn9tFeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbfktsG3T+FX8u1vEpKiBIjCok+8ygs/T1MwD618ktu1jWymnV71hEGP7WpTmAdGJf+5d5Ik7JS9hcL2OonCopjkmaPmv8Rh7kWwe7Y6RShLyPpkgKOJR4aCre59r9W5mo0mRkJZTMruaraKCmDMMdE6Q8k9WFIvzXB4+Kew/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MmD0YmmB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MmD0YmmB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eY3YfrSiHGn+QyKL+EhxeV3jLRSOyd1osamOIw4l+FA=; b=MmD0YmmBAWJgMo43ea1zLPwQbc
	Qc43YJmfuB5M/ue3kZ2BcWOcuVSIVkyu0GvGDl0paJ2fs9/uVJB/y+3JuMgJFZJC2IZ9EewV3iqx0
	/8SiAbstx1vXuvfmGFH+T47iQy0fKBKr6XfU8qwAC+cX5RJPBVvv7hDMsZbIslEBbjTVSHKXFlWUS
	jFxLS+eIWfiXFvlY9H7xgdDKfiSc+eGUCBSFf1GbQrzOTnQWxZgo12Gr3HsP7DPdd+7urZPMXhDkP
	82APDflZ8stZTABMYnnc8RKSJKeATPSNDL+MlHMm3g65w10NzkaotV3VBJkrqBwC9DJEX01JogY5S
	4G2STWog==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKyc-0000000Cakd-3p2I;
	Mon, 11 May 2026 07:22:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] fs: remove start_removing_user_path_at
Date: Mon, 11 May 2026 09:22:29 +0200
Message-ID: <20260511072239.2456725-3-hch@lst.de>
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

This function is entirely unused, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/porting.rst | 1 -
 fs/namei.c                            | 9 ---------
 include/linux/namei.h                 | 1 -
 3 files changed, 11 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index fdf074429cd3..f546b1d3897f 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1297,7 +1297,6 @@ Several functions are renamed:
 -  kern_path_locked -> start_removing_path
 -  kern_path_create -> start_creating_path
 -  user_path_create -> start_creating_user_path
--  user_path_locked_at -> start_removing_user_path_at
 -  done_path_create -> end_creating_path
 
 ---
diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..bc641838530f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3029,15 +3029,6 @@ struct dentry *start_removing_path(const char *name, struct path *path)
 	return __start_removing_path(AT_FDCWD, filename, path);
 }
 
-struct dentry *start_removing_user_path_at(int dfd,
-					   const char __user *name,
-					   struct path *path)
-{
-	CLASS(filename, filename)(name);
-	return __start_removing_path(dfd, filename, path);
-}
-EXPORT_SYMBOL(start_removing_user_path_at);
-
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
 	CLASS(filename_kernel, filename)(name);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 2ad6dd9987b9..80488b3de0c9 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -61,7 +61,6 @@ extern struct dentry *start_creating_path(int, const char *, struct path *, unsi
 extern struct dentry *start_creating_user_path(int, const char __user *, struct path *, unsigned int);
 extern void end_creating_path(const struct path *, struct dentry *);
 extern struct dentry *start_removing_path(const char *, struct path *);
-extern struct dentry *start_removing_user_path_at(int , const char __user *, struct path *);
 static inline void end_removing_path(const struct path *path , struct dentry *dentry)
 {
 	end_creating_path(path, dentry);
-- 
2.53.0

