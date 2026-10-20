Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500631;
	b=Iqxu0xZNSWQFv+GAI9h0glKdOQRdknMfPH6LMUkJV2VyM8Dk1YgT56igY+BLxN9oK5ub
	 S91HksaIa49F36tkB2TPWWyGkV+uZyU2FNRV3K0Sc/uP9avgEonl3vSIzB0JfhkG0IPI5
	 4Tzd4XIi8jlxnou5GlQRZ8UQMhwu2mpDafsnTgOCCf832rScZhZQooUyzvgzghXi4o3X/
	 2Nx2DEQH0OwYgPZV/oODu9JGh1ovt6q1/eOCr0e5X2bnHNCUJR9pZsKwFzBspcl48JAEn
	 hufRSAgTFODIsXuQXhUWSSzTHtnYeIWvUHa83D5rl5N2NZIcR8OVXzSNfiXAfr8he1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MXdHjYF/iFD/DCy7EzXB6+0TlqrWF/Nncm8XHDPT76g=;
	b=ncu6VdhU+/snQwOUH2EaM9o6hbNMk/fsGg6TlBU+ES3nTA+hfm9cdWruwGr04HAfsYdb
	 nEBiC+mJBiH18OXCJYzSEXqa0hDHTCfDhl0UkMrZGJxC9vYqNT7vLEY3EMe/J8QTZvmQ2
	 UXhURJrdwLnBg+C4BFz5seOENQRt3anWzukFFsAZLv8UDmDNG+mJUvVjf3zIbtCTYv6lp
	 cR3tAWNpyfu5Cj5hevWjvS6V3dLFYd/MrqPcT4PyuOSGIUvTDbE8x06BYiL5jTbll9KyU
	 lLhfc6NEYA74sC8s6SFPqo3Y0iFc5efTh4J7A4gtefWu91aR1sAtvAeN61gV6yVpoYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IHCblJZf;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA0606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 12:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CFA0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IHCblJZf
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ea1e7fad99so3942785ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 05:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792500631; x=1793105431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MXdHjYF/iFD/DCy7EzXB6+0TlqrWF/Nncm8XHDPT76g=;
        b=IHCblJZf3H7599IBWylg66gU0BdWkqOQqEm/SXRhQR1bUZoFbQktsi2LBaQRTQeR5m
         Hj+fW8zZoHJTNJj1PHYnEdUekhAcSKhL4rDIWZoe6EhAUiL5hKfkgkvhMNTkQXlu1Sgh
         Hf1lJR03QSEY4hAbCLfviHGJyrGpC4KByDFUnEAK1gJTpwW8CJn0Z66von5N0T2Mi7p0
         gwJK3UlGsFIPvB9DcM8nmC+TVpt7Yjf8Z+kBI5up04AXWwmWL+AFkfCre8ORKyhUzAtP
         jXXPUAbKE+Wna1Irkj7ES7OKkZ85qTx0YcsS2fuocZmn2xpypw3PyoU55nQuhoEDbm8l
         dTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500631; x=1793105431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXdHjYF/iFD/DCy7EzXB6+0TlqrWF/Nncm8XHDPT76g=;
        b=nr3zQ9bkzg62p5qhuWIg2NVJ2r/qCW6WLkbQVzgjCd17FkICf5wQBxyylBcBl5Z9N5
         NlxPgeFMmYrfogacBgwk/XajiaLTpSfJAdsF5IxAuAIfFpooD23VafdJ3gI1U6ia9o+R
         Y9b9h5+k+a1z7Iu5bwXwYMtf2PraKVxhfFs2FekvktA6C85ass+umOAEabCBWYdRuoy9
         seymprjGr0H75rZPzsY5x0L5i2gO9loiuAjpzvI3ZKeNUoG5/gZasxwOYBBrm2kA8Wfm
         whmWxa7Z1jhJiqb3sAU1N4n6XHFkB0vgZZlHQvqlufdWQ4eF225wuWpHldWDNfcWKQIM
         c3XA==
X-Forwarded-Encrypted: i=1; AKwUvBwAN4YszLo3gPdhSA0CWS8P8yZne2tR4SmlNSyKSXaRF3dDTN1o578AfkbNXc/EWACx+r3lVnAgxeREMHCu@vger.kernel.org
X-Gm-Message-State: AFq9FYK86/wnCyaXnRBoO2d/0zIaRDIxnXEXqLhlTCZaNXwmVhtu0JDt
	xGYfgylfRNy6RYCNU2dbTcLWTcgzPP0tR0mrHHfjb6A2d0B1y2D544mL
