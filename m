Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694463;
	b=1cSn+SLWXSM5FcxhSQR3n6sfmkYUSSzs8pscKQXWJERiYm3RkTQ8AJShKQddV6jtXcTM
	 WX/R69bpPIas93aVA9XmbMTd/ptDt83cKDZbjfxTmauZjXY1QdABLwDq8KfhGf4Edg/eN
	 hmewBqSbGWThqR5w7dqTfcLR9ThrWaLCE7QaPGGC2OJsHHZupBAoJvomSvqL9DSii/Bt4
	 wpZ/krArunWoLjs8cy9oJ/nw8YGBYwVcn1Pack4YBdmYyqfiuIkQc1Smvhoxq1mbIUQZg
	 wyHggyBEZHBM7ZXNBTkz/W0GfQ3F7dai6b2IFGbhbwg+Mef187h2ZAO0zimmvukgdIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=B6CEN+98TLk95Pbz6PoJyknaTEGQ0gqo4V17h4hhV6k=;
	b=Nb3SDq3J59wDVmN5OfQE2rMqi+bCWdM0Qb/eK7ykZb16SVdfWlLZ57pyYdj/Xjpm89oV
	 YD/qFMVyNaOx5CBPQ3AUKzsBKOJa35ZyiB4Ce3aDAhANYhvxF6WClaLykjuMGLO0iJV5o
	 FiV4yo0OrEVmhRLvUWRYL6qOciNSj1SPby5W5ECUf5BgwtfAcp52mRNlcYeKqDFYqnga1
	 9Uvy8j2Go0HLWSiCqZUuC9X68I2742ndJiy5haivBES+6tpNqrtUL16+A3CvvJfBieFsE
	 angwNQoOf3qXo0MmbU8Jc+kclqoeX7t2VSim2/LK6r1/YoivZfSak02IAQmmPK2+lDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GKQ6cMhE;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3469A606A329
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 08:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3469A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GKQ6cMhE
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8ab43af5e97so5053747b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 00:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793694461; x=1794299261; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6CEN+98TLk95Pbz6PoJyknaTEGQ0gqo4V17h4hhV6k=;
        b=GKQ6cMhEVrJ7jehb6dd5/TVi6VVeatz1LhtksNJEcuLaD5b7oXIuhrn0kDSvtrqk4j
         WXy7QiGFtfK1j2LoGOWT+nfkUlcigqn+rvzxfp1HTahz1sF715ITJ9TckpreN2ySEIFl
         ERMddEaeKdZ5/hjfv722VzuQzGcoi+RIRMqqQRHM57LXc9qcNgm4WJM0qO8k/bEP1SND
         lT2x3H8UcQ89zPmNvCgTBxj4ZYQLMJEmyMrThRh9JsZGewnqbeOTAzzTLI5l6ctKuDUM
         wHlocIjkFHmuaSLsjAS41wobpqGyqBFsRI6qLiX3KCcugbUAa/Wvi6PFNNUKF1oeWzXX
         WZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694461; x=1794299261;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B6CEN+98TLk95Pbz6PoJyknaTEGQ0gqo4V17h4hhV6k=;
        b=1PmYHKP+CTKG6X8tsntYYAcHoCVbHHzJs4aSGVHvC74yjN7t4AQE9b3uOGNvVNl0sD
         ksoeB8wnMVs1M8D3TWY9u/Pk2/oKZPwlT13EV+0bgEm68+BtDvqSliDA8AcasGeyoOWL
         534LLo2avg0Rs3rySASkLJeaDPiBWw8BYDzloqQVoAOi4m0IkOD4cnMBcX/It5FmzQi9
         wfFfk/XqP+xg4IOzMX3mxlvO9TvROdOkAhXZ1dyYQ4+vxQyC+wq8sdWtG7uYlfFvCViZ
         t9K0xXPDcyrDTP1Ze1E9dA3pExMeG85GDEZHCZoCUPH4fxkPrzwu9rEXs6CvAHjLKqLz
         gK1g==
