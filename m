Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491583;
	b=KY3dsopyTqmdSOB4XZYtxpcETGNuNrJR6WzAgi0rGXM929wh2vrEX8f1X/4Qr8pqJ/do
	 cjWhWsCqY7ZYXH2mM3fKYz+mT/RfWVv+sqnAYGVbakqxJq6wbbJJIu/SgZpk9uVFXbFHL
	 TltpHPkt1rCYy6OJjxsnG56AvrMn2uhtHZ64iNJlreVv0pCQy9obgq3Z8uhMdVrak9QnD
	 AVt/vgzOKDa3BDMu+Im20Auv93XnA1jFp33Wbl6IbJFldBR9H0Pt3FItZ4UCe0jK/iyF1
	 uzxDr39wBp+ojbOmHTU26IsfEGhneARsh0LU2sVahR3l1tfym5kwAleyQdp/tcDJDvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491583;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bc/m0CzcqxWth93tLtYdqczHcrTbNNUtQOBrsyNweF4=;
	b=I4aWx4QyreAQQ9aFGxr1A4BLItZOSgSi7F8ZJPb0cbTPqtD7R/CPjjXx8kLPGWBz8ets
	 er1FwnjQWJu0FefISRDKlBMCcO0d7RU1/9ZCe3dm+CiTpoRDRMGbN51+i293xTlUMPGUm
	 DgiPf75CLpYO85nGgrDHwVd9kOjQ0TbhodSsPCYhNEXEKrvZe2x5irFNiXqX2DYpZQj7A
	 aDwKDgBAK5OzGT98s/i0bg4SSCJ5wb372mce0WUeue2rYgA2JxJ/sJ2kNAclzNkZLVquV
	 SWz1oeDuji4vmBHiMH7dgI6xDxS/T/jFqRh7wLAyucbUe1gim/swcp5xjT1OHLP285Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ICRh2WBd;
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FEB606A321;
	Tue, 20 Oct 2026 10:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6FEB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ICRh2WBd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792491579; bh=bc/m0CzcqxWth93tLtYdqczHcrTbNNUtQOBrsyNweF4=;
	h=From:To:Cc:Subject:Date;
	b=ICRh2WBdr1w+OiQvfWeTq4JJcOydREAhVRJ3sdpevT0Q6rPx0f80eSSf+94RJi7oS
	 zsaUrDzDDVXGLjm4PEbMC2zJ6MExhKJjn8lsn8LcmLwEgZMHyhdCcr+bBmM6vWDghM
	 9EJ5AhV86iJbmcCDA1oiICNHtqHbxyF1wJChuuSs=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4E1B60EE; Tue, 20 Oct 2026 18:19:33 +0800
X-QQ-mid: xmsmtpt1792491574tsoiclk6o
Message-ID: <tencent_190DA969DF79232C4E2FA681510C3E365108@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GVZS4gdzzyrTkJEIEhBsc7696qTYBcS1mfdqG2mf1OqM2f3ZvuJ
	 oFBlJTzCHjWpERulNcZBE5DaGnDOvzVVAko/XKg/kBb5KY5cWDPhhQUKqrsPM24BEcozLtPHYYRJ
	 bg/MbJVlG0YgN/U9ELbJpFGjEuEPBhBlfsygCw6ObCCafxR16Hn1OfeShj8jFeZGFYhMMV/QKnev
	 7xK7KuUNbvm1+7wHSboZGVs/WsolMCStUFw2w6H2j4S0mNh66ExypxPsE0LuJDy8if2/a/SJyKYf
	 zK9MHIQKpjyT5wWdEA22zLRmZ4Bbzu7pZaWk+laUDeql+d+S/j9qQbmKdvObkssKglzC9oSuVv9e
	 Oclj0Sy1Ytureg/1fitrvR6bJDYj6GrGgMjy+pFfPz3RJ5cISsTI+rY41jnbq5IHZiDl2wjg9diw
	 8oOLVbPT3krLbp8W7PkVN7AAJ3U7NaWeLwyxBJ1QbzRjLAelRRebPVODXnnS+jNLK19ywjDwPwGy
	 DZGNCpfd7A342Lja/FftKg2jYL6A1/djpTyZxDQGv9FizML/JZRGj6t3oRcCbSXsnBA7bvE31G83
	 xCgNRNmhDwyQFaH6FRnaj/QfchxQ4/FvIZopvtkfAhTPHhSxYRuK4ho8E53dMNniGY1UleZuKilv
	 2XlkrWTfoywxtJV9+aqFZ9x8wGQPafx6ZIsMCYjr6E5giuqyw3NkvxUxku6ZG4tAGGVjWFNQmViM
	 ZVD5JJXsapQkKTfydEanEFtpZk1LlLQhOyD5itfi0Puy0rEFKz6VAm519jY12DcRVVo11hGOUz3u
	 i6FD4byrpt4/9Kj95HYpErmDCa7wJxEwNdK7vFMbj7ysOxSVaJ2f8T0O+kgtDAQO6je7f5jOXuFq
	 RzNNQfVXQSYH6RlFhwInZ/6dj1+eGzHpmj07xywbohqUCuAOXteeiuMFZRlw0GOCSxzKztM45tN8
	 RXlH3VfC5TWU6SEV2xJoLBgwKbqYfyCoOU6PTRpGLeF+V924Ewdh4NBPWR+1+WCi9D38RjZ2oQQN
	 8+2v+3+7C8EIBn7sTnNuWAEKXO8MLevnEEUun42XAyVKJM80QOKvZzSpJ011Sf26KpDt0lZswmXa
	 sqRI26N48HeY+wOojltTaFoRYG3C1Lpwdwq4tem7yf+yreCcU=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: yangguikun <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] hfs: return ERR_PTR() from hfs_iget()
