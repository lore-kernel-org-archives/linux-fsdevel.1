Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C0B3D0924
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834439; cv=none; b=qi4dNaVK0DYRUGYalk9tgGmpTCXIPZf7LQD/Y85P0eucsOHqAOe8ReWHDLfDlV4C6OSLCePby9qtxBndajKyudXCfwxLpmRs+yLcXgArEx/13YFXPa5f6lMM9QfmF5lPR8SsOP4305ZS83+Pd45ubnTeXqAfVtXz3xRXmyk8quo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834439; c=relaxed/simple;
	bh=cZuKarhYJDEptiuTIA0AdK0CNpmejV6Po9Z4lTFO+Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=br2VQDkJNoV77oejiTyBdEf77vgYfkP2qjxmNPBMynOznPPvW62490qZCqmIXsz2YkEkzS6+hzSJhhU/v+sL4Kkt6VuEcebRiUqSz+u3yd2y0gHhxE1V+AvqFSUH5uLiv3AjwG+5gRQxM4gJdAd7SMpEYTO23sbdmaVSRBUvftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=Ki5bZHSr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="Ki5bZHSr"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829a27414a3so4218082b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 04:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773834438; x=1774439238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLqnHb2ogCoxqHkELJxhX6U8ujBBduz9IxDDxqOJz0g=;
        b=Ki5bZHSrVu0jmUa6Di9wxc6KJQ298fYgbGDbtDncJKgJyFZnOaFOFbCDqk5SnBuQQj
         R4xK0ZFEh/pzPtq/lnio8o5AMgNRfcMbG1kWFxw2QyIj/i8OUSBM37cjSpBaDjcEyLHe
         oPQMZQAOS/KmxPgt6YtwjMFJXOi9QRNtHuTYH8iBbyxhppjgYq5FBRWJRzXBQktsVcgb
         fVnVPABqBW+iotKROj9TtPlwarploiEolY4sd/xRHpM2vFPBvGbGgB9b6QGjbOAsd8Eq
         qy0HwotCEeDHCTXOz8B8nZT4RMt2GFJXvvFgDD8kp028wO3dYlWCRIG+h5azxqSaTDU+
         jaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773834438; x=1774439238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLqnHb2ogCoxqHkELJxhX6U8ujBBduz9IxDDxqOJz0g=;
        b=qsPXGaeFjnVK+87iSzxwjTBrp+n/Pr+X9h3geuR5yXXq+1NFp8aP36gn3B2QfoVyAx
         McF24DVkB0Xg2O9ONf0vHO4m6eaZLyb8XERZSLeNVN0Di4cym8zQigremu7J/QADYjSI
         oqf3hfUKT/c0hW6zN9WrqbZ2oXa6AC1C3L2J2XyDXjDx7lZQzc2YEYf4wallHCgIxc9S
         hGKcTwsd4f2WrS3/UBTXX24uIqpw5avgEUXhV4zQWzXulL9ZXCPKR57x+jWUJhe282xJ
         iMZSKEYDmnWsXDd3+YYNksyXyk2amED+FUPo/DXz5CpgI9par3SxUXy9lxTQ7lJVsN9U
         Y2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXipVU0No9w8UUWDx8KRIfap6EAjua+dQf0M925hToiohLpKgwLa3j1NJksO9nrGi3el44eRSgzPqtN50ci@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/IDIAf41OISaqQNcgZthCPaovqLU0huP2aPFLvKe2RFARnE4
	S3Cg6C20iD5mfoFfOWE/QiHnLDie5Ir7cWBFe1Oqz63qsTRWZZy2U0FtKpC599qkl9I=
X-Gm-Gg: ATEYQzzy+1IiGMIjWsGKy8SYWdesR1zckgE7vQcoGDDeq9qIP+2gQg24KfVnR7wNVju
	W+qiIBhB3TLq4LH8Ttv0CoxJOHpVw5z++wF6S4drmyZWJ4vqZU1XaVdnzApW8llwGgWUdI1QuY+
	e8Jwwu20+jsyFTeTj/NI6r6fgEJdo6SYEweqllLnXYFAf1HBtfp+zcd+0QM93ok3iDb+VtScLeY
	6eY91NSdj4vIGHVB4ztsywSTNiZHu2FZIILb9FGDuzryZue3UGQq3IsIXRq0PW4BQztEABXWI7t
	bewEot9LtxrvoFBGsXejjOuECkxxl2mgw29a9eO/oi3c1QAGnK44I0IYE/Lr3MV/CiJJPgpGR4+
	QrBSIlVG+qnSuXxIFCK/RNU5V8ZhmtWvwOpYP+6rDXJ8xTzN9ox5WRbkYdRKGvfY4fN/8znw2gq
	nd
X-Received: by 2002:a05:6a00:1ca3:b0:81f:4ce8:d64b with SMTP id d2e1a72fcca58-82a6ae4f234mr2558433b3a.44.1773834437848;
        Wed, 18 Mar 2026 04:47:17 -0700 (PDT)
Received: from gpc ([2400:8902:e002:ded5:78c1:8178:95c1:6ca3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bf0cf5fsm3176671b3a.61.2026.03.18.04.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 04:47:17 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: usama.arif@linux.dev
Cc: Liam.Howlett@oracle.com,
	ajd@linux.ibm.com,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	david@kernel.org,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	jack@suse.cz,
	kas@kernel.org,
	kees@kernel.org,
	kernel-team@meta.com,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	npache@redhat.com,
	r@hev.cc,
	rmclure@linux.ibm.com,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	viro@zeniv.linux.org.uk,
	will@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com
Subject: Re: [PATCH 0/4] arm64/mm: contpte-sized exec folios for 16K and 64K pages
Date: Wed, 18 Mar 2026 19:46:53 +0800
Message-ID: <20260318114653.123656-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d0c0ac64-be15-4683-89ec-e32bf4867109@linux.dev>
References: <d0c0ac64-be15-4683-89ec-e32bf4867109@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Thanks for running these! Just wanted to check what is the base page size
> of this experiment?

base page size: 4K

> Yeah I think introducing Kconfig might be an option.

I wonder if it would make sense for exec_folio_order() to vary the
order based on the code size, instead of always returning a fixed
value for a given architecture and base page size.

For example, on AArch64 with 4K base pages, in the load_elf_binary()
case: if exec_folio_order() only ever returns cont-PTE (64K), we may
miss the opportunity to use PMD mappings. On the other hand, if it
always returns PMD (2M), then for binaries smaller than 2M we end up
reducing ASLR entropy.

Maybe something along these lines would work better:

unsigned int exec_folio_order(size_t code_size)
{
#if PAGE_SIZE == 4096
    if (code_size >= PMD_SIZE)
        return ilog2(SZ_2M >> PAGE_SHIFT);
    else if (code_size >= SZ_64K)
        return ilog2(SZ_64K >> PAGE_SHIFT);
    else
        return 0;
#elif PAGE_SIZE == 16384
    ...
#elif PAGE_SIZE == ...
    /* let the arch cap the max order here, rather
       than hard-coding it at the use sites */
#endif
}

Thanks,
Rui
