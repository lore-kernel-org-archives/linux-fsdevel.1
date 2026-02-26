Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C702882D6
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110219; cv=none; b=IODKeSUkuZC5E5lBu9p5bca8hWgkGg300Zskzzw2M2qMztCsuAg6pJssJ8TWzO7ZMwvddQM6MQz1emhB3a3dRBlqVIBtHJtQISXJy0oEP/1BM99g/01l3kmTNgwFMMUzblO390imZojJ+ce25aKMifUnikh02UTOyznRQ/jtUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110219; c=relaxed/simple;
	bh=70hSkNsvLqkJRBWbDIHj65tDaM3EKJ2BXVr9m7vSzXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXRUE1eAqKkW7t7O9ZDmBmked4lbq9VVPbVNhSBrQ7hWSCiSgJkb8a17FIA+bwFDsqaMGlYDT3iLuOzY9Vux8snFg/H4N/EeoqLC65fiJqU+OQMGlCz+Ikn727LFGoazcfe8BPo2QbLa+QS/Yb+ejiwaQ3UY5LEB+j+a12SRyLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QKvpjdVC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QKvpjdVC"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2adbd435864so2865015ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 04:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1772110217; x=1772715017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fyIjJLPqWTAlsU9TtEHZSXx8eta5Q+FhX9SZdoxBFNw=;
        b=QKvpjdVCL6Ix94JhEoAqYlJLujYLIucDGezY/m4AE5zOWQQHuy5IUWWy+UIgI54dAt
         bXEgF/6P+H9gvQFEaASPo/zsoDzMIaDRBis5SPgu+k/CtU7jedHnpoTw7MY/hHNCm8pu
         fMVB5n6v6NPeIKw9w5s2+CTXWHigtL7/PzGBwP+tQ/pf2Sx9EUY+he0DKVa4G0PeLhVg
         L37vnLNPgu6R6rDM+pHA6Ge2UiDT0wsERdyi4/LG/v1KIbIaM736Epwhy2cPUh+hPpK7
         CsdH6vO+Qhmm+ZnPSbvEBkY8PungkYs9t8u75ZrcoFFmeTy+zveuPvCOeREeMdhYBCPW
         UzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110217; x=1772715017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyIjJLPqWTAlsU9TtEHZSXx8eta5Q+FhX9SZdoxBFNw=;
        b=BPDTH/Q1jwpEUV3EDTXto8p9PTGS84rEkdvDDCqZ4VWhNjuRx6sMaKhS3yLTssfiu3
         taFP8HbbalwruZSIh9+Vh9GHiQ8Rf3T5mSAOdUYKzJZTz2wTCLqOcbakpcxCJg1+acy/
         1NzgEO3FZplzMCNumUWH2oL/4/rJXpqLq6OhEsXg35ITcwSEHL17VbU8Uffo7ruEVkYe
         BQ2SkGiR1IE9PhgAxVP6TWiuVHROsBTGsU0WhnFAGmkHCEnC0WvcaHLTCL6yyiBolimG
         +5rxbL1tr4Ag53z/xnU7a4eu8xgnp9yD7TRyMaqZQ06xMgICM0a4jgIfj2KnW/oZJFbK
         MTww==
X-Gm-Message-State: AOJu0YyXSa1+ZHOt2lIn1r2J91j1eNNpHlj8CRkfxraKKxC9gdOK6xNH
	dFFBPdBMNLPKiqMraY+WhKoVUX060y1YON6tw10ab3CGcMXzmd0OYOB8vnk1fkHFw44=
