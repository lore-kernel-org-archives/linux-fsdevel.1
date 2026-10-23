Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763850;
	b=fkt5ruatrCYenIak5HQ3UXgpzs4gh29bqozgY7hyZhtEaRfEMy9B8Q920B8OK7BgwTW4
	 vF63CL8kGc0hb0YkI9i2GDzuaoH+hLJQyFAuu0baix6xQdkFtBZH3ir717Pk8Xdhk3L4Y
	 RKzj7TbUh2tOZ20MIJbI4gwzUJ2HUUIQ5D0nkwpVisrEMadJs2Tjg2vKEVog8Df/pMIS0
	 AtTCoB7fE5Ukhxje/WYhX/PyqHDlF/xN7RqOmxY/e7vMv73A/CaSkAQznrtXUAudfsIED
	 2lDadSSEYSpKIOkh53LhEgwSuh16c8BHeb18cscJbmvtC7Pr9q0/3zSbDveB6HRG+wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Lu2xDF4zP+BYqEQ8/1UEOeistALiKOano5sbvaYKoU0=;
	b=M4LXxi2tdMLFn0vdJwgfjePUpRNFw4X02JYgNJZ9GpoxTeBdwqH6aIxgoU2jCBTtW84L
	 66nTQbbr3DcpiTur19qp0ZMtE3pG1GhZPYRpVMKs7t5A/EyyS5TZ39mPZ5NpgCT55aL23
	 iBOj0dtFZCWjBn3QlLXlEnQhZIVazHr6KIsy4ETS+FZPHiDt1gbekb5Ldn9pdKhgmltaI
	 DtVoGTuP9m8pDPgjfb3Atie18mbjqWwT9oqTxEpiQvNruP1nKSHiHixk8bPpf1XfiT4y3
	 fwnBHVHQxShDTkoMS8iJGzuXu8gb9Y6sgI9U43uiLZc6lS0B2ZxQ1umVQFkLx2eN+tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iCjCxQ5H;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6564606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 13:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6564606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iCjCxQ5H
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eabf243d05so389367e0c.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792763849; x=1793368649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lu2xDF4zP+BYqEQ8/1UEOeistALiKOano5sbvaYKoU0=;
        b=iCjCxQ5HdjI8XhwkeaIkn/J4TTeeLTcWOLZFYT3OJohXJ4hnOjPYBG12apjjLURw4P
         saqZ38uMDXR4760pc7vbacu2yXiD/tYwVTqIWH9PRF/+a8u2a2wdXWRQMy+0NUB4hFj9
         8ILnJGO1V0kQPxjiwaKMn0/rJM+fOsJaRL/w4+lCOw2eoJTxjb/qXWhT43WrMZtJbq94
         SEsj85Jdq+5w037IcYfwP+181gIH4qoUCcSmlSUjpFF6/q7cYTtZW4a6rtX1HrHR0XRC
         aLKe9DgcJb7XwoPQM5PbbgQjs0cGSPMnEUpL3xIF6AgBr86cPVVgMhJfQSdobTF3SWOn
         6dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763849; x=1793368649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lu2xDF4zP+BYqEQ8/1UEOeistALiKOano5sbvaYKoU0=;
        b=NXM+62EGLemjb/VXwYOqSJJ/5al/Fh7xHENpDxG7EhMypLpa6OMgLHOx+UXBH6ZIBu
         BQwKaLlQrnJ3pKQ0Qdh6M50VfDBSAKpT+dya4wEOpwhuW+Gb1JXkAdzzEX+Ub4MeG3PS
         6zsr24wJ8/nTD7CD2WHip26UclN+xOsZwWLmH3o9xtkvY6JvmplNxQp6E7/ZGbQhEBzo
         knhQFutNXXAmIsIviKBKVJDeHVR3BWGFAPLyGosG1wE3Yusgai9AUYS8LAE/hrwQGj6c
         s9N2cokUuftQzFcr59/gFT2KR+2QlgwCAAr3ag+pH99d4tbvn77tLcnSciqDHTDB33+I
         sxnw==
X-Gm-Message-State: AFq9FYIWbqrExYKPbDcbbq/QvshCRMN1RoRAtcLlXQnB3ROvdtESB61a
	wDJQfrj7AgtHEM439ZMOA844BiGizSo/5bcuAJ4D97aHKn5EgRKLQY9dp0VPfQXv
X-Gm-Gg: AYBFou2Xr1H2ip2IW+4FpE5pVNAcNyAuCa3iudL9dZaNlNLmy2WArlHw0bPaFMvIMAC
	XSV/7008Qjoypu5vwbjwwGJRvtxRqMu6U4KbNPBSPJyGMYSe3PO2R7PICLhIbFiOMistWrNP6zp
	uf2Bac8pVEfw8OILpwY20yjVWAThifEyETZmu/EUWCQmkIxiz1vL4WEUedcEkEJYE+ExKSNsF6t
	ZJ7L55rFoD6oQlYTk+CKOFM7XTPg7hC6jTvRFosZ855ObhC0q1eBX1Hx0MQiWvy2gBC24gJBBv9
	6ALe/TO3Nqg21Hi59FV8PKO89WXhuN9g7Uo2WZfEVZsdAX4YIxXcml9b3vK+BqhttoO4svvHiGn
	iChPclmpt2qdi5AOS4nFpuXJTtrZRaTLcvHedIcet0XBVD1sLEhec2UldwYt6AXbzqCKEEBRSWk
	3dXAtjOhGSrOLMQ/+DArdSFUh3fDUQA69VwaKyYYerfmrU+Es6ogRIdEbuEZu+22hy2MSbmOIHi
	kv3fltkRhYuc6x1/cBW091eCGPbu+D7ezhmkgvZPS0Fw+7FhQqnJ0llWG5fLywRYPLGWtBVaqv9
	luGGlQ/+Aw85qDDN7leVZhc=
X-Received: by 2002:a05:6122:e184:b0:5e9:6d96:a910 with SMTP id 71dfb90a1353d-5ec148d2971mr815504e0c.3.1792763848631;
        Fri, 23 Oct 2026 06:57:28 -0700 (PDT)
Received: from Biostar-A520MT ([187.94.15.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec1feb44desm161827e0c.5.2026.10.23.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:57:28 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Breno Rodrigues Alves <breno3011alves@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH 0/1] exfat: fix bitmap lock ordering and inode cache reinit
Date: Fri, 23 Oct 2026 10:57:12 -0300
Message-ID: <20261023135714.49481-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Two correctness fixes for fs/exfat:

 - exfat_alloc_cluster() checks used_clusters and updates clu_srch_ptr
   before taking bitmap_lock, allowing concurrent allocations to
   observe an inconsistent bitmap and potentially double-allocate
   clusters.  Moving the lock to the top and routing early errors
   through the existing 'unlock' label closes the window.

 - exfat_alloc_inode() relied on exfat_inode_init_once() to seed the
   cache_lru fields, but slab objects are reused without re-running
   the constructor.  Reinitializing the fields on every allocation
   prevents a crash in __exfat_cache_inval_inode() when an inode is
   recycled.

Breno Rodrigues Alves (1):
  exfat: fix bitmap lock ordering and inode cache reinitialization

 fs/exfat/fatent.c | 13 ++++++++-----
 fs/exfat/super.c |  5 +++++
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.56.0
