Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243127;
	b=0GC7c9HgD+RXlQFkVvAvzIC39wtW5oOyUoW+By7yt3v3UISr3Yjcd51H4mG3YW/z1nzx
	 Gs/LUpQlpJGI2WKhgT028cueaZukF0wC14JYR+SR52oq9bWqusQMjbUTXJ8pNeajv1ot4
	 6yIal9KIg0hcte6rDAeYa015SInjjyGyUI6tb2RUQyY4OQReJhj8XZYsKVtQEAeHmUgAo
	 u1FLS/PuVBnfX5ag1/9PyuXWpCPgufUGVI0cSd6eqpQZ8XexEpvBIw+s0Hr4pUbEdrXQi
	 ivsNJU1+ENP9xBpf2W5YqFxwz5BAaqA3sIanKqX95OIc8pNDCK2MV42XJTdIGT9nkDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Qt+rBjELLMxb0qTKo9uNTiwBY/+V4YZH/Ya3Tn3lncw=;
	b=RTkdL5ku7PdbcupFbWmRqKBfRNr4ihPloyreDlsazAi3ATW6hVpROZn4ZS6vMlXT1oW2
	 vG9tYlaxjUFanewTyBaYaLgmtBvPKxTTEQpInPL2lmDNoALe7iAXgMrX52w4MdiQSJb9/
	 +Aqdmv5sqGRPZM1rxPlf0P0fnlm7zQzE0++tjFvnjtG5RKRuuIU8kNYtci5h5FmqV//i1
	 e7mElTWncqon3Wg5F/7UTjYLFhSHQpgbjCAsLwmK+xzppa7vQF1JauZbQDRQb4NC+WMo9
	 c794B8R4WUpkJIEavFPYjIVdf51OM3vJHvcuCXL91G0UIt+ODZo2I6tQSjmOBEeB6dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xHNh2s/Z";
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E54606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93E54606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHNh2s/Z
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so952622a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 20:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793243122; x=1793847922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qt+rBjELLMxb0qTKo9uNTiwBY/+V4YZH/Ya3Tn3lncw=;
        b=xHNh2s/ZBjEIdJDX4r+dFuo8rNJ9MVQVAR+r5+cnenMwbZpMBs1xnjBlakkyac9yTO
         8bMDjuugxd7EriUc3d3oVvtIWW2p3YbNJ6KsEsKfm1ubZUETX0TsFQzRwNVFq/3LHMUv
         XupBgGrNQPXrLmyVezeYmQp08Rnt+GIf42xgjCkAl2khgayG0W1ZslJ/HRhejgKgtgHn
         aFTEyIabEusutC3KAy6fFI5jwEfnN1Cwnh8aBLn4XOw3TnjNw0MbYfUpudFWA9sLlVpm
         eYZpu6l7g4dB6hYU0VRew9uzv8fblmkebY0fmLw8l+APd394gUkEs5tyKa6ZltcieY09
         Ysow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793243122; x=1793847922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qt+rBjELLMxb0qTKo9uNTiwBY/+V4YZH/Ya3Tn3lncw=;
        b=iLSMDD0qJ9fJ4ccmcZOA5xEdhipMTps+1IjZ3Sj08m0AZwPqY1x7rXzCfOhpymg6GZ
         VYwBHZ3IrB3k4cVxAU+DrLZyNwPG2oEE1mplLSK+ojA4HcI7GlEdaU4ddwno5ZeJ0/6r
         ln+YvgxBd54QjYVWjs5pBIlxkIadPhhfc5/FT0ERbO6AcorCezzJnY0uq6Fp/P9KhcLP
         5zLQl+oKkNLBvEWfVapD1pHnPBS4EC80G30seSwimhdIkTkv8441b3jKu3rGkDcYkGt1
         WpRRZs1ETEg6wIdSgSxGvySnAJcFn6JtfaxcrHacxmgRR/A7UsmCmJUM9S5A51TRU6by
         g1Ew==
X-Forwarded-Encrypted: i=1; AKwUvBwAStoKuVTZXKOKd9TZi3af8OGjpltwXoiwlNGA2bG98egd4PISzI7gtzp/xtD6minZF9BCD/eDKGg15f7Z@vger.kernel.org
X-Gm-Message-State: AFq9FYLw4PG8R32PEls6YhBdgtkjZtzOsIxPF1gi6Xsh/ybVD9ICMFDy
	zlscaBaLwl7YIJyFO8bt/8p34U0o/R+Ww1Xh7ze0sRp7iXq6J105wKxYvK4vokEJ8Zsfhg==
