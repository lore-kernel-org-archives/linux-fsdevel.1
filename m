Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965374;
	b=zbuC5UNPKPd/LnIlC6tY1Fe8qtyGxYnZXYYWAhw8q8FNx4wGhQivBoM//k0vGKukx1RS
	 dfX1+N6s8mntMsWnx85eyhOgOyDyQBV9xO+NQSY6h8NsvR1kOUDkuf3leBUiLnrmy7qXp
	 x6OiQHo50T2mpcPDW27anYgbxmDUJqLu2KOxbT7hbtVY2SFav2U7NuISBNWoGgR3lWj3q
	 W8mLpfs2R0rb5qLhaSjlia6kfZUPe/iDWgqBzDtjv9boj614MEDCj0Zwg1yiMJi4eHKlj
	 uTv7aBQUZ0cfgTcW2a7hojH/uPu/ykDHpF7VxPHdtvkPu8jV01qJ7emSVnG6uh/ZBaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=w3JSCXNwcogBu1PJnd6LhkuPj4w6tsB9fs1YwGA31yI=;
	b=08OTRZDhV2qUtSjVGIrI26HOz1tzhoM9hrlyXwDmkim9bso5KhmqQvUntT34JsI+fmwo
	 k8W0w7oVEVUfN+dLao78xLTXV/fRmn0IK0kbrZOqVledakN1CJE02ZHSTHCiePAUrt7Li
	 BSK5KchYwZXQa+VUpmSjM/dh3k/PDLMQ0hZZTuGoTB+LzY3S9sp8FQbpI1m9h5NAoTH6h
	 soboy3+2ookP1jZLL+G/bfPetlL/1wXER0Pzq557OUJWEWU7VPRtj82WFBN2ImibS/kdJ
	 wGDI/tlSJnB1ittA33bxIeb47LyLSnE3FYF6CfPvkGKyguOxLwwdmNQvUh+LHdWceFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=O9DHBRIP;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59781606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 01:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59781606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=O9DHBRIP
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2edcf6c3a57so596985ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 17:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794965374; x=1795570174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w3JSCXNwcogBu1PJnd6LhkuPj4w6tsB9fs1YwGA31yI=;
        b=O9DHBRIPmjIqt6AhONYCYYyAxWEJ+jwHuEmk99wwjzt2Nc0YnZQ+dKRQk4BcX4Tx3/
         EAwCsCIjOfij+kfDzFdvTyjQb7+AGv+8efMSQO+env5URswiaB4hGUmHq/mLnQ/2rVeR
         InpfSAF+62jlzeryXe/PJ2gNlX/ew/8siqlyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965374; x=1795570174;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3JSCXNwcogBu1PJnd6LhkuPj4w6tsB9fs1YwGA31yI=;
        b=N3SD+66vhtQj/C2s0hmRQA+9Ma9BtUQCqPHPMJtP846z66nYfHb6Y+APvI0yq+n3FN
         c2zLbqXyP6rvDJBrmolmxofee309cgIR3zR4HAmafkUmBzaU1DWIvcFAtYPJ6QNi3hpS
         8E8fDJM4pvQK3+Ax8U0vMtqW0KJ8fdzSMC2jVbNnw3VZ5v7u0hAxFQlVVSyiUU1dFNQU
         jThFgU7BREIpiOqDK6bLmwVjmL3mq5dHnwQB8jjyFu5kIOEobJVuddHrfZzqBfVXimrb
         kg+UN/yMgCqjfmiKV3lNeXt9fpXm8rk4GvdNUknmseXjZMC55Oc9AAIizssBLPcHn8Ik
         8CDg==
