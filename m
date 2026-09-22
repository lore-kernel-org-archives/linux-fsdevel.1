Received: from mail-ua2-f25.google.com (mail-ua2-f25.google.com [74.125.226.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF85304CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790120512; cv=none; b=bgfJxb8zrcjSy5p2XTLHaMEta9dqfZ8QxVSL5uwfNxctqJGtOIs898HCKTmT4r0GEtC53uyJpxcBlyAWTebjY2pxX38BrHPtDsqLGLL29C3WR5mdWovQWP9xCUZzdp6mhucDYUDGiDwolqbaQrsbxGzmoYUej4a17xDNufN97XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790120512; c=relaxed/simple;
	bh=UBbJe1oEZMVEBnwz0Jkyz9CJtRLjI0G4uhKnk+yV9DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwqd1A5MhwoZmxPjkjoisBb1831mmc9WoEF/Tv46j11evEapMFZy+6rtbJWQ17L2Li+qakHdUySDpWUcFnCQ8QSliqgprctzOxjB7cJj+HaZ7NFJuMg5Z1o8uw2qFthfnMobkrZ3SXCRoNCf8u1OtrY7vlZwLlCXpT09Es2xLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjI7uDXy; arc=none smtp.client-ip=74.125.226.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjI7uDXy"
Received: by mail-ua2-f25.google.com with SMTP id a1e0cc1a2514c-982e8fa91d3so120408241.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 16:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790120505; x=1790725305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rSatJQry0kvCfjOyHMI34oJzA2rpZ7XOemBqHWKUcnc=;
        b=GjI7uDXyoOHrwuQhXG+Xc12baPazdBd7TF3uX4qdYhBIjgwFBLXfZvgUwudp9H6rWu
         vp0jw7ZhkPBtKVfymFAYrzIMq6f9Ac75EVLrgREJz33DBSU/0xy6lgE+hy6/9afuIvkQ
         lQvJoMFFTRGvxg7aVuSojw8LKZNul/tMafdLbR6CSse7gJ9S/1lVs1bn8EE8rncJPtio
         XWOJGev/dthIXIiPluygTkFnarqvkIyUUAiUw3KVPB/g0TGL6b8JqaEtJ0QZwzQfCGY2
         YvuElWlJjXdXH945JizpsrIsYBv8Qcvtt2nbFHwbSId85Mh0d86PWUdsTe54dDHohVn1
         zyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790120505; x=1790725305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rSatJQry0kvCfjOyHMI34oJzA2rpZ7XOemBqHWKUcnc=;
        b=f1wNSol67VEa4rJ3cLRPZhW6WC21QeESj+1Epm5l5r2Z7A8BgBGr6tXhsn1fmxw3Ur
         JiB4Ngq2X20RoG//rEddKwB7vpmtMqC1Zn3RvsnydT9IHW88FF5Jn21FuoYjAyV6gcse
         CKz4Go63wOJ0Z/+OojU3eDqruQq9273ju0AZFFumIKsaCuMKl7HdWFXfaH5GTAp21l4h
         KWSOmGqv8RQU2KnoYSoeKtjg38zeDEOE6CCNH60hEYIHRdH0lqpRO1L1jJlewRu4yUnP
         vscd/QGPgb+m/qbQISxiZrepwk+W7Er1RAp1uJpXcwvVx1CDI4yJ3cCPFWH8kbrTshSc
         qwxw==
X-Gm-Message-State: AFuF++lOl2JNOZiYXbNv3emdv8AUJaqSpZ5QhgMWZjtgSG3CD+uolkNO
	llhDN/PFNYMfgB/w7Llel/R1sHcnGHz46vZsUaUJcVS/4rRU56nFTN9s
X-Gm-Gg: AYBFou0nY2jySNWFzBh9VeWYHtUjJZ5Gfc8RTLCQ+eNOfrXOdcsn1rMWN6f2L9rOzDZ
	OKSuv3Z9vtDEmPHwF6n6D+LQiBx7bSl1RU0ZB9N0Kp0Uy9y1ssOAVhXlo31tOTVrguE1RC6gsqY
	+JYYgijA+ge1Q/N5W867n7DsAazSzwVMpDsNZhFEIq65U1zlJha5sG2BSnEsRe19E9aDdsQ/1W5
	AskHzLDCEfIwJ29hUR3ZvBCXLgvoIzcCJChi8I8dbRijBLrL8LwK4AbXL64wIAXZ6UC2GMKqSf1
	Nxam+3Lw+WbECImICfID+kw2rOy/lai34fwzJqyQlvLkPRGbVVTKMHSiZBT/UuoixgjNdR4gVWe
	bxPT4U64ZkYdiXOz8Q8xHHugAjAuqSLv/B4MhXZGxiyD+kU+D8ex5XtqwNzvmfncB9MNoTik2NL
	KjruEI+ZgO+kXODuvlyyvd6N7HCKFVnWdPikmPCl5mPlWPZSOTpdEBOO+mAikBy6CD5th/LLT3v
	hLwz6mDfvWj4ViG/mvSb+KXMe76LcPI8b+JC3BrmaxMOY3TyZXo0TxkAQ==
X-Received: by 2002:a05:6102:4414:b0:7a1:f2b4:dae0 with SMTP id ada2fe7eead31-7ac0d12c7b6mr1298181137.13.1790120505470;
        Tue, 22 Sep 2026 16:41:45 -0700 (PDT)
Received: from bazzite ([138.122.221.5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5c6d7b2sm1842902137.8.2026.09.22.16.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 16:41:45 -0700 (PDT)
From: Davy Felipe <davyfelipe34@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Davy Felipe <davyfelipe34@gmail.com>
Subject: [PATCH v2] hfs: handle extent B-tree write errors
Date: Tue, 22 Sep 2026 20:40:39 -0300
Message-ID: <20260922234039.1307375-1-davyfelipe34@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920160213.285316-1-davyfelipe34@gmail.com>
References: <20260920160213.285316-1-davyfelipe34@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__hfs_ext_write_extent() does not report all failures while updating
the extents B-tree.

When inserting a new extent record, the return value of
hfs_brec_insert() is ignored and HFS_FLG_EXT_DIRTY and HFS_FLG_EXT_NEW
are cleared even if the insertion fails.

When updating an existing extent record, hfs_bnode_write() returns
void, so its caller cannot detect a rejected write. Validate the extent
record size and node range before calling hfs_bnode_write().

Propagate errors returned by hfs_brec_insert() and return -EIO for an
invalid existing extent record. Only clear the extent dirty flags after
a successful operation.

Fault injection confirmed both failure paths. Insertion errors are
propagated to the caller, and invalid existing-record writes are
rejected before hfs_bnode_write() without clearing the dirty state.

Signed-off-by: Davy Felipe <davyfelipe34@gmail.com>

Changes in v2:
- Validate the existing extent record size and node range before
  calling hfs_bnode_write(), following review feedback.
- Return -EIO without clearing HFS_FLG_EXT_DIRTY when validation
  fails.
- Fault-injection tested the existing-record failure path. Before the
  change, hfs_bnode_write() rejected an invalid offset internally but
  __hfs_ext_write_extent() continued and cleared the dirty flag. With
  v2, the invalid write is rejected before hfs_bnode_write().

---
 fs/hfs/extent.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index f066a99a863b..13426503fbb3 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -121,12 +121,21 @@ static int __hfs_ext_write_extent(struct inode *inode, struct hfs_find_data *fd)
 		res = hfs_bmap_reserve(fd->tree, fd->tree->depth + 1);
 		if (res)
 			return res;
-		hfs_brec_insert(fd, HFS_I(inode)->cached_extents, sizeof(hfs_extent_rec));
+		res = hfs_brec_insert(fd, HFS_I(inode)->cached_extents,
+				      sizeof(hfs_extent_rec));
+		if (res)
+			return res;
 		HFS_I(inode)->flags &= ~(HFS_FLG_EXT_DIRTY|HFS_FLG_EXT_NEW);
 	} else {
 		if (res)
 			return res;
-		hfs_bnode_write(fd->bnode, HFS_I(inode)->cached_extents, fd->entryoffset, fd->entrylength);
+		if (fd->entrylength != sizeof(hfs_extent_rec) ||
+		    fd->entryoffset < 0 ||
+		    (u64)fd->entryoffset + fd->entrylength >
+			    fd->tree->node_size)
+			return -EIO;
+		hfs_bnode_write(fd->bnode, HFS_I(inode)->cached_extents,
+				fd->entryoffset, fd->entrylength);
 		HFS_I(inode)->flags &= ~HFS_FLG_EXT_DIRTY;
 	}
 	return 0;
-- 
2.55.0

