Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114192;
	b=U78EicMxlZhjZCjBYBeel0o7A/qJEqPwF/nsNEDgaibSKDWlxjOKPsXOrLM9xBCixpy6
	 Qrpzv/yOYM0aEvPgY3ed/VqSCjOaG4FtkKdwcv7UZeKn4yxBMV82h62fkpfbI9vW7IoUN
	 Y/n+8zWGzNkVU+kF9E0FlHFXeqyrJwnM4NHgi0P8NMFDct5BeOdd/E2xATQMcwr0ii9mK
	 zACij5IAKHoxVdLcNiJB7oUVHh64G8rP/FTxUp2FLewqaZFwqwJqP2+UbUn3/jWIi8eFd
	 O0r5Sb2w+UIAVhiqAVEb/71vksL8aiQrcjoKMRQT7nHiKbw2Vq2MC0aJ0g218bKt8kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uTppmobKlXCQMDn3ZVLxidM0e+PEeg9PY8KBlnC43UE=;
	b=aHCZHBRYQx81NlJqNSM5vgPNAolixlmfHdfLE4wKgKE+UtARjoDGs+4tpP+9tz8WC1e7
	 PE7eRi8ZD9t+0+lTcDfM7WC11fjeR45xq8vTHllFqpN4BwSUeURptod9rMZPS47jEWgku
	 Di8FZ/iJsSPwnOlHjZ08jR7nFXkg5vOPgo4LbbosFKa2iWZdo7E9H3o+IQEh4kfL8BQbe
	 Xy33IxrtTKw95yb4beiCcOaEYaDnviQW4tANWXfNhlUOPoRIWWKDA44o7fcSAC7Elunb7
	 xpq5Xngwh2T2gaV3tWBluZlOj//GX0B2d5xUGPLEZpx7SyxP2avLvUE8opLr4hvGA/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E45A7aCi;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D8606A322
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 15:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A71D8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E45A7aCi
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-824413e10dcso2177548a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114190; x=1793718990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uTppmobKlXCQMDn3ZVLxidM0e+PEeg9PY8KBlnC43UE=;
        b=E45A7aCi61MU/blkZE72dtLfe7C9BLMirAPuvC7djnoj5oT7666j8k2GG/oUKL3hbv
         5hhxwpqTjSMetX56AsLS03dd1i2rE8+ZBBGRLribP4n1eFthw8KiyR5Qn1C+H3KxYWEu
         rIx9AyYL/mBUb+aucQRu8OzMCqUioax5nfCImwaq8sBMWi3l+uqJtWi7Sd6SCuO0zN4Q
         5MuRxgHpMEG9B/yKkdzSU6u6z/JiqtW82z/fKSs1wdeIu+3FCdOOruHDzYHeRlfhUb3J
         HH7wTl26p2yFhyxlBTzS6hAqFu4H1//0OaunyBnpxc8x5uIgOkKAIGRBVv2+ygabVYo5
         a8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114190; x=1793718990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uTppmobKlXCQMDn3ZVLxidM0e+PEeg9PY8KBlnC43UE=;
        b=VcoVMUQmaytREh+fLE76qr1/xR8VrH7HvjGnusR4ib8UE2jEgRB6CYlIacPCjEY5F+
         BSWpJM/DeGtscypa2WzCj43Tjt9XtpiUQ66U/+ePQ8HaqMBI/vPp5PeszBuOZVd08GiQ
         m9tVsqVC4x4+uRj5n/MPyinmVkDyiZQfDHYepGgThPmLzr6RyhKhndoXgr5anoow1yCx
         wSsQmvaigwBvIMxZRih/NheamENxpE5PTGjs29Q6qFKcppjnJZRJBx+A3zr0fDtojDZq
         CUh2OiqVoq+EY4j6PWde3sTVRSjm02sPXat1xg4hnVfvf73+4/6nPLCgCtQnywisf2YS
         WQGg==
X-Forwarded-Encrypted: i=1; AKwUvBz74bP44S7F25QaEW2TPGY90uJ/e+8n3Iun87mg2OsWruzI3BenqyhE2zlSsjMpl0vcM7sfGIprgt2HtPR7@vger.kernel.org
X-Gm-Message-State: AFq9FYLd3Rwft9OUzjL0qxDS7D/5CMcAncViXT1ofz1pP6RWoebYuRuH
	ELnPN9LEjR8jBvSX95Dz42rccAzoD9fDUy2Y3x72khImV0kJNhUQwKIS
