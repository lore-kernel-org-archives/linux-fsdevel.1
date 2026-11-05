Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793920680;
	b=YmqJRZnRVmRB9MDMzj6trGWrTqYtNo42VLoyP/O6T/TOE3f2QG69FLUWoedjZZoL+uCi
	 iKdXCGjAIg4R66447KB3cioVkFTC+1ok5Z+ZfxdjP1teAnngqvZGXKEsTlciKslZsNqAY
	 3b2L+Ij2CiwO1X6SZDZ7RJ01lTWJ9OzOtf5m6+uRVGIdSB7tWTZC5/pi//6VuX2YEzbVy
	 mDo323AY80lHiLmN2vzwhe6mp6BcHIrQwQWh//pomki+xSYMiYQTgMPiGZ3Y27j1xW2M8
	 0UMtPBIrbBHK1HEw6tRL1upiYbb5BrgfPxXcNSIEu45m/JVxLKNxndpwPgLXUh1UdZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
	b=qV8vhfxQgBf+t0pFEtFFcNc6mdqAOVQ7etNGNZDtzTlzPI+WjIH7CBjPvx6UQkjZYlqf
	 eteMO1aII+uLI7tayW+zYprqpW2WblzlQx/LveHpEEKhHiNrjw6A/0dgaq4Sp8Va4nOzX
	 DX/VB/jmdw2Rwauo+AhiAg/NRmbW+LFOmFkjBnIevEU8rFMzXzcmWHg6EuQOUa6k/5470
	 9jrbGuYELqv6FnNasbeRMYT06UiDPApXQ/29xPg0iOuR910bZmy7wj3TbmJDyq+ufwM8X
	 sHoUEYvYXECbe4OhfsB+r0m3P/kp9pCYwVCpSbyajyO3BjWv6L5Vhs6QLaS9fCybOeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=F936vzKm;
	arc=fail smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D4606A32C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 23:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C8D4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=F936vzKm
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso31379a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 15:17:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920679; cv=none;
        d=google.com; s=arc-20260327;
        b=cKDNpnL5uw/BTG/FE68p8AYiRhOQhRxuKFN1xVpsAp9dR77lSyk0cBasWLUdu87e6h
         VLfM4tSSo441RRAYwi2h7oPpfAldj5OB1WMAOHFrdzKG9464jq6Urx+s6mDUQn4YxEJH
         NAWivqtvGPBFQAFw73qUuVKQsRup/ROZPvCFLPHZdhLOJbiqzvSffoj4FaGZu2H0k80c
         eEOIyY6471jMUgbrggpRy5RnYpCQ5IfbUGZkMMfF6k9e87ZLh5FiuoJRC4z67m4Qceok
         wA1KAD1U8DmWBkj/UrjEiM0/+BH/PPJH2eJAi0Z5I4P98duaEPVlARpxxoMFuikwwhYB
         BnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        fh=Uj8bZELHN4O6OAiPRxiif8C/MAYOqiDwJzvARiAEegk=;
        b=BgMSDELCuv6L47ftY8OAHCFXdbMwnEBEnKRtbMEGoa88wjFFSoKNeHR5QtbfTiAlXe
         SJsN4ED9oDqbQO+b0tERCMryHIXbA6ijPQq9h+LAyIhGTelkUS8emFKXMPYUo/26g4hn
         7s6vRTrk1cufMWO4smlMFtKtxNzhQ9+/Z53sr0pwCWClPxr1ZYhrPX8ZTqhbThVJuk/f
         7yAY9gyEIEiPZeN889qvdNZsdxn3zZGOghUsFZd7d55zWo1lYTk8Egqm8YW9TG9lhuPm
         jE9aaZHSgtJVRVUmFwtFEq2UOWXnEZkfL5Mrx0jXM4oq8NxEk8HK8yhDtf8SpG/oGkZX
         KU2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920679; x=1794525479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=F936vzKmZco1Rg9qiS2Cf7yXwnXt8dn1LQ3YxCN5SMsKSJRTlu37FG2JQnmiZ4tO3q
         ZY7C/eCqTECYbf79gAR8gp3oow9+Ykdrk78RZdAOFLnN4sIU8x8jDIiI/j4+tmIgfhgQ
         Kfc7/iulz45+20nMepsyi2DVKsca2I7vu/IOFa2DSNB+5NoNB+X3xZL+TnSEr5nUJW/0
         t+eWupnUof2Q+Z07m3XUdhgKdmPOk5SNXh4+R1i03zuB5eyYkN5hGGMTpwfL4P3jF/oi
         qjoVjwxKWuHtQbutc+EbzPaNTI2YVJHBnHBIs9egvV2qx2jXIUZICkPleteOCZKku3cJ
         ZAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920679; x=1794525479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=BSGpI3IKe0cMhsWUskCHh3LwHwDSkrsOMKmAQQS7KJbHJkH9QOXLUtcDZMOI5SCSWr
         1hd1iIlyN9wnvb7BSqZOJxXeSaFO2u14hjLTXATEWNL/fxSTsO9s/BUT1DtBwooktjRJ
         KPTEWeQ/ne6VDl/frVTBYzT2GKJvA5roQWndz1kyCRcQFXw6fDVG8U3cn8tG1Qa5rs4z
         a24/dEGjbw4iFteOmiJGWMBYzvc4fV+jmXLFhJnKWeWwovBv03aP/UhaCDjTDNb+xnMD
         grzUSBmJdKM7a9bLb9TB/vPW1fxfnd9RQC348BafeYs+0fCcj8gpWcjNIggGbVotaDSi
         HCWA==
