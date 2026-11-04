Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789207;
	b=dcgJY3Y7DgYSK4EcxgGOhaI2CsSH50Leql4WNAN9R3Qopnu0I77B8mzIFbMVLl/VjKHI
	 wlwQHTVMQNdQL1uU/HDC2j3423KBdE9S6CJ/k1T4JLO1dHrcSVoZK6suIxSae3Ngf86GK
	 54JRgakogDN4c9VKNEn5nYoSDsZlfiFA08BcS9bHpov7mvx/1Yl1zndEDR+VyEoCcz+xE
	 Ii3e0JQbE6D9hBYOcDFqxyXZVLe6AYz71n0BwWTtgvuAuKrHG1Q2q7z8LuYzS62H2QGrs
	 HHS2fg5aKhukUff7Wo79/QL2ic52FDvZbv/0Y2D0Yo1/BgDmHqXqoKZGUWvIyYJIZcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HLh1868bM3xI6tmCVDDotZeFZNzZ5VuBhrB/LMUfaUQ=;
	b=3yB8WsD3MGHhDyMKlE6jQRP62YXOpnRDhExZKLkZukiK4N8pFzRVLJoWTngtaNfL/f5d
	 Ti4Idfg8e+Z9hFgI+7+mPKq3KADwHLnzybOxqZ58dGsMfoHxsZjubX1+E1cC6dvjk5X4b
	 hIj/sUFhu803th1Alc1/GK4xtlB1/y1Hw1WAYVNq3sXO2Oua7ZFGiJUMq4zWGhPpEm4PD
	 ZUub/2fg5LC6GZKWIPwQZr6QWnWHK6JGk9q3FXmYcw+69/kWh8OhSdYuDtASo0JREeeaM
	 caM3dYkvNEiewIZVC4wDFHi/IwaQlHoKeXOgPzNKbmrptVwA/PLv3fAo3ehArnZU0eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBmu7vWG;
	arc=none smtp.remote-ip=74.125.229.131
