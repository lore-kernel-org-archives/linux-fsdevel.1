Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794653191;
	b=1DexRVTq41l9/iBP/C3K0elmwZV+AgI6o9UFQRfPuee87ecGHeyxuSmHIZTv0rnh8fgD
	 9KkrsJBVNQ5YkeOeK8F4IvvN5gNAai3hOp0/wru6orFZticxmE3jFEgs1yfmRBSa85si7
	 mBWBYrqHTay9XH+iZAc3+8aqBrgmvLqI4XgD2ZWO2x2IF+mGaBrJfgai44RRVW18/QJ0q
	 8Kb8RgEUpI/HBJWvWEcAflqsruLuburXh6CDNG78B20ILy3eN1TxJkfnudqb1cfpFwXUf
	 0TrLZkBZbZoKRNdw4NERFco6BYTkZaLMhRUzvFAILsCvwWqVGFYTeoTDxbj9OZ5cgKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794653191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C6u5x5/DdMosjCSe/xuxd40YZvBeML2e32CnbMo6vE0=;
	b=WDdhzP7nSZ4gwcuF8xRnaWDK0yZPkmcj/2R1FN6/QMY/7V1bIVmo7ZiBx69N2+tXQKv/
	 UFC/Y72YdYA0qs1MmsfV38n2UYq1Vcd9YCTKtJT3rmPA+LmN8FOzadvMqKmFLGf6hdxVD
	 KdZB5HBPjn0Sc3M/12XUo7Z4mQx0c/c2hLhFwsgH3CNQinx0RM2oUPIq+T8UFH4fvSPEM
	 Ob1XHaTy//DlAURIbaTqGgGY/Luco9HK1pESiM40QimfunkA1+SfTum4nFppIkuXVam5B
	 bDe0IoFHCgWir6pdmTp8eEf2xmpz1f6hCbOpCnx1U0Mm6XB/qxwR7qxfsUAX6AsOxXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hdUGXGPM;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18337606A32E
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 10:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18337606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hdUGXGPM
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso22016055e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 02:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794653189; x=1795257989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C6u5x5/DdMosjCSe/xuxd40YZvBeML2e32CnbMo6vE0=;
        b=hdUGXGPMuzJATrP8CQSkwqN9F4guGypyou8IOW3tXduPT6zToglo1XbRnVGIWpH4BI
         7R3NcVrpUfo6gIU2cmt//UJMcdkBevGkd4AO3ni0x5nnnSinKZVGjcwH+1pgT/+Kx2ix
         2/xTYWjNJhilpyKHr23/dKzWSEXcNPFK3iaYZTPLeneJTNF85c0Wgo6dF3ZfyNjyjns0
         GeypPXZ0CHP4s1SP65d4U3Dh1asTNjj4/7XY1et7zN2CA4GAStlJzz3JX31eszb9paLz
         YGA6V0N5x0bBA6eJ2iq0NgcE8OUKTb5qX9WbskI0tqbPnSvE+i1gDpUHqTyY0TkIllVF
         +YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794653189; x=1795257989;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6u5x5/DdMosjCSe/xuxd40YZvBeML2e32CnbMo6vE0=;
        b=kj1h7fkVb4rX3wVUpbRuHL6bTdiLryt7Ucl8gV9u/jbydRWhBMBeQMY/uQ+j1aoWLD
         sN9PX5wZvapXS8REGDCxZqv9nXefPG0KMLwNIrUeYRkds1KSmzdFHDesuPZ5Vp+hhH7q
         ZBxnFObdYBOZcZjoPwPMzMyJXqbqCMT3fzI5oj/rjFcMYnStokq8ZSu5e4P6mgu77CcV
         fy4+mG3iP7Sj36pzzQotrveCnkwVtwsaKDUbKo8SR6r6+HxXLXEWE9gMwe9Jy2WMgXW6
         mbiathk/4dh3jwZEbAmNSAoUV17jlzufNVl/H2D8Tu4AMBh/L5OygYKBwYAtcXwGVtD6
         MdzQ==
X-Forwarded-Encrypted: i=1; AL+hErGOb2YETvRQVtoFTC9PpLSpxREPNXiS8kJK+oFTHeJtDF2XMz/7fMzA1Ic71AgD0VEm9qpMgNTCfWMzEO4Q@vger.kernel.org
X-Gm-Message-State: APuU4Z+0eGJpfZ4NAc0PbthiuowKxMNzaY4pRnXAUZ0NKFx8VrJ5D6L6
	JbPv7F4oxm+5CDJhwqdN5kJwfsrW3r10w9Iwe6n9mN3tVa7id57nzVec
