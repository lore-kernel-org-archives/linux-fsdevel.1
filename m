Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386383D1CD4
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862826; cv=none; b=HvjVQirEytdU36UDS6EdHLzOx1sJfzWQHEvEz6s3yxWgwtnyeb3i2p30fHVj9qfFuEIrUmDyEmjOTPkzg4etLNVned88R13d4vY57hX3g2PPb+6lRPyx0X5Uw/j+H63aEcbUoZUuNDlKgO7/mbIIIZdlrk576EcXP+m/SHQMDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862826; c=relaxed/simple;
	bh=vxetH8Avmfd4QFDfR5JZ6ol+RIrQLp8uhBHQlntbX4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i7PG2dr79QkI7Hd4NCCaoyccPXcuu4V5eOo12jP4MPpYApTAtH7x/oP0P5LLiMsFm5CRtQMke/GWS/lD59EMgGTik6NrsQhK+6EsjUA+gVld4usGj6WSvspC/DJ2Pdg7jo+TFLDrU6IUw3MAS1Wa10VQ+Xy5EOFwIPLalED+ER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miBGNCft; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miBGNCft"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b7ec7bedcbso46622196d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778862824; x=1779467624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZn4Lhw7aGUHoPUqoI+ds26hnYSAESh6BVmmIrXoe1U=;
        b=miBGNCftw0fwULzsuOLTxFMvIcKrK32Z2xk2Z04Jqez/EpedXzRFLJ2rF3q04rumkm
         LpQUiNwXgyAX21gLNS3/va0zyhWNdknRTtlxu1ZbHKecInZa1E2ZYoXlijlJZN24U0gm
         C9Fejoae3679Wp8ui/Iv40RzTQ4wflVWanLxRqLfuIQR8NhSD6toAzcsLXR7QdtXOqeV
         7UFV4n860k6ESIAkKDEtY4rQCP56EU6PDg/EXyyl8m2b3UsFCzEhqdM/rgsbB+ImoONZ
         bj4QkwAdvO6HuCrOPXCTiwUgrUAY8+UZI6bBPA3frjckloUGzUC55YDOBcObegirqSso
         IeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862824; x=1779467624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZn4Lhw7aGUHoPUqoI+ds26hnYSAESh6BVmmIrXoe1U=;
        b=BwVRRKxgKs5A3uCQWCdqezd3sbFVj0CTj0U4Rf7vMs6vfYTFrq4ZS0VQg/HMs9UFPJ
         iz7q2CtsaH9WPnaQXk4jJ1Ui3Ohbl7aXxLUnN9CWlzfJ1QecndmtA7Kf58y/kp/OGycc
         dLG3SK5ahVPPfi40lmBp8GnQbTW3uZsV49G2EmEjY+WhGcAfz7onyOEPJmlc6nxCfhN3
         MXt9KJJiWeyzS6KN9FFgtnLDjP5vp9kkaXmLHrIoo3IPX8blWAIX4O4txLn66wkdjaxP
         uvdNFD3CKlC4AtP5XBfkMlCsP7XDnJJr+z9FIOnGmk3R2SGElwY0fDT2WpL+T2f+IJRw
         Xilg==
X-Forwarded-Encrypted: i=1; AFNElJ/zT5L4OB7hABMRZaFUvAMt/fSDVMBhum8fausC4XwCWq/QHKzLiMvqcj4OI1OsjNUry0GzfjnR5r6JGpSk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywit/dO2Hlp1MIoBv9KOwV5Uhb9MyjjnMZZtYxwLvyBrZwKLq11
	0PfNwzM8AaWEhK72N3riOxMGNr5CX2dzN+bBXdMMUEUlC0AYGjvHfneKcVCTVVCS
