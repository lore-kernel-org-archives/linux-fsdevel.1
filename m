Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EDA36F42A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787089588; cv=none; b=CXTDOBkvZQ2CjZ8GbLHLO//S1RnIL6+K0jEr+m0OYqNpIf/n/V5x2z+QzWbvs8DhOPecF6sIUJARdLNRzFwP1/uJTptnRRkIL2AnvuicJko6BZhuXK73bfa1FlxZtWLfi06SffVfjwG18yj8/xRLDCzl3WekxxP+cl5iHYQEE+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787089588; c=relaxed/simple;
	bh=/q8hG1HOccz+AJjNFdVlUE/9f6w88KiWNmEioY8fPt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hn1DdFe2/+kHrjaOR20KhJ/OOR9q4APlYn19Hb5k+Tkbdmc1fc8iRahKrUeydBomqschDSzILBY5uwqR0/cFgF9uCqw5lN8wTITTSrGQ28MU9L4D7mMagxWH7uGquElb0uS4i3q79tDoNI5x9NfDDEdqz9yVTnJLXkBNDHvwTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oza/OBXa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oza/OBXa"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b966dd74so1962065e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 14:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787089585; x=1787694385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JZYRfp0/X2LvT2oXc8wVuBSIyEOJyJnzKAFqCXBxq8k=;
        b=Oza/OBXaJ3KM8iSvXUZKAV+C+WqpdQEwJ08CgDM3kFIKqt5V1/l3drKy6tuQYlLgYk
         PeQY65btr0njPo+tGLypQVN5v4Wz/uwpQLGI8hWSGaTxrsw4rxGXyi3h8gTSqLpT4TEl
         KCRZqG7tGd+D/ieg34GdJyq6RdH+SHxRk8ZdVtAdZJhaNSjUinAJ5Ta8jSPACFlIBPOq
         AWv9ws37Ss6TLVV/XkJ+3HxoeNE++1HmnX9OaCslHeu0wLE6kxp4XiCe4Uhe0Rv/KoOw
         qxDb3jfk/dftne2OV4LA/LqackwLTekyK5ucvC0z1M0m83aIoAe7hCLL4uLLd8rh+eaw
         bLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787089585; x=1787694385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JZYRfp0/X2LvT2oXc8wVuBSIyEOJyJnzKAFqCXBxq8k=;
        b=pb2VnVA47rDTmFI4he9d1MInsN2ksxGSNQ+DoadN5lSYXIsliRt6Qk8aYEyUnGEJ8e
         EbFOED8kX01HIdAOZ8JYildgtGiD3+WmT/f1ncvYyjJMoNf9GtPQjqK/Sv5pScnEX1tM
         pBDU9YRgxUyAyL+cYD6a26GbO1zXuLqTDXeen8LPo18I55xmPbVeKr6bWGUFc2n6gh0y
         jOBA2hUnAUvdqKFwq0ORe3HkKzFFWEojFalskFzaWRQq6thr1i22wMiZP0ZvhqKAyeCU
         t+VJThYnbZml3on05xmU0QGt2y044kHU0dowcotv8qh7Z5CpA5a62eoQb8YCfkYqZdEx
         sqjg==
X-Forwarded-Encrypted: i=1; AHgh+RqEiV89EhHfS4nt0opOmJPIenv/CpwGz+J6Sah9Af5yKmM5vq9eVatprDbRL3p7eYvGXJU2lx8ThVCMNgiA@vger.kernel.org
X-Gm-Message-State: AOJu0YyTA+h+Q2Qwx07yOzAUGs4NUGUlt969wHEE1SzJEo/7ARIOBmmK
	a6HtSDyiP94ICjHwl6jM6yrEfwo07jQ9ZQUl53stoLhK6/N9iQTWPb3j7YG4iA==
X-Gm-Gg: AR+sD11nwDGCNOj4vwU1wDyTLlfF1BLwlHGR8IDyiSDw71fz237nLvDKLTyStBRjhL3
	+MwBaOmJ1sO2h9bAJloHL9nx8C13//bSqRF+wayadSjlhZfIu/6ZVrOIqVpmmAv1ChxwuV4GGYX
	WVvnWuCkBmQEuLDAwFNIqkPSCk4sfemj0g30xUYcSza7VBdvonnpbXNYRQ6yCNiMXgXPlzVDQBZ
	tWQIdnRUPx1iVH7vHYtv294zqaMVe3ZPlUXaqEZqcHLb3B/QFOzJDbSkz3WOB8hcICETCQoPX9X
	vUYnrpz6Ky8zE9CvZWEhxU63FwNBVvuj4n5/vqvY9iY4YbttVenrLr8Tq44Utx+7tkxgXpLSht8
	A9MLJJkpDPXlPQPbyGqmMBngvrNwG7WtBN38q580ex7Sjt6bmmC9vwvTR1N91vv/uK8mMBAYZOp
	yKK43r6HxStVTb9qs0rob+xi94Fok5iOs/z7LYiRUOfQJigYH19eW783bUJPCvJ5jeFLoZP+4gp
	ewq6AQS+uK0VkkJ/f/wvJnIb4dwht9IgBt8OIzX
X-Received: by 2002:a05:600c:354b:b0:499:872b:abd4 with SMTP id 5b1f17b1804b1-499aa1a1f2bmr1882895e9.6.1787089585136;
        Tue, 18 Aug 2026 14:46:25 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.97.113.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9e84d75sm3588685e9.5.2026.08.18.14.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 14:46:24 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH] docs: filesystems: proc: fix typos
Date: Tue, 18 Aug 2026 22:46:03 +0100
Message-ID: <20260818214604.20349-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix five typographical errors in the /proc filesystem documentation.

Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
 Documentation/filesystems/proc.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c102b62023cd..78a632fea2bf 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -440,7 +440,7 @@ ioctl()-based API that gives ability to flexibly and efficiently query and
 filter individual VMAs. This interface is binary and is meant for more
 efficient and easy programmatic use. `struct procmap_query`, defined in
 linux/fs.h UAPI header, serves as an input/output argument to the
-`PROCMAP_QUERY` ioctl() command. See comments in linus/fs.h UAPI header for
+`PROCMAP_QUERY` ioctl() command. See comments in linux/fs.h UAPI header for
 details on query semantics, supported flags, data returned, and general API
 usage information.
 
@@ -576,14 +576,14 @@ encoded manner. The codes are the following:
 
     ==    =============================================================
     rd    readable
-    wr    writeable
+    wr    writable
     ex    executable
     sh    shared
     mr    may read
     mw    may write
     me    may execute
     ms    may share
-    gd    stack segment growns down
+    gd    stack segment grows down
     pf    pure PFN range
     lo    pages are locked in memory
     io    memory mapped I/O area
@@ -719,7 +719,7 @@ size, in KB, that is backing the mapping up.
 
 Note that some kernel configurations do not track the precise number of times
 a page part of a larger allocation (e.g., THP) is mapped. In these
-configurations, "mapmax" might corresponds to the average number of mappings
+configurations, "mapmax" might correspond to the average number of mappings
 per page in such a larger allocation instead.
 
 1.2 Kernel data
@@ -2008,7 +2008,7 @@ For more information on mount propagation see:
 These files provide a method to access a task's comm value. It also allows for
 a task to set its own or one of its thread siblings comm value. The comm value
 is limited in size compared to the cmdline value, so writing anything longer
-then the kernel's TASK_COMM_LEN (currently 16 chars, including the NUL
+than the kernel's TASK_COMM_LEN (currently 16 chars, including the NUL
 terminator) will result in a truncated comm value.
 
 
-- 
2.43.0

