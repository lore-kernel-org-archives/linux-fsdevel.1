Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B183A3821
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774718667; cv=none; b=NIR4d/MV2UBQjsN2hPgzM3BDoDixWRg94WHtPCufdHI+rw1XsQhgPaCBJ1vmkH2qGOtO6fwQccRfz+/3IvKPCDaPrs+yNXAW6U64H8NJdJ4LauEmNfMRkWE8BQTAbCyRFwMHjq8Pqr3cWuBxQ4c+oYHDiJ4ehOsH0WgbkvbTfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774718667; c=relaxed/simple;
	bh=Q9dm8LTnk+DFIEJAAB7tpFWixf8EizWYmak8EK7I1tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXXev4aSCflefnoxunrO4aiXZSQKD55QxDrMg5XxiEEzyXxNKDQdOsTu1YdCTQySZwqCSljvblSlF2Xs8Bhu+M92zx4FzU6GnSJJBctXW0flbRik/z6hFdbcFzsiJfTbavzUEawyxQn2PsSCZ/PFE/vG7n/mtzun42zAlLvjcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUHC39t5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUHC39t5"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso257675a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774718665; x=1775323465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=fUHC39t5SVFYPhzjdVkydSn6kkxLe/mQ3HnNYH/M5q3wq6Eoem2pwd7OqgnlJpwO+I
         p/mg53wMg9CJ2i8ZMMAWJuGt9mbPfa3mspXRaSxC7dEBgKRsM5EWJW1Umw8805nuLH1x
         kUvZWoYQ7QEleQ9S6i5L/U2m47KXH+m2Ld9THKApeMdTTV1A6THnMVIXevNDPgCzaPMv
         rBj672km8OsufCBY/xztP1co6wDvqD15FyUDMEPp15Xz5cnxylowDbInB/mSxjDP5kiT
         RgAHkTDt2k9W+GGrPwix3NpyxqfQaRE2k9rmYWyaNIBMT0YIRSDvd+t3q7qICRlLSVQO
         IPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774718665; x=1775323465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4HfR25bhfBsIe8RbNyIL8PstGgybd8nsB9r91rb4k4=;
        b=OpD1KDzz4OdnWYCkP8P1Nr8Z395G27cecubklLnRl3s2PLYMBk82/VcwQq+thvNAvV
         KgStvAiSFO7leUlEMZEyjdxU3AF+cXrB54rqylzyUw9AbpectSdqeUrT3qBLWb7sGI8g
         t/EoIDwzUCI/ZD0jWkVAcb02r8jP/R8Hx3gscObup0pP/IfEBdMY0MVcK272eRYrlyuv
         xMkcjuXrPcLjDjonuaf0tR3I7Ahot6wOBkA24bLpxP64DWDTDp/edBKqy80Q8MQlp8Cs
         1V+Ylu1N+d4yQFP6iOTlUxbW8vxNGmUrynOOw7hFaxeDspXrFQDDzSyVJg+1mOTTwn+0
         59KA==
X-Gm-Message-State: AOJu0YxaSB/+h6AjMPyBx5CW85B7j52d7/Mq7W30Su+cQ+Bxjhf5gRZ+
	LORFvADVkiL4/cEihYR5Y2v0Y+K4FQvMUFcDYoLPqKcAzK0NnZpjzuPrCGq8wJxs
X-Gm-Gg: ATEYQzy3h5YV2YfyX8HfC+mX/pmes/4jA3C9PNmQ76F3kNBGjY3aBz7g53ZDtsq8sLS
	SmeZ0xx70Lv/98V9dRGJWcH+R15PtuSE1DbypT1VUYSg4sg1+ZaObVmf00oxykCEQBbRD1/9mES
	QouFELFjBPa4ZAK26TQG7yOlfbwNVUihnprDoPKfpPvY/TpUcQN5/NBWD4U6Ok/PP5psLmIBAjl
	VdwZf0aC7TgWASuTTrtRFXwk9LjQOkwmj1w7T/QPw+hBtwl7jvaesIcUM9KzXTDI9Tu8w6I+IdD
	/Q9cUOqGh1PI/YrdIFoey25DY436JZ/r49ctT5uk8vocdufsH/TQvRPL3sie8IBusAuMbV0tTfp
	CLmkU82F4e0/ZTv/GDsuglaF1Ps/M8ptZGC/akDOrYR84LIVSlZpRaHJR90mrjmW+lZWxZOyj0e
	ynMGgw5WxBQKSLnjpfWPpuMSF5gMqtVHFj7fF7ZJE2GH7mPBxxz8Cf06o=
X-Received: by 2002:a17:90b:3ec6:b0:35b:9397:7073 with SMTP id 98e67ed59e1d1-35c30126798mr6566152a91.30.1774718664565;
        Sat, 28 Mar 2026 10:24:24 -0700 (PDT)
Received: from toolbx ([103.103.35.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a5570esm10513773a91.3.2026.03.28.10.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:24:24 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v6 3/4] sparc/fcntl.h: convert O_* flag macros from hex to octal
Date: Sat, 28 Mar 2026 23:22:24 +0600
Message-ID: <20260328172314.45807-4-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328172314.45807-1-dorjoychy111@gmail.com>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the convention in include/uapi/asm-generic/fcntl.h and other
architecture specific arch/*/include/uapi/asm/fcntl.h files.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/sparc/include/uapi/asm/fcntl.h | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index bb6e9fa94bc9..33ce58ec57f6 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -2,23 +2,23 @@
 #ifndef _SPARC_FCNTL_H
 #define _SPARC_FCNTL_H
 
-#define O_APPEND	0x0008
-#define FASYNC		0x0040	/* fcntl, for BSD compatibility */
-#define O_CREAT		0x0200	/* not fcntl */
-#define O_TRUNC		0x0400	/* not fcntl */
-#define O_EXCL		0x0800	/* not fcntl */
-#define O_DSYNC		0x2000	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x4000
+#define O_APPEND	0000000010
+#define FASYNC		0000000100	/* fcntl, for BSD compatibility */
+#define O_CREAT		0000001000	/* not fcntl */
+#define O_TRUNC		0000002000	/* not fcntl */
+#define O_EXCL		0000004000	/* not fcntl */
+#define O_DSYNC		0000020000	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	0000040000
 #if defined(__sparc__) && defined(__arch64__)
-#define O_NDELAY	0x0004
+#define O_NDELAY	0000000004
 #else
-#define O_NDELAY	(0x0004 | O_NONBLOCK)
+#define O_NDELAY	(0000000004 | O_NONBLOCK)
 #endif
-#define O_NOCTTY	0x8000	/* not fcntl */
-#define O_LARGEFILE	0x40000
-#define O_DIRECT        0x100000 /* direct disk access hint */
-#define O_NOATIME	0x200000
-#define O_CLOEXEC	0x400000
+#define O_NOCTTY	0000100000	/* not fcntl */
+#define O_LARGEFILE	0001000000
+#define O_DIRECT        0004000000 /* direct disk access hint */
+#define O_NOATIME	0010000000
+#define O_CLOEXEC	0020000000
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -32,12 +32,12 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x800000
+#define __O_SYNC	0040000000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
 
-#define O_PATH		0x1000000
-#define __O_TMPFILE	0x2000000
-#define OPENAT2_REGULAR	0x4000000
+#define O_PATH		0100000000
+#define __O_TMPFILE	0200000000
+#define OPENAT2_REGULAR	0400000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
-- 
2.53.0

