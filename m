Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9603939B0
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566867; cv=none; b=HLlFhCiJxS4T1tPJmELL2zI/Tryjbdbs7FMVSw2Dl+aVs0B8w8M2sPUzjkc5TyenDrKV4kV1I4VPpGMODEkLerXzSx683m6jYpuM18dBlZyNOz34ssn8Q2kL7CWKteEWxpfiJ4FRD6+1SmyuisQM6L6ZCD5r5RyPj5lEcj6SHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566867; c=relaxed/simple;
	bh=+07jS6PpQwh1XfOQpyTSGTMrH6P0pjfnNQhjeJqFLyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9NiR9XnsO/FirYT9gqEeb9WUAr8NNBAbzeOd58p6R6ZEhGVrzHz/SaSa2oMVsuL2cwYVQq2BVPpKAsLOx1tJN4XtOjm4cZe6HW62TEp8T9ZI1OgiADFYYyheJBfe/s5g8R8QaDSq1uCPezeUAuwpTIU5CJ7TXUE8fwvWFMibcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmIW17Hj; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmIW17Hj"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2dd8923e7abso9131945ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789566857; x=1790171657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkamZhdfow2jKHw/yQZCsOWhCpUIj+tm8XFno6yYVFU=;
        b=GmIW17HjW4uexHr6Y3G88JTQpp1sobHmy724AYk5c59HyDmsGRolIn2Pw4gtJ9vemZ
         6hVxLXHF7moCwSioZoHi/EP1qlTf6Ip/k/qC4En9dYxDCInIST/V5TIZlfqvBz8fQP0B
         dPTXMx46Mt3RuXuSQrEsYImrsUoHP63IxsnM/qwel67/4Y65lbBPidZn3KGIwqK51GtC
         2In4ugiMqloj56RoVNrnG5afmjmdZTdM7DCxmW20+9w2AXiKM7fVlEYJDNtT+AOyULQ2
         oZxy8IUzo5MAtJFlrfy+Wsx9fsVSS2e1WDzj2owcCczQ1Wwm+mfnl5+LIQPx4gd9RxOg
         GqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789566857; x=1790171657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WkamZhdfow2jKHw/yQZCsOWhCpUIj+tm8XFno6yYVFU=;
        b=zMp5zv4sEL8DIl58CLliKHUKEeL1ZmshMSNafJcoC0oIogiIycd13KzRe1mgmTMUeE
         pE5AZUjf4zxUQWFceI8BhUHQiMgs+dW0UIxf2CYW/As2uItDEYrSLbhS4cLp8u0tG5Tl
         pogimrkeeTEHFUP0xh71NCQiWImlFYSTNV8h6k21QxAOU9p/GsXB46bN9P1muM8FGYC5
         MiQMMKs6yYTKSutAYtmkWmhVCncngq+0Dad96dSFXOnYdAAf10SM+u61YSM1p0NL5t7d
         CeNjpG5XsexzlhWQqc3S4Pznb37EoQl/IVoLXnFsTq3arBuyctALmRt0bl7RhecrQ9TH
         NkKg==
X-Forwarded-Encrypted: i=1; AKwUvBxtDxzTvidXDfuqtNfbERzTOjJtmPe/ZvvE7XWYlX6+Yx6sMoElGvYLbxaWJNzIE4V1UOuWHWTnOjvp8hhK@vger.kernel.org
X-Gm-Message-State: AFuF++lFK83JfUICYhw2EHW6M0TkVSX5uFUS+WeI2Vyx1VXDs8EAcnJX
	5dUVZAzsw2eXfTixO8dqzG9SuGvwaE9jtXGmgv2BmHgTW27GKhdjtckK
X-Gm-Gg: AYBFou0Ou6Zz7U3GUosdqS8QjWOMlqKA50fgbfCeY3/OXcmMeG9k0zw5PvZv20dbqjQ
	ph63G2DJhGjh9t7yp9YFas8QCr3maAi5PMdqRrOMsvJqohLfAfqtjEHqF1UUImK6RbSYpotIr+1
	juiwBHef4VeQTCgiDJRomPFhI+0ayDBoGK4B03HxcGlLkQOjGRE5eqNDmsKygnQeyH1PFzdfSo1
	BiSTJxajtzJtQRZ1NUzETHNTDUFQKQp+iJupBg8K4POlSAkZC3Cn83tZRI4VVv1jw4TMd4Q0oOg
	YVIu4Tet87oUX/CPa2bcQg6F/DmL/k3YLmPEkYroGgvdaThEUQ6hm8BpdzSLND2gF6nJIiq4YnJ
	fPMZ1bkLQve3Fv/EJADXAMr6ddolTp2I+m9Xiy4/ZzKT7WIMm8BT3h1IPfA8OKq/sx61lgoVn6j
	0awszQXA0mdMwdn3a50APNwmaq547fuVLzQc6SnPlOLtwumeqWZAglgSfie2WT277wDJYpoEtpO
	hudIva0x4A1Pqh2O2Re0AxKxgAaUD0pMGJzeqcdvbgqshKmjxHvQOWQYzI=