X-Gm-Gg: ATEYQzx5aLbBcAVvkf4AChGQppAfZr1wyUIhDuPC4ZBulxxBtyQXSyvX9bQmZ398CMj
	ghqgSVLaWN+EQn1Tl3dRwvTrDLYrMZ8+uK9Pzb/lP7KWwrjiHx7u6+EOrUHlAK43MwnTZLO2/aT
	mQhLt/O8qUxh985TjOwKZyYygdGPthIX4OAhgEFYl7ICo+0WwnpPKhm3kJHYINfdUFkr3sZ+wE5
	CyGJppvxDiQDeNAvsTEjEazAmcpYq3nu2p/bhmSN/asqVcxRU7RLk9njHE5FiW7Mzh/dnAl6uAB
	TLWNmIyIci6qzhrIoA9XS068R3XhT3xj1xPwZP8CQDL956xcq/Xd7C2TKJZOdCp2hc1qROsE9nB
	KmWD3oSikmrQ9+xHtkxw/dsivhgNdtdFRY6p6Ea1Eil6P5EoPXtnaRuwKxuuDGmBI50ArsFH6Fj
	NefVqxx5bIQ8muiZ5rkes8dVNT333uGcFMWK8cIVHVCkxXXG/7zf5g9YNAeK4XN0oPR/dK
X-Received: by 2002:a17:903:46c4:b0:29e:c2de:4ad with SMTP id d9443c01a7336-2ad74471022mr197131715ad.24.1772110217454;
        Thu, 26 Feb 2026 04:50:17 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359135ef1d7sm3468315a91.5.2026.02.26.04.50.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Feb 2026 04:50:17 -0800 (PST)
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bernd@bsbernd.com,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH v2] fuse: send forget req when lookup outarg is invalid
Date: Thu, 26 Feb 2026 20:50:01 +0800
Message-ID: <20260226125001.16287-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We shall send forget request if lookup/create/open success but returned
outarg.attr is invalid, because FUSEdaemon had increase the lookup count

Reported-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
---

Changes in v2:
 - Fix wrong usage of goto label.               [Bernd]
 - Link to v1: https://lore.kernel.org/lkml/20260202120023.74357-1-zhangtianci.1997@bytedance.com/

 fs/fuse/dir.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff2..be25934b86105 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -578,8 +578,10 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 		goto out_put_forget;
 
 	err = -EIO;
-	if (fuse_invalid_attr(&outarg->attr))
-		goto out_put_forget;
+	if (fuse_invalid_attr(&outarg->attr)) {
+		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
+		goto out;
+	}
 	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
 		pr_warn_once("root generation should be zero\n");
 		outarg->generation = 0;
@@ -878,14 +880,24 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		goto out_free_ff;
 
-	err = -EIO;
-	if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid) ||
-	    fuse_invalid_attr(&outentry.attr))
-		goto out_free_ff;
-
 	ff->fh = outopenp->fh;
 	ff->nodeid = outentry.nodeid;
 	ff->open_flags = outopenp->open_flags;
+
+	err = -EIO;
+	if (invalid_nodeid(outentry.nodeid)) {
+		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
+		fuse_sync_release(NULL, ff, flags);
+		goto out_put_forget_req;
+	}
+
+	if (!S_ISREG(outentry.attr.mode) || fuse_invalid_attr(&outentry.attr)) {
+		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
+		fuse_sync_release(NULL, ff, flags);
+		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+		goto out_err;
+	}
+
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
 			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0, 0);
 	if (!inode) {
@@ -1007,11 +1019,14 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 		goto out_put_forget_req;
 
 	err = -EIO;
-	if (invalid_nodeid(outarg.nodeid) || fuse_invalid_attr(&outarg.attr))
+	if (invalid_nodeid(outarg.nodeid))
 		goto out_put_forget_req;
 
-	if ((outarg.attr.mode ^ mode) & S_IFMT)
-		goto out_put_forget_req;
+	if (fuse_invalid_attr(&outarg.attr) ||
+	    ((outarg.attr.mode ^ mode) & S_IFMT)) {
+		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
+		goto out_err;
+	}
 
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
@@ -1040,6 +1055,7 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 	if (err == -EEXIST)
 		fuse_invalidate_entry(entry);
 	kfree(forget);
+out_err:
 	return ERR_PTR(err);
 }
 
-- 
2.39.5