X-Forwarded-Encrypted: i=1; AKwUvBzN+w/UA8lIuQjkthVAEzbcWgnFqbnei9FqyfVukSCpnYisd7rSIj2g77SqXZnXqDXMAvFCGwqPTIXPLVqp@vger.kernel.org
X-Gm-Message-State: APuU4Z8YG9UJZjIf1Qhhn7d/NDQ4Nf89rDWNwIMhNgwNM6zRf7HWUjtC
	mTIRaGS6i9Cy37+x3mYBQDnFzvVcF71LEi1qvkQy/HieqeKIJwMr2gODfZJXmiqXGygLqMAlYZF
	AFCRETm6n4XqL0Um/Kl7SbZQV7q2uG46jbMve62O5
X-Gm-Gg: AYBFou3e16VjakmrfJlhCBR5ct8UAz+6XYDLkWi7aQI/906BTJPmGOyyGVgEwwYAf9V
	Hfvh59lLNBSNeTmhHeWSoL7yi7Al0MdXO20plj5PoRX9cEg6C8ZhJVgN84aeXPDHkfuyZsTPImb
	svqXWlH0DubyuqE7qX8pKr7HmWO2EeXhiNXiGfsQMdA1GB7mGxZzdER6s/W+ikdfLzPf1eoG53b
	IvGJ4R+S0gA7xjPx+TsCXp75pu88hWmJXmozQBv9Uesx/sUVy1QrnZbNVbH1StHabdx+aFi8IjG
	AXltOo9K/oNwnEEV8XM5gXtFT1ln5O8mGnIC23Ymnu8Z9korMrjs6vuL7UBhRRyIsGbe3p/KTVo
	xd2Yavj3Z0YcYct1/HvjIaVTbEFFM4sgQ50l8NE/Hl3piwDVvGEA6j86NXPgE/64YxR9p
X-Received: by 2002:a17:90b:1dcd:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3b0db703e39mr535625a91.34.1793920679319; Thu, 05 Nov 2026
 15:17:59 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:17:47 -0500
X-Gm-Features: AclHuK_gkg-Hspii6U5_01_jGLQO23B7F4YXuvzvsb53ImE19wnChR3DgLruv6g
Message-ID: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/apparmor/lsm.c           |  2 +-
>  security/integrity/ima/ima_main.c |  2 +-
>  security/ipe/hooks.c              |  2 +-
>  security/selinux/hooks.c          | 14 +++++++-------
>  4 files changed, 10 insertions(+), 10 deletions(-)

Similar to the other patchset you just posted, is there any reason why
individual subsystem maintainers can't pick these patches up, or is
there some reason I'm missing and they need to go through a single
tree?

If they can go through multiple trees, can you split this patch up?
AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
different groups/people.

--=20
paul-moore.com