X-Gm-Gg: AYBFou2Rc1y+uvAWKwKIQpVxd/qpFQB1mEYZqZ98+MUwPG+DG80NM1gnti+sEdQPUF6
	zKCBv9uWp7zzq8E5s5J2W/MxPNU8pZiWN9z/lyPx7/P3mePnSfT06wDqjgrJSxuKI57BIsGSsv6
	2H4utzInBixTar8ldHEPGAYELKs8a/UHp0CXCFkGWg+ChdC/8WbocJxkKfMvCZsXxt0XKkQxQgM
	wrnmCjHzmxrdjO1QH2pfPiW2qIzoa3yNP3097rN2k4BArk6yfIMe8Mtmzai3dvTk3JSHkVwT62v
	jpo37RaqwlTUknh43gsoI098s5z2i27PDrg5ExXk4n6EMQiGwFfPIaIyiuPv2w9jzw3lV4Kt0WQ
	Rwfrn8OzqhTSvNy6k/Ofe1SIOPio6+/d1RkfwXpeyIFyW2PVz9K5Ddycx+5mX99XKF31uP6OD++
	Pxd1x95fTL7tonKDfbB0wFaiq2WSqM3DCs6VVYg+1bXBQmyknj9qbQc724Vy1gVPlfhFROPlC/W
	hxpE7NhGpPES8/o4H64hCXodrLt42W61Zf8gOq6Aj8pVFoBrSkNCtFN1ID08cQACSNj7ButWUgy
	JHFlM8x7fsCzQ8IvBI7jeXjo6Y6+Fsmf8kPocHfgXe9OPHQ+IuEffMaQwZ3w0hlBzadpqJ5ENWE
	vhp3SWl1dfLHiyR6CD92mJJdh
X-Received: by 2002:a05:600c:e555:10b0:4a3:59c9:a747 with SMTP id 5b1f17b1804b1-4bb55a4e55emr76257775e9.17.1794653189422;
        Sat, 14 Nov 2026 02:46:29 -0800 (PST)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb609cc1b2sm45447055e9.11.2026.11.14.02.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 02:46:29 -0800 (PST)
From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven29@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
Subject: [RFC PATCH v3 1/2] fs: add filename_utimensat()
Date: Sat, 14 Nov 2026 11:46:20 +0100
Message-ID: <20261114104621.1186744-2-meven29@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114104621.1186744-1-meven29@gmail.com>
References: <20261114104621.1186744-1-meven29@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Méven Car <meven@kde.org>

Copy utilities that preserve timestamps, like cp -p or a file manager,
set the times of every copy after its last write. To do that through
io_uring, the request needs the utimensat() lookup on a name that was
imported at submission time.

io_uring takes the path of a request when it is submitted and looks it
up later, from a worker thread. The path ops it already has call the
filename_*() helpers of fs/namei.c with a struct filename. utimensat(2)
had no such helper: do_utimes_path() took the user pointer and imported
the name itself.

Split the lookup and the vfs_utimes() call out of do_utimes_path() into
filename_utimensat(), declared in fs/internal.h next to the other
filename_*() helpers. do_utimes_path() now only imports the name.

Signed-off-by: Méven Car <meven@kde.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/internal.h |  2 ++
 fs/utimes.c   | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index c658c8a5ebd5..985b2bc5895e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -63,6 +63,8 @@ int filename_mknodat(int dfd, struct filename *name, umode_t mode, unsigned int
 int filename_symlinkat(struct filename *from, int newdfd, struct filename *to);
 int filename_linkat(int olddfd, struct filename *old, int newdfd,
 			struct filename *new, int flags);
+int filename_utimensat(int dfd, struct filename *name,
+		       struct timespec64 *times, int flags);
 int vfs_tmpfile(struct mnt_idmap *idmap,
 		const struct path *parentpath,
 		struct file *file, umode_t mode);
diff --git a/fs/utimes.c b/fs/utimes.c
index e22664e4115f..8072f05ac8dc 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -79,8 +79,8 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 }
 EXPORT_SYMBOL_GPL(vfs_utimes);
 
-static int do_utimes_path(int dfd, const char __user *filename,
-		struct timespec64 *times, int flags)
+int filename_utimensat(int dfd, struct filename *name,
+		       struct timespec64 *times, int flags)
 {
 	struct path path;
 	int lookup_flags = 0, error;
@@ -91,7 +91,6 @@ static int do_utimes_path(int dfd, const char __user *filename,
 	if (!(flags & AT_SYMLINK_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
 
-	CLASS(filename_uflags, name)(filename, flags);
 retry:
 	error = filename_lookup(dfd, name, lookup_flags, &path, NULL);
 	if (error)
@@ -105,6 +104,13 @@ static int do_utimes_path(int dfd, const char __user *filename,
 	return error;
 }
 
+static int do_utimes_path(int dfd, const char __user *filename,
+		struct timespec64 *times, int flags)
+{
+	CLASS(filename_uflags, name)(filename, flags);
+	return filename_utimensat(dfd, name, times, flags);
+}
+
 static int do_utimes_fd(int fd, struct timespec64 *times, int flags)
 {
 	if (flags)
-- 
2.56.1

