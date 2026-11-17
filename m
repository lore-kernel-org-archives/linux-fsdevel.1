Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923537;
	b=kJ7ARL8gRnZofLlh33ZW8p5p/0vXIFOMY0E/xQWJa1inkMCTWaxyYERteJotOn6ewxeL
	 UcilWB8/OT/FrYvyrz/xiCDcwPTObTe51wyhHvAf9hHghwhruP7houlRo6Xh1OwKA9C/r
	 d+7/9LpGMtgpSbR47H/AxKPrWAEHnCO+8xYyIk5xwNgfrOCQm3nXT+L+J+WZTtC+ZvKUv
	 hFxE1Vo+cmIVMYqkLoCLswlgFYnX4UvBvpq0GwftPH67lN9fc0CDut1KHX9JVsxk4B4R+
	 cW8RyPfg5F+BjXoS5kQc4Q0SvvS/OwKKOx2N17hbNrN/1nxZ5Jc7ewrAVeK75metx6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qEwXXgzCb9umMJN15TTOelMx6FvsKuxkJvNzraJF4vw=;
	b=Uq1gh4ywAF1wJqUv5Z/ctpTA6wSIzXvj+cNXzYh4qf1Md1TLaJEPpGA3cRD+J6HKaThV
	 pQByYt2XF8S+yJFjs35bf73TGy/9LylkKBTaFuO2I2HD3GXgo34GgO9ojS2Oaw7SA0J6b
	 K5EvO+gxEbg85vC3WcmEvy8OPifYLvnqkQQ9WuQR1afMlf8LXXOkIjT3tkbfb3QaFaRRo
	 TPrjrnMelVJOE9R4fTsyr5lfauUiTzQzgRNz2JQKpngV0ha4EPTYdp+jkX/m0/aQhMIdX
	 xlgTa3zZ9/RdwZasFEiW/9Z5FCs3wXXWCJF6NiU0zxVm8pB9aLpKn3xQGEAqx+6gMMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7Urt3aV;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC67606A331
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 13:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BC67606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7Urt3aV
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9e53d011eso41306645ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 05:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794923536; x=1795528336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qEwXXgzCb9umMJN15TTOelMx6FvsKuxkJvNzraJF4vw=;
        b=F7Urt3aVliZhyCp3tG/lsK08lCuZYAIvCyon27UzKBJ4vX2TDyEbDkrjD6R2bbeqwf
         4mVnMlK23NJQmANKWMGu9UDqvHN6ZfPKk7Zb1zoR88x8rGA7grG9meGGkdnEkWLvfG5/
         cb4TzFxZBroymBY0paTX6tNotqPiSSuNKJKqHVqAB0EF2Are/IBYCSUZPwTTvRHyfZl6
         2+QnfBN4Lwg5jAs+I8oq+qaXqMOZd8Sw7M3o6bXKKdt6LiKaloeIscGRxHVNtriipsQq
         mqLJ5b8/XyCqieOo4nGQnSPtbvtGd84W73cqTqwgs+DfoOx5Y63myZJj5j7YsGMBaF2o
         pfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794923536; x=1795528336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qEwXXgzCb9umMJN15TTOelMx6FvsKuxkJvNzraJF4vw=;
        b=rixKYNim3gB78yfdwQ/SbzmPw+Emb3H+dN1tTg6XeUa8mGI1aTjFaZKBpouhWtTGry
         O2I5K2sHWsi7NQMMybUsu9E2A7KlheZFTgk9MTM/eEZLzN2v3+H14myZRqqyN0LqmyNS
         YuhZ+0qbOBY7OqK9SdAGXaz4ymqe950QgKWHF0zN4Ao6hwjumdt3sNrT84f6TqXQ4C7g
         eFT6Ypczg2M316+i7cKxl+kkg2FvSl5E+e/I10N/GRe5rXTDMZJ5fYnl/G/l/0lhDdrc
         CcEOpcV+ktPOJFqe/SQXlDciy7jOVNBWXrXZlYALR+UzcoRqlq/L4vr3lKgDid8q1+1T
         c20g==
X-Forwarded-Encrypted: i=1; AL+hErHWDv6NcPLsTl4bKXnKR6OPmNgy6KBA945CI1L576S/w5zxnuot9ZS20G4GmvcFS2GIGZx58vxGJWkI+gBO@vger.kernel.org
X-Gm-Message-State: APuU4Z/AdbFKrKeqtV4q97qf8KUE69B+kYux2NfzTszgyU1zyXqspmXM
	rLv1RmpbFc8pLoFuqu/zjiedYq5VwQMXIcMSH9JshkUwDk3/g/X+S4OP
