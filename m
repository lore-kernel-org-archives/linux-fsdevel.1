Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794544436;
	b=3A6toeNHecpZ4Oz1uh2RzUCRXC5lXMnX2VyIbpk/RvfW3nXENSqFacxV6cuVbZjf/8OM
	 Xk0yFa9x11hOIdlZo8KR2BlYnIybWvg44MaCH/euHBDI8JRb/gsdl8nyMg2KzDQj3KPa+
	 Q9/sF7gmItIH1+oI0YGcaPZiPSPfL3CJtowOtaM4uyPReAsnSDHWUbwYSqWCW2G5gOBw0
	 PDAkH8F/PZr7sUzP0OOo6sB9wH9a39ad9RkgQf6xCvc2fAAbNnl1DfNeu84H2mrmrCl2U
	 U7K0A571xNAz09MjTbXXQ3+9JwU4NABiWiOnkUY28Fi/ulpXmqLPSnwGsAJTV0Gj9Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=5H76beDR155/tKgd6bms2sqDirr/ypiJD3wLDnQnjso=;
	b=OxtFD2GLSoQLQvFTyrF22ftBJYePLhrdNbdRZmDtIyhmkziGe09aelwgSUF0qyysfv1Q
	 ROASJyYxVE4NNiz8wtqBhlNM2+SlFpKH1rcIXrSdsmJohsOBwNcMWzTIEKtDWB9yJlTgH
	 /Vyjs+AilH5oDbb1DWTwIOtGrNwD8CoFpqjlVfMUugytG6lOIN9f2gLiJK1M1wNCCBjij
	 re6xFMPfLLVWau4tpI4OAfuktUz9EXI/zI/j1Ll3p6Hnput0jNjMcadRU2yG2EmhtYHcN
	 bQBC46K81YHgqHa8Wl4LvizVcZZbWdSHZGqa6JhchYZYxXtYQYgZn3omUgguoVQEHTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=UPGLfDoh;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A7B606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 04:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3A7B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=UPGLfDoh
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b1535be329so489720a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 20:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794544435; x=1795149235; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5H76beDR155/tKgd6bms2sqDirr/ypiJD3wLDnQnjso=;
        b=UPGLfDohYxsHcaPM6Ppd29PM/jkGccRp8ufFFmnKG6phEyPGzWVMkgJDAtBHvcg1Xj
         rRAcTsoDb/GkTrXInudIFTl3rYHFHE99RfdDy8mPAGWvijXXF+w5YqCIX/c9LeAeI2v2
         +X6VykhsFWD3A3Wp7EpfkCdVpCYlmSF+Sm0tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794544435; x=1795149235;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5H76beDR155/tKgd6bms2sqDirr/ypiJD3wLDnQnjso=;
        b=oP1/VIHujNJZ9uQctndPwGd2MoZ6Pe9Rm69EWgTDR8oFAYM/zK/kPheHNLuUv50PXX
         1ipoihswnMjnMXx4DdIvvmWP9P/ot1Is9SF4J4hlox2EcbF0Ni4CK/UG81pXEvEfW7xq
         ujdar4G5Gxh2UDAHRzUBHmxVeFxDbfrKuSJQZNhmapEG7doyDkZXcKwa8OATAgWrYOWg
         LSaQdPMziGsuHuu7WLoiEyAg/rNF1NSaLaGUtzi/6qvwIk1YA0iuBhQ5qtabqBby5Tbb
         MVW1BJ1V5xP0pcMf4rII4sQfaNTEI3SzCbNHy55RKnltOBOHK1HAohf4My6WH1X8vlUv
         E9/Q==
X-Forwarded-Encrypted: i=1; AL+hErGxu2hjNvgzbspcJ+vEf6dLQEku73S003rNF6ry4aeG9M2e9ge+biXpxIUqVkNeecUEe4NOKt2YSWJsr9g4@vger.kernel.org
X-Gm-Message-State: APuU4Z9Wxyy9QvCnMP+ohYLkwDEx/gbZ4bLcpopWoyLR+8W1VMWOKJfE
	nb7NV/Ywr5vdLJVP+bMX8yOkxl/NRapkFZUuQiP9VVlnxUNYoPM54GaSOfCB4hmhNns=