X-Gm-Gg: AYBFou3rk3L+KW+ifmdC0RsmlqTrEPrnGd04e3Gol/hq5NsLbkz77VyJ0Og7iaS/pMD
	sAqXNr78d9HsoIbLKIi1gdMWY7jGQcW+3yikC0uAiRnlxqwpcPV0bxfbgUVeLXoMziWs0huZduP
	WmX8SymD/i0Uv4NOkPYc7Es8azMHhDhL8jMftrEYjYG1R1Vddricu1+kgh4Gm97Iv1paZirpS95
	a3S1z48HUued8UhwCNe5jNFmphX6tn5roWonwCs2IIUR3jDsOiLgjqSenDSPjMS0GojHak7jm4O
	TbaOvz+uRvNSaEcLVzIbVgVzOYFz7XwDQ2Hpd0fnmGmyMeW4dtq+KqScfcUxNsKPzuoe5DLBcwH
	2lpbt0mdJm9l7HK8wRhhg8qOvm3I9q478QhplFJJp3BGFDjg+fE4cSWBt6AVIK1aCJqCdbK4EBA
	QRak9OL2LLFl7yLj4BeTh06+0KKv7k9UsyE09ahx7yKdbBNb6q53K7l7DvltyjwvzY5IMxGLksx
	+nTNIzpAcbqxXGSqfpoX5xz+EuRbYl8Y8dSM4IAh0Nt5ul4Dj3O2JJgaSpwMcXkzcpQZWtPsrpV
	HOuGFywzarpF/khiPbs=
X-Received: by 2002:a05:6830:4393:b0:81e:1262:6536 with SMTP id 46e09a7af769-850fe4f7abemr8973671a34.15.1793114190396;
        Tue, 27 Oct 2026 08:16:30 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.40])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850f8458d7fsm10768970a34.2.2026.10.27.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:16:29 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: fix UAF in al_destroy() on stream inode eviction
Date: Tue, 27 Oct 2026 23:16:14 +0800
Message-ID: <20261027151615.971171-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

al_destroy() unconditionally dereferences ni->base and frees the shared
base attribute list:

    void al_destroy(struct ntfs_inode *ni)
    {
        ni = ni->base;
        run_close(&ni->attr_list.run);
        kvfree(ni->attr_list.le);
        ni->attr_list.le = NULL;
        ni->attr_list.size = 0;
        ni->attr_list.dirty = false;
    }

ni_clear() (fs/ntfs3/frecord.c) calls al_destroy() for every inode
being evicted, including ADS stream inodes whose ->base still points
at the base inode: the base's attr_list.le is freed while the base
inode is still alive (iput(&ni->base->vfs_inode) happens only at the
end of ni_clear()), racing the base's ni_lock-held attr_list consumers
(attr_set_size, al_add_le, ntfs_load_attr_list).

Stream inodes have no attr_list of their own; freeing the base's list
on their eviction also leaves the base inode with a destroyed list
(size=0, le=NULL) even without a race.

Only destroy the attribute list for inodes that own it: a stream
inode's ->base points at another inode, while on a base inode it is
self-referencing (fs/ntfs3/inode.c), so the ownership check is
ni->base == ni.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 fs/ntfs3/attrlist.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 8710560cf2944..6aced486a45c7 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -29,7 +29,17 @@ static inline bool al_is_valid_le(const struct ntfs_inode *ni,
 
 void al_destroy(struct ntfs_inode *ni)
 {
-	ni = ni->base;
+	struct ntfs_inode *base = ni->base;
+
+	/* Stream inodes share the base's attribute list; freeing it here
+	 * would race the base's ni_lock-held consumers and leave the base
+	 * with a destroyed list while it is still alive.  Only the owner
+	 * frees.
+	 */
+	if (base != ni)
+		return;
+
+	ni = base;
 	run_close(&ni->attr_list.run);
 	kvfree(ni->attr_list.le);
 	ni->attr_list.le = NULL;
-- 
2.43.7
