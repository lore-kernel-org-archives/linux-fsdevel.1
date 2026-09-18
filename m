Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730EA3DAAC0
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699754; cv=none; b=u+yZRYsmVTPheb8Sz0VTtBG02uozJfZDH6udE7EhFSxrbwWhPMhx5bX8tA7hchzarodFbFWKyZI500uWZyTU2AlIC1qxTPZPTi43aIgpzSH9yXU3oORs0iDtv58+W0rVMy0LGu8FsW/VPiwSUtHddG/hc5GtBEhzit5KAJgyL9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699754; c=relaxed/simple;
	bh=S4Vuo8YtaM3fxM4JniOrdvLWoJgGdyu8cvpbGNZfQnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9resOC0awB/ofVmkDBhmrrlEkxWtI/j/qe4dWsMw6MLjps+niCRSgI+U031CGK7BLS3aoOM0kv5+blcA27TsWrHAdzn6MYE5Z0gkuOOeKh+o4iAyjOk5buIn2u1kwq2O8uw1oAg3RiqSxiv5R/zjdfDrqMNtLcqrkCG4xhY644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ea4WKne9; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea4WKne9"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-398e10200a6so169461a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 19:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699744; x=1790304544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTdSu3rvffDl6KxCGguwZ5xbCq9qGNFXPPkm/ugbL5A=;
        b=ea4WKne9EYFypo77CrYaTiGYH2TYadkIOrclh7Y/H4Z4Wl3S6S9qbq2u3rAuPONoxL
         eVwjP3UV3PDmugfx6thArRRBWWEkfTF/TNMcZnx3YQX3Kk/Xrzx64WRDnJ5oGue9u9d6
         JyKG/4aU7lXcDQ2027Jb3Cf9KNnU627c/WNiF37pBv4UF8zNGyq0uJ6fcMSHvMToW8Ro
         xkbQS0Yj0tuEWiyfvgKVPAtjttP8L0DZrALpbPqZN30mxeq6+rnmS8RknyttsmzzpoW0
         GSkXaKuemOYbPlIJxcliv8t0dbNrQeAh9mJt5XyQ9gGGVPBMnZNjLTCMcGQQJLAxHq6V
         0nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699744; x=1790304544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vTdSu3rvffDl6KxCGguwZ5xbCq9qGNFXPPkm/ugbL5A=;
        b=xtqAhmAPSbDVhb0UPi/hMx5t0jJj2ln5E3uk/SM9g8LTwd080BNYy8lgYj55hcDNmb
         ebLBo4QljppeHify38k1kiKTZ3W5aDLTbOCSJhfPt/l2z/wp9HzBazz3ssPrt28GeFsm
         1aHIeWLcsiqTK6ZKa7X/EZqkynCTZAhsgnD5wVk8HLDYjvjnoKUG5Pq4VxaW3IFl+k69
         qU8pDAMPC995urp/XKEXqhgNTuui3S6HmaKemwuqTZdgk0ddIFbXGqOpIvLkVr78RykO
         Rq6mg7upU/jvqiB9OvWg2UmLes/sRVlWi0LPMm5lt6u+Crf7/1YpCdp7M1PeQslmWoEh
         p0HQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqlFx8i3MDdnjpiZVDW2Nsc5QkOVjXuZMf0/vtYtw5GkiJq4DoUhB+o+8PqW2sAMjp0EHqAuPY3ondEB1h@vger.kernel.org
X-Gm-Message-State: AFuF++lyLBMRCOj1KYnpsrMY9nIdopin/xCFzjJxi9/HKhjsAa+EXs1S
	Cn/+Gtjxav2iDqxZcprdz9yzdowdFcPQhvbrKsuFSfyCuNNtp04OTigo
X-Gm-Gg: AYBFou2l+YhNLXreD0KOBH2ISjD6ITScTxARHry7NVNKZjPKUTQbzKjvauro8BBnzdp
	WVGPJGkeYoe7tz04/bYix1fmwJW6LX8HVgJVatifCLfkwfUX6HdxK9bmOoMjvLt1o8rW0LMNBjx
	GxgvJ7xryGnQ5doOJlEs/UyzmNIwTDcvDDulf3SDe68K+1QI0uVQUeh/ONNVmteLxhKLDhWfxXD
	1+XoCKBA7Qz6n++GvORWgsNuNMx8ap2d3KGAguGqokoZWI9I5KSXDZ6tASJANKll8bs2INPv+mU
	wchVTWRdJXvXNW4lWoQeklwIj9EnxGVPI2kTK669t7YqmHg7YUvWBxFUnizWV6ZMjdDimabLYc8
	YqQ/fabFsX/ABtlunAhjCp7l85JvXHypWChIYFqmVg0ey8Ng+/VNY6P61K/VrvXjfunbdadbPFD
	+RVxHH5RN5LKiDHlZT96u7AOZIFH7p6RAk/5Trz3ukLaxfXTj4g65XeubXpW3RpFsRYv0bgVuIK
	j0Hf0BCeqitfOYSTedgjuaMpzAPHs/KKg1lQq8QzUufUOU8
X-Received: by 2002:a17:90a:e707:b0:39e:345b:3322 with SMTP id 98e67ed59e1d1-39e54cf11c2mr2532091a91.23.1789699743563;
        Thu, 17 Sep 2026 19:49:03 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b023bsm388217eec.23.2026.09.17.19.48.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:49:03 -0700 (PDT)
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
Subject: [PATCH v3 1/3] 9p: skip intermediate directory entry name copy in p9dirent_read()
Date: Fri, 18 Sep 2026 10:48:49 +0800
Message-ID: <20260918024851.51229-2-853555@gmail.com>
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

