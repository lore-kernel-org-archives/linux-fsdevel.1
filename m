Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B51353FD20
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180642; cv=pass; b=FTeIFGbLHufvKWjKJ3taGbC7f4sK0yXx6R2PpAlYJKPsCzs6KKEvXuevwlpUYphCHVOzRSGSQ9xHmohVx67vvdy6ow1Is9kUupaDY6PsfhMPYD32u7lH5FThIWxrIT/Qa+eiWR15JFGqZliG4jBOFjzUtUQkgvA1XIWWVII/K3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180642; c=relaxed/simple;
	bh=2Oteq2LQAfmMQohvmzQdfax4JBAWgMtdwlOqmBNmox8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6sDnPuS4Ttzsu8Ikpfz/CT/4ejGIOwqp8iqikax8ue7lLm2iQEKadMPIFDGEl1TtxQX+DMKaDY0XhGb/O1zn/V4NXaP+fFM01zmVtJcVNyOINw7DQa6V3cF/Ap5yg3LmTAVhiW4aGTCdy8XftpbbqKe4dt3tYkXp1JYwxAt834=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEd/4zx7; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEd/4zx7"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52faa58bff5so282521cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 09:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790180637; cv=none;
        d=google.com; s=arc-20260327;
        b=aTtInjV4MrFsxU/y+goSWPQBvZ3zvCHueOCgE6MiE5hRbF8m2RXjbhocCNZLWD66ii
         d/I5gXmr5IpQSUtlnVTkvUAxTs92xr76KP3QdxkVmPEpRRc4u6r5DEeLmuKJd6wkuXzV
         /R9BTVq85Z3mV+MxosZMDDnDjacEKZJ6ZqEY6HEyc/I7pWGuMknyhocSq7td5NiuXJPZ
         d2vCWCOi6whROWQV/ceOpTPwVuA410mxFIX+StoTaBjvOT0WQ6jlqVw9M4FHe1ywmHXA
         hQuh5md1tL71x5NUmNYI4MoIjk3ABMOr5YtafKmfZE2+RgfN6WIFqd7ntr3JBH52Fyqp
         /8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
        fh=gSmGADsJZz7iApU7vw/lRNQtEfHIdPVQZBN0IN3EhbY=;
        b=YNJkTLb5YuaWl95OkO7O12km3UzhgblL+T+r3+4VRuoOpGY1O12lFcYuTOsXoggSNA
         lN839csZfSBtUSCHvbtdR1Sp2U/t8WEZSz1pcNbfCy24gx5DdQhvHekaDEQlFREK4n7L
         /9SAvX8AYzFJHHTxNWbtf7BS3guuxFSwoabGZqNYSycy3OgokC/VGyIwXNw6+9QWI14N
         pXgBAKuaFBnNgBsZtew5nuFoRg/dOmm3DEGn5FUl59C5YOqvwGOb+jEAq/qWQ6dW0oLY
         Hwb1frtGSbNltRXO0nCOWxBlHw3JrVBYmq9XPkD9Rp+T4UgAnw7qhXaUG5gVhAEU/L12
         KFNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790180637; x=1790785437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
        b=WEd/4zx7Jaw6N2UvE9ErsDRPD2W5F8+AuDISUgXBRyBoK9r3OWGBweIAd8Z/UpZzKH
         p05za8XzaClAZW0REIguKzHb6Mxk1fy/wRxHFqwg4CfxETMqi1r41NObDpo6bjY0UfKs
         Jyu4Po4SIkpeEBrcoPTQ5EK/lNGPcMVFGXgDnxUpUNjw9ZS+EFtfCGF/4BEtwtQiu07P
         oyksd3surmOtyTiMVQzbuT2zgiB+VpgdJUB//IdsXOUSubfFgtpwt4uMdYFkhPGsaa91
         StwUEYOtRyaHQXj4MdOBzhoLCYsqD+D2lAdGKqOpAnNG1gun5Gx3CL0lLu2mkVa/r81B
         VwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180637; x=1790785437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
        b=Ox9epK20+TIx0p140J7EOweel4xlhnnpjSfzzaTV5tXlJcGfMNyQMWaPgrZh5Y5pF9
         7F84coJzen9sccnrq1cGU6k3FtItr3PNekLOzYzFyq4D9335nL3ZnvFfZkuFqxmp3+kz
         y+fg+l7Gq3QiWgIaeBVrOcGQRWw8dWT/2hREkEnfIT2wMiYC1yeyDkWpyPEIArEnCYkd
         2LZHSaLKeFilzUIcOhSraKYo53JDwhy2RlijBb9M21PSwq/lXJGmpXyPgckuz4pwzWuT
         9NtT7kwXgEWURmXE1mL+iGn5dusrWxddGHokua9+BF+o0Jsu4o5MIbFJ7Pn0KNlLlHCy
         sK0w==
X-Forwarded-Encrypted: i=1; AKwUvBxdXoXy3KaMNCk/MvWo5AzTDrjk/95c1btFZEJl7omc3GPLmmF8FF5I+n1lNRacqUGqrOyIPDoZnpYQtQqj@vger.kernel.org
X-Gm-Message-State: AFuF++l3nfaoETp5iKMqL5WWFRwavQ1dOiDLfiNTrpUsYB7ms4uIc7mG
	2kNeqAHxdzWrWHG0h1N1hdqEnZ6CfvyQNzCp3xWFuh7VAl6KonTck5NzOpLYFIWwXlFeinV+Ty5
	Z04hTv/c595iB4sqdiEVk91qM9qcm0HfS36EnJygL
