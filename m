Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C631E839
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102894; cv=none; b=PXeAnbhDxhUhBINjj5/7IhvPVKoRYnxt8Q0+MF0ouSH05jZYnir7Di3fN9584lnDHVFhax3Zp2VettuPdf8TUvTvCCQRyy4MPA/o9diG3yrOfyxcaKUxXrRNKKMJN3dlZ/8u95hMG5Bs3zwcWaaYkwhAuh9/F2iDWqTFImXw/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102894; c=relaxed/simple;
	bh=PQ5/BK7Vy3rri50nCJ76meVM/jGmLWEkIlBnXqDTyEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeTwm6sVv2GeueHnC4UBlQGSxN35L4KxJZqcbVyUu1mOpItdq5p0h5SpX+r4ZmyxvP+BTxfTcqulr3KhyIMe6ZlT5HuhxgRgF8HUAxlnUaCMMsXX/s+z4LZDkoTPxrw08zqSuuOYViUlA3boSZ12PGUBvF7oTOOUj2CDRb2xgfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=xSBHa5ao; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="xSBHa5ao"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b0484a6de4so12181915ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1774102892; x=1774707692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFdEgLKBQwl/qBMdiHVw8eCe65OPPezRSACDbsiut88=;
        b=xSBHa5aoXw1aaMMcF+QSsD6/ehCU5YCDRpXvyeIvu7cAYYCgWWzB5Rk1C4nWg3O0Mb
         UDXtghkV987NWAUyJM+IdKiBpdpFHAK+64oi4yIcTLC3QBngeOT0FyJRW4dEVghwRDvn
         pmfUlQwXlX8C6zd0bmoibsw9cILE7/jmL9M88wn7RtfkLGVuF0M731QDjvJHujTZiXp9
         c0/H/VS3epK3mBg9ejzXYw4ha285qr/S20qu31xH3Vwbaz997NfGMdIIO8Y1bfoCQa2y
         IUVj0TzGTFYJ+0pW4M7rY2TvCMrihE0RKBDCHvPDpomwPF1qJZM2FsN6YboYFSoJBHvH
         yG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102892; x=1774707692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FFdEgLKBQwl/qBMdiHVw8eCe65OPPezRSACDbsiut88=;
        b=EMYLsszU4l+PcxE6la9qJmqDyUx8ZCngejO8cYAPMFdWMd4XIDNQLSGTeRsQLz3lIh
         73q9s/m6dWu6zguB6EW6jiERl+bwyiXXJKgT4LU6gx/250b4Rioo8j1JQoTJbRde0VB5
         ZB9w9klekB9zbT3HFZBiC1Vju5qksMw8Qd2rimlr+EROHPEwT+OPJTt159U5ReIZ41KG
         l2MSiV8CmiURaNQvRG6hiPDUIAL28jVqTqBrwzozRuEJpSErgCpCU2fJkZwyedUiVVqm
         WHIUwDplHxzMceK2WilpkdGmGYIOV6leXXKWYHF67/EAVzVsUZhCilobJhKjovanUATb
         +0Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVVqovZthyuZnlOiFNkmc5K5vDZPFHR7JVYpg8YM554q5gc68is7HfRjLaEPV3P7W6Jy5DUbK2+QEznTgGW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Ro9ROFYZzn1NK79ax6q15Ke9ji4bZitni0p3qT5XObOFQ97a
	iKyUEZjtxztjXCrORdx9PKF+fFsacvXw+mII4UkYjlxaMFtUXqvJ3WZTx4qNFQ4HTPA=
X-Gm-Gg: ATEYQzyvuhIItGfRPY1fYQNSDIlaH5fqWRfzbOCvtKb8g6JYskYlHdzTMuCtlnqUWvR
	/WGlHFKq2dcjtxO3sIbzyKuUE9CMYn6YEYe9OAyEmFD34W24LdAJBQSIqbftstAToJn0iK68E+z
	GBr7GlHy9imp8w1l6omrqC60j3yTL6b42mjSO5Pr0zjz+fZ++GrAwkIuamE6K9k0fRgeJyX5Aul
	Bhjn98nTGKw6V2K9NQ1fu7cJobIerwJEajyim4fsiIsLtt/D6aMdjPWnriH+WuX4W1gePfVihka
	Q5DmRU1HoL9D3aVGHM4CVNeNCYEa6DpD0Hwgw82kmw/bvKZgCUnRThYpUnAKk3mhwSfGORkOS4b
	fgGq2bOQMqphXwZAud6HTnesRrcMIUDMbC4/8sSPO+vUYgQ6L9Ia+QngVoK3EBvzjqZBUVlrzKT
	GT
X-Received: by 2002:a17:902:eccb:b0:2b0:8106:f3ad with SMTP id d9443c01a7336-2b0827c7f52mr60674775ad.29.1774102892319;
        Sat, 21 Mar 2026 07:21:32 -0700 (PDT)
Received: from gpc ([2400:8902:e002:ded5:78c1:8178:95c1:6ca3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656df5sm70621765ad.44.2026.03.21.07.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:21:31 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: david@kernel.org,
	usama.arif@linux.dev,
	willy@infradead.org,
	baolin.wang@linux.alibaba.com
Cc: r@hev.cc,
	Liam.Howlett@oracle.com,
	ajd@linux.ibm.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baohua@kernel.org,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	jack@suse.cz,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	npache@redhat.com,
	pasha.tatashin@soleen.com,
	rmclure@linux.ibm.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	vbabka@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5] binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for THP
Date: Sat, 21 Mar 2026 22:21:19 +0800
Message-ID: <20260321142119.102525-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320171115.93235-1-r@hev.cc>
References: <20260320171115.93235-1-r@hev.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One clarification regarding my earlier comment about compatibility with
cont-pte.

What I meant there is that the alignment logic in my patch does work for
systems with 4K and 16K base pages, where the PMD size remains within a
practical range. In those configurations, providing PMD-level alignment
already creates the conditions needed for both THP collapse and cont-pte
coalescing.

This does not fully extend to 64K base page systems. There the PMD size
can be quite large (e.g. 512M), which exceeds the 32M cap used in my
patch, so PMD-sized alignment may not be achievable in practice.

One way to structure this could be to treat alignment in a layered manner.
My patch focuses on establishing a reliable PMD-level alignment baseline
so that THP has the opportunity to form large mappings where it is practical.
On top of that, Usama's work can further improve behavior at smaller
granularities, for example by enabling cont-pte mappings when PMD alignment
is not feasible.

 			/* skip non-power of two alignments as invalid */
 			if (!is_power_of_2(p_align))
 				continue;

			if (p_align < PMD_SIZE && should_align_to_pmd(&cmds[i]))
				p_align = PMD_SIZE;
+			else if (p_align < CONT_PTE_SIZE && should_align_to_cont_pte(&cmds[i]))
+				p_align = CONT_PTE_SIZE;
 
 			alignment = max(alignment, p_align);
 		}
 	}

With that separation of roles, the two approaches complement each other,
and we can get the benefit of both without changing the core alignment
policy in binfmt_elf.

Thanks,
Rui