X-Gm-Gg: AYBFou3AbW1HKgrJGVeUfZQvnP5DFxubSJv+2LlNi++QBm0/Fs6JsYM5+3ZELm14GwN
	gfe7C+L4RBooA6mSJfCQdWQNCd52IEV8IXW9HNFmNuMxye0ydc0Yrku8ds/1DnePAhfURgN9Xaq
	f+MFQJOxr8KvYl1zJUvcdHJCiIvmviwfhSFOLm5SzVRqHB7usntqxzAJ5UMeyXU7fcW4Cj5BbKg
	CEWDssvAZiuzPCqMktPBomu8NYzz6NP3LWvp4FyUwtbVlaxuT+7yKQETWHDUtulcLmLrSRsOuEE
	JUGUK6ENrNiFL4Yvr8Jpww8zuwECyMvIb0ZIlu5xtOzoM4g0kmatAIbqowAWy30hkGF1qq8rcul
	vTXS0Z9F8dFWYxYCpfavmHsNa+/V/gqp/yK8Fnv6xWlIubd6PwSJS1P8/3pla0o4qUIsI6pk2xs
	3x2yIRrD8jaa75ahuNgs3sgkBzdxk/DU6Ck0pdXBOJsQlSTq1BppsZXgRf07l1czDxUe7+vHkug
	WzJSpqXLnaoGmtM95DOFUF04Um4e2VEYVB2NY0NofmfpFhfSheTM6uf0kQaJHr106En73QHF9uB
	4wsXfdghEik8uc7RtdAJMu/gMNCx12QbIkMdTicbVucm2lZU21kpAA==
X-Received: by 2002:a17:90b:3810:b0:3ac:b08a:ed2c with SMTP id 98e67ed59e1d1-3ae5822fb8amr3357641a91.40.1793243121828;
        Wed, 28 Oct 2026 20:05:21 -0700 (PDT)
Received: from localhost.localdomain ([101.44.96.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9583c1sm1932931a91.10.2026.10.28.20.05.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 20:05:21 -0700 (PDT)
Sender: Yilei Zheng <trilithzheng@gmail.com>
From: Yilei Zheng <trilith.zheng@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <djbw@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 3/4] mm: add shared read-only vmemmap support for FS-DAX
Date: Thu, 29 Oct 2026 11:05:11 +0800
Message-Id: <20261029030511.12004-1-trilith.zheng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <4c9741cf-ac62-41d4-9c7a-7d5ceea4a8e1@linux.dev>
References: <20260903122128.12264-1-songmuchun@bytedance.com> <20260903122128.12264-4-songmuchun@bytedance.com> <20261027065723.66564-1-trilith.zheng@gmail.com> <4c9741cf-ac62-41d4-9c7a-7d5ceea4a8e1@linux.dev>
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

Hi Muchun,

> Thank you very much for the test, so in your scenario, this is also
> the behavior of your real workload (mainly read/write-based, rather
> than mmap), right?

Yes. We mount read-only rootfs images over virtio-pmem and FS-DAX. Most
file access goes through normal read/write. mmap is only used for
loading binaries and shared libraries at startup, which is a small part
of the image.

> To be fair, it does fix the issue, but it's not very clean. I might
> do some code cleanup first to solve this more gracefully. I want to
> move the initialization to where the template page is allocated,
> similar to what section-based vmemmap optimization does.

Makes sense. Initializing it at allocation time is cleaner.

> Thanks for the analysis and suggestions. However, the reason I
> haven't sent out v2 yet is that I've been trying to refactor the
> vmemmap optimization logic to make FS_DAX support cleaner. I think
> I'll probably do some code refactoring first.

Understood. It would also help if the refactor could support subsection
(2 MiB) alignment, so any 2 MiB-aligned device can use the optimization
without padding to a 128 MiB multiple.

> I'cc you next time if you'd like to help me test.

Sounds good. Please Cc me when you post v2 and I'll be glad to test.

Best regards,
Yilei
