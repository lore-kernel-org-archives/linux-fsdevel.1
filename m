Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B876E3BFE5C
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944499; cv=none; b=b8MSTDnOcQ6OnLXGLQg5f5E69MdeZgPdZhQGsj5GLi09Op88YuJBr7i2EBMzc+IntPqO3zBtDVCYCXeSrRfvgbJtVN9MwKTQ61QtaIfE8TQ8yn3VRR4hqzbF574qitYxKWQzmUsLeXnbseRk57vPJFm2Zs5meunoKiEbsHqgVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944499; c=relaxed/simple;
	bh=alSKPTQT6qyupCa9Wb3tH77OaCuCEs2eZNAD/mw8pDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tE9LatgAxo6s+PE6mt2Tw1D0YHS4CZNRvy3UNYjJTO65AigX/V28MFcTelS7NeCoQL0NDF4N5VfZBgLWALHAL7do08ZcN47hvuUq45qdgg7tSal5Tqj76RcPkfuur7ir69b+DWmSEFEU5i0PONY2kisFzrq9OLhAHIjQNpn3xjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YN3OK31P; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YN3OK31P"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8e5be46f663so7657196d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782944497; x=1783549297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bjo3T7/TDMFL6Bk9RMp5aO8WfjOwcDSqkt8gjpOfos=;
        b=YN3OK31PkMANkY+aDMjAgSDCJL7LIiY1inUzNTmLI9irMx4ofgIY6D/MoeS2updoPT
         XE8b8IISkdFGy02dOftkRVB7So/Tw3bmoLff+0dumvnY8lKKau1YKQL/sRsx7MO1lTHB
         GbCtowY9wzzLq8g1qbyUB0Vg0XndpnAQSvPtbfnxLlnC+4bERVIgGmZJtrTvD/TfMxc/
         28yDUYWy6/LAlR9p+ITAvNF0h7ZsmsMAscHe33ELqMlqva2C7Ia+9TnEDObjMqZjpFsi
         GjLJUHOw0rW1s5AIs8POncfpxH2CdqBM2LYhKHJ7PCtP3c9X6hYsFY2zpGw13ec9gyNU
         EdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782944497; x=1783549297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0bjo3T7/TDMFL6Bk9RMp5aO8WfjOwcDSqkt8gjpOfos=;
        b=AJW2SwvViq1ariZeFygxhyyOWtXgf9qDylpwC4818+zjbntBSka/KG4uokDzqWPJxS
         kjk0VmhJYFhJ8fqC7M6O0T7I+kLsup5Aj7c+b8e7XV+0VFEXPMlhrs8erLjMpL5REUvr
         eDgghUbdEfk00NvnQG6UpCCsdhI88Q/oHjDjkKFjsMLelfY9MFCsZbN57q2JhsbdZfBE
         Qc6IMUXeGhUj4fP+ePdKDTvktygkLGTCCXCS1WfphJQ2+hrzn7ZfGa9u6x8L4eY7l9bu
         Vd4JQd0LipDHHfjJ5+9N9qC00yRHy9BlvziW3ymLlYXQWJr+cqLTK3xX/yEj9ibkorSx
         TxnA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1d/Yw9f8WzSA5UZxovEQZb2HW+qlIfwWnd2NQ8Qlj9GCes22iGdYxJPvzajhCR7f11klbTV9LVYirlYLf@vger.kernel.org
X-Gm-Message-State: AOJu0YyFz0U2gLoxlh9u+L3RvMOokGK8DNk81pfWr2dkQufVYLGwlkSK
	xy2z7xrLOsiVyPdk2K009Vj57tEakJkbRvnxiI1kx1uOYku2xlQcsvL4PLSry9BtoqY=
X-Gm-Gg: AfdE7clM1IbSN+bbjRpekUea0cXmCx9XhBjNHLuSEtjM3+Nj0QN8O5OZujo6qYW1g2e
	DPes645NCzlTKSerPaRA7W3L98shUKXFWpKM3OcDE2uVbZAmsyEy2MFxhgN9kgl1agGEU8d7boW
	Kd7NuucS/yaJZMCrCFoaBlg2az4QeOl1bn00klKFibs23qLxHdo/Jaw4c4d01xY1bmgBZ94LxrJ
	eNceHrBDXQKKNeVQbGfFwDeKZtNynmWCMtU8IL/gSo9VqVEJObvoyE/QAWQAx3c2MLiNKfIPlsc
	QlO5VT4ItNfs2//PFznLTOhfTgMkZXG/3VXcnhit1Qel5+OcZ7JgVu+2/R70p0L2kVpSjYlcTdB
	E8zGF6SrYD4TliDgoIxJQFI7tpj45WFyqJSyKZud0LhYNrTvYb5WtoC4EvS9ccQ/UUFCeE/DTj+
	IH4H9mgTvGjWJzG8HnwDqRHhZKOJT8BaJla57mfZryNwBsRAmN50pPc+NrsI5hlSg2GkwQsFXxg
	w==
X-Received: by 2002:a05:6214:29c9:b0:8f0:275e:8b3a with SMTP id 6a1803df08f44-8f42557f540mr40756456d6.48.1782944496729;
        Wed, 01 Jul 2026 15:21:36 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d137sm9709076d6.9.2026.07.01.15.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:21:36 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com
Subject: [PATCH 1/2] mm/filemap: place page-cache folios via an explicit mempolicy
Date: Wed,  1 Jul 2026 18:21:11 -0400
Message-ID: <20260701222112.2820098-2-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701222112.2820098-1-gourry@gourry.net>
References: <20260701222112.2820098-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page-cache allocations have no mempolicy of their own and implicitly
follow first-touch task mempolicy via the page allocator.

Codify this preference explicitly in filemap.c, rather than taking an
implicit behavior from the page allocator.  No functional change; it
keeps pagecache placement stable across the following change.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/filemap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5af62e6abca5..d419d09a58c1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -25,6 +25,7 @@
 #include <linux/syscalls.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
+#include <linux/mempolicy.h>
 #include <linux/file.h>
 #include <linux/uio.h>
 #include <linux/error-injection.h>
@@ -1010,7 +1011,9 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
 
 		return folio;
 	}
-	return folio_alloc_noprof(gfp, order);
+	/* page cache defaults to first-accessor task mempolicy for placement */
+	return folio_alloc_mpol_noprof(gfp, order, get_task_policy(current),
+			NO_INTERLEAVE_INDEX, numa_node_id());
 }
 EXPORT_SYMBOL(filemap_alloc_folio_noprof);
 #endif
-- 
2.53.0-Meta

