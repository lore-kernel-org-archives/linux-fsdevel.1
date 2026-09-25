Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCC444CF4A
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321346; cv=pass; b=hhfL+qWGHi/JueCaVBK4KAOnQWIOFGoxPr95s+Ti1laFBxNlzRG+zT1Wfe3mMYcPBGq/6r/HTHm0iauJa42ORqnCAt7yBToTbyJOU/88EucnLu2/KIrJ636RczRqz9p9b67tcICSseW6GlH28KPdfnb3MSER/FkgfusuhuEKZIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321346; c=relaxed/simple;
	bh=jVgzSGCm8ywlcuZ7qh3DmkhvaTUxolTqjmx7km46hGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4XElTaozvYFQUbiHjmebqY5qQuawK+V6DVTwjIVY11axwEGrQiC9qdBouZZUXYXz69Ka70XZf4EW2lM07VqLfIkdBWs2qe0nidwim4YyL3zihLW8AKiw8UcO8hbYYokIL96mMFNpWO4vtqM6HhuwnfFnog2I7B/1UPY12STv8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jD9s5J6B; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jD9s5J6B"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-532e9ad9a1eso202671cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 00:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790321342; cv=none;
        d=google.com; s=arc-20260327;
        b=A61Wjmu2ivxza8lTVoRWk4w5xEG20xZHEwZq2UbkfStcpsNrc+W4DGx5ZNc/hTBTjJ
         4ekoOLHTxkvcAVE+HMRPSuhN/Y1wpj4AvHZ5Bs0hiWDyCfMD9F/kkGIAQ527Q8iYp1e3
         oX141Gp6Xffk2QdNH0T/0kJaATgeVt+B7ehiWKNKvV7DEAdS+951UuN8aVfnFCGqYJdL
         E59mfHV833bSIObRL6mlN1zSQJl7K0zUjp+qfw7Y7lDAHQo2qaBXtnPyGXTDKbaybFdQ
         pw6ptfPdvShL15Z94VpgKGYktFVzbXx4xEPa4PLxqKFG7bzwXdCzV26efqdj8MQ8LEkF
         sOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKlx39bvD+La1fyAAMePfYRq9L+0k8EzNqVplWKbJoQ=;
        fh=PHJuThl8Vs/wbtfLTdR7wZoWXCEekxJGb1AXHoF5uJw=;
        b=lbBun+/BXDtxYrRf9D6OSD0gjevd8DIp5agmiTe3MGB980o4Y7Bh5hUytFfppjG+pm
         pUXSkUe7yt2JabYgFZztqt4lyw3hhJmsRLl/iipHQyq4qLADv6I0w76eRazcfEb6qIzr
         w018R3IX5ICxbL95LZQeXsKlHLI5Hq7UO85w1+yqZwS26CzixsP6mzUhSpMXSlv1/d4u
         A5WtTMOAeHYMoYFVMbQmwN5/PFBSOoll0ie/AJv6KGgQHVMi4WVP3K7/pXdJgeWm7vXO
         JKNkDxvCO7pZm329iIxiu4rGx2RbKQpofukRXIP4G4nMKTFSHjgXAD0Yb/pr4vyPGxZg
         HGWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790321342; x=1790926142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QKlx39bvD+La1fyAAMePfYRq9L+0k8EzNqVplWKbJoQ=;
        b=jD9s5J6BxLUpOD+WnjyHgcQqvyMWXtKd8JOlF8Wqc7YrVArqK3BEC29170xB4S3ZdA
         5mH36URtK99mdnb7qjMWW9ASPxDIu+iiFZ/CSdaBcqKTlKoO3RdcRNxAlFCiBxkpg5Ll
         5OP3lufYb5Wc/bmKdPC5bRSrxQOTz1XzF8KLKdMBm2Z/FaYNVuWkDpCr2iTsgdUlppYA
         xVLDCzZTCpgtBnyn0TGzsYxarAsXKPeNbHClPsDS4ZHo9aNc6Fsst8fQmbYj3RKRrAzx
         ShvTucutNkiNSDR7HvOmG84bvKdJ3EPHoOkbIRJqumaMQ+a6VVzAfM3mRCoFc0IJ3Aro
         BzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321342; x=1790926142;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKlx39bvD+La1fyAAMePfYRq9L+0k8EzNqVplWKbJoQ=;
        b=kTw9vpNjrpR6iyH2gItlyExRZ1fkmXAqjlQVTgdkyPEe95WdqMHSfsAd3B/hlyDyVu
         7gyaZATJYuUkTjd+TQcRN/BFTvONii28fwSAQJO0h8H4L3nV5Vgo0/8+YzCM9oXNaUUD
         N5HI7Rv7/B4p5zqk9U8jtDqWINu/w3JJqVqqg+GDcgMobfx3Z8i+THnX3eH37j9q1+uw
         NzklaF0trNS5NGWxdZkFQNq3pQB1QFQ7qBiU0jthF2fOHFTH9GZvSLB2SJW3v/9cZ7xq
         cC64cVkrrM4BoIsQHVR/7S4sz51KRDb7PeY6uTqwPr1iGPMdl6hOenKfBf72pt1AWtE6
         BZpQ==
