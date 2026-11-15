Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777009;
	b=dKCrZuyFzxEEuHQ1C0l4G7SjexuYw7Zh5gSOprnZswRMSKdAq338RMjpUbS9cFCr0ogP
	 Vx7pZcwltcK4CUYVlHqR7bBbkfN+9jMIjuB//yGp7e+dTQJu/q0n1XfwgQ3DKskVVBsVj
	 yk3cJb/46XOK9/mGVIwhNZup81CqYJWq5H1FpQJlZQTBxc27B8rIgKSf7Q7jraLcpIfS1
	 9Wxig1clTpGtdUDvPBe/SoA+/ipN1CBJyRrsUmTFk5lv/J2XYVW2oJNl3IFJX0ANUD4Hd
	 9HrhgqR6k+fraPJB3zl5RpDzAAkhKNzDkcFo4j1dJ9/FVoyo9FKJF9DDh4yOuZymLCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vlAOOqvdVdKcDhX1498cVDfr4IVfu30LnqK+9Pi/SVM=;
	b=Qp5tfe1x+wVin1HB076nrN1uf64jAV/8CqRn7jP03+IPy4vL5/0zUNrOP41DBqlhGTg9
	 9Il2Yblj0IIoIgJXQkPz4EzSAAUYe9NmBqnaNEzrSu9dJS4GuSLK6+y9Gg5fmNMM2XkEF
	 3ABggOTTqaqfikmzjLnysHv1LkaMvjwLB04IN4Hgqbo00Fz9xTqDNkSs8jNIYhtfb2iGz
	 HdSPpYTmOaUGe4rJfWHtKolNEjfgtvgI4fL+gRmXj2mV/O3m1XnHziB1qB6lOG4JBO3x3
	 uJrjfv06E7x6f4gWoyPX7/HfcdL5NO4cHll/uhsrnSjrINsmGbdkUtpqG9wVjVOJbeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guaYaNZk;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6525606A332
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 21:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6525606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guaYaNZk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso1148952b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 13:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794777008; x=1795381808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vlAOOqvdVdKcDhX1498cVDfr4IVfu30LnqK+9Pi/SVM=;
        b=guaYaNZk/CmHtjGyoHywjpKtBpLnajf+xotGjJMBqKnv9tJF/WAP/XxAh2lIXjql12
         v5eZ0DcJH5Vo12/N1BcnGUd4HeA1hV+JHp+X8mUYNawbcYJLEEsA21POdvcRKGYTmUfO
         vo4nRJgc9USgqxoflly8wARJdpLkqVgfZatztMQNDojWjG/c8wEitj2smbnshnN5P9mL
         k/zIvzjdRSO84V5F26gltuIoQxZfdGvPn20gPynkxO/RWCH5I3vEUKie2A8qj9jKZYQF
         ehaMi/hZTeXyKJ2eGgY29MF4JyF/AjTSgNVVIk99n6w5epG6FAe3nWuLsSFXt3Ty/FA/
         QA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794777008; x=1795381808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vlAOOqvdVdKcDhX1498cVDfr4IVfu30LnqK+9Pi/SVM=;
        b=ILcnTpricOL+tfpCNta+HQqiEQs6HIyBrWFbxHuPlzFBsp1WkQ+08OFd0cIMiCZHxO
         BH23CYZKqwDl3pGD53w4FrCE/g4kHGls17KpFCRnu/Cu1Cbi6fOy+G5lmPr+8zgwzgYo
         OaP6ybi9t6WJIUZL4AWL8yKIhLYZODDVpi4NkpJ1QRI8htkJPQby+3glBAMAV/FuGxZG
         rHq/o0XpFbR0qIAO5YQQskPwCOXt43y6qa9rVZLKH1neNBGw20m4XhUHMSXrsBll5Fk2
         hHiPbix+tQB1VuXKl1nXypaQmChIcLU8oeG3iw2yT4o1t6ehJoayKy0wMIeJdnhgFtEH
         JouQ==
X-Forwarded-Encrypted: i=1; AL+hErF7ov9Rpj1nebzkuLl6tejBJ0GUw524QHA+JBEr1/rH32exqIJu03wIogH1roBPFWPaEmLBxpCopxMNQWmd@vger.kernel.org
X-Gm-Message-State: APuU4Z+oaPf6b+CSCv+GyIlg4/qH45N9suro95FoXDmSefrJEzw+RCvH
	heAIOKqjyEQgPsqK+jytj/R13rRV2NSJRilfbHQV0x3yd95HhE0fd3tO6G3GmAS+
