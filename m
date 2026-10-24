Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877691;
	b=SwoIP8+ZNXVLZK7dzL4tHZAWLHuElMms/1B8nYeuMJdQhilXpKAQBj01f5uj07IC4lRv
	 DFNspmrxpkqcFbaOrCpebVN0pWh/KzGF8PgCC/FLQRgJxR+hsA8bQDUXGUSdXwM69TMVp
	 RLetbZMRPkv2hx/CcCecoo2Gta1SsoYYwiLNCQx06RTaosJajzw4pCVknh+92+bmlb2ZT
	 Os3zD+Os8xCvjGES1IJ6wbPRT9gLvkATshIJt+BKCAbMHHMxrSeSakvAnRHtAxkMkHnmS
	 dHGkG5Sgt1kNztqHLRoeKjNGz8OloSOgwvHMI5d6nteavOd+z+zelNyIDgMOfJKxWDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877691;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8DAy5kmeVLA1wy3Yop9nszDQUaaMMP3pmQIaTQ6p8+Y=;
	b=qCtaT8yjTEtvLkEQxVB7yF/DeiKNpItLK4aKrYC6fDdOzH/v4rrss0KcaTGP/+GbMgc9
	 W9+oIQ9HYba4kRMSM0QqMlTYX4h1mtxi78S/Wsei3vC+wUmVEzPO6PI/lFLuacQh4C8Mf
	 jr8yCkZBZjWV9eON/+bSgjlo0WQoleeT0vD+56R/VpmhNCLQ5/A7Pkmf99ZrmiXxjJz9d
	 95fYKvK3+SxkDoYRL6sEdJ7bMwqRHrtpWKsL0buTXj8sNP/B8+ZQbK/EJX0GfCuYwJ4cM
	 eKW/98TK165N1Wifhk231/K6WKeh15U98tKrDyQiWIF6RyBRl7L8QdDu3L7LzBcyWkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b="MYj3AbD/";
	arc=none smtp.remote-ip=195.121.94.184
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705360A2600
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 21:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8705360A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=MYj3AbD/
X-KPN-MessageId: bc3b21d1-cff2-11f1-a3d1-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id bc3b21d1-cff2-11f1-a3d1-005056994fde;
	Sat, 24 Oct 2026 23:34:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=8DAy5kmeVLA1wy3Yop9nszDQUaaMMP3pmQIaTQ6p8+Y=;
	b=MYj3AbD/Mp+cASdENCEzLkctymRfsSX+CA1FnyveAUGpgwl5y7EUiND4j8OxM3Yi79S1yoNbDNd8P
	 7BKJgZwIlZqXarVht8kmY4auy0F927YtMZ3cZRur5DUWXezGqLw2zGPOaSUYoINaJZvkSuX85TRlpd
	 tMJUKH9p7ZEhxjIdPe8CV1Ii+0fmxrpmQUqWIvYxM8UDvfLlwyhVSKVB4A8HQFdCwfjCYyNbTfv1ng
	 jMmwWspYxb/L7M+pmw4Es0F702KoAULhXvV31QjTAorahYPajBw+YsQEVB47hyiuHNUNP9VwEurJg3
	 rIfvZy5J6s3l+wXJstx1cYBoKC+sL4Q==
X-KPN-MID: 33|08lQ8/utAEZeOoYWIatJfHwVxIrGhilB2ZoGWzltMuU6X6YXi2LS+S0rtOqFNHi
 XlCtktG5Uth1Yhf9Vj5eHQbTOFGgHdugUolvP3rch9d4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|v2hMz2Iszsiwc7zBRDrVJ2FPag8ktxDzyAA8VgB+IQRplWAejYdIPtZxLAxrktJ
 JDvn/RgYHu5NaXDLWc/U/dQ==
Received: from daedalus.home (unknown [178.227.247.81])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id bc00a61d-cff2-11f1-8686-00505699b758;
	Sat, 24 Oct 2026 23:34:47 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	neil@brown.name,
	cyphar@cyphar.com,
	jlayton@kernel.org,
	amir73il@gmail.com,
	shakeel.butt@linux.dev,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v8 10/12] vfs: use finish_lookup() helper in __lookup_slow() and lookup_open()
Date: Sat, 24 Oct 2026 23:35:37 +0200
Message-ID: <20261024213539.1307600-11-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
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

The same code around calling ->lookup() on an in-lookup dentry is
open-coded in both __lookup_slow() and lookup_open(). lookup_open() is
becoming quite unwieldy so factor this out.

No functional change intended.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 51 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6463eb8717ff..5c157554d677 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1889,12 +1889,34 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 	return dentry;
 }
 
+/*
+ * If @dentry is in-lookup, look it up in @dir through ->lookup().  Returns
+ * the dentry to use from now on: @dentry itself, or the dentry or ERR_PTR()
+ * that ->lookup() returned instead, in which case @dentry is dropped.
+ */
+static struct dentry *finish_lookup(struct inode *dir, struct dentry *dentry,
+				unsigned int flags)
+{
+	struct dentry *res;
+
+	if (!d_in_lookup(dentry))
+		return dentry;
+
+	res = dir->i_op->lookup(dir, dentry, flags);
+	d_lookup_done(dentry);
+	if (unlikely(res)) {
+		dput(dentry);
+		return res;
+	}
+	return dentry;
+}
+
 /* Fast lookup failed, do it the slow way */
 static struct dentry *__lookup_slow(const struct qstr *name,
 				    struct dentry *dir,
 				    unsigned int flags)
 {
-	struct dentry *dentry, *old;
+	struct dentry *dentry;
 	struct inode *inode = dir->d_inode;
 
 	/* Don't go there if it's already dead */
@@ -1913,17 +1935,10 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 				goto again;
 			}
 			dput(dentry);
-			dentry = ERR_PTR(error);
-		}
-	} else {
-		old = inode->i_op->lookup(inode, dentry, flags);
-		d_lookup_done(dentry);
-		if (unlikely(old)) {
-			dput(dentry);
-			dentry = old;
+			return ERR_PTR(error);
 		}
 	}
-	return dentry;
+	return finish_lookup(inode, dentry, flags);
 }
 
 static noinline struct dentry *lookup_slow(const struct qstr *name,
@@ -4588,19 +4603,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out;
 	}
 
-	if (d_in_lookup(dentry)) {
-		struct dentry *res = dir_inode->i_op->lookup(dir_inode, dentry,
-							     nd->flags | shared_flag);
-		d_lookup_done(dentry);
-		if (unlikely(res)) {
-			if (IS_ERR(res)) {
-				error = PTR_ERR(res);
-				goto out_dput;
-			}
-			dput(dentry);
-			dentry = res;
-		}
-	}
+	dentry = finish_lookup(dir_inode, dentry, nd->flags | shared_flag);
+	if (IS_ERR(dentry))
+		goto out;
 
 	if (dentry->d_inode || !(op->open_flag & O_CREAT)) {
 		/*
-- 
2.56.0

