Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463A365A15
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773494472; cv=none; b=Bz39dIt0nnAPuByZiOm04SnBvgHwn8Vmh1xJxyXjwwEgCOZdSabOUENG/BacOAmhc18ZfTYGvDp6M4/jUOg6yQTNY0z9uflpFjUdaPuT+4RqpOatMq7u0C6MhDtQOagdOextnw8q2fj9vibkflQbnM25TETDpqoX4BzibziDkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773494472; c=relaxed/simple;
	bh=hKSCkW0BeK5up66BRXXiiTYFSs9Fl6al4vvswcco47o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfrDa7H8shMvzLErW9jVyW+YokcDm+HWx+lyq1UlF2vNG92YI1FGZGgcz/fQ6cknz41LemGnIjSMlx2MtIbLohsV6vcsPGZi87fwXBdk3eltekAiU4qAu0f7w0Zzki6UX/ZFDDDwoRzM1B05ycfgHyd4qwJyTiiNDPf1/FHp2ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=AIjpBLKo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="AIjpBLKo"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35b905a05a8so140824a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773494471; x=1774099271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKSCkW0BeK5up66BRXXiiTYFSs9Fl6al4vvswcco47o=;
        b=AIjpBLKo2iWwKzi53i3wPcgNcYznwcwWiXj7CHSHLkobjuiYeHoV5Q88X1Y4mwBZ5s
         A4hrVP9kJDXAzMLM+rDdA75XNEiqcMo8iiF+yAlxGv3HyERB8IdUScVsrOY/uZ3kF7vT
         LCfzGQGk3qF9V6qXV1E5r9WxYfgRlWFwectT4GDpWnEx+IHeXsMswtrgfy3aGCaKFYPl
         HZR0iFuut28KK15rbO70WGNphAu5ON4ChKs3B2/8VOBSBtc6O0jgaj1jz2A+t6HW1oEd
         pjekKIlwlm+DzFVNJgv6FaVSWg3w/+vhrIhy4+I+LRJQ4q1H7DcelomwoO7We1fJ8k7H
         yKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773494471; x=1774099271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hKSCkW0BeK5up66BRXXiiTYFSs9Fl6al4vvswcco47o=;
        b=TT3lLtmt1hzAaotXtoDuPy2jGP8+kQBSV1lSe/g07EwBlZuwo4awC/hp4vTVXTjNpd
         Sc0ncNRHIy3xEUHyMSSv2ivlN9pWvT16mCI23dc1h/CRBVuUhXISIhMkJ7SodLwtRjFW
         qPQz4GT0UTPJoP+TpZoa1fHp2IhIz5r47j0nZNCWxdT6DlTMx5zLsngoJ5ihcXvnbDxH
         B4WXdjt6Mypj/XILZdENp8OtJwX5zEgOOWCp0jPIsMklXFyc479JYSMj9DnEFDTnOgno
         PEo6kVylV2I/jevG4cXIsXFDKXJ3DQjryMC/xFvZL3nz2cbBJju/r1GzRRhyK2KrV3RI
         otWw==
X-Forwarded-Encrypted: i=1; AJvYcCUL+o0E4owvOed9kQYUpPpNfYJGcrG4No2LFSDXGYC6qA146yeZBfA1yvrfXyXmTNm/yBGyqWhEW2LAEnpF@vger.kernel.org
X-Gm-Message-State: AOJu0YyqN4EOR27gf5HO/vrH6+wr5uvBLgCG00C77Y168HGSA1VJmroT
	uuA/MxwvOdPq4nXDX0WbHcdjkee7FkSKNvzqf432F99VfhZqPaI6YnBxJORPNHzCcXg=
X-Gm-Gg: ATEYQzz+nCoOEs23W7ljQUXXXei/Ishgw8M1JJflo/fB9Q+r7HUzMfE3ti+6JeZvJCY
	x8YP44oXRd/Sc0oh4oP9RcpVNBw//V7O3b4bMwesR6GXhZUDPxkULVch7SGTomvzPTWHvDEzsV2
	vNxHO6k4Dur+/WL6RegIqwAyM0WrJdiHqy9ykfQXfYTEOMPtdGWZcU8gCyYp8MqEqq6yGMN8tAO
	FIhS4oHJGH1vVxAmVvKftMFRJH+lpJdplLmkc4HxpFvFXjKfCS3la1WYaIww8xXCO00R8gsJybQ
	krr0Oz8dzzM1PyN67xOuBDTyhCZR0qbhYgdBjSJq2Y8npkImWKhHSDbBMsmvjBya1Cue0PuxbQO
	Jy9pxdWLwLXsOczbMbfcsnp7ypHLqntQmjTl20Z8VX4bsCmybt67keaYJ9Q0txo91AElp0jTov6
	Uy
X-Received: by 2002:a17:90b:5306:b0:359:91a0:98fc with SMTP id 98e67ed59e1d1-35a2208bc41mr6562451a91.21.1773494470557;
        Sat, 14 Mar 2026 06:21:10 -0700 (PDT)
Received: from gpc ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a03005f7fsm11288866a91.15.2026.03.14.06.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 06:21:10 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: ryan.roberts@arm.com
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
	shakeel.butt@linux.dev,
	usama.arif@linux.dev,
	viro@zeniv.linux.org.uk,
	will@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com,
	WANG Rui <r@hev.cc>
Subject: Re: [PATCH 0/4] arm64/mm: contpte-sized exec folios for 16K and 64K pages
Date: Sat, 14 Mar 2026 21:20:38 +0800
Message-ID: <20260314132038.223901-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cfdfca9c-4752-4037-a289-03e6e7a00d47@arm.com>
References: <cfdfca9c-4752-4037-a289-03e6e7a00d47@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ryan,

> I don't see how you can reliably influence this from the kernel? The ELF file
> alignment is, by default, 64K (16K on Android) and there is no guarrantee that
> the text section is the first section in the file. You need to align the start
> of the text section to the 2M boundary and to do that, you'll need to align the
> start of the file to some 64K boundary at a specific offset to the 2M boundary,
> based on the size of any sections before the text section. That's a job for the
> dynamic loader I think? Perhaps I've misunderstood what you're doing...

On Arch Linux for AArch64 and LoongArch64 I've observed that most
binaries place the executable segment in the first PT_LOAD. In that
case both the virtual address and file offset are 0, which happens to
satisfy the alignment requirements for PMD-sized or large folio
mappings.

x86 looks quite different. The executable segment is usually not the
first one.

After digging into this I realized this mostly comes from the linker
defaults. With GNU ld, -z noseparate-code merges the read-only and
read-only-executable segments into one, while -z separate-code
splits them, placing a non-executable read-only segment first. The
latter is the default on x86, partly to avoid making the ELF headers
executable when mappings start from the beginning of the file.

Other architectures tend to default to -z noseparate-code, which
makes it more likely that the text segment is the first PT_LOAD.

LLVM lld behaves differently again: --rosegment (equivalent to
-z separate-code) is enabled by default on all architectures, which
similarly tends to place the executable segment after an initial
read-only one. That default is clearly less friendly to large-page
text mappings.

Thanks,
Rui