X-Gm-Gg: AYBFou3Dgm/TwGUHLpR00BamtyMxIAuaMkyLlQXBosCeTTukGmzJA2F1LOLdcNALTpB
	8fXpcPOpTlwIBmLpCNhrYk/a1yFKe23bWO24EYD0pmEFUnzR2jIE2C6TXyTDQB1Phn/fFQe8x6j
	QjnBCZMiOviVYrBrRcKRc7IDMYLksE1Vb14YH6PacwGizn3blX7NUmPGd9o6X9hFdV4d8GwiV3N
	uPx7qEGcZfqtsQoEgNXuIHLFlgtC4PExSWTLo7wfKfTXJvGRH30/ekt4SMgg9NRa4G6dSVxXZee
	aQAvmdle+TNcLtHF2MHyp2/fPTZXuvwR/SwqFPa1IMTSONY+YeuA2tdE+stefVzQKo8oPhJN45z
	n9M0mWE4cDmtm06y6ZUx8OHQKldTe0a2pB0wGXE0vDnlBZ7F8TWwx8cIAqYD3xNFC1ICCPRRECY
	Vf/Hrgs22LAhmLQxeiEakr6k9Z00eWIYxgPROwb0Sud06xG7UNp/yONaO4UuQH4DZmXPFAzzVBr
	ae1wS317gbNGUw4wJidnvFxOrb9EL5mKwrs2fI2fyMOz9PgSjZ1UGbLkrUBI9f0EuSIjIWyD9ID
	Bx2d0wGBW2AmRRTwn3xGOwv4ZS9ki7LeWI0UkfREx7oVZgZoHw==
X-Received: by 2002:a05:6a00:369a:b0:882:2b16:c314 with SMTP id d2e1a72fcca58-8beb7d18ac8mr8266410b3a.52.1794777008100;
        Sun, 15 Nov 2026 13:10:08 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1a6e7f5sm2892615b3a.25.2026.11.15.13.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:10:07 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Matt Bobrowski <matt@bobrowski.net>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] fuse: reject embedded NULs in readdir entry names
Date: Mon, 16 Nov 2026 06:09:48 +0900
Message-ID: <20261115210952.2140036-2-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
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

parse_dirfile() and parse_dirplusfile() reject '/' in dirent->name, but
do not check for embedded NUL bytes.

Unlike plain getdents() buffers covered by verify_dirent_name() in
fs/readdir.c, FUSE READDIRPLUS passes dirent->namelen directly to
QSTR_INIT() in fuse_direntplus_link() and instantiates or aliases live
dentries via d_splice_alias(). A dirent name containing an embedded NUL
produces a dentry whose d_name.len extends past the NUL terminator,
which allows callers such as inotify to copy uninitialized kernel slab
memory past the NUL byte to userspace.

Reject dirent names containing NUL alongside '/' in the FUSE readdir
parsers.

Fixes: 0b05b18381ee ("fuse: implement NFS-like readdirplus support")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
 fs/fuse/readdir.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 1f6cf565477f..e8b47c2a9103 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -126,6 +126,12 @@ static bool fuse_emit(struct file *file, struct dir_context *ctx,
 			dirent->type | FILLDIR_FLAG_NOINTR);
 }
 
+static bool fuse_invalid_dirent_name(const struct fuse_dirent *dirent)
+{
+	return memchr(dirent->name, '/', dirent->namelen) ||
+	       memchr(dirent->name, '\0', dirent->namelen);
+}
+
 static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
 			 struct dir_context *ctx)
 {
@@ -136,7 +142,7 @@ static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
 			return -EIO;
 		if (reclen > nbytes)
 			break;
-		if (memchr(dirent->name, '/', dirent->namelen) != NULL)
+		if (fuse_invalid_dirent_name(dirent))
 			return -EIO;
 
 		if (!fuse_emit(file, ctx, dirent))
@@ -307,7 +313,7 @@ static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
 			return -EIO;
 		if (reclen > nbytes)
 			break;
-		if (memchr(dirent->name, '/', dirent->namelen) != NULL)
+		if (fuse_invalid_dirent_name(dirent))
 			return -EIO;
 
 		if (!over) {
@@ -461,7 +467,7 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
 			return FOUND_ERR;
 		if (WARN_ON(reclen > nbytes))
 			return FOUND_ERR;
-		if (WARN_ON(memchr(dirent->name, '/', dirent->namelen) != NULL))
+		if (WARN_ON(fuse_invalid_dirent_name(dirent)))
 			return FOUND_ERR;
 
 		if (ff->readdir.pos == ctx->pos) {
-- 
2.43.0
