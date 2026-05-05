Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D053F30CD9E
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979586; cv=none; b=sIbDIgsBKqhF+B3hR920Y8o0k8bR+UMVALKY4rH2wf6etBOSDe3pZpn/XfzPrT679+7EwFtuv+/fk9ym9D8jBchYy2hAji08BZPMXaH8s3N8myyIiYaxIo9cgZe0AM0cmbFZUMVR+csbs2SRub8f9tdnpq59tOmewX+SPLyCy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979586; c=relaxed/simple;
	bh=9dD2I+0WrxMeGzTQybO0Oq66wv4w1ldPaLU+2HzXlvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oekl0UNAJFmMFgq1StIf2igJLiZMB5dtc44yKKnb8kDztkveZq9m4tLnVfFnkbTARtvvmKO5lWCKHL7i9ETygO80Jb/l/qVAC8oHGppiuWmxOZ3oPciZVP7vN6+ox03h8A0z+UDSuFdQ/NBMeI5RhszTfpfAgElp61Qnpx0IxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGuzi/rn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGuzi/rn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso38925585e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 04:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777979583; x=1778584383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLBbPQmiia3Jzj9CZTqoCt+pxP8PtFKqIf20080wUWw=;
        b=JGuzi/rnItf5/ZRnWvW++mE5Z3g8Nvne+jpVX303HGNY4NVYOPLdZCCEUg6eRbdYnH
         pSDEtMMRD5mjC41kfxwQMw3fAj0Lpx1lhkk8QqEAmUe6pD671V3qwHthAqIgkN+TlcnH
         YxTXwChP7/7tKJoX3uaP9bOWpkFjmgwG5jpREN7bXfAFHAyHr0KWgwFr8+H4rEA3mcnA
         tV1kWq9s0heGwTXRJ9ysEwKnRvbyMlLOmB8XWCtDppO7rWQ9XRXJ0wWxdEsXimsvYu8o
         DnnGshlxD6scVsGifXOKM45ZKY8sHKMTL4S26ajkok8U5Vrit35irBdL+JTitjbryO0Q
         ztTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777979583; x=1778584383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vLBbPQmiia3Jzj9CZTqoCt+pxP8PtFKqIf20080wUWw=;
        b=H+d6IyU0rKowW9kIxiZz3Sg0dqJzdVo1GkyeLcF6QSJdU4kDhCvwL10X5TMnQtlYBN
         2nshyPft/4eLlnVNanBN2DJgBGBbPc9efYMufrAXSsGfy9x2OI4SUpBS1tKcLO7XM/MQ
         reP9+1u4Lufqii+1dHgUAXmUQ2qPb9yAmC7sNv6Xbo0Igs6twRH85lMgHA554Q0n4TWK
         Ub3TwppM82bqyb3OKrbt2QF2CyA0oWaF+77EqrxAyNNbEcvHu3fhpueCSoQk1xjgfqT/
         R2ERQxTsUUohmPRSPZjNll/s4r3SRW3/CrA9m3EqGbg3xtKjXhNB4WPFDYPdWxYx/pL8
         zEmQ==
X-Gm-Message-State: AOJu0YxBXMpFNBeORb/zAwLXY7rdKiDMEoJEMk3AM0TCF6CqNK5Yu+gT
	v7IMiNalVsF8HpAuas0GuAcHylSIfKdZ+ddYpK7nC5IkcpT63wdarh8=
X-Gm-Gg: AeBDieuWw8B0Sm/ZxHd9Rm6kJ1fIXOJ+30HgQnd5QIpWX6E70bYkDlB+wfMzmxhTod1
	CbBCPTZnuE0YWuGeyiqTln1uTq1AgrspjLhul4uCsW6QK0SnHiIQ/oXua9aGZHgbSICcLwKu1ae
	WBBhUVcGTTNgJEoF6tKOiIFF3e4LYUVU+XX3VK8QmA5u30n7QUXzXz+WKAS/uggQeNzYe5ar7DS
	LrkH4sUq4lJQkC0qGr5J6E73MAhn7u05WU4ESnZCEJ0G5TciuMFHALxSl7ptcl63jJtZse299j4
	o43DxE7yOL6FLs+DRbzRx61FKAarNbuHHUe9QA6h8YgKQobh2a3bZ4Rrz6NUN1MSTCF9sO8VE9z
	aEQHlO3CpXh6pHenb80leeKOas7moREoNZxPphLyCsEEkd86I8D8YxOi9S6FKgYE7Zfi6x8uroK
	LKxoc=
X-Received: by 2002:a05:600c:83c4:b0:48a:674d:e756 with SMTP id 5b1f17b1804b1-48d18be4526mr41493945e9.20.1777979583119;
        Tue, 05 May 2026 04:13:03 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a488d8sm3786183f8f.12.2026.05.05.04.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:13:02 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hfs/hfsplus: zero-initialize buffer in hfs_bnode_read
Date: Tue,  5 May 2026 11:12:59 +0000
Message-ID: <20260505111300.3592757-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505111300.3592757-1-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
 <20260505111300.3592757-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

hfs_bnode_read() can return early without writing to the output buffer
when is_bnode_offset_valid() fails or when check_and_correct_requested_
length() corrects the length to zero.  Callers such as hfs_bnode_read_
u16() and hfs_bnode_read_u8() pass stack-allocated buffers and use the
result unconditionally, leading to KMSAN uninit-value reports.

Rather than initializing at each individual call site, zero the buffer
at the start of hfs_bnode_read() before any validation checks.  This
ensures all callers in both hfs and hfsplus get a deterministic zero
value regardless of which early-return path is taken.

Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=217eb327242d08197efb
Tested-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfs/bnode.c     | 2 ++
 fs/hfsplus/bnode.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 9571f33b91085..25cef62fbba6d 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -64,6 +64,8 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 	u32 bytes_read;
 	u32 bytes_to_read;
 
+	memset(buf, 0, len);
+
 	if (!is_bnode_offset_valid(node, off))
 		return;
 
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index f8b5a8ae58ff5..14d1af2c7ba93 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -25,6 +25,8 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 	struct page **pagep;
 	u32 l;
 
+	memset(buf, 0, len);
+
 	if (!is_bnode_offset_valid(node, off))
 		return;
 
-- 
2.47.3