Received: from mail-dl2-f3.google.com (mail-dl2-f3.google.com [74.125.229.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661A606A335
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 10:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1661A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBmu7vWG
Received: by mail-dl2-f3.google.com with SMTP id a92af1059eb24-1b23f91cd75so292396c88.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 02:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793789206; x=1794394006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HLh1868bM3xI6tmCVDDotZeFZNzZ5VuBhrB/LMUfaUQ=;
        b=XBmu7vWGfccTPCZSJN6LJ1LcmTTbH2lkdS3TuZX0tBvcqvUZL/zfrqQDumoIisWL9a
         h1mSlQVMzAWwEw4Ul9Zpm6Go5YT6Eex48aDLDKrDo8npS3V/5W1MBA0MArp0Dry1R3GB
         jnZQyHyYf3XOVByhWUGYfEs8aolp7Xg2q1GCuw3ROcv1RkgeXlJCWtUjZsBaxBQ7uid6
         WIeEUsFtzohb+9SP1024P35VZEn5ckk3n3wSlVlTOMXfijU9YYIeQedKBUNJASHBxCe+
         cUISp6p7wjpjoCQHU+pXxSsEgIjjBOmdCNh8AhdUqpYMg9yM22juUXHjblDI5PX/EIYl
         B/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793789206; x=1794394006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLh1868bM3xI6tmCVDDotZeFZNzZ5VuBhrB/LMUfaUQ=;
        b=YwiE2FB45WhkIAlP/8RIfxsRvJJlVV9F4qaPC/xidogvEh7ykX8FMr6O8TOO9DyxC+
         5ctAxZ/pK+Y4EO9DhmsT6oYiWdcNYq1l46Humd/uk96cYzs3znPuhYo5HdNh3zM8JIBD
         Sn6d0theUIKmWpdp9Qmr3xFrTX8FclUCibhLwLmuAKZJjxEMtbvf4sJ6hUSkCdZ5WD/t
         g6+CNJuomc8taPQA/hBFdNsAVw9L6Z/1ZdAGtqfEu9dPvSc0WJICrOf9I7ydYHyoHBl9
         GhHgioRqEQJC3HIpeyh97A8N0g0vswG2CQAMG/FsnbzU8LNnvBIQvo+DtdlQiwi7E7RZ
         FaCQ==
X-Gm-Message-State: APuU4Z8u1ieHY3TZ/Gu9rio2RtyJdferABLh3mzhf9M9wudNNY5xe/Ll
	T361udkfYDi9EfplA3Na87Lxrmc/vxLE4q++lovVfX9rRl1zAhS0/Zcr
X-Gm-Gg: AYBFou3aUOSUmnx2SMQMEcA2UjyFF2Y/katU0CZQEpD35o7yiyo+Zd9NUIhTDUQJaHL
	SZk7ayXHUUhwPJQE4rFb3dUPzWK7hxOx7waEUlsB+JAU2PJDMYxESM3lYwMbkdir9ghu6y2eB4I
	IM83E+/YttiOmx7k/DJdRpGydNTNx/I4pouxO/LiYisdzhuR5pZexLaFYOGcO/2M3/z6HOu+O+O
	rCFy3PgK2NvapsxTenD9nXrqr6gKg5ur3X3CL5yBVVeEiCSvTSbonz7AeQWk7GFoL4AZGKzSUub
	epzUgOrEm8w+pcwmzv7EiU2sP19599QiOBMriHyPLz88PI0UCIzeylTtOynOvdJIZxMap0/hWsc
	udPOx4HQGTBDnGnT9WhUSCtiC1BA3xT2YpiGlRv3+I1lDtxOATF3ZORaH+g0wsxsRNO4/mzEzLd
	T0Jx6qY83xIgdaOyer9ShMZUzeNseoFr98xrGVOSsc7LYuPkNm4+AVx7YkfFj4j+Yz+VEj401T0
	TOqJuBxlx3aZ7sZg+wTEmcqJCEd1rKhiLwwc21W8X2yq37qdzCjPz3UW6SXP5tbywBEeB4Yx/Og
	cO8cw+kG5P+5/0WXo35M+4LE4oDsr2CyQV04QciDApInqeOTSKUzwluBk+wWes7QfLDyN/qSQ7z
	5YcHyeo1MNV18XxchTqMFOVam0xmC9+r9gb54mg==
X-Received: by 2002:a05:701b:4248:20b0:191:3c:aae7 with SMTP id a92af1059eb24-1ac5c64cb0emr24775668c88.26.1793789205904;
        Wed, 04 Nov 2026 02:46:45 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm8266549c88.21.2026.11.04.02.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:46:45 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: dsterba@suse.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] affs: honor copied length in OFS write_end
Date: Wed,  4 Nov 2026 10:37:02 +0000
Message-ID: <20261104103702.79093-1-dennylin0707@gmail.com>
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

affs_write_end_ofs() uses the requested length instead of the number of
bytes copied into the folio. It can therefore write data that was not
copied and report more bytes than the source iterator consumed.

generic_perform_write() then advances the file position without making
the corresponding progress through the source iterator. A one-byte
pwrite() from an unreadable buffer at EOF can repeatedly grow the file
instead of failing with EFAULT. Partial copies are overreported as well.

Limit the range written to the copied bytes. When nothing was copied,
unlock and put the folio without modifying block metadata or reporting
progress. Remove the obsolete comment: an uptodate destination folio does
not guarantee that the copy from the source succeeded.

Fixes: f2b6a16eb8f5 ("fs: affs convert to new aops")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/affs/file.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index 23e088a7ed4f..84f53ece87d6 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -700,15 +700,13 @@ static int affs_write_end_ofs(const struct kiocb *iocb,
 	u32 bidx, boff, bsize;
 	unsigned from, to;
 	u32 tmp;
-	int written;
+	int written = 0;
+
+	if (!copied)
+		goto err_first_bh;
 
 	from = pos & (PAGE_SIZE - 1);
-	to = from + len;
-	/*
-	 * XXX: not sure if this can handle short copies (len < copied), but
-	 * we don't have to, because the folio should always be uptodate here,
-	 * due to write_begin.
-	 */
+	to = from + copied;
 
 	pr_debug("%s(%llu, %llu, %llu)\n", __func__, inode->i_ino, pos,
 		 pos + len);
@@ -716,7 +714,6 @@ static int affs_write_end_ofs(const struct kiocb *iocb,
 	data = folio_address(folio);
 
 	bh = NULL;
-	written = 0;
 	tmp = (folio->index << PAGE_SHIFT) + from;
 	bidx = tmp / bsize;
 	boff = tmp % bsize;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