X-Gm-Gg: AYBFou3NXP+IvcVubXwu/cczogKY0J53qVag36rP5ZTDJEx99eiK9ARjjiECSimu7pN
	oD+b+1rLlkd6ChUSVSFyDQbatIVKWoFEYaiC6jkNyScymAfCLypHqWo2PfniVdiHB7Erh8kEuga
	u+wQWJF7d4bnPx5DVqGUmuN30yoZHH4+k630A5L55L2lDw5gZ196YsfehQSMCNkab0Z/A42S7PA
	/ZkQ+85JMThFnUx4OBX1+htaTmzvkaD/jvn+pP3mEyq+KyTgMDMx+jVV7E2G1v1DZPUNejMNneW
	N/nza6os64DYuALWiGlkbcFlmbAeeQwD6XBwfj05O+aUaxU3e9l8322PIRMDke6O7vEuN6Y0eLa
	5vZXK5ZIg/BLx4OEztqGI4qyb1Ti6lXvG5ASkJYt5DvwDU9siPWxWoCjEfO7fdqJuYLwpHuENwY
	8JfLUfSgbrGzIGp+KM8dfqR2tToYKPHd3qC8+IjJOU1GOJ07cqpCb4Xq0eXe6mxAcAPmZDBYrRF
	AjUuphlhzJLh5lRO35E+N1mFZSfwax2oazHavNCbf4uAoEacjUzkjbp62YR3qrz7bUolQozVc+Z
	3FLv3HyXGFlQUfaS6T71QsiOSWlrx3E16SGEZh8P5yhhfvv23fqt4rQW/72wygbVfSoM/6ngGiU
	ozWl+Y+CwR+vK2cAq/YTcTp9zsERPwizopzL//INURv1JZGsL2r5DQ6ETpTElEzR/x/RACzuhFZ
	qJhvhwxaXWPHIeIhCywGfXhLqxA3eo9FatvR0GFwibblY5SW+g7hjuq4gfflc=
X-Received: by 2002:a17:90a:c105:b0:3b0:9976:c1c6 with SMTP id 98e67ed59e1d1-3b1b0b8752fmr1061273a91.66.1794544435107;
        Thu, 12 Nov 2026 20:33:55 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197b76ccesm7614323a91.0.2026.11.12.20.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:33:54 -0800 (PST)
Date: Thu, 12 Nov 2026 20:33:51 -0800
From: Chris Down <chris@chrisdown.name>
To: Matt Salsamendi <matthewsalsamendi@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Muhammad Usama Anjum <usama.anjum@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: fix stale walk_end after a completed scan
In-Reply-To: <CAMPWk9NE_epOdOCbs1PGh8OQP4wjTObvjU-1Wopmu7SSNAMXhw@mail.gmail.com>
References: <CAMPWk9NE_epOdOCbs1PGh8OQP4wjTObvjU-1Wopmu7SSNAMXhw@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261112203351.7d5bf7d0f78d652d@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Matt,

This patch doesn't apply as sent, because your mail client mangled it. It
wrapped long lines, including the hunk header and the Fixes tag, and took
the leading space off the blank context lines. git am rejects it as
corrupt.

Please send the next version with git send-email or b4 send rather than
through Gmail, or set your client up as
Documentation/process/email-clients.rst describes. It's worth sending it to
yourself first and checking that git am takes it.

Matt Salsamendi writes:
>+	/* A completed walk may follow an earlier full bounce buffer. */
>+	if (!ret || !p.arg.walk_end)
>+		p.arg.walk_end = p.arg.end;

While this fixes the refill case, ret being 0 doesn't always mean the walk
got to the end of the range. pagemap_scan_hugetlb_entry() can't
write-protect only part of a huge page. So with PM_SCAN_WP_MATCHING, when
only part of a written huge page fits in what's left of max_pages, it backs
that page out. It sets walk_end to the start of the page and returns 0 on
purpose.

Before this patch, the caller got walk_end pointing at that page. With it,
walk_end comes back as end, so the caller is told the whole range was
scanned. But the page was neither returned nor write-protected. From a
quick test with a single written 2M hugetlb page, PM_SCAN_WP_MATCHING and
max_pages = 1, the ioctl returns 0 with walk_end at the start of the page
before this patch, and at the end of the range with it.

Maybe it would be simpler to clear walk_end before each walk_page_range()
call, and keep the existing check after the loop as it is? Then that check
only sees what the last walk set. In the same quick test, that fixes the
refill case too, and the hugetlb case behaves as it did before. It would be
good for the selftest Andrew asked for to cover the hugetlb case as well.

Thanks!

Chris
