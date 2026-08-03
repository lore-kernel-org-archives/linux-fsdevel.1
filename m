Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E67314D13
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786390; cv=none; b=ae9WavLPaqzQsFa61LG0RiBvD7NYeHii4lQbHSE7bjjbTTiD18KYJS5iBIl+hr8U488BYOsvMN8uniP+zLuxyzJZMgLVdDLSotatJxtKMMaqHVroF9ciJC7Jfplq8LeBKjPzVPRJvVYjOogYOAO9b6zuk/NrPa7cJExurpsYFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786390; c=relaxed/simple;
	bh=typ9Azzk008ITRlZw56fyhTb4AIIzw4bA/fCdMQJi0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NFWQjzEf3t/EXpjyqc1rLg1BH4dln1TMkycdZ+pOGUgyR8LqVqlMoJ6A1y9fSWCYopnBnzXR2kYdOZFpya/w+hCoAll95vKBX4+w3JdJBxuvL2WOCHUbfeKL3bnO3hLCZB2mPlsu9mSk7Kv4Dwv0rXIn8ua2xZrpEy84UTsSii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXJt9iHB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXJt9iHB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-498012a61f6so12835e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785786387; x=1786391187; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XYjmDiw2VbLsmJPIgyiXAfWmLhwTUZnrbCHzr6uykSs=;
        b=TXJt9iHBViOy+KtPBKoqQK75eo3IYqm1AQhs0eHrHRyyI5pRp4TWNFAY9Mvl89aQqX
         XEKJuT5arufSK3AQQEo/szq8SKExuP6nPcOhKozauFoU2spOmyXxkfc0vfl7WFcR+gTY
         hYvrPCLDLyQp9Y81UPkmyN/Z7QFQRkdqlr5EIT7QgYq7Tyw+dCTE3QK2avyBHdFUUecR
         zai1xeSabSU3rb8UWDndR8MQjqegLk7dMjNOtQFOfn9K2+5+mNgO/GR6a1HVFldDoY49
         orCf6rfh+4YHUHOG2LXLXBHdUUsE5u0n4jWPus+hIuizYjVhJJ/jlibRzXgPeVS3o9MW
         bkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785786387; x=1786391187;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XYjmDiw2VbLsmJPIgyiXAfWmLhwTUZnrbCHzr6uykSs=;
        b=UuFkr5DdSwCHJbK6pNM6C1UnIGvLCxqyGLJfHO8IWPtIV0X4zULiqg4IU14V7X3Zq8
         OCi3//AYW0UB7Y6nLdw7q1Mw6sO3l4kvl5jwO2n+ejzsbl9y8WcO3HrDAzQr3NrCkbls
         70o4rvY/hWsLpGzajUtloEWEd6a0rjJWpsg+kQR0cNtSlDN8XxP/NQe2v74t7LcQvWs1
         vxZYSOjSneIJH66MNRHn2OAjehhogk6vwi2TI+EoLAoFd05w9DwSnEXuAw2TG+s1ELBM
         tktvTGCXxgY+folZlZXK7GWPp2X6pWPF04a9ucDWkG/WEqLCo+6gXt2gIdGAPdGnLELS
         lbsA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+SbR0YC3lQvtMq/5c09q3pOrPYm/mf5V6CIktJds4XOku8VQEBsI/6Vfqosv0PrJBux7J6R0ANEatK30r@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVooarOWOoKO1vYifJ5vxyAtCMSbq5VJRTzOnOxQ7KQDa+2x1
	0r4imR08TmkRH492HTk7V4T0RSgpr/esEM+/eBrJxjxqvHfMSwaRB6kw9woQAjd3DQ==
