Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1964BEE35
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894755; cv=none; b=rPHoLz/xydnnxIo1psyFLhI8l01JPNZEaiPXt2OAgVeZgSZFwghkQbuV8u24VleOJR5wFyv/gZvS9l16maTPm3gVWg3eDRLb4EqO6H9uBLCjqnYLoVTGcrMBEGs2zMHXLnRNrJn/zoZ6AW0wCnsQKVITEAnXK1EzWh5AL/t4pZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894755; c=relaxed/simple;
	bh=v4Z5ZRX7eHLUFgw3mUN2WbJgY72WztS+eISLQnqHhg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S6fdh8ShpqDletxYSzhUHJHa0myvbf2tu/nlf/DT+56BoQCJht6Z+qQhGW13Ae10YG5ZzuEJymP43OS34B2Nvb0hPr/Q9O+j2HA9vbMhz5Eb9EBQbtjNSlK66jEfpyUtBFgMTJnu2irNHHU50HrbpxZCcynCH+PY7JgOeRQAMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2fjyPWn; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2fjyPWn"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so11320208a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790894753; x=1791499553; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xlzI/cIJ8uFSXRU8etErWLoS0XVafI+S+YwrCFu3no=;
        b=B2fjyPWn9Cykksixd49b0ORppjnBZfnRWtj4r4njOG9EEaZ70kVlpDqR2FK6Sl/Itd
         TjH1nz465HBIGX7egea1oSVH1PS0AgRU2ZNHfHW6f1mUSsMQqyNTTe5sZ/GgJ7xDCPSJ
         HTwaR+C/TelJcscaOvb2WDINldC/JVLdUQ0DwQIcAreF9fBxRzw4kndOo+oHrw38DslN
         01rT3nyO24/enUiTRVNLWY43Yo49BWkDRecxz772iUsFgqA10yJKjgpTadXIEMrzdTTC
         LmqqseA//zBagnX0dmcocAH0+zRFFcKxyaBKyh9qxnLeoQ03tbVN8+vt8Zx30YGOjjwJ
         P1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894753; x=1791499553;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3xlzI/cIJ8uFSXRU8etErWLoS0XVafI+S+YwrCFu3no=;
        b=eSL3xc0J0rGBU0xUUAI4QiealZgEDNwmNSSZldOIXM33Qbp+MEzIDxAGB6X1VadDr6
         looZy2GMvn5130Tgl2LPqLNQzomv+ZgL2YdOAE24rWRP3LLSS20tKzIf/gq69WV7DlJw
         Ax1WvriRlNrAcNDyCDNZKh3BxkqDwP8QXJt3P4wg7hUkx6GSAk8lEiHzOO5Pk62Wc+v3
         tnifvg+/DBxD0g3bH+N6YhfMvrLnc0ye7u+XyIsCmClxGQXc13Jokcy9T7YBk4+QoepQ
         qtkr4krlALO8VYSQSJeW2+xWP4lj87UIGprXKg7YnfwrFGSqNjit7mZEWrcMCjkpIroD
         xC3g==
X-Forwarded-Encrypted: i=1; AKwUvBzQNu5jKZl/f6r8zisZ32ZS/3Ne9wHKa2Dw6mjESrjfA1/f4vbSJrNEsiRgmoKIa3wY50Ip0LG9y+cxpdVP@vger.kernel.org
X-Gm-Message-State: AFq9FYKzEsWx49ziYfxKy83KANp6jjJHRy4Jz2du++CtLvgi9pIdu/Eh
	wDWbee89eUbn0VkZhHbT2/Yn0S68QyyH+3JIVZEKon6pGz1IlRZF7nKJ9lOWcF7C8I9wHurUzkT
	dqQ==
X-Received: from pgbdp8.prod.google.com ([2002:a05:6a02:f08:b0:cc7:a4ca:364])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33cc:b0:3a0:f2c8:9ad6
 with SMTP id 98e67ed59e1d1-3a6ce9a677fmr789753a91.64.1790894752501; Thu, 01
 Oct 2026 15:45:52 -0700 (PDT)
Date: Thu,  1 Oct 2026 22:45:27 +0000
In-Reply-To: <20261001224531.765278-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001224531.765278-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001224531.765278-4-praan@google.com>
Subject: [RFC PATCH 3/7] iommupt: Enable per-domain IOPT attribution
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Logan Odell <loganodell@google.com>, Pranjal Shrivastava <praan@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update the _table_alloc() helper in the Generic Page Table library to
use the attributed allocator.

By leveraging the pt_iommu structure, which already contains a pointer
to the iommu_domain, the library can now automatically attribute page
table allocations for all drivers that utilize the generic_pt framework.

Thus, any IOMMU driver using the generic PT automatically gains IOPT
observability without any additional changes.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 07ec2b3ab986..cf07946801d4 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -416,8 +416,9 @@ static inline struct pt_table_p *_table_alloc(struct pt_common *common,
 	struct pt_iommu *iommu_table = iommu_from_common(common);
 	struct pt_table_p *table_mem;
 
-	table_mem = iommu_alloc_pages_node_sz(iommu_table->nid, gfp,
-					      log2_to_int(lg2sz));
+	table_mem = iommu_alloc_pages_node_sz_attributed(&iommu_table->domain,
+							 iommu_table->nid, gfp,
+							 log2_to_int(lg2sz));
 	if (!table_mem)
 		return ERR_PTR(-ENOMEM);
 
@@ -1177,6 +1178,8 @@ static void NS(deinit)(struct pt_iommu *iommu_table)
 		iommu_pages_stop_incoherent_list(&collect.pending.free_list,
 						 iommu_table->iommu_device);
 	iommu_put_pages_list(&collect.pending.free_list);
+
+	WARN_ON_ONCE(atomic_long_read(&iommu_table->domain.nr_pages) != 0);
 }
 
 static const struct pt_iommu_ops NS(ops) = {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