X-Forwarded-Encrypted: i=1; AL+hErHYq4b1pJ5GSp+Fa03po2L5bLy0IZ9qCldMZSqEvc5/PoOPq5+aUiFH3e2cYk3PEHZsDd5Vc6hsKTcutnJc@vger.kernel.org
X-Gm-Message-State: APuU4Z9vmoUW5MbXxJAcNFU1jd3ZlkLd1avip/qKgyBF+woZShj2viT9
	kAlDJWRJl3gMBfGcOJXMbbrgnLAPWSZlwKl4btdztCpejcqtApITgX1nhYoSpqpg6A==
X-Gm-Gg: AZFdTZdNRCCHMtH5x870xpT2qDy6Nx/NzIZhRKOqcBnKQDlHjQXRCgq9dNdvgecMuZX
	f9wSRi5U3DgyYSCDwiDsK7gA9xr7pxKNFEFwDix9gp9Kratg0pC4ABGGPB+dkn4XjFO/xM9i/tm
	rNn61gOTnIurkILj3upjUhc3zfUpJ30+ey0xqnpbER56KSd12LPTV/lb/txt1mO9mAnGmN97BH5
	1V8E3chXcbAavpYDaFh9LRT6pZ3LT4Jxq8+k0ABIAemDmbVYTBaAHXC82T0SnsY3nggmjfXDinG
	K3vIHHyy2PXA7NDXM83TcxGSxIvyYemrwDlM7J3Ixm3KA5yewBm7rgiDOJqOzPcKmK/K7dsN+78
	o8ldHHWiJAgJMuevUdj2XA7aUF14GUxU1fbXyQ59Aualh4n8z9MpPA92ejw1yLd3hANHVgo71IX
	WCKanVGyn1MYF9L5JC4WKyfTvEc9VbHY1tlKZzN0Vk0vkioChxKNHzaPCHHmSnaBq9xAmEGWoeF
	nNaevWbVv4vJ6GhK1NMlcYmDKli3lYYYaDkiPfP5c40omTG56G6JCj2Ax0/3jpYLahS9daiLZPQ
	Kg53VK1S4/DWG7vPcuhaFCwKKcp5F1oVaDDt4Zez3xSTK1y9FIoXfQsY/ydSQ1TiQ1aZkGyaim3
	lVbDX3o9KUrC7aw7w
X-Received: by 2002:a17:903:3bd0:b0:2ef:eadc:5c98 with SMTP id d9443c01a7336-2eff6f86b0emr15976975ad.0.1794965373725;
        Tue, 17 Nov 2026 17:29:33 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2eff5ed09b4sm4409835ad.9.2026.11.17.17.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 17:29:33 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Evgenii Stepanov <eugenis@google.com>,
	Ian Rickards <ian.rickards@arm.com>,
	Jann Horn <jannh@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Will Deacon <will@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kexec@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/7] mm: kasan: skip KASAN for GFP_HIGHUSER
Date: Tue, 17 Nov 2026 17:29:29 -0800
Message-ID: <20261118012929.290499-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
In-Reply-To: <avwp1ZpVudiT1Gux@gremlin>
References: <20261116230627.3537051-1-jeffxu@chromium.org> <20261116230627.3537051-6-jeffxu@chromium.org> <avwp1ZpVudiT1Gux@gremlin>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Nov 17, 2026 at 10:21 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> This commit message is just inscrutable. It's like reading Finnegan's Wake :)
> LLMs are obscenely terrible at this stuff unfortunately.
>
> You seem to have rewritten commit messages for the other patches, could you do
> the same for this one? Thanks.
>
> > Link: https://lore.kernel.org/r/20260519-panthor-kasan-v2-1-b7384458f076@gmail.com/ [1]
> > Link: https://lore.kernel.org/r/20260521105148.5497c281@fedora/ [2]
> > Assisted-by: LLM
>
> This tag isn't used any longer! Thanks for acking LLM usage though, we prefer
> you disclose it but in the commit message or the cover letter etc.

Fair point -- looking at patch 5 again, it is way too wordy. I will
rewrite it concisely from scratch for v2, and drop the Assisted-by:
tags (keeping the note in the cover letter).

Thanks for the review!
Jeff
