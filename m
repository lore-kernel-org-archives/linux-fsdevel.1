Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358393B4EAA
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730832; cv=none; b=ez3vQxkaJ4UoODG/SMF9QC0KMfQzJF1MvyVVxb0berqv/JhzbarWO1+wWgyHHJnmO6uFTIx7u6r9wr2xG8gfL8sFEvKdVauKfZttMA5k+XvLBimZn3imyU79nnVBrveKWuPbDNWdH2bbkS2UvQXW76qniRx+NjY4kecbIWX5nNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730832; c=relaxed/simple;
	bh=Lqti2WeVTVBaLfelS8od2K/pMXkfFP2j/NXPHvwrwnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cS9VVcRZHTOgWwVKHinztW1dIIDtOPN/lmPqIDm6FqP02QppiUEkWFvaCo6nRAdSFILw52ttfh2xzOIxoFXPnLGk1LTRGJSXS/YbKKQfHwC/rI5p7lKlIi8sWbAeLgzprgaN4Zo5LcNDAdKunNKaUI6LBHhcL24j1aM2aCYqcR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db0RRn9T; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db0RRn9T"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a2c3dfb4a1so808397e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775730829; x=1776335629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZCUPUgWtF9cnC+OBlLzSDFkNCO2ZEIu1l+DqN/zQCg=;
        b=db0RRn9TPLfgQicGMqG/DqB3XS1cVjbIRRcuyTGXihZP28wmt9tGzSZLNqruTkP/WF
         dnMP04kysJdHz0+6YRp1BkMIVAkjNAtLu7y2dZZXZh8J8vrI6HP1NNcmTaTqDl/zfWvI
         ykj1uR/FZvM6jiNF/gXPe9MGy8apkRpMcDlTqL9sTMNwlc5OcAYbLiUaWfQJhOux3kc5
         pWTSTgYgYR0otpHp6SxM/b+ykxGTRDfO/zN69tuDVIwJ9iyEIm62Nckwmu6147YMOJdv
         sx08adr5jFVDLZaCdJxGetkm7VBPGyAAmCeUYsW7ibj8V4PgO5N6+tXZE3NmgF6UO28s
         /ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775730829; x=1776335629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZCUPUgWtF9cnC+OBlLzSDFkNCO2ZEIu1l+DqN/zQCg=;
        b=RRHybGdXtLyefzoJGJ4hwMBMs0WK0Vb/9ZGAvVHlgCfPEW7HIsrgb8JFvyT39wq3u2
         VgGzVrNm1gNgI2Hwf+YE0bPqvStECbgljbqR+Zr/6KJN+eHqOerbpOJH0lzTEiS7loc4
         XY+cEe/5jcxkAa7Wp0Lo3mX0RLMdeZIztoYgAPffiH+ycHDTvvKEH1qXuRBEBhu9ZoGv
         kjDqtlO131KrpUHEOW78otS2jZ4yuvSzCCsNIXgS3zFhgH3IwvMalMSxhZLj7gLimNOt
         KdZHitydd5j7jDKBYFWLOBubLCNk1GN13cHNECtIWe3D16UTPyOe7R6FR56CvyiPdaKv
         p9nA==
X-Forwarded-Encrypted: i=1; AJvYcCVrxe40mNXylZWvSmOmh5t/8DPRa8x160gzREOa/qQ0h+Pka9PjCVS1ZGEIf/UcpZnKZCdr/N16sTAcURn7@vger.kernel.org
X-Gm-Message-State: AOJu0YyyLCCaiHduefHFIJfEHroUYJ3rw6V937/SUEkZHQlFDT4c2uw+
	KkIAUjQnP6OkhZ/6ixQpg7FoaKv79IiF6r5CWVd/SwBU0AUWD6vN/9RVpZPQFFI4lGM=
X-Gm-Gg: AeBDieupCFPBkf/3OHSeekFH6sMd3wJecwQdnC65U3ELolFlulbytla3cCfSbodYAdG
	W5Im5n5J3gIrLMn7MCeAg7bNFWQ/kBJNmEE4SpNuGDKDtCwrEl5sqIJO+J+VyjGws6KxNYawnO3
	GKbBkfdyS5B1YM/LQP2aOsdl03J5VjjLzP5z/bT/TSake8KPcQJUd3Vyp4iaIvw+t6jRf5QZz0R
	17IO85K5SyJ6edrDOxakuTPhUpx9MhJ9AYU6vdpTv6fHQ71mfIfZIFubiDC0P2dVfJWG52+l3kD
	m7iYNdUIU/snF+TtgBiPg9MA1E3cCuwKBLE5uUjAkIaDZfW2cj/3M/XqkPti0eHQHnDhhMkZBTB
	MGjaBBHnWQuoBNwB+gD+CcauOMU8zzmIPMZddDDs0fQ/J9QMumq/Bso8H8TyCovereaKbd2mbCg
	fRZgj1kdbeCu6QdoPDx4hZ
X-Received: by 2002:a05:6512:3044:b0:59e:57d2:75f0 with SMTP id 2adb3069b0e04-5a33758ad0fmr9639795e87.32.1775730828956;
        Thu, 09 Apr 2026 03:33:48 -0700 (PDT)
Received: from agp-laptop.. ([5.180.139.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c9f42b6fsm4958305e87.84.2026.04.09.03.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 03:33:48 -0700 (PDT)
From: "Denis M. Karpov" <komlomal@gmail.com>
To: harry@kernel.org,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	ljs@kernel.org
Cc: vbabka@kernel.org,
	jannh@google.com,
	peterx@redhat.com,
	pfalcato@suse.de,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	usama.arif@linux.dev,
	"Denis M. Karpov" <komlomal@gmail.com>
Subject: [PATCH v2] userfaultfd: allow registration of ranges below mmap_min_addr
Date: Thu,  9 Apr 2026 13:33:45 +0300
Message-ID: <20260409103345.15044-1-komlomal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of validate_range() in fs/userfaultfd.c
performs a hard check against mmap_min_addr. This is redundant because
UFFDIO_REGISTER operates on memory ranges that must already be backed
by a VMA.

Enforcing mmap_min_addr or capability checks again in userfaultfd is
unnecessary and prevents applications like binary compilers from
using UFFD for valid memory regions mapped by application.

Remove the redundant check for mmap_min_addr.

Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Signed-off-by: Denis M. Karpov <komlomal@gmail.com>
---
v2:
- Remove the check entirely rather than replacing it, as suggested by
  Harry Yoo and Lorenzo Stoakes.
- Added Fixes tag.
- Link to v1: https://lore.kernel.org/r/20260407081442.6256-1-komlomal@gmail.com
---
 fs/userfaultfd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index bdc84e521..4b53dc4a3 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1238,8 +1238,6 @@ static __always_inline int validate_unaligned_range(
 		return -EINVAL;
 	if (!len)
 		return -EINVAL;
-	if (start < mmap_min_addr)
-		return -EINVAL;
 	if (start >= task_size)
 		return -EINVAL;
 	if (len > task_size - start)
-- 
2.43.0

