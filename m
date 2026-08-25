Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D838DC77
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680476; cv=none; b=q/5rc8OtaUE49RyIMkkuFTfpkJ9hcqMlLPDw/TjKDOaBAbvDji50M9Co4yAORW9JuZatJXsg0aHc4ftmM2gkxiiDAJxxT7149FIybw24PkhVZGpLs1SCRkPwbrcF1FS1f4HZPGJXiYXL3UEX/82eZ5l6na29KyUR8yK0Rk8WngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680476; c=relaxed/simple;
	bh=KunFI4u3eP0mN2tR2vXuilYiFM0NZ8HdLfTaTjEW5IY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c9cKJ7r6UGrJVeX8aRe987p45U1nidHRGlbsVnVSuAXZMv27F0lhs6UG0N0ngJM164B+AYAOAF/ddn3V3gz8eovS9XmeDeh02ePlSYTGEDnWjLpDpB1xFGSbRdbEKwwiyig945ReIzis3000kEU3f4AOxlYJuvmk9MhDkREgmYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--psalian.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCgli3FT; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--psalian.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCgli3FT"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cec4226c70so1571615ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787680474; x=1788285274; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N59DgKOPss+GkqdGuEiTBLRkcriWzSRmCcb9Y3QV98c=;
        b=NCgli3FTJRCN7ZYOCZr8DyxjxmyJuSQcj8OfTy8BwCvi4B+zBAfUJo3VbYfN4qcfCk
         2BSqBH+mRXcGNwjpRG2kEj99WOpyhFBwkJ9Ib4BuLN4IO8UIlKVLAgKCpy/LWzfMLTcU
         Eo0cJWoC1d/PmlvydBBzmValAM6Ez0bVS40TEtjtPB63+UUtSSY/y+v9OGyGUXCE1KDS
         ioxXnbGc5s5YWVOZVGO+2cyBEe6KaA3di7H3VmRCuE4plT/XxN7B5k/wiaAYvn3DO7CX
         fpPIyiOKloLzdExUW7oY1SHpFWQhB95nz9Sdxo3uKrIhcrVlXe6KeVU2fW5jKLLzumcP
         NBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680474; x=1788285274;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N59DgKOPss+GkqdGuEiTBLRkcriWzSRmCcb9Y3QV98c=;
        b=aG4YWI5VBkemcRRwDN6166OTpsv5s3RCFBNw+BRjsdRKkzGq+f0f8LUQvxtZfoGK2r
         N5+ZvoMbKoUifmAfK/HuiFYg9a0WD8G5bP9Gs58MZfLmxvSVZFXkziokYGklADAhGe1u
         gkmThXLXmCvgRcJbNHrxk15YSvt98Wdzz3xSh4vEA3vA3Ta4R9JKoKAOVM5+KSrvl7yV
         Nvb6+MuF46i6+PpKfkwWSAg7wdHs3Svwj1EbaUeJOiACFk+ueYtLToNlXf0Sw+nh4Lcf
         XVB7outWHrtGQanqEowScDO7DaHserd5I5e8D0j6xtfeTNbll5v0pHBg/4Xmhjl5VQ76
         19zA==
X-Forwarded-Encrypted: i=1; AHgh+RqG4EaykGRPDPPKSpjhRIyAANHPDVHE7YlqxixLaxJiNL0IHokQO9rBI9E0lYBXSs3KPxbw3+EC65eN7IMU@vger.kernel.org
X-Gm-Message-State: AFuF++kMWt8lyfokf/QrtSU2Tqd3+Dohq1QI7aFZN0paeRsJz81R/ucY
	XPcTMNjmW55QfaxQuzXjAgJFuE03rjYw6UMeTWPAF2IY0gryV5DiREy/5Fm7yl0lY3oIMmUuT50
	4OdGbgD3TUw==
X-Received: from plbjw24.prod.google.com ([2002:a17:903:2798:b0:2cc:8741:f340])
 (user=psalian job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf41:b0:2d0:401c:2ebb
 with SMTP id d9443c01a7336-2d7079df723mr271545ad.4.1787680474357; Tue, 25 Aug
 2026 10:54:34 -0700 (PDT)
Date: Tue, 25 Aug 2026 17:54:33 +0000
In-Reply-To: <20260727210718.125872-1-psalian@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260727210718.125872-1-psalian@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260825175433.2588528-1-psalian@google.com>
Subject: [PATCH v2] fuse: mark DAX VMA page protections as decrypted
From: Punit Salian <psalian@google.com>
To: miklos@szeredi.hu
Cc: pankaj.gupta@amd.com, michael.roth@amd.com, thomas.lendacky@amd.com, 
	stefanha@redhat.com, vgoyal@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org, 
	Punit Salian <psalian@google.com>
Content-Type: text/plain; charset="UTF-8"

In confidential computing guest environments (such as AMD SEV-SNP or
Intel TDX), direct memory access (DAX) mappings between the guest kernel
and host-backed FUSE/virtiofs shared memory regions must be accessed
using shared (decrypted) page protections.

Modify fuse_dax_mmap() to apply pgprot_decrypted() to vma->vm_page_prot
when establishing FUSE DAX memory mappings. This ensures guest page
table entries for shared DAX buffers are explicitly marked as decrypted,
preventing memory encryption faults when accessing host-shared DAX memory.

Signed-off-by: Punit Salian <psalian@google.com>
Acked-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
v1 -> v2:
- Added Acked-by tag from Pankaj Gupta.
---
 fs/fuse/dax.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index a15c464c8d19..00e316a7f805 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -826,6 +826,7 @@ int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
 	file_accessed(file);
 	vma->vm_ops = &fuse_dax_vm_ops;
 	vm_flags_set(vma, VM_MIXEDMAP | VM_HUGEPAGE);
+	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
 	return 0;
 }
-- 