X-Gm-Gg: AR+sD123tg3xSgRs3vMSg87I0F43ATQ/BkmxHP+GUOQ6znNDPUcTne82NZwyYc/vp9s
	L7mW3MVuKVX0jopdx0cekDYFcIxtwlvQ8k8+OjOVN3qeWWVNEti0v1z5uBu2eHrDrcBwD0o96JR
	GhxeJsJ0Pzs7ai5Y1WiPBh5MMo37t9XhI0Xn5I0FrGRuXT6sw7w2yXKPDNLf+9KSzBHd05tviVR
	WML27wz3hSNIlvSYXgBAHOL2idFRo05hZJ6/iEXtOxpjpAvCdhaXimE+3JQQ5LiHoM6hnie97Zp
	7lJ23s2rZLMu5M0GZ3pnLh7Z0WBaZRqR9pHRpKWSmnwbXBBIICKKNGlc+xxzXSV+sMc7UWGrVV8
	RwfapkvFbjoSEtUOFWsQzGmfzb93gXz1+oggF1uk1SGIzXwITP/1wOXkXwPoY7GwVn9RpUqsIc0
	BNqaLHZWffPgEQpVGIMiST4C6XoOz2ivnw3MYYRnwTr5enPyxrWnbWzT2l0+eUTekfKdjca8FW2
	rpw44pi6Le3dLxzHK3nz0MUNRlZNznVPIfJ0yEEL7DLKGDHzj8Sg2m3l7w=
X-Received: by 2002:a05:600d:101:b0:493:aca0:32e2 with SMTP id 5b1f17b1804b1-4994a33d363mr207745e9.4.1785786386648;
        Mon, 03 Aug 2026 12:46:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:28e5:f164:de97:d72f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b86sm17257885e9.10.2026.08.03.12.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:46:25 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 03 Aug 2026 21:46:19 +0200
Subject: [PATCH] fs: document semantics of kstat::{uid,gid} fields
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-vfs-comment-stat-uid-v1-1-162d062b737c@google.com>
X-B4-Tracking: v=1; b=H4sIAArwcGoC/yXMQQqDMBBA0avIrDuQqtjoVYqLmEzaKRglE0UQ7
 260y7f4fwehyCTQFTtEWll4ChnPRwH2a8KHkF02lKpslFYVrl7QTuNIIaEkk3Bhh2Rap1+1b6t
 GQ07nSJ63e/vu/5Zl+JFN1wuO4wQ3aPwweAAAAA==
X-Change-ID: 20260803-vfs-comment-stat-uid-ea9d874f9368
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785786382; l=2128;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=typ9Azzk008ITRlZw56fyhTb4AIIzw4bA/fCdMQJi0M=;
 b=8eOftUoJmeL4qbf244FvXp4URGvEKeoGrpwx+VLB8M7Vv86w2G348lZxw23kLOz9sIGHJ7kaW
 cE1rf+DvnmHA+vcZ8T6KnvKV3oTf3C3OSlQbIPklE4C9zVFql8/hwmK
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The uid stored in struct kstat is logically a vfsuid; file systems
initialize it by converting a kuid (filesystem perspective) to a vfsuid
(mount perspective), then use vfsuid_into_kuid(), which essentially just
typecasts from vfsuid to kuid.

For now, just add a comment to note this mismatch between C type and
semantic type.

Below are some notes for anyone who wants to refactor this in the future.

There are probably two options to refactor this away:

1. Change the type of kstat::uid to vfsuid_t, and perform the conversion
   from vfsuid to userspace-uid in the VFS layer. This wouldn't change
   machine code, just be more semantically correct.
2. Change the semantics of kstat::uid to really be a kuid_t, and let the
   VFS layer take care of doing the translation from kuid to vfsuid that is
   currently done in filesystem code (or in generic_fillattr, on behalf of
   the filesystem code).

Option 2 is probably neater since it moves more logic into the generic VFS
layer, and this is something that is expected to work the same way in all
file systems?

The following coccinelle script:
```
virtual context

@@
struct kstat *stat;
@@
* stat->uid

@@
struct kstat *stat;
@@
* stat->gid

@@
struct kstat stat;
@@
* stat.uid

@@
struct kstat stat;
@@
* stat.gid
```
detects 43 field accesses to these uid/gid fields.

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/stat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/stat.h b/include/linux/stat.h
index e3d00e7bb26d..9c5709132862 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -41,8 +41,8 @@ struct kstat {
 	u64		ino;
 	dev_t		dev;
 	dev_t		rdev;
-	kuid_t		uid;
-	kgid_t		gid;
+	kuid_t		uid;		/* This is logically a vfsuid_t. */
+	kgid_t		gid;		/* This is logically a vfsgid_t. */
 	loff_t		size;
 	struct timespec64 atime;
 	struct timespec64 mtime;

---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260803-vfs-comment-stat-uid-ea9d874f9368

Best regards,
--  
Jann Horn <jannh@google.com>

