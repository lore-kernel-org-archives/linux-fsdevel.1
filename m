Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532832;
	b=eqBmQWVCSvCThk866m5PFU6WSJoNKNMnKtw8bbxadNFaKFGANHCWAQCX7XYp9UZ5u/mY
	 dGDwcbBQ3fmlcsiopH151MrkWZTNQEzEozy699ZgSjWTi8YT1ttl3RddDyI2JaWk0X+FC
	 Cf2bkDeVHgHUButN+v7R1X5F9eIaix6kbyOpo1B3budMdMPfJ7dAXWiQydvszYg0vFwrd
	 AuuNaif1WdQ1TRw81KzA5m7Zj3uOrk0vOrPh+tVJfQYDn/7+ThD1wY4XUZjwP1TXaIxn6
	 OiByIIfepnL3UZ0HWDwNygLIui63seBTlZQSkMh+66rLYbkwkpyfLjzEthfjPMuIhTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=PvIPEfkdtZUqofHUAuuyqlxSRMhwpGZiFkVH0+y5Y1c=;
	b=AF0sEdOfJzTvjPTc/QxqJ8rBYjVxEHEMgB06leJmvDgF4KEk81dwYjL6ke7bgIULpFNj
	 EBREuatir0XsG11e3ZcDEz6OxaCacMinG/HKBOQvVF/mIsNl85UFvBt/Y3biTsU4iDqck
	 BysRjfcpI9zqqtKisJo8ayPMNhJ2tbln2vAesg0cZ83StSzQI0uj7vq0SjWor/BQBliZO
	 u+u+TJSP8Nn8Iu2d4QgbgcBnZOCo7pW26qilBPlnEyzCpmqcFrrkL6pz2/J76T79O3o1a
	 y8zgH3Z4iagGkgqLfweujI5jSvyBUQjgVj16jtD9YLd0t8M8WMXadZ3KI78Z4Iu46xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="Be9V4V/O";
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72165606A329
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 21:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72165606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Be9V4V/O
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93ece7a73b9so12342585a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 14:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792532831; x=1793137631; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PvIPEfkdtZUqofHUAuuyqlxSRMhwpGZiFkVH0+y5Y1c=;
        b=Be9V4V/OnZcQs+aTguUkhXyjfDs+6JJuxPIxsTY0MU8vcLoq2Ds5+WAG/mvOSf5UnH
         qG4vG0jzud3T980Y7BBhsxA6XyfCA6tiZviMhWU4/+wT8+W0ov45kAIA60U3hjyXHS1u
         QHC9R6NQx0kEHSOtnCSJgG8u9NNWRA6qiQZCfix9yFre+N0E3xrBCTkLDPUTnqSyfAo1
         e4M/vKZNAYjVg32XCZwHCogXXKYC8ckAikMM7FU/CrG8ztcV9ldNoGM6GSLm8exDlYqT
         hZMeYLGNdrQf05wa9mXZAHB8UfV9LwY5GSZpSU6v8aTth0PnClzyHD4LWjMDmCDtVi1R
         i5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792532831; x=1793137631;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PvIPEfkdtZUqofHUAuuyqlxSRMhwpGZiFkVH0+y5Y1c=;
        b=JgjY2F9AxBesTxdwIbP6aVZZZv10K5CO84h2JKOMoSbITgOQJImz8fXSC9iTyR/4UV
         c2AdqRm55TFGWh+q8XEqtyrs+Ov9yrPtgUPweOiIoA7YLbpzuwVG1UvuGEloi7ob+VXa
         G+QxinfUmHTKXlWoujMEgQ/p83GWx8DvYDOng1EW2gfkdsNDSLGRGNDEWaVmXBfJjO3G
         BUJBa5BtVypNYlMutZgCwfjSyzgG9KiDIsCOldV+9B+/WQlcnIX7NADDZp6HyzJhMhvX
         ZQ3JaG1UyJmPtKByRervquzzRF+7RQNnxDJL/nklN0Lu5gOpUl1io37in9WG+6ptU5EC
         FzPg==
