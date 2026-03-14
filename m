Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9134EF11
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481846; cv=none; b=E6bAGi/OWGDyMlSNN981nWoKJ/tc8TH0SR63frJJvjHz794yETl7A4RbhBxAwTFicF26B2LA6+IKF+XVbEG3v7cpbzdzRIHuM+gmbZ3LL3bzYNxvg8qmGWrVeaGZBUDviYXoJ/c4FswzuxsVPr6sDq0iCXkYGbMyoHe0q94DTcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481846; c=relaxed/simple;
	bh=UtLsqGqmgw+1joNMOoNLl59Rq8QZjqfWHWtv+oAVcpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDzLSWZPhmMsYUTIJO4lHARoUlckvmH+5NxMurrJeAHrwuVPX+perZvWFEBiy6v27zhHX6fhdRl+DW2ft25PYH2STm8J5JTh+l0CHCKbHTa4VNOWNX7kesH3oMzF9zbVqPbDMHqsj5s+GTtCOQ9atcWFeFz+8kIoL+hUoChkwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=Va9MnArY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="Va9MnArY"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so36790555ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773481844; x=1774086644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+89Xi37wcYlP/W+L3Ja1g3s+pCfX5Ep20EarskpAcwM=;
        b=Va9MnArYnBnG/qbos2TefMR0C3oose51D4zkcFOYvvASNoX29V0cnSj0A88P/dNSFA
         A720gjBVxC85iIFRpevWaBqHz6Ddrswqfwf2mHAjT2HOJg41JhCDVvRoKpVD7DXUvlHI
         zpelIkLLJc/vDaK8zV3wDvTfSHxW0blNlOgAPsPC+E3io2GDwjvgH0Kt3/rpCmLugb72
         epmh4Qw/dg3lJAiWYtNygsTw2y9Vx/JwAXusxw+nHExVwQnXCOc6+37B+apKBp0SmQ/r
         j1mZWCxERyaEpb2EX7KQsbtaPD6cJHVqnu80TKHLpNenCZu3HxHpRSW6tPZN4eR9qtae
         xmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773481844; x=1774086644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+89Xi37wcYlP/W+L3Ja1g3s+pCfX5Ep20EarskpAcwM=;
        b=mAROmVFm6pWt11ie1hnicazCGC9GDlHF1nec/Siq1iM8wN5kd0lFPAeOruukk4A/hd
         QDo4i2bmK/lSKsi997RvRTOsTi16WkcyEp648hcjbD79DmNdL1bB6nKpHRvhgcVKTQOo
         Yn/cANsMVG6xpN5j4KwhNllrppNoIKK3RqPlA68jsdtwzkJ4IS6ks0AikIxmBlmZdGOu
         a8fDtrU0IStdY4WvqKiEtXdFCo4GAkhwOmC9JUiEI33HYspnWNxVuYCouvT657AfJ1nZ
         qImfehlor0zigTKxVQ5G+/HI4f6ZTnNX4lKx04gmRl+l0cvZtKIlzzzPL+utZenuvwEA
         qG+g==
X-Forwarded-Encrypted: i=1; AJvYcCUUiU62cu9t2PF9qhEprVnN22iEQEKgRYresN0EYe0JGAKtbgRWLWXu5LiNPDdVv0EMOJoY40J1ufqBNXPs@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxD2f0ZZeS3MQ2fiZiCnsWzTLDfPide66FKgWNrDZ0REZCsEB
	PKL0Ivby8yrqjKi2q2S9ua3D9HpWUL368sJmc0/dwqKJE7Fn+MKhyRQPO0Yv0RrPvPw=
X-Gm-Gg: ATEYQzysQ1fYQ3DmHYaNYqx2tEuqqf9TDAn3gyF3HxCWHfECL40p9skbK/OPa2OgbnH
	ykrZmDOedEXlgMPuujMMTgLYcYUxYjCfHPgeaVLDIhlZgnlo1PXiqyPjCXW7jcmmTsCvGCCSbU/
	+MK4sc/5Bw/Qt5/9j6saK3/cU9KeAb5sIBH5Bvh04VqN0mcdr3eR3SK853k9srsYk8oGhRHg87n
	WQAkJBDm7leDiVzWujHyt8z7LVDc5zpgYppcsrTBKiV3bZlT95+aD6YKaaG3flDe+oa5EwYKpoB
	ZZPWzqcv/2fWdtCohYaMAF1ZpGoi0Pn737ocsqB3jVWS4vz1a23nmUuJ3d74mfZBftWgEdOs3SM
	j1IcwmS9iqzBRjmXMIr6xSqfltt74QltWC0nxGHMusHWKDe+cFBDl8xZmhSUK7S/eBvn+NUaXPI
	CFsMGToYCv7UU=
X-Received: by 2002:a17:903:90f:b0:2ae:59d3:27f8 with SMTP id d9443c01a7336-2aeca999738mr61011205ad.19.1773481843716;
        Sat, 14 Mar 2026 02:50:43 -0700 (PDT)
Received: from gpc ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece5f8dafsm47520565ad.26.2026.03.14.02.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 02:50:43 -0700 (PDT)
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
	rmclure@linux.ibm.com,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	viro@zeniv.linux.org.uk,
	will@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com,
	WANG Rui <r@hev.cc>
Subject: Re: [PATCH 0/4] arm64/mm: contpte-sized exec folios for 16K and 64K pages
Date: Sat, 14 Mar 2026 17:50:21 +0800
Message-ID: <20260314095022.217231-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310145406.3073394-1-usama.arif@linux.dev>
References: <20260310145406.3073394-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I only just realized your focus was on 64K normal pages, what I was
referring to here is AArch64 with 4K normal pages.

Sorry about the earlier numbers. They were a bit low precision.
RK3399 has pretty limited PMU events, and it looks like it can’t
collect events from the A53 and A72 clusters at the same time, so
I reran the measurements on the A53.

Even though the A53 backend isn’t very wide, we can still see the
impact from iTLB pressure. With 4K pages, aligning the code to PMD
size (2M) performs slightly better than 64K.

Binutils: 2.46
GCC: 15.2.1 (--enable-host-pie)

Workload: building vmlinux from Linux v7.0-rc1 with allnoconfig.
Loop: 5

                Base                 Patchset [1]         Patchset [2]
instructions    1,994,512,163,037    1,994,528,896,322    1,994,536,148,574
cpu-cycles      6,890,054,789,351    6,870,685,379,047    6,720,442,248,967
                                              ~ -0.28%             ~ -2.46%
itlb-misses           579,692,117          455,848,211           43,814,795
                                             ~ -21.36%            ~ -92.44%
time elapsed            1331.15 s            1325.50 s            1296.35 s
                                              ~ -0.42%             ~ -2.61%

Maybe we could make exec_folio_order() choose differently folio size
depending on the configuration and conditional in some way, for example
based on the size of the code segment?

[1] https://lore.kernel.org/all/20260310145406.3073394-1-usama.arif@linux.dev
[2] https://lore.kernel.org/linux-fsdevel/20260313005211.882831-1-r@hev.cc

Thanks,
Rui
