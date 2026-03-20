Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820ED28CF77
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020137; cv=none; b=XvjapDVHHUcRhxinTJf35Q9lMgJFFDzfA65kFti9uy2Xm+MghsOm/el0Q4wA3pSPV8qfdxiaN+LotZAmhPq/sinP9AGHVCdJgmyPqG3EoRTDETDCoeRyJ+uud2skAHx6ZYZO6ZatN/yrl86dYpvzOuqx0mV7/ztmaFkPjmlHHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020137; c=relaxed/simple;
	bh=wzjlx6/m1IF+o6ZzBjmWYJBkrfJsCLPieNSYuu9n8g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KchXxFbFphMKwW7I9M9sXhZWUAuQ17BCtBulfZOyaWZYBxpSWYGSI5H7k+YkialONk/Y/HltpXtrG7MLtMcsu4t/04zP45opvjFAf3v/8ak8YJHQd0PlikuXOXbv3UhXdgpdJRgqABgOSXYpeBubHwMwfDUSYY1lge35NVD5h4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9mTWDVf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9mTWDVf"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a1d4a095bso1246687a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774020136; x=1774624936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vug4xw51SY7nIDNg+l1R8UK1FZuQ1hUqr+zLZCuFim0=;
        b=C9mTWDVfYS5kbpZd7zahmMqe/eFjWNV/hxNZfq3DO2h05YNXra3erzp/kOKpygYjbg
         VYHHL0TdAlLxnPp/A9Cs1jEYvfNg7t2QWvszPE6IRx2Uo43MlLkjUwfP9PztAZSOrRZN
         brE2i7qeBb11m4OoU2gAOMsGM+E3nXovq5lI2BGd8bumo2Nu8yZb10S545jwGYwKhScB
         pcGSwdQJOr1tDt++ie3xACwuPKAUSBhzmqjS4p2iCT2giFSJOPfzCTSccBfkPfMGW45w
         6PlwQ2DqVDVzh8aMeFe7HUqbLmS8mTZwH7i00+6djtjkaThvXxjj4cfrlQZhSD8AVeKo
         Yn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774020136; x=1774624936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vug4xw51SY7nIDNg+l1R8UK1FZuQ1hUqr+zLZCuFim0=;
        b=jhLrPfk9g33Gc9alillydCTMTmnpMwxC+nRfZMLaT8ZcPGypAyQD8nybRai3YUYyY4
         NVsMw4J2H7ZlRs1YVV8aUbs6F3BoB1qdkHFChcPeIgd7V2bpC+U24BkM2PLMOdhKLLIP
         sBryfcyzUI/DnqxV/tlR56I9uxyJnWMvUjpeQtM5XFWII7IeBA2fSqOavCjDedOmKn2x
         uBsJIUCvR1RM/6Fh0zeDBD/pkO3ImdC8haqrrRY9w55R1FBuUX2eL1EjujBoo7cCqLUA
         f/Xjg47p5gto3Piyh77AmOiTkadP+HXxV1TQv+80aQ5RiKhS8Py7LPUyXt+gr61CztSc
         txtA==
X-Gm-Message-State: AOJu0Yz6sySRBzur9NOOpnBu1ydRKgApvjZYf4KS6tjTBTpsZNb8Q5pJ
	lGeRARkpYWu/wcQvB/MttPvNEsaswfdeLg4td2GMhDkl1eIQKxKt/kHD
X-Gm-Gg: ATEYQzyWbeZiRtlkK1v0AMwF9vW7Oq3HeVhZQYF/93mIevdab+I1wNTJCwkYOPqvvKS
	bjwFRjTaVTTRCLI1JYI3OC2g8hKJas44VeFrAxkVAw0G24KYyOmiWz6vZnysVvf1MIjIUMJUfml
	Xty8mwMJzoYgg4dtPqNPN6CRO2VMpKKoIBLuftZ3ezvm1WqOVBbkQ90s4ejT6ueuC1eYywu8Z2A
	HNZF8zBKMl+7l6qDmFvBA5a3nlUtZKYkMqdUGc/LIe30t6XNVOTxHt2tkOuYLYDcnwdkCoxvjyK
	ystx3YWPiIzWuQm3fI4/5Cxd1gBD9T+ikmM2//UMgss9rodb6JalhVpOuiJdOVlqnz6eaza5c8S
	yeXgzNRKceiZGHRqpscc2gvt2p9vjkBORv1WRxGHfiIz5yWsGQb9VujwnTTSIUYTOmXiYbbiEK7
	wZE8SWWPXlAIc/vL1YsEmLGlnc
X-Received: by 2002:a17:90b:28c8:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-35bd27807c5mr2363550a91.8.1774020135892;
        Fri, 20 Mar 2026 08:22:15 -0700 (PDT)
Received: from paeyz.Davolink ([49.172.60.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc60174e7sm5848715a91.6.2026.03.20.08.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:22:14 -0700 (PDT)
From: paeyz <iwasbaeyz@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	gregkh@linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Kees Cook <kees@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] adfs: validate nzones in adfs_read_map()
Date: Sat, 21 Mar 2026 00:21:31 +0900
Message-ID: <20260320152131.34551-1-iwasbaeyz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026032021-renewable-control-9c81@gregkh>
References: <2026032021-renewable-control-9c81@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bae Yeonju <iwasbaeyz@gmail.com>

Hi,

I tested moving the nzones validation to adfs_validate_bblk() on
6.12.36 with KASAN enabled.

With this change, a crafted image with nzones=0 is rejected during
validation:

  ADFS-fs (loop0): error: can't find an ADFS filesystem on dev loop0.

mount() returns -EINVAL, and no crash or KASAN report is observed.

So the issue can be prevented by validating nzones earlier in the
validation path.

Tested-by: Bae Yeonju <iwasbaeyz@gmail.com>
