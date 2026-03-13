Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D50A35F618
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419783; cv=none; b=HSKOMJGUdsOKPU4exk64fStRCWMXdjIOUowk6YdN43ZNhMkV/CSE4NExxMdwsxEB0v2CPuyFWh8QTX2BbL1SR8Fd69R9z2J1QYOFDBM+x0p02TwDnkhfQGbilmaLfHKhdsalx53dJRzgyKLHBlXWXZSNW5cUCsHthChDwYeZXE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419783; c=relaxed/simple;
	bh=BmW48dokzlNwa31Po4pUO4SpcA0MMj2odF4Gvg+WTuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rS3z9yzzEPKxf4GYFmo9UsiHxKzmJED78jvXjcKtr+G7UFz+kvNmwg1wJRyiO9z3ol1FJiWKO8KTjsnghdr3fp4PMZp5VBgZBEw0D43GUvgOygJJLA4GdH9kNokJb1Bdy2qndgVt7tqe5pxHfhVgNjLqzB8tXMSWVOqnciLR19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=kMz+j2cR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="kMz+j2cR"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-359832fc558so2028889a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773419782; x=1774024582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+bv56JD7xnnmkG1/WXNNS8xw0C/IEr4oRQdePf+aIw=;
        b=kMz+j2cRhh5ORI5HzZfc4iZFbsvxsfQ4d2MygmI2hO6xzQRIyBQF917WQdfnY9wAdn
         1jG7dz1xUtebXdaKIYZdGmJm1aQiOJwyVsLXOa/65tEJS7mw4vHpBNqPFArUOWFDqTk7
         D2vx6CKCw0PiITax7lx9+6gMMBkaAt0nt0j5k3jr6CTfewSM9uDB+bF2rgqT+tDtQRgP
         blODH/EoA+9UxhlDG3kuT6MG6wBwCABqoTpvNOm+uvqjbkVYChSYx3wcLmreBJyH+BBi
         fwE4XVeiWBuGXbLmblcfdtD5vug+xxu46eeOTl9YklTUAjWbLExKlWJD8sjZREovkoRk
         EMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773419782; x=1774024582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+bv56JD7xnnmkG1/WXNNS8xw0C/IEr4oRQdePf+aIw=;
        b=UVUNVaWnhhFTtANP/z14mX8EwruTGOQn8ILN9yzra+KXJBByYOoKsvvPyPuo+lRAvu
         RA9iCk3LgRli/cTSctZuq3zl1jq2ScMT7SWt2PjkAFNj0l4h5sk/9NeTgG9zAGKcXDSx
         heHLdwkQ43AzP0PsrjHv8zg+buA/reg6IDdrlvbO7iC5H4l8PmEg5aDNwxodWS1dg9jp
         ntsbmm9CiJZJEbDcNEeMnxN8/pdsOm1Zsmlwjmj6yiTIqOXEcKUGyVCD7blEcNB6qZU2
         RlahFTM2Bdu9UA0Mc+m6nO8oeWtvc//AZJ/dr8/GV/fThEnAX7cVzHvj293n27m8IS8A
         hMZA==
X-Forwarded-Encrypted: i=1; AJvYcCX0UXaJapCA+ySkg/BywrqUb/My1y/cGjiH1x9jja0tavS4TinBxqv9sLK6ksjhO+nw/mIKajFW+jo83Onq@vger.kernel.org
X-Gm-Message-State: AOJu0YwPm6wTs/0wRefn4GBiR/uCwwGDRNcKOYF59Vax/aN5CcWWJUth
	C++nA2rFySK8fiOicDj4ftI2/qkNFk1AafBliDSc0L2ZOT406NoI2rfQgewKGORhnuk=
X-Gm-Gg: ATEYQzykCgP+TjYlzcJp03PqUHdWpNoqVpeipK3zlP3ubeXEPA739ZIW8k/HGPCSbvB
	KHFJwds2or2gKvLpvy3jeKoCJhMeCbly0tblwHJQ7T0EMfBHOiIMAWuzBJdkMDZGindVi2kMt7t
	3741ix3Vy6XeQwvCQguTEI4nbTKmIu5u0peQSLbo+OFZIFJqJeLzF46pW6YV6yLTwLmYA/0IowF
	WLoFameH0PrsUo3vVEsLgLxq1bbnFCZsG1GNiLARqRO5sFbJR7aNlMZg1C9eLiwkNqw0XOnWdxt
	3IsZyAdPf2eiDg2UBNQHHzZ+dTmOuGpeYEsYUfizBMtRFNfOmaAdrASfk+BVTvrjjISB47pcQcZ
	Zq6/erGohQHai4QMc3KLpv6ePNvwOKpgMxysRoNKKAS6cKXSvUtU/CbUnUbLtEcgugVVj3OOZu3
	8lIEQ=
X-Received: by 2002:a17:90b:278d:b0:359:f3ec:c773 with SMTP id 98e67ed59e1d1-35a21e4ee48mr4110674a91.3.1773419781856;
        Fri, 13 Mar 2026 09:36:21 -0700 (PDT)
Received: from gpc ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359fe40bed5sm9754313a91.5.2026.03.13.09.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:36:21 -0700 (PDT)
From: hev <r@hev.cc>
X-Google-Original-From: hev <git@hev.cc>
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
	rmclure@linux.ibm.com,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	viro@zeniv.linux.org.uk,
	will@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com,
	WANG Rui <r@hev.cc>
Subject: Re: [PATCH 0/4] arm64/mm: contpte-sized exec folios for 16K and 64K pages
Date: Sat, 14 Mar 2026 00:35:57 +0800
Message-ID: <20260313163557.147948-1-git@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310145406.3073394-1-usama.arif@linux.dev>
References: <20260310145406.3073394-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: WANG Rui <r@hev.cc>

Hi,

I ran a quick bench on RK3399:

Binutils: 2.46
GCC: 15.2.1 (--enable-host-pie)

Workload: building vmlinux from Linux v7.0-rc1 with allnoconfig.

                Base                 Patchset [1]         Patchset [2]
instructions    3,115,852,636,773    3,194,533,947,809    3,235,417,205,947
cpu-cycles      8,374,429,970,450    8,457,398,871,141    8,323,881,987,768
itlb-misses         9,250,336,037        8,033,415,293        2,946,152,935
                                             ~ -13.16%            ~ -68.15%
time elapsed             610.51 s             605.12 s             593.83 s

[1] https://lore.kernel.org/all/20260310145406.3073394-1-usama.arif@linux.dev
[2] https://lore.kernel.org/linux-fsdevel/20260313005211.882831-1-r@hev.cc

Should we prefer to PMD aligned here?

Thanks,
Rui