X-Forwarded-Encrypted: i=1; AKwUvBw8QXIhba9aQ9vhdMIScCv2xHeJ17fC7B0m6ob2D27hX/HHkwanpMvXr9IvfyEcIUEw/pPY8gQreXqGxjje@vger.kernel.org
X-Gm-Message-State: APuU4Z/fF4T14asE0O/0b1hqLw+4S7HLikSULn2F39UOndlfyK3uDe+K
	mwl1FCc0/PtNkfafl/ZN8AEFLBrFUbZWJ+iduvYd9VU87E85QLTUugh2dInbSE0fEw==
X-Gm-Gg: AYBFou13wpLyk2uP7hSXDH0mVHERuiFmRPPmAMZFtL78EonCcSH2A2ZmPGwZZYN0CDa
	tuNuL/4TQY3N8pkp0x9Pqo2Hxg3W/eZ3Seddwmigpgz24we8v851UdY5VR8FrfOZU7G4mSydMXn
	Rgbjkk+rgGB/9dUDIPnn9lafCjCxpMebChECGlXYJPWVqj3+5ymIXCFb4T8KYlnNMoeGzlPViYo
	PXugx9SpgoOt7kFMt25ayBqNLJssnBPAtpSWUlSe8zb2z/cIYwAz2FMHTQW8s1Z/stF7xD+dA3H
	SSxj/zuCXZt27mQAsN5yEwJmil1yTNQXxOEmbiO0gN05hVzvcqC6OF9AYp4jfjFWT4720+AWUhl
	UwwEOE3NOs2+tRHZlQ1/9J6p1HVfy09zrJfn5uUlqVpRM/UTzlQ6yJ15McJTAVrP8MoWV2aWbok
	EH7YXvbkPE+U20aYz4q8UvJN/1w34GGr+xTkt+DcGOyu9+Ex2H8XrmprSjio59dP2pk4jQ3CDPl
	pefn74+CdUusYzAGOypYYS2gOzkv6TOZYtrQFhub7DyA6+loO83psj6us/3To0g6/x132PYQEhH
	Uo88nRYX+GoKQG9lWQutCDKum6hRBN6v13bi6nXUmC6nM+DQJsLNFRGdDKjUmeiJfOMoR6uXdZt
	Oz8chaA60T9sIVKGVkN+NTfPOsEOXDkdw5ymE5YYn6e6u
X-Received: by 2002:a05:690c:d89:b0:8b2:26d5:7878 with SMTP id 00721157ae682-8b2b676a47cmr96699227b3.25.1793694460567;
        Tue, 03 Nov 2026 00:27:40 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b714bdafsm67833187b3.19.2026.11.03.00.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:27:39 -0800 (PST)
Date: Tue, 3 Nov 2026 00:27:22 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
cc: Alistair Popple <apopple@nvidia.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
    Brendan Jackman <brendan.jackman@linux.dev>, 
    Byungchul Park <byungchul@sk.com>, 
    Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
    Christoph Lameter <cl@gentwo.org>, Dave Chinner <david@fromorbit.com>, 
    David Rientjes <rientjes@google.com>, Dennis Zhou <dennis@kernel.org>, 
    Dev Jain <dev.jain@arm.com>, Gregory Price <gourry@gourry.net>, 
    Hao Li <hao.li@linux.dev>, Harry Yoo <harry@kernel.org>, 
    Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>, 
    Joshua Hahn <joshua.hahnjy@gmail.com>, Kairui Song <kasong@tencent.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, Kiryl Shutsemau <kas@kernel.org>, 
    Lance Yang <lance.yang@linux.dev>, "Liam R. Howlett" <liam@infradead.org>, 
    Lorenzo Stoakes <ljs@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@kernel.org>, 
    Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Naoya Horiguchi <nao.horiguchi@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
    Nick Piggin <npiggin@gmail.com>, Nico Pache <nico.pache@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Pedro Falcato <pfalcato@suse.de>, 
    Peter Xu <peterx@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rakie Kim <rakie.kim@sk.com>, 
    Rik van Riel <riel@surriel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
    Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
    Uladzislau Rezki <urezki@gmail.com>, Usama Arif <usama.arif@linux.dev>, 
    Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
    Xu Xin <xu.xin@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
    Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Manfred Spraul <manfred@colorfullife.com>, 
    Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/7] MAINTAINERS: TMPFS (SHMEM FILESYSTEM) updates
