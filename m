Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969319;
	b=zXIvmYJc/hXbCk/iEfxQtlmzXqhCFSd6ow7DPYfS/wTi5lCywEM6ZW9AH1kVy2D/KcqU
	 McpCHvLUh3EMNvajHV6jkWBLaqyIp3pAtDamy2iYCA2Tb673SEa38oDNd3UvvY2Z0xnX2
	 8oqi5pDgP+psXzEbRMIy/FrqS7139AR1bEppKA3x2lLP8CvwjLP3V07/4KQPrEPcE+52u
	 Rlr0xiROGeSoVXRJDme9fcrANZKMSYdEBjjxd5s8dU8AclfyGW+QSVW7cTB669LQKpTzo
	 e0KMBtPSlRRyW0yXPXqHvimSUaiyxSlVIN2FCXjH5n8SdtAcDb2rc12FpOdlIYK/iVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AW6pi0Cj9ME2bkQXK4xo+E+sfPR5KEsKdLAIxsgAUfs=;
	b=Lrls1O3bKTKuTkjNSDSzsUjDdHTo19LqeD07jJiWfOmRQwhqwOlsKHRfvkGzzAr+IryX
	 Y8vgZwEiMw0eTQsB1ViTFBF3IrZoq6pEZfPrii5T4WmXJUCgx6Zywadiw6fbub4txsG1q
	 gzQUOb4RnuJzlQreGT3J+31IKberBzqOf44f7kS7pDjVlLiHS3BkjwH1nj3Y4z7xkDMab
	 e+h1aZr+pdHwjw55HeAEJT9OTIUOlNv6IuGmQ0rmRfc82DWqJM1frVMYEhvHUaXY4Mikf
	 uxSBlhTN8bcjT7Y526/wpXhJWwkQVzhHDZcKqKviyDZSITBbfXt5m/ocEWLgyuvaw6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wkJq7lQn;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E8606A325
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 02:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB8E8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wkJq7lQn
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33fb4680717so1228546eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 18:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794969318; x=1795574118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AW6pi0Cj9ME2bkQXK4xo+E+sfPR5KEsKdLAIxsgAUfs=;
        b=wkJq7lQn7jQbkhb7zUt0fj8NVtNITkZPbZUlllr6I1BSMNVSomoPkPHuULigCx6/H+
         6wCbCjAImlBRRmDlIx075Jf1YRIrwKqHGdUwUvp3IrJOcuYGIghy0wS5tykRJ6L2mRiI
         ooHfah1NRrv3sfiWb7wa6djmy3H3REuy56MrF4Ip+ic2VJuD7Nh5AezM/6YAnryz68zE
         wBBbBLoQ20Wi8wGz2XNJR1kg24vMRIqyp5Uaqw/20vA4sDPcN9R2xoGi6jgoPXrksu/u
         ZI/B7ypPmiyvm2h5qf7iTfj0mjNzM15rVcend8xmG3Rrx3Q9atB9SCDQXfBjF7fSWwLA
         KzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794969318; x=1795574118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AW6pi0Cj9ME2bkQXK4xo+E+sfPR5KEsKdLAIxsgAUfs=;
        b=eFZEMZaQW9jQ1jUwLD/ctqtsLtyv0M+i1pwekTqid4SEwkEsN2yh7E3jh23UJTyKFB
         2XiNx/UB9J3Wk83cyM7KddGVNoZJUJllpQ90po013tIqllE/MS/gcvS6EPBb857BfyLW
         /wT6e0KgudU4Q+6m/AcH2FzuldgXGg2yiSz5Z4u8fwKRqXmpF3rEsBhp4WGY0E7ROc08
         oNIi5fpemY3GkywWytnOa5iKMevUFBxq8ykMlBIE6PtYKQvZ6m44v3SWCcTCq9Rr/a5z
         tQMzwsbFCo/Uh5tuR9EVx8SU8C0Ua2i5gQ6poqmqpCF+JZo6/rI1JfKQPE8V4HuuLWVP
         RRTw==
X-Forwarded-Encrypted: i=1; AL+hErF+QPFyZCiBNUL0NyEEhOGXeAMzu9guyTXG/tzNWHxaFuC7n20KEX2D69tlojhDytnT9bWx85V4lF/+/Ent@vger.kernel.org
X-Gm-Message-State: APuU4Z/FqQDz82Yf30pIilOqG6KCvMZFgCrERcZPaPpOCuM6XaFROrgY
	tTPFMaA5jywzK0/YxPXYku3GNYcs7c3Clv2f+CDpQvbi2TpWRP5MA54eiKcx8GxA
X-Gm-Gg: AZFdTZfytajbQDum9prpr6ciMV+zdttNaptopr8ZtNIlOXcyVEJ+TU+z6rPvulmbU8W
	SMfIfCXh8ryawZsLAne8eVYwC9RPcBCRnOxQOxDLcduzU5cDHGJclIGO0CnD5LlGG6j8if8uoCD
	XVhL8L5jC8MsqP2M5g8+DXDIKT7QQOYVIelHg5kv/pJ02AnsLyZDjOU0CbpMEan9O97q4ZmjK1c
	CaYEETa2InmzpHOX2pim4tdL/Xs9CBPOisRp0GyqaIhwu+uqdtgcuX7wKAWW78J0VhGgWZ5lKSQ
	A9U0xVEm9H9sbzI4b2kANL9+yptZE+NBu29OIlLYpe5aYbu1yOAWW2pugXNydQ1ZmsM58KZJXWT
	/yXqVwIBfKvQ7yXu7pS14hyRikgLByuFgKpN1sBnNMyvTsoh3qdQoUvxTPEKxvYBECoUtCj6npZ
	KsVnSN1AZEGwDK6EeQzbOgfjWX6goFRE459WWPlV4eBq73gDNzx9LpV5foH8iAA2rAuivEiOBOO
	QyOp7EbvdrmxX3hIkNrQKLmPImOXuNclbTVtif071IuZSsHqAAJ5CvpgNhSCq6lfnazehsxPl/5
	+uRATpzGBRhyleEf6DsLwb17lOW/
X-Received: by 2002:a05:7300:fe09:b0:382:4c1e:1c1a with SMTP id 5a478bee46e88-3828151fe38mr1178823eec.40.1794969317550;
        Tue, 17 Nov 2026 18:35:17 -0800 (PST)
Received: from ubuntu.. ([2405:201:8026:213e:efcf:4622:136c:bde5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6304ff2sm2240332eec.6.2026.11.17.18.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 18:35:17 -0800 (PST)
From: mdshahid03@gmail.com
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] fs: sync: fix overflow check in sync_file_range()
Date: Wed, 18 Nov 2026 08:04:52 +0530
Message-ID: <20261118023452.48090-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Mohammad Shahid <mdshahid03@gmail.com>

The addition of offset and nbytes can overflow before the result
is checked.

Use check_add_overflow() to detect the overflow safely during
addition.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 fs/sync.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 4a84dd837b86..9497604d7b17 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/namei.h>
+#include <linux/overflow.h>
 #include <linux/sched.h>
 #include <linux/writeback.h>
 #include <linux/syscalls.h>
@@ -233,11 +234,13 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 	if (flags & ~VALID_FLAGS)
 		goto out;
 
-	endbyte = offset + nbytes;
+	if (offset < 0)
+		goto out;
 
-	if ((s64)offset < 0)
+	if (check_add_overflow(offset, nbytes, &endbyte))
 		goto out;
-	if ((s64)endbyte < 0)
+
+	if (endbyte < 0)
 		goto out;
 	if (endbyte < offset)
 		goto out;
-- 
2.43.0