X-Gm-Gg: AYBFou3v1XT7W7lqst7DkLspKHECR/fUbX3wCGBNlZjAsR2ocYS4nLM02kMMeFDJiGK
	tQha6PysKYdrer7Teu3v889QVaZtfK6qddbvc0dPGuhAr4Tz15ZL3bo5nh4pmJ1wVkqnkY/ss/F
	ySuzLQc2lRIdpKW9hC1hBGRh0dhYfrUHHtn6DfawP53yyQJBL7hEWl/O0opyAMTHVzjkl3HjAGh
	CS+2iUCT4q6MazEgkmNxIgeS3TC1VwqySIzbAiRgI92LYHUlXI6GZvabiv72Wpz4Ub/aqkQB0TF
	byeutACPu5+zunpeKCFhOHaDRb+mXB4mxkNnyjFka5Prjg4xEpua90UQsE3wvISpakHMP5q1x83
	eaUx8T1bL/w==
X-Received: by 2002:a05:622a:609:b0:531:282:6560 with SMTP id
 d75a77b69052e-532f9d4a86emr439391cf.15.1790180636277; Wed, 23 Sep 2026
 09:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 09:23:45 -0700
X-Gm-Features: AcwNN1U-1rGp6GFHFrF0qqhOHTzivX5krrdmfBch0hMHABT_yaCwm6D93D-Dyz8
Message-ID: <CAJuCfpE0WCr1Kp=+4EVJB7UdbH22HuCouOEtGMNCL+a8TnCQPQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/40] mm/vma: introduce and use vma_[flags_]can_merge()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 9:24=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic wit=
h
> two new functions vma_flags_can_merge() and vma_can_merge() and update th=
e
> merge logic to use the former.
>
> This abstracts the check and expresses it in terms of the desired behavio=
ur
> rather than an arbitrary and confusing VMA flag.
>
> This also lays the groundwork for making further improvements in VMA flag
> usage.
>
> Also update the userland VMA tests to reflect the change.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mm.h              | 21 +++++++++++++++++++++
>  mm/vma.c                        | 19 +++++++++++--------
>  tools/testing/vma/include/dup.h |  5 +++++
>  3 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 969594074fd2..68250ece4219 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1612,6 +1612,27 @@ static inline bool vma_is_shared_maywrite(const st=
ruct vm_area_struct *vma)
>         return is_shared_maywrite(&vma->flags);
>  }
>
> +/**
> + * vma_flags_can_merge() - Do the specified VMA flags permit the VMA to =
be
> + * merged with another?
> + * @flags: The VMA flags to test.
> + * Returns: true if the flags permit merging, false otherwise.
> + */
> +static inline bool vma_flags_can_merge(const vma_flags_t *flags)
> +{
> +       return !vma_flags_test_any_mask(flags, VMA_SPECIAL_FLAGS);
> +}
> +
> +/**
> + * vma_can_merge() - Do @vma's flags permit it to be merged with another=
 VMA?
> + * @vma: The VMA to test.
> + * Returns: true if the flags permit merging, otherwise false.
> + */
> +static inline bool vma_can_merge(const struct vm_area_struct *vma)
> +{
> +       return vma_flags_can_merge(&vma->flags);
> +}
> +
>  /**
>   * vma_kernel_pagesize - Default page size granularity for this VMA.
>   * @vma: The user mapping.
> diff --git a/mm/vma.c b/mm/vma.c
> index 4b74b48c29b7..05d2c676672e 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -924,13 +924,14 @@ static __must_check struct vm_area_struct *vma_merg=
e_existing_range(
>
>         vmg->state =3D VMA_MERGE_NOMERGE;
>
> +       if (!vma_flags_can_merge(&vmg->vma_flags))
> +               return NULL;
>         /*
> -        * If a special mapping or if the range being modified is neither=
 at the
> -        * furthermost left or right side of the VMA, then we have no cha=
nce of
> -        * merging and should abort.
> +        * If the range being modified is neither at the furthermost left=
 or
> +        * right side of the VMA, then we have no chance of merging and s=
hould
> +        * abort.
>          */
> -       if (vma_flags_test_any_mask(&vmg->vma_flags, VMA_SPECIAL_FLAGS) |=
|
> -           (!left_side && !right_side))
> +       if (!left_side && !right_side)
>                 return NULL;
>
>         if (left_side)
> @@ -1152,9 +1153,11 @@ struct vm_area_struct *vma_merge_new_range(struct =
vma_merge_struct *vmg)
>
>         vmg->state =3D VMA_MERGE_NOMERGE;
>
> -       /* Special VMAs are unmergeable, also if no prev/next. */
> -       if (vma_flags_test_any_mask(&vmg->vma_flags, VMA_SPECIAL_FLAGS) |=
|
> -           (!prev && !next))
> +       if (!vma_flags_can_merge(&vmg->vma_flags))
> +               return NULL;
> +
> +       /* VMAs with no prev/next are unmergeable. */
> +       if (!prev && !next)
>                 return NULL;
>
>         can_merge_left =3D can_vma_merge_left(vmg);
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 16c09dac59d9..2fd422789717 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1647,3 +1647,8 @@ static inline bool file_is_dev_zero(const struct fi=
le *file)
>  {
>         return file && file->f_op =3D=3D &zero_fops;
>  }
> +
> +static inline bool vma_flags_can_merge(const vma_flags_t *flags)
> +{
> +       return !vma_flags_test_any_mask(flags, VMA_SPECIAL_FLAGS);
> +}
>
> --
> 2.55.0
>