X-Forwarded-Encrypted: i=1; AKwUvByYmvwAwX5Nd1JAPg2Cqw70RQUmNYXWwmqORQEJHYiirExiP43n7JO8ojs/QH43y5QUrwcTlX5oMC/wg4rp@vger.kernel.org
X-Gm-Message-State: AFuF++mxxus4xQN+/fimT6xqrtmV3EL71N5SozFJtyzW0sTPyyIZdcq9
	Upn1bP85/KPrS72mmK+QQoTjmE+GTTUifcjmcOYch8FmmkY5Y1WrGZOKFyfu6NKpnmO+V4phTta
	8FvtXUwIV54lIn4Mfzf+zZCquWlxni+2nx1SwvTJG
X-Gm-Gg: AYBFou0FRgsU023IYtAm2PM1DZjW3FF5vxfFlU4ERZUSSeWlph2YptYStC9ttt1bvzu
	avG+YzCvkcioTpllTDJenau/Pn4kCImlKcM2TJ3lIWWgjAej8OS0b+8IzymTXsQZTmIKAP8BaBV
	QYly92CQD1pR4SHuPBHt6AoSxrZJzgv0mTz/tayLUXQOt9l1bFphTqLMZ9IH/qjn4SA1CWli0e0
	nwOCYvCVrmNguBVAYcdFdLJg5CSurkI+YuzoMi49HFKcaZIVBD5dEI3uZFXL0MMSPHxdUuHOtbw
	zAHrDWlKm9FNc7x1nHRR2w7p/DHJ7h7v0wQF5zqREQGdXTfo8gw/hQ==
X-Received: by 2002:a05:622a:4c15:b0:531:d8:e437 with SMTP id
 d75a77b69052e-5330e1083a8mr8850471cf.7.1790321341004; Fri, 25 Sep 2026
 00:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 25 Sep 2026 00:28:49 -0700
X-Gm-Features: AclHuK8wpU_boMBtoQ2BxSfl48UrjTg974xy2tCF5bv_vM_I_Kq5OyVf7aIl6LM
Message-ID: <CAJuCfpF2U9rgHmhaDoXX1hxsuuS=s-oWK9Nk19TDQ6CLpjhFVA@mail.gmail.com>
Subject: Re: [PATCH v3 05/40] mm/vma: ensure mmap_prepare doesn't set actions
 on a mergeable vma
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

On Thu, Sep 17, 2026 at 9:25=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> When a user requests an mmap_action be performed in mmap_prepare, this
> involves populating the VMA range with data.
>
> However, if the VMA is mergeable, it might then mistakenly be merged with
> another VMA without having populated the range.
>
> Every mmap action currently available sets VMA flags such that the VMA
> cannot be merged.
>
> However, to ensure that no future mmap action falls foul of this, assert
> that this is the case upon mmap_prepare validation.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/vma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index d6ed10cefc8f..62f2ce1ad5a1 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2809,6 +2809,15 @@ static int mmap_validate(unsigned long prev_start,=
 unsigned long prev_end,
>  int mmap_prepare_validate(const struct vm_area_desc *prev_desc,
>                           const struct vm_area_desc *desc)
>  {
> +       /*
> +        * It is not valid to execute mmap actions for VMAs which can be =
merged,
> +        * as any such merge would leave portions of the mapping incorrec=
tly
> +        * unmapped.
> +        */
> +       if (vma_flags_can_merge(&desc->vma_flags) &&
> +           WARN_ON_ONCE(desc->action.type !=3D MMAP_NOTHING))

Any reason you chose this "if (A && WARN_ON_ONCE(B))" pattern instead
of a simpler "if (WARN_ON_ONCE(A && B))"? Unless there are races
between A and B updates, I think these would be equivalent, right?

> +               return -EINVAL;
> +
>         return mmap_validate(prev_desc->start, prev_desc->end,
>                              desc->start, desc->end,
>                              &prev_desc->vma_flags, &desc->vma_flags);
>
> --
> 2.55.0
>