Date: Tue, 20 Oct 2026 18:19:37 +0800
X-OQ-MSGID: <20261020181937.18360-v622-yangguikun19@qq.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

hfs_iget() returns NULL both for corrupted catalog records and for
allocation failures, so the callers cannot tell them apart: hfs_lookup()
reports every case as -EACCES and hfs_fill_super() as -EINVAL.

Return ERR_PTR(-EIO) for the corruption cases and ERR_PTR(-ENOMEM) when
the inode cannot be allocated, the same way minix_iget() does, and let
the callers propagate the error.

Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: yangguikun <yangguikun19@qq.com>

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index e1f1fb3..0834d40 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -35,8 +35,6 @@ static struct dentry *hfs_lookup(struct inode *dir, struct dentry *dentry,
 			inode = ERR_PTR(res);
 	} else {
 		inode = hfs_iget(dir->i_sb, &fd.search_key->cat, &rec);
-		if (!inode)
-			inode = ERR_PTR(-EACCES);
 	}
 	hfs_find_exit(&fd);
 	return d_splice_alias(inode, dentry);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a66de7b..d28fbbd 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -484,15 +484,6 @@ struct inode *hfs_system_iget(struct super_block *sb, u32 cnid)
 	return inode;
 }
 
-/*
- * __hfs_iget()
- *
- * Given the MDB for a HFS filesystem, a 'key' and an 'entry' in
- * the catalog B-tree and the 'type' of the desired file return the
- * inode for that file/directory or NULL.  Note that 'type' indicates
- * whether we want the actual file or directory, or the corresponding
- * metadata (AppleDouble header file or CAP metadata file).
- */
 struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_rec *rec)
 {
 	struct hfs_iget_data data = { key, rec };
@@ -507,15 +498,17 @@ struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_
 		cnid = be32_to_cpu(rec->file.FlNum);
 		break;
 	default:
-		return NULL;
+		return ERR_PTR(-EIO);
 	}
 
 	if (!hfs_is_valid_cnid(cnid, rec->type) ||
 	    hfs_is_system_reserved_cnid(cnid))
-		return NULL;
+		return ERR_PTR(-EIO);
 
 	inode = iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);
-	if (inode && (inode_state_read_once(inode) & I_NEW))
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+	if (inode_state_read_once(inode) & I_NEW)
 		unlock_new_inode(inode);
 	return inode;
 }
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 5e6d66f..d201502 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -378,8 +378,10 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	res = -EINVAL;
 	root_inode = hfs_iget(sb, &fd.search_key->cat, &rec);
 	hfs_find_exit(&fd);
-	if (!root_inode)
+	if (IS_ERR(root_inode)) {
+		res = PTR_ERR(root_inode);
 		goto bail_no_root;
+	}
 
 	if (is_bad_inode(root_inode)) {
 		iput(root_inode);
-- 
2.53.0.windows.1

