Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4523CDBD3
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699762; cv=none; b=ehdlRcr4/rDlSInoHnZpEzrLm850B2WpsK2DmpyO2HzhQ8gKuhbv2CGOZ++1wIVxcW/eyQx2XhmQmLjYiecWAx0Zc9w6c74Vkdxo3S3Em19EPmR8dsCY0Rroo8/6bsyUrEGUmBydDsYepjYRbNKRzyYF8frI4sy1g4tZyEfV30Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699762; c=relaxed/simple;
	bh=7mZyvLsdD7rZFz20RtO0OYHMdBvBnkDzPt/82DlOJfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZ3cu32pkYT9QPG3oMk2fM8shF1e6cF9lpaTQZamoaDwi8d0kwxr9S3UxVyfMTSoAt3XuC6pWIjB3AMFxMdijgK7hn8rQ92hXxVivAHpIVKaWYH79XlrZGfd7rDQ2UBonn8QinKcy0cyGEF45trtWfOhBQUtCzQrNxFfkitq2Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9GCvagV; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9GCvagV"
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2d8fcda61c8so1056705ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 19:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699753; x=1790304553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zt8G0xpIOOhfoNc/LpRJ6HNqd0QOLFO5B7X1F4wwr9s=;
        b=n9GCvagV4vzLOItApOQYz25/x/JPn5IyIANJKNYuUakigjbbk3G/p3jAk61QXVs6PF
         pTwKFM1QOpCVkIJKWgHeRrZhYzMVJgwnAMrkz+AzzJw4PApVE/NNnviquQKEGuyiM1/4
         1NkP4mxZjlWmwqLyPROy50C/fmW0yDNi07rI4yBb4IjY8Xma/fkXcSRUnMrM+X/dP0ls
         WQSURO18KI3OJOYvPTg3V0H72Rb2ul0RvWWdOYDQfp3J30dKgIZ3K0kHTeFtCF0ofLgY
         bQWk3++paG2OU6hPkI4AGhP4BYZqrM5mTabqohBWKNBq+CK1dTiJZOTS/pr8JxlXoHrN
         2R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699753; x=1790304553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zt8G0xpIOOhfoNc/LpRJ6HNqd0QOLFO5B7X1F4wwr9s=;
        b=leUZvhJxISLOtsAnf9XHwL/mfFf3bKCeDoY15zJtaAnzkI50IQKJplbX00NWqiqZT4
         6e9sa2A+t3VBnsFQM7jQXA9UBfFzS9EsXZW0Lc46Xa8b/DaZNFLamklyC0+ggniZZ6Xi
         MOym2lcc5uvcbEpb6vr+J25c4Hv7Zx0ZhiCX9VyC6YlJ5/G+0VOPEUqHBWRylvk4Gkel
         AWesIl8mr/JGBJYOgi5/h5A7et9LTnqeAjshW9+vkKOe1ZIZGTu9QlQGTY22KI7CN9Er
         6f83YvU2M3aVjkBZjK2/CWZte/MdakNcC+pFojl9M3bqeYupVZBGoKOJWGOKvRVZjELM
         8STA==
X-Forwarded-Encrypted: i=1; AKwUvBwmuGcYyCLJC+DOBv7FaeEbdh1cUAtkQEWm/iN3VuPsR9WtQeP/dACOzQ8dX7qxnwGzRm+8fAl8ggcT0Bbb@vger.kernel.org
X-Gm-Message-State: AFuF++nByN4Zzh8jCjYOzOcgdKCZIIpGluiVNtB0I4QkocaZDTPNcg/W
	NXlQmHQrgCjw1KCreeRIS3K8IFvyIyucFzRMEOLVif4kTR/dT70ydPGb
X-Gm-Gg: AYBFou39w4QsJ6ikZu0uC4bT5QfDOl/6mlsTiPgrpq9zkV/iGHU0yYS3cf73Wkf9Dj4
	EWy+SlDWsMQ3zbqpUFtcSGRclT8h9rtLaG/fatT3VVAjbUnw7H8sy2JR2TIShmLEFjyliZrXMFe
	HGm7uArzk9GffCLL6BY7w7J9pZJL2BcBLIkETE2b9nSmzc1aXAxnYCyD0UqqjAqxqX3qlMqFy5L
	MC6lCIuHMT3QeE/NEVrC1NJQ7OViCRdXlXhelnbZE7wAFcfDfUyVSnhsB5aKgfl5DmgZsti7Xty
	kR0cmj8yNChBi1yHL7YEj7IU4QF4aui9GLVTYx9f8O9ycfE1AcZZJmWNzhOuOECZgpja+TqSreg
	u8aruaG2t65hAiPOXJLUzs9U+1PgBHv3DCAE+7d4wqGSkEIxuuvapcX3bIXVpqLu/LXlB7LGtAb
	7lrdBW2ug+jQGIGELKc/4EkaEVYRKDI8DmuZxxtNAp3G6bhcle+WEUf6gWeeAljo3+EhOFBXiH1
	MDkOq/R2hCwHXTCyIB05rgWCmzS1F9bMACtVtXszeZtscXT
X-Received: by 2002:a17:903:46d0:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2ddb1b04363mr24129965ad.13.1789699753092;
        Thu, 17 Sep 2026 19:49:13 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b023bsm388217eec.23.2026.09.17.19.49.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:49:12 -0700 (PDT)
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
Subject: [PATCH v3 3/3] 9p: skip over-long directory entry names for legacy 9p2000 too
Date: Fri, 18 Sep 2026 10:48:51 +0800
Message-ID: <20260918024851.51229-4-853555@gmail.com>
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

The legacy 9p2000 and 9p2000.u readdir path, v9fs_dir_readdir(), parses
each entry with p9stat_read() and, unlike the 9p2000.L path, never had
a 256-byte name limit: a name of any length up to the wire maximum was
handed to dir_emit(). getdents64() therefore returned names longer than
NAME_MAX that no later syscall can use, and failed with -EIO for names
of PATH_MAX bytes or more.

Apply the same NAME_MAX check as the previous patch does for
v9fs_dir_readdir_dotl(), so both protocol variants behave the same.

Note that this is a behaviour change for 9p2000 and 9p2000.u: entries
with names longer than NAME_MAX used to be listed and are now skipped.

Suggested-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Link: https://lore.kernel.org/all/3910569.MHq7AAxBmi@weasel/
Signed-off-by: Haobin Wu <853555@gmail.com>
---
 fs/9p/vfs_dir.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 08d1a3429654..31de9ac913f0 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -119,6 +119,8 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 			rdir->tail = n;
 		}
 		while (rdir->head < rdir->tail) {
+			size_t namelen;
+
 			err = p9stat_read(fid->clnt, rdir->buf + rdir->head,
 					  rdir->tail - rdir->head, &st);
 			if (err <= 0) {
@@ -126,8 +128,16 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 				return -EIO;
 			}
 
-			over = !dir_emit(ctx, st.name, strlen(st.name),
-					QID2INO(&st.qid), dt_type(&st));
+			namelen = strlen(st.name);
+			if (namelen > NAME_MAX) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "skip dentry: name length %zu > NAME_MAX\n",
+					 namelen);
+				over = false;
+			} else {
+				over = !dir_emit(ctx, st.name, namelen,
+						 QID2INO(&st.qid), dt_type(&st));
+			}
 			p9stat_free(&st);
 			if (over)
 				return 0;
-- 
2.54.0 (Apple Git-157)