In-Reply-To: <20261030-maintainers-v1-2-97278f8a5f54@kernel.org>
Message-ID: <b04d8d01-b42d-d948-b7b8-c360f8ec6002@google.com>
References: <20261030-maintainers-v1-0-97278f8a5f54@kernel.org> <20261030-maintainers-v1-2-97278f8a5f54@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 30 Oct 2026, David Hildenbrand (Arm) wrote:

> I am not really the best shmem/tmpfs/memfd expert around, but it should
> be good enough to judge when something is ready to be picked up, to then
> pick it up. I'll have to heavily rely on Hugh and Baolin on judgment
> for the more involved and more controversial bits.
> 
> Rename "TMPFS (SHMEM FILESYSTEM)" to "MEMORY MANAGEMENT - SHARED MEMORY
> (SHMEM/TMPFS/MEMFD)" and move it accordingly. Add myself as a MAINTAINER
> so people know whom to CC.

Thank you for taking this on, David. And thank you of course to the
unlisted Andrew Morton, who has been uncomplainingly filling in for
me year after year; and thank you to Baolin too.

"SHARED MEMORY": should ipc/shm.c be added to our list of files below,
as mm/memfd.c is? (Though both can also go off to hugetlbfs instead.)
Or do you prefer to regard ipc/shm.c more as a client of mm/shmem.c,
rather as drivers/gpu/drm is?

We don't often have to touch ipc/shm.c, and generally ipc/ is well cared
for by Manfred Spraul (but I couldn't see a block in MAINTAINERS for it).

> 
> Add mm/core.git as the target git tree. Once shmem becomes a high volume
> component we can dedicate it a separate tree and have dedicated people
> pick it up.

Okay: but do keep in mind that tmpfs is a filesystem, and often the
FS folks make small adjustments to it, which usually go unconflictingly
through Christian Brauner's tree. That generally works well, so please
let's keep on working in that way (just once I remember holding off
intended MM changes to shmem.c for a release, while FS were busy there).

> 
> While at it, add some more shmem/tmpfs/memfd related files+directories
> we missed so far.
> 
> There is also "kernel/pid_sysctl.h", which includes some of the pid
> namespaced sysctl vm.memfd_noexec. But that's really more of a proc/
> namespace thingy, so it's not a good fit here.

Agreed: if I ever heard of it, I soon forgot.

> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  MAINTAINERS | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dbb5582ec1c74..0baeb37b0dcdc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17772,6 +17772,25 @@ S:	Maintained
>  F:	include/linux/secretmem.h
>  F:	mm/secretmem.c
>  
> +MEMORY MANAGEMENT - SHARED MEMORY (SHMEM/TMPFS/MEMFD)
> +M:	Hugh Dickins <hughd@google.com>
> +M:	David Hildenbrand <david@kernel.org>
> +R:	Baolin Wang <baolin.wang@linux.alibaba.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mm/core.git for-next
> +F:	Documentation/filesystems/tmpfs.rst
> +F:	Documentation/mm/shmfs.rst
> +F:	Documentation/userspace-api/mfd_noexec.rst
> +F:	include/linux/memfd.h
> +F:	include/linux/shmem_fs.h
> +F:	include/uapi/linux/memfd.h
> +F:	mm/memfd.c
> +F:	mm/shmem.c
> +F:	mm/shmem_quota.c
> +F:	tools/testing/selftests/memfd/
> +F:	tools/testing/selftests/tmpfs/
> +
>  MEMORY MANAGEMENT - SWAP
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Chris Li <chrisl@kernel.org>
> @@ -28202,17 +28221,6 @@ S:	Maintained
>  F:	Documentation/hwmon/tmp513.rst
>  F:	drivers/hwmon/tmp513.c
>  
> -TMPFS (SHMEM FILESYSTEM)
> -M:	Hugh Dickins <hughd@google.com>
> -R:	Baolin Wang <baolin.wang@linux.alibaba.com>
> -L:	linux-mm@kvack.org
> -S:	Maintained
> -F:	include/linux/memfd.h
> -F:	include/linux/shmem_fs.h
> -F:	mm/memfd.c
> -F:	mm/shmem.c
> -F:	mm/shmem_quota.c
> -
>  TOMOYO SECURITY MODULE
>  M:	Kentaro Takeda <takedakn@nttdata.co.jp>
>  M:	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> -- 
> 2.43.0