X-Gm-Gg: AYBFou0qP7OOiCxNQTDGgAEdwMuxZuAHCnI+PSdHnkXxWyMeeQtsJTXjKE5+IGvHK+P
	ZylVKn+lw2BacWwR081d1weoJ38YkJPLdzl+0K5/aoz1WnVofCR7TZB+6LesAo1xKmhc058g67d
	PMvDqeUBh86uGyOtS0lTjacR977FvMaYPywWpfr5ivqPgIUJrxkylBI6axniRg63Gf+/ucsv6gr
	Di7DUbOFP4R81DTUxHfRC+dsQhGfQcZyCP9PpFiDnAEX7dQVW3gdVQkQ4prqTh7QJ0zf+XAHlZq
	G0879JScfxzWVPxZcDOCFtYNx3IkJE/V1dvo+vgRcWc7HbMTD0hDuq9u07r24QaGYIEATEi3b/Y
	Cvb8MeTuQA7sorNYIThNjyIFQT9i1pBAs27B1KRKb6hxRPpTtYJFtgipvaFopuqtELCXk5J8oKc
	3jGCzsdqfEbZJlViw4Rb+vNhS6nlsmaHlivg3qlFAwzhVqXP7lPfP46OoZKmZ2i4Fg7X9rgCtK0
	c5OjKxqSZw=
X-Received: by 2002:a17:903:41cf:b0:2d9:520c:38e7 with SMTP id d9443c01a7336-2e9a68346e4mr91135645ad.1.1792500630628;
        Tue, 20 Oct 2026 05:50:30 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45b:2646::3d0:4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151a2a85sm11467305ad.71.2026.10.20.05.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:50:30 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: paul@paul-moore.com,
	eparis@redhat.com
Cc: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v2] audit: don't use the caller's root when it has no fs
Date: Tue, 20 Oct 2026 19:50:24 +0700
Message-ID: <20261020125024.8550-1-ngocthang2710.1999@gmail.com>
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

audit_log_d_path() calls d_path(), which resolves the path relative to
current->fs->root. do_exit() runs exit_fs() before exit_task_work(), so
a deferred __fput() runs with current->fs == NULL and d_path() oopses:

  ima_file_free() -> ima_update_xattr() -> ima_calc_file_hash()
    -> dentry_open() -> smack_file_open() -> smack_log()
    -> common_lsm_audit() -> audit_log_d_path() -> d_path()
    -> read_seqbegin(&current->fs->seq)

Without an fs there is no root to be relative to, so log the absolute
path with d_absolute_path() instead.

Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=975ace299d6ba2eb1cea
Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Changes in v2 (Al Viro's review of v1, which patched d_path() itself):
- d_path() is meant to be relative to the caller's root, which is
  meaningless here, so leave it alone and fix the caller instead.
- audit_log_d_path() uses d_absolute_path() when current->fs is NULL.

Reproduced in QEMU (x86_64, KASAN, Smack+IMA+audit) with the syzbot C
reproducer: without the patch the first exiting child hits a null-ptr-deref
in d_path(); with it the reproducer runs to completion with no KASAN/Oops,
and the audit record still carries path="...".

Al, does this match what you had in mind? A final fput() in some unrelated
task still logs a path relative to that task's root; this patch does not
change that.

 kernel/audit.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9412af9144bc..32085674d0be 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2218,7 +2218,11 @@ void audit_log_d_path(struct audit_buffer *ab, const char *prefix,
 		audit_log_format(ab, "\"<no_memory>\"");
 		return;
 	}
-	p = d_path(path, pathname, PATH_MAX+11);
+	/* No fs after exit_fs(), so there is no root to be relative to */
+	if (current->fs)
+		p = d_path(path, pathname, PATH_MAX+11);
+	else
+		p = d_absolute_path(path, pathname, PATH_MAX+11);
 	if (IS_ERR(p)) { /* Should never happen since we send PATH_MAX */
 		/* FIXME: can we save some information here? */
 		audit_log_format(ab, "\"<too_long>\"");
-- 
2.43.0

