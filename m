Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3F37C0E6
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699760; cv=none; b=ApdDicbYTRpRCunJBfOjfPiQF5tF2bzPpuldzQybzD1z/8HbgDO/fVlclB2Cbxs4j+F2/zVb7zXzL1iH0SeRuy4C1YdhLEwYgXCNQSrQsO2no1dH7WFhibCDkTjzae62FrV2i1TwY0WhHQ4jC1AGoW8ALFw+02SCcweoZn64QU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699760; c=relaxed/simple;
	bh=yjmkwbpeQMdmXCBXESN5xDVi7K/v6oHuMoxkmkDC8Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3WJRKbxg4rmlkky+lWSoPogrpwS83h3yA+cc2IKoJXaFeDLcX8Xc7BB2LdsxbAoGK0C4wYDqpDzsXI/BcFHJce61qltrqEpFzOB8xf0iyJILGfEczMDBIrWbsX0j3+0YAumXxBKBEr9kx9tCTVJgUnShns1/8jucwJDZkM6GG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLbTDcyT; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLbTDcyT"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-38fd9408220so78465a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 19:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699748; x=1790304548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V75GajmH07UG7qaYgZOmgqCDwlXfTM0MKIoEOxgI2Ys=;
        b=pLbTDcyTqZcIG23zZ9lxfWQEgWBDANU6JTQx8JZoukMh7lkhCcDxoCfbjnnOsE4zi5
         hU4lQOCCY3pDdDV3efw4H+0OJeKoaExMdWCuzy3zWFDgSASbR7YoRqiJlbmDn0MA8CQj
         JNY8REx5LPg2WSzZKeJ0re3paEP2W7l6ZIWu7jdmQrHtGyflrX8x0pV95U5enJa7wITR
         dyZP6rFgbDFOzG9qcStX91hZ3mxM9leej63S3P7J395uIaSMS2TZsQmS4niLELAZdbiz
         P/QQzo2P7kATC9FtBm9IUiH1xI+jV2W1cZIieALdJP4exRNaSS7dxei39exRvZpUfdmd
         EDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699748; x=1790304548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V75GajmH07UG7qaYgZOmgqCDwlXfTM0MKIoEOxgI2Ys=;
        b=E/jCPmOO24twVcyGDZ4onfFwjlRrWC6Vq0YDEwcq9ax0qKYwtNlkmzKtu4LvrH/uLb
         b02N421Fq1yuaCEi8eKOUCRr3b4bLQGWU2PVgMwSB6JMJC2cNpVhx9VDF3bTOF6aZHXH
         2fJ1Zx3JitPB/VgWsO7PoF4rRdCC3W7QL8+ZEqEprqmFpMXvsuxU2DoQSE1BuRoW/bHR
         MaFDasqVkYQ2mH9feHMLZmkwThgG17FMqyqK6xi3V4kQNV23mVExYSDkOiuwuWnXVKqg
         5T2zcm1HjpDiRvyXD/Tcigf5USTjUTKuMA8YZPYWebFYctb9NPzRXsM3r+NkFakO/Bnk
         5z2A==
X-Forwarded-Encrypted: i=1; AKwUvBwhh03BOoTnlnn+UNLkQ0pZfXUh+bZU+5jgUCJSuDp/J82S1Pavczr/y4DJ4bYuWWZiApgsQjHMHF6aWWiB@vger.kernel.org
X-Gm-Message-State: AFuF++n9qoIeiLm5pfsPdrDZR8q0bOo+fHjI44BEwFasK5J9nCk/UswV
	y2aKSgTX+heEuDJgIj+pAyHZuYHkJIJZBXr/x5znv5+eq/ApiPzBEwX+