X-Gm-Gg: AZFdTZclBF4I39jFAE6SdzZnQXxVbQvWkwBYmynl3lEeVqEiko1YTLAGx7xfN43aNoO
	oPrlR5xzs2CnRWSA5YE+1hzFsiU6OiyP0HpNk1uZLCLcuzIijc72p6CyWt6tfJhpxi6qmq25TEI
	BRBlldEd2KmcyC7RPsfwsw+xvSeYDy9XU/t1M9jBXLFYPhPKYZpmmCsQm3XhIsYB2WjxqBSiBwQ
	p+DJaruRpqZK6yiBYQy+aMVb3UquSr/EW8VqRkYqUDiJBko0XE18f730cZptA7pFdfRDIYA517u
	25PE9Dz0M6MYAC4M/bTbzapJgEVukKy+F+UQbWw2tO82bfYrgH87KA9M++HDr/IjhGNsMC9i5rb
	cEp7Y+U9fCAIWmWozw2/mhMckmIFaTsoHMc/OjzjR0e/ReHsR/T3wBBfOJ9FrjZnjpMlmmhcepm
	esQrxDbBlzILkchwlJXZjsRpzaJ/yB7RX3caGKulvzJ3TYk8VP6WpwLtCwBsF0URl2k0fuebOLt
	4idIFFXB7+YyuZWkWoNtWJ2idX6WUh9NEN0eDPsvGBB9Ogs9g3puHrOCyx5Mb72h6g4jMFsWPsA
	CV8AHANA7P7x1xPaWmOMHru0a9rLA75e/DmuzUFGn3sQvE2ZRQ==
X-Received: by 2002:a17:903:1846:b0:2d9:599e:df95 with SMTP id d9443c01a7336-2ee0d6600acmr138465855ad.3.1794923536549;
        Tue, 17 Nov 2026 05:52:16 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a586c1sm15937035ad.43.2026.11.17.05.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:52:16 -0800 (PST)
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
Subject: [PATCH v2 3/3] fanotify: copy full qstr length for copied event names
Date: Tue, 17 Nov 2026 22:51:37 +0900
Message-ID: <20261117135146.3174252-4-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
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

fanotify_alloc_name_event() reserves name->len + 1 bytes for each
copied name in a kvmalloc() event.  fanotify_info_copy_name() and
fanotify_info_copy_name2() use strscpy(), which stops at an embedded NUL
and leaves the remaining name bytes uninitialized.  With the original
length stored in info->name_len or info->name2_len,
copy_fid_info_to_user() copies name_len + 1 bytes to userspace, leaking
uninitialized kernel heap memory.

Use memcpy() for the full qstr length and write the terminator
separately, consistent with __d_alloc() and d_path().

Fixes: 929943b38daf ("fanotify: add support for FAN_REPORT_NAME")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
Changes in v2:
- Use memcpy() for both copied names, as suggested by Amir Goldstein.
- Write each terminator explicitly without reading past the source qstr.

FUSE fanotify mark setup on a zero-fsid mount returned -ENODEV; the
normal-name FAN_REPORT_DFID_NAME and FAN_RENAME paths were tested on tmpfs.

 fs/notify/fanotify/fanotify.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index c25cf5c1fc70..2d6b5c2c6f25 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -221,18 +221,26 @@ static inline void fanotify_info_set_file_fh(struct fanotify_info *info,
 static inline void fanotify_info_copy_name(struct fanotify_info *info,
 					   const struct qstr *name)
 {
+	char *dst;
+
 	if (WARN_ON_ONCE(info->name2_len > 0))
 		return;
 
 	info->name_len = name->len;
-	strscpy(fanotify_info_name(info), name->name, name->len + 1);
+	dst = fanotify_info_name(info);
+	memcpy(dst, name->name, name->len);
+	dst[name->len] = '\0';
 }
 
 static inline void fanotify_info_copy_name2(struct fanotify_info *info,
 					    const struct qstr *name)
 {
+	char *dst;
+
 	info->name2_len = name->len;
-	strscpy(fanotify_info_name2(info), name->name, name->len + 1);
+	dst = fanotify_info_name2(info);
+	memcpy(dst, name->name, name->len);
+	dst[name->len] = '\0';
 }
 
 /*
