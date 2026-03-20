Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737E1A0BF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026713; cv=none; b=oyxImkv/K6fIX1SS/RUdZYHHesgMD9pM4agQ1eNfoX4PNT3rmA+g9Om5akiHO64CaYg/vdHDQZxeN4UDDIpLMxLR/vyDWNFpdBP1I+2qyMCB2eatyHoRtXVr4dI9zRZZyooVaY0Q/FOCbodqwHmt98NgmGCqM/vSj7HnJ6UkDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026713; c=relaxed/simple;
	bh=ahNTPAefQMpYMnBF9fjbq40PKYiHzlPr//dFmraZ1KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRR7f6l/nXt12kmaCgXKsS7/6cBIu/UWpJJhXYjo96PZ1/6wCTOvYpyfzS78ZxDIyKe+r9KZTdUSyqTfOlb3XZtue44j54+HQRnLJVg4Iqsp9TGHCCudTTaFnktwAQppcZ2gCcmb7uTFeJ8sn+TTTMr3J0P7tZ3mI+mwgCIqYXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=w5cANios; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="w5cANios"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35b905a05a8so1168811a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1774026712; x=1774631512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahNTPAefQMpYMnBF9fjbq40PKYiHzlPr//dFmraZ1KU=;
        b=w5cANiosQUaccQHzZnp4Sdc2w6iJqpqXNTEvaxLFZ1K3Je+xK9eAu5DzL/auXU+iHp
         LlxiyYlZYnBJ/X+PB4vuCfGHiugqspX+3XxoMf/r/Q2XKi6E9ZWYquiEQSEtMbklzN3Z
         esQkp6tS9pfewcfykMqSnHYg08bdwxHtm5eA4vSu8fOuMMen80YR3I9F3mZUqlIN6cGe
         OwG667y/yr0PqDtft1P/j5jPb4wrgYsHhYLO4bhb3foExckjfXG04Pt7zNLSrnPnpx4q
         lvNclg7rnrxbnCenFfdv3jbiIUGK/264rpFwhKiOTD3BV4/7TMLyqbQLcerPVMxqUDf8
         YGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774026712; x=1774631512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahNTPAefQMpYMnBF9fjbq40PKYiHzlPr//dFmraZ1KU=;
        b=HoalezCcIGOha/UMx8CChiIxmUJsIvAWI0fGi8P4gnGo53udDZm6MjUFGwqjwpGhhp
         yi+Gsnnu9s3/WE2zn4YYwViK2KGzFq90iD4/F5NjA0UgIONk09RlliRbswRKH5kst9nR
         CDgpaB1hUu5DYLV7QehvpNQysrandwjdQARwrUcMymR9OgPL/1UIGQ8J+H3jAjjPMnq5
         9fvxcdii+1w1P8FcYy9T6Y9zMUDtR46063hCq4NsKkukEo9pMM5WAXS53xpoUqP5d9a+
         zjc8WuSL0QeSDeZPcMV/B4ErPdhrtqt7gHiHjgyOqupVQfwpzrpwAIGLERV+SNHCqys0
         3O+A==
X-Forwarded-Encrypted: i=1; AJvYcCUsA/dAkKtDM+IcHHmd3jmxdMIfDtLf+VLKQ7+09Aqc8Pb62UqFkCs7qitWL4ac+jDOSbSRcFvlVcs18Xjz@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7btcStSODCho8NbqipHEMbAjtDRv8YvwvROSw48eozO96Ftl
	fj8YDL/Sb0ChvFgQ7GpEmtkvxUlB7wQon/jZAfrarKgeDMAQ+HOFLozl/btSSjzg3Is=
X-Gm-Gg: ATEYQzwcfo0CnwM7Fnx182Qrm+KEElSQMljSSWX3HgUf4RBPO/DW2v5OflrsvMZRnYG
	Q6zwBaBWSxsFhcbhAEeQ6dWL+hWFRySU8pd0cCjcqQqGjkpqdSWanVhzx8uA1oxNbjEeCEh53FK
	ldYo8vtqNDt3UC7m+2e3dBIWcbZiiyVaC3EfDpaPSxNxvLaBAdrZeimzzONFx3u7LSzwDtNaR+n
	Fu5xI/V8+m3JLAUwjX1Hrzi5cZ1xGHJDMyfRwRP9kKrYcARQzhMybvcujVPueZ6/Jf4C+mTpEqb
	0N10jrQDRsWptsKCxgn2EJ/ZFmHmNleM6IN6zKXtElgo6lLoS6rPDaH4819H9V6M4TvodH2/pUF
	Nd/bDY3O3DEJSYGf/hTyoGx/uy9zJ/r1LtEaUNo0kP9poNvGWGQ/6XJFgQgHEvk40GN/CW8h6l1
	xq
X-Received: by 2002:a17:90b:5108:b0:35b:9cd5:232e with SMTP id 98e67ed59e1d1-35bd2ce4493mr3220503a91.29.1774026712038;
        Fri, 20 Mar 2026 10:11:52 -0700 (PDT)
Received: from gpc ([2400:8902:e002:ded5:78c1:8178:95c1:6ca3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff7056sm6018617a91.4.2026.03.20.10.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 10:11:51 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: david@kernel.org,
	usama.arif@linux.dev
Cc: baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	jack@suse.cz,
	kees@kernel.org,
	lance.yang@linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	r@hev.cc,
	ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	Liam.Howlett@oracle.com,
	ajd@linux.ibm.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baohua@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	kevin.brodsky@arm.com,
	linux-arm-kernel@lists.infradead.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	npache@redhat.com,
	pasha.tatashin@soleen.com,
	rmclure@linux.ibm.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org
Subject: Re: [PATCH v5] binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for THP
Date: Sat, 21 Mar 2026 01:11:14 +0800
Message-ID: <20260320171115.93235-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <024d2480-df23-4c2c-9f2a-1c4a130f71b1@kernel.org>
References: <024d2480-df23-4c2c-9f2a-1c4a130f71b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> Thanks! Also adding Ryan who did the exec_folio_order() work for ARM,
>> and also raised good concerns in [1]
>>
>> The problem is not just alignment for elf, we need to fix more things like
>> mmap heuristics [2] and how unmapped areas are gotten [3].
>
> I agree, ideally, that would all be tackled in one go.

From Usama’s v2 [1], it looks like we may be operating under slightly
different assumptions. His approach seems to key off page cache
characteristics when deciding segment alignment, while my patch is more
about proactively making things THP-friendly so that more code can end
up backed by large mappings. That helps in cases where a segment size is
just over a large mapping boundary.

Maybe what we really need here is to make sure the virtual address is
properly aligned, while avoiding overly aggressive alignment (e.g. capping
it at something like 32M, which is fairly common across architectures).
Beyond that, we can just leave it to THP in “always” mode. THP already has
its own heuristics to decide whether collapsing into large pages makes sense.

It also looks like this approach would work fine with Usama’s cont-pte
mappings. If so, would it make sense to implement [1] along these lines
instead?

[1] https://lore.kernel.org/linux-fsdevel/20260320140315.979307-4-usama.arif@linux.dev

Thanks,
Rui