X-Gm-Gg: Acq92OF/LRrULYk0YZnE3t/RoVT/rxUh6l7UlNJIZJN4SFa4kHhSZIPZ/TVDkLcMcOl
	ExDb2InPF7HMmpWwGDmTLx+OBc3NJH62gvtpxZpDc4HM1hMeIOg1qpIDthCa634Zthprze9jTEZ
	S8Avcd8D2lk/oEhQlQItF9iWXvRrgadvtMKxFsPL0x20JZ/PYdKMD7pgh2T9Rx5R+JW286PWpXh
	bvUCjixnV3BmD0euPiFSJkhL41u+4Wo98sIHWl6WLknCM1Ceeol+7MAKf/AHZWcjEub4N0skEuT
	eR08B+nodTKrCKz2l7CmZSH0Hkda5iwJ9ge9FkiXIGizgBucnNsZvVL7EErDm3MOSUnomJe1SBP
	7vyI6GwzeYQvECLo5we6MY9MEORpq4DEy+GfQ3LW+G0yMkGjRQuBB2baAFBJucRvWTkrtH9J3YL
	9PEbV7gP054Lw7V8et0kLq5fMH+JDZFgFly9psSpt4u5RjN4MkwGJT0H8mpmItdFTb0Rd5GJjMI
	EAF78wWxyiltRaT70r8u6nxYQjvpZAKGQOGZC2VjcQ=
X-Received: by 2002:a05:6214:8017:b0:8c7:2924:29a1 with SMTP id 6a1803df08f44-8ca0f618071mr77850116d6.20.1778862824134;
        Fri, 15 May 2026 09:33:44 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c9093e62c5sm56371036d6.21.2026.05.15.09.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:33:43 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] fs/ntfs3: bound DeleteIndexEntryAllocation memmove length
Date: Fri, 15 May 2026 12:33:33 -0400
Message-ID: <20260515163333.1573210-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

In do_action()'s DeleteIndexEntryAllocation case, e->size comes
from an on-disk INDEX_BUFFER entry.  When e->size makes
e + e->size point past hdr + hdr->used,
PtrOffset(e1, Add2Ptr(hdr, used)) returns a negative ptrdiff_t
that is silently cast to a quasi-infinite size_t when passed
to memmove().  The memmove then walks past the destination
buffer.

The sibling DeleteIndexEntryRoot case at fslog.c:3540-3543
already carries the corresponding guard:

	if (PtrOffset(e1, Add2Ptr(hdr, used)) < esize ||
	    Add2Ptr(e, esize) > Add2Ptr(lrh, rec_len) ||
	    used + esize > le32_to_cpu(hdr->total)) {
		goto dirty_vol;
	}

Apply the same shape to the allocation-path case.  Also reject
esize == 0: memmove(e, e, ...) is a no-op and leaves
hdr->used unchanged, hiding a malformed entry from the
existing check_index_header() walk.

Reproduced under UML+KASAN on mainline 8d90b09e6741 by
mounting a crafted NTFS image: the unguarded memmove takes a
length of 0xffffffffffffff00 and the kernel oopses in
memmove+0x81/0x1a0 on the do_action+0x36a2 frame.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/ntfs3/fslog.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index acfa18b84401e..4b32d08441b8d 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3570,9 +3570,24 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		}
 
 		e1 = Add2Ptr(e, esize);
-		nsize = esize;
 		used = le32_to_cpu(hdr->used);
 
+		/*
+		 * Reject crafted entries whose e->size makes e + esize
+		 * point past the INDEX_HDR's used boundary.  Without this,
+		 * PtrOffset(e1, hdr + used) underflows to a quasi-infinite
+		 * size_t when fed to the memmove() below.
+		 *
+		 * Also reject esize == 0: memmove(e, e, ...) is a no-op and
+		 * leaves hdr->used unchanged, masking the crafted entry.
+		 */
+		if (!esize ||
+		    Add2Ptr(e, esize) > Add2Ptr(hdr, used) ||
+		    PtrOffset(e1, Add2Ptr(hdr, used)) < esize)
+			goto dirty_vol;
+
+		nsize = esize;
+
 		memmove(e, e1, PtrOffset(e1, Add2Ptr(hdr, used)));
 
 		hdr->used = cpu_to_le32(used - nsize);
-- 
2.53.0