X-Gm-Gg: AYBFou3QB/DiM9j/bm2rwVEn3AjB/9i1n8CY4xmB2djIT9PBPs4qx5kLD+OqBxUoYyE
	zeb9Xzboa+46gpEwU9BXmEQ4lXcDTvyMrFe9gAMFq3hpGw+RjP1eDIKhCiiBWyKtAMtyzoP2jOF
	odHHgkm2pOmDxXPrI6ll787KlVxrEWN/vpB8l5pKYjtzQeHneGGREnElJvNYftZuM8TfMoZd8Ld
	0wobVe6Z73grV6CUpyehMZveA7zEXL2AOBJ8KTuarbeZGRlukGHXlehi7B+Hso9SO0G+yiIIBB3
	0kBAA3nIT/bGN42YoawD5fD/sO1Hm33CQr3NzjvmhQI7zSsm1Lb7uulo6kgrkmg4hHVzVwQWZV/
	+YM5C/Hm962D6LN8XhRtGQO+dSrzUoNxLOinhoJgjBpyqZrBftjSrELDk/axgAmCWL7oLM/wIwc
	akzin+kiEO4ViwMDkaD6koJNx3D9nW+0y+YBPxTWtdn6/VUOZPYOj9tOout4IcAg7M8XWW6ik9O
	9nENaLP17YmYFOE6J5TJJebmsBZqfpkcN9rf+FYnjZtbNAO
X-Received: by 2002:a17:90b:2649:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-39e54dce754mr2452791a91.14.1789699748336;
        Thu, 17 Sep 2026 19:49:08 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b023bsm388217eec.23.2026.09.17.19.49.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:49:08 -0700 (PDT)
From: Haobin Wu <853555@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Cc: linux_oss@crudebyte.com,
	jack@suse.cz,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aneesh.kumar@linux.vnet.ibm.com,
	willy@infradead.org,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH v3 2/3] 9p: skip directory entries with names longer than NAME_MAX
Date: Fri, 18 Sep 2026 10:48:50 +0800
Message-ID: <20260918024851.51229-3-853555@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918024851.51229-1-853555@gmail.com>
References: <20260918024851.51229-1-853555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 9p wire format carries directory entry names of up to 65535 bytes
and nothing on the client checks them against NAME_MAX. Since the
previous patch, v9fs_dir_readdir_dotl() passes such names straight to
dir_emit(), and the VFS only rejects names of PATH_MAX bytes or more in
verify_dirent_name(), as -EIO, which again fails the whole getdents64()
call.

A name between NAME_MAX and PATH_MAX is therefore returned to userspace
even though every later operation on it fails with -ENAMETOOLONG, and
POSIX requires readdir() to only return components of at most NAME_MAX
bytes. Nothing can use such an entry, so skip it instead of returning it
or failing the listing, reusing the strlen() result that was already
computed for dir_emit(). Log the skipped entry at P9_DEBUG_ERROR, the
same level as the strscpy() failure message this replaces.

Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Link: https://lore.kernel.org/all/vz5bum547fqyxf5z4m3x7tuqkuq52jlopm65t7hvynqeulh7i3@2t4wnhfxs7qv/
Signed-off-by: Haobin Wu <853555@gmail.com>
---
 fs/9p/vfs_dir.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index af00b79d801e..08d1a3429654 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -173,6 +173,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 		}
 
 		while (rdir->head < rdir->tail) {
+			size_t namelen;
 
 			err = p9dirent_read(fid->clnt, rdir->buf + rdir->head,
 					    rdir->tail - rdir->head,
@@ -182,10 +183,14 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 				return -EIO;
 			}
 
-			if (!dir_emit(ctx, curdirent.d_name,
-				      strlen(curdirent.d_name),
-				      QID2INO(&curdirent.qid),
-				      curdirent.d_type)) {
+			namelen = strlen(curdirent.d_name);
+			if (namelen > NAME_MAX) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "skip dentry: name length %zu > NAME_MAX\n",
+					 namelen);
+			} else if (!dir_emit(ctx, curdirent.d_name, namelen,
+					     QID2INO(&curdirent.qid),
+					     curdirent.d_type)) {
 				kfree(curdirent.d_name);
 				return 0;
 			}
-- 
2.54.0 (Apple Git-157)

