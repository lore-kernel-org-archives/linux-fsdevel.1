Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7543E1233
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334339; cv=none; b=rtP8Uu4C6pOlZFFMoaAFF4X9iWjHgJ421TxRH4N795FBh//s4XqWSqWc+T3BFjf/MqelYK3WVgPzlKlLls4LKAVCL2xLeI7Pu1hSCTBIgrW8BXqRSOJsVGABzALsiIw1XvR/zhhTYJ4k4kUTmOaX+i8WfSZmQQeTse2GcKksVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334339; c=relaxed/simple;
	bh=fOk2uLz0kp+du9hIijEy96gF+mn97snUxPEaHV9jQ3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1WL5ia/yAhciOelyD6uTG/Mm5PyEqF8zPbKeuWyXmq/9zGJIW3Djn2ygyPTOHVb78B2xJ0w5YOVhk7Av8P40EhoxzBgLfZI8BEuyVWc2wxFRMGF/N0IjlFlYlbrC3oqKasvH2CFtNSqhLZiPfniiAUXJRHmaavtRgIeTgmlonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEVq5bBg; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEVq5bBg"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4471b489240so602849fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782334335; x=1782939135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cT8XyovIujOpRgJEtF3RzCkx+q1q0m2DrqWUvg8EN24=;
        b=FEVq5bBgVCzKJLhwX5P/uOhsqSxgsptRqAdjw2Ni9Fk9+2p+3RzPhHeq1HFDc4Y+Ij
         XdKXCcJCPFEu8VlcHZtqpYl6eqHL0gNHQNbQvwttEtUVuoXFV7A6H1hIQRrRpKulXefQ
         y8itUW/P21mIF7L2dNfIkmYQnXSZnbzrJBs9jtNEbvwRQUcXlTjilffb68CdzwfFQPji
         iZP0s5ZuaQuXh4kaYhS0BHgHxxeQlA9YaEkzC5Hrf7T6m32VVigyI0kPdTLfk7PQXbLd
         aaEyw8L/9ySKaRsDpvuAiGD+Nh7idELHwQ9BaXGr4+tNQSRrUKBeOgOk+Tvle4mPR92n
         58NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782334335; x=1782939135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT8XyovIujOpRgJEtF3RzCkx+q1q0m2DrqWUvg8EN24=;
        b=XHUuhdvtdgmwrUKAGr/h/PxqUBqXpja2Hq9IhrYMWVITpjPq5MCsX+zG88r5SLvaZH
         xXeiplOSFRijpk1WG8SpUPP62wbBgwwjHBLihX4ruFemWq7Ym9pHfOmdAkJmUO5eIsur
         S7S2gsTr7vkFxnlkFpaGmHHA+T0MLHW887UN/sDYrTuIRGX0WiTNec7aqH8hKsiwbjBk
         AWRZXxqZE73xpSzJWiYQDqE2TNlEZhMxU0Q2EMpeG5FlIFglq9EwoOsHw7kbSDBLsR70
         t5b4gJtPOOg2XG2qH8lFLBwQYzawARgtIvlXz4KQq1yMnfhyogtHotHsaGd1ddvhkOC3
         MKeA==
X-Forwarded-Encrypted: i=1; AFNElJ/rfzc2gLS5ZzsVnVkCxS49i6sSnM+KS4kc65Zf2XUmmJKEnS0qvofyin/F0MeV5zCzGGWPTti+BC4ifmG8@vger.kernel.org
X-Gm-Message-State: AOJu0YwwxmSrEORLisSB3tEWpVQ1JjhG+3i7bJOowYbhb/+GINMauKC2
	YHAmwc63q+Y2hhYC7jyacWpU2LVj+4DAqcpMPoXcl/b2vyNZwPRlmTpi
X-Gm-Gg: AfdE7cnnfA37BPEClIOsZfkgxZfUcIPaR0cUGoKLpFqqmm8j1TzU2TxLvz5jQlqmAwI
	3hZq5t/bEe8Y7PNHnA9u165bsGq9wx4zHRhyx93UdlFQtEX1gwkj/idEY1dWaWq5FMjryXKlU79
	e4DRNWtG/ywxtqQIUQWLsuMeSz/GmqXsZ430KCar3xscgS0C9H8jGY365Q8p/bW1vQlZkNfy2ho
	HP2tCMVgI0iShuy7mcOAej3h50/Ite1trY5difsogGe1tQJHxqfGe+YvEvuWmBV6556xKzS0mUw
	Xr3vZTs5SIl0+Yr2l+f9t8w48QBRGqYcCRMB0GPMr0mhsvsR6VhPmTO05a7uNHxhrnLb9MFprHO
	ZRbJEodfLSbLS7r3vtfSZ2eFLngZdI5A4HRTIBakpOu/dGN9uisCEprt4URlZrrdNKU3XfDhk+S
	SOZUy+2FNpLfy0gIhmuPkrwO8mZT/L8wg+HPnHN2sFu8SlwLJHEG1ueyMbZTX5ztTQ
X-Received: by 2002:a05:6871:890:b0:43d:7b24:95 with SMTP id 586e51a60fabf-447dc653ffbmr3634916fac.0.1782334334934;
        Wed, 24 Jun 2026 13:52:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5d::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44778b6159fsm7756695fac.11.2026.06.24.13.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 13:52:14 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	willy@infradead.org,
	hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] fuse: don't clear folio uptodate on writethrough errors
Date: Wed, 24 Jun 2026 13:52:01 -0700
Message-ID: <20260624205201.842714-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the writethrough path (fuse_send_write_pages()), if the write to the
server failed or was a short write, the uptodate flag on the folios are
cleared.

As explained by Matthew in [1], this is dangerous because the folio may
be mapped into userspace. The mm code has the invariant that a
non-uptodate folio must never be visible to userspace (to avoid
potentially leaking confidental information to userspace) and has checks
in place for this that if violated can bring down the whole machine.

Practically speaking, the effect of this change for the fuse
writethrough error path is that if an application does a write and then
the server fails to persist the data or only services a short write, the
page cache folio keeps the data the application wrote instead of being
reverted to the server's contents on the next read. The failure is still
reported to the application synchronously through the short count /
error return of the write() syscall. Folios that were only partially
written are unaffected since they were never marked uptodate in the
first place (fuse_fill_write_page() only marks a folio as uptodate if
the whole folio was written to).

[1] https://lore.kernel.org/linux-fsdevel/ajtPMgO65FA1TXhi@casper.infradead.org/

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index cb8da4c06d17..c4ae4009a423 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1227,8 +1227,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
-	unsigned int offset, i;
-	bool short_write;
+	unsigned int i;
 	int err;
 
 	for (i = 0; i < ap->num_folios; i++)
@@ -1243,24 +1242,9 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	if (!err && ia->write.out.size > count)
 		err = -EIO;
 
-	short_write = ia->write.out.size < count;
-	offset = ap->descs[0].offset;
-	count = ia->write.out.size;
 	for (i = 0; i < ap->num_folios; i++) {
 		struct folio *folio = ap->folios[i];
 
-		if (err) {
-			folio_clear_uptodate(folio);
-		} else {
-			if (count >= folio_size(folio) - offset)
-				count -= folio_size(folio) - offset;
-			else {
-				if (short_write)
-					folio_clear_uptodate(folio);
-				count = 0;
-			}
-			offset = 0;
-		}
 		if (ia->write.folio_locked && (i == ap->num_folios - 1))
 			folio_unlock(folio);
 		folio_put(folio);
-- 
2.52.0