X-Received: by 2002:a17:903:2f82:b0:2da:eba4:b640 with SMTP id d9443c01a7336-2dd8dd1c7a1mr57691465ad.6.1789566857040;
        Wed, 16 Sep 2026 06:54:17 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm12070425ad.62.2026.09.16.06.54.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 06:54:16 -0700 (PDT)
From: Haobin Wu <853555@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Cc: linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aneesh.kumar@linux.vnet.ibm.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH v2 1/2] 9p: skip intermediate directory entry name copy in p9dirent_read()
Date: Wed, 16 Sep 2026 21:54:02 +0800
Message-ID: <20260916135403.15789-2-853555@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916135403.15789-1-853555@gmail.com>
References: <20260916135403.15789-1-853555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v9fs_dir_readdir_dotl() decodes each entry of a Rreaddir reply with
p9dirent_read(), which parses it through p9pdu_readf("Qqbs"). The 's'
conversion in p9pdu_vreadf() already allocates a NUL-terminated copy
of the name from the wire buffer; p9dirent_read() then strscpy()s that
copy into the fixed 256-byte p9_dirent::d_name and frees the original.

The wire format carries the name length in 16 bits, so a name longer
than 255 bytes is valid on the wire and may well be valid on the
server's filesystem, but it makes strscpy() return -E2BIG.
v9fs_dir_readdir_dotl() turns that into -EIO and aborts getdents64(),
so every entry after the long one disappears from the listing.

Drop the second copy: keep the string allocated by p9pdu_vreadf() in
p9_dirent and let v9fs_dir_readdir_dotl(), its only user, free it once
dir_emit() has consumed it. p9_dirent is a short-lived stack object, so
the string's lifetime does not change.

Note that the VFS only rejects names of PATH_MAX bytes or more in
verify_dirent_name(), so after this change a name between NAME_MAX and
PATH_MAX is returned by getdents64() even though any later lookup on it
fails with -ENAMETOOLONG. The next patch skips such entries.

Fixes: 7751bdb3a095 ("9p: readdir implementation for 9p2000.L")
Closes: https://github.com/microsoft/WSL/issues/41192
Assisted-by: Codex:gpt-5
Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Haobin Wu <853555@gmail.com>
---
 fs/9p/vfs_dir.c         |  6 +++++-
 include/net/9p/client.h |  2 +-
 net/9p/protocol.c       | 12 ++----------
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..af00b79d801e 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -185,8 +185,12 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 			if (!dir_emit(ctx, curdirent.d_name,
 				      strlen(curdirent.d_name),
 				      QID2INO(&curdirent.qid),
-				      curdirent.d_type))
+				      curdirent.d_type)) {
+				kfree(curdirent.d_name);
 				return 0;
+			}
+
+			kfree(curdirent.d_name);
 
 			ctx->pos = curdirent.d_off;
 			rdir->head += err;
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 838a94218b59..9f3079c6f386 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -268,7 +268,7 @@ struct p9_dirent {
 	struct p9_qid qid;
 	u64 d_off;
 	unsigned char d_type;
-	char d_name[256];
+	char *d_name;
 };
 
 struct iov_iter;
diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 67b0586d807f..d4335884e0c0 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -770,7 +770,7 @@ int p9dirent_read(struct p9_client *clnt, char *buf, int len,
 {
 	struct p9_fcall fake_pdu;
 	int ret;
-	char *nameptr;
+	char *nameptr = NULL;
 
 	fake_pdu.size = len;
 	fake_pdu.capacity = len;
@@ -785,15 +785,7 @@ int p9dirent_read(struct p9_client *clnt, char *buf, int len,
 		return ret;
 	}
 
-	ret = strscpy(dirent->d_name, nameptr, sizeof(dirent->d_name));
-	if (ret < 0) {
-		p9_debug(P9_DEBUG_ERROR,
-			 "On the wire dirent name too long: %s\n",
-			 nameptr);
-		kfree(nameptr);
-		return ret;
-	}
-	kfree(nameptr);
+	dirent->d_name = nameptr;
 
 	return fake_pdu.offset;
 }
-- 
2.54.0 (Apple Git-157)