X-Forwarded-Encrypted: i=1; AKwUvBxziIs7wbWZrspgQvEYSlw3EW/d0alov2PE9hRvtEXdijE9OPVVB8T02AiZDXA3uuG0qJIED5v3CWhF8uPn@vger.kernel.org
X-Gm-Message-State: AFq9FYKYl68BZ47p8u1I7PfEBiGxjS3nMmqKEmPHKUSeFbiEKYgcDB75
	7cmGBuFuj6k51NILsBiglQj7lPPrs5oPhKTZuPbOfusXiaWgoRNEj4cDuiOtv+zrXco=
X-Gm-Gg: AYBFou1vVUhzAElUYzwIwuwvQeZ99Uzf39iPb7PQtmDo/zuJLZfXrGRogynfX6DMocG
	8UGfb6ewtjJn7tz3LlsAisau9ARBWd4DjtC3Hxc2hNN0AMwU9BXUiBBzrJIiBxXAVdcl4O89uP4
	hka4fy0jzQmcITQEKWGU/G6ughva6J/la/eiiBVUl3Ax+LiqVK4ndqX/PGpf6YtExa9/JTT6vYI
	I7xB8aj4IiOf3HvK0SWKeG+MR46hNrZyurKoGA0F6Z+EwiDIVxh4wjRq91DK9oh6sVkTF07zVjq
	mcfzCnUkIRbczP/uNiQyoeil/wx2+lVZDCC5Z8aVrmgcnaesIZDxCQch4WawrwZWKQ8O82n0XUj
	ZtmErcFzO8g3jnNA+qJDSOTiLDZoFHkC42cNuH09xlZaj24Q5PTZMER0nHf0mbgBfoCsYnpuPco
	XHoj1anLQdFaiWj3AHm5EeR2P42kXXeN7AdVpAO7U7MbOvKEKzKorgoztt6R+44jLNBHgo+IT4V
	07JC32RtzjdbPwcBAWbJAKEHLbih5+2pAGePapYFVcO8uiG/jSaj+RSzBnQpqRcD+aAK9Ivv1oq
	Wx2DaGakgb0NWOxmEvW3T0v2eVY=
X-Received: by 2002:a05:620a:198a:b0:93f:3391:d5a1 with SMTP id af79cd13be357-93f57f65930mr93498685a.75.1792532830268;
        Tue, 20 Oct 2026 14:47:10 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d98978sm86912785a.10.2026.10.20.14.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 14:47:09 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/39] mm/vma: fix mmap_prepare file handling,
 remove file_doesnt_need_get
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Michal Hocko <mhocko@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
 linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
 fuse-devel@lists.linux.dev, Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Bert Karwatzki <spasswolf@web.de>
In-Reply-To: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-1-1aa3c9b139f9@kernel.org>
References: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-0-1aa3c9b139f9@kernel.org>
 <20261013-b4-mmap-prepare-vma-flag-sanify-v6-1-1aa3c9b139f9@kernel.org>
Date: Tue, 20 Oct 2026 17:47:04 -0400
Message-Id: <179253282492.1207257.6426479952081115792.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-13 16:04 +0100, Lorenzo Stoakes (ARM) wrote:
> The map->file_doesnt_need_get flag is confusing and the existing
> implementation has holes.
> 
> Drivers are permitted to change the owning file of a mapping. If they do
> so, they are required to take a reference on that file.
> 
> The mmap() operation which ultimately invokes __mmap_region() is guaranteed
> to drop the refcount for the original file the mapping was made under, but
> this is not true for the replaced file.
> 
...
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Have a nit below, but otherwise

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

> +static bool map_same_file(struct mmap_state *map)
> +{
> +	return map->vm_file == map->file;
> +}
>  

Terrible function name :]

~Gregory

-- 
Gregory Price (Meta) <gourry@gourry.net>
