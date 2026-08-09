Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15261AA1D5
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Aug 2026 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236603; cv=pass; b=DeTFqzwfZt0V2EeJpxIAues7aXjUkRYv5CqWtgQwb3QYqFzSNRBnEmvhfx0h5tjW9NysqbkaXri7OMkeg2xdoPJhqM9+tkg/0p/arf8Zkk/wa/JIkM1PTG2Wnsy4kwfGHOIwM2Q8E+xHnX+5ofWGtgwVYgNwOcv+jeTzwHExzNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236603; c=relaxed/simple;
	bh=uWVe1BdpMd0lRes5ct6uZ9noXUP5xpqgoEGZNp5fE2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvK+5WjyYIGR0megpOmGBE+d0tbeY+htfX/9zZvnucGO08b+rCZFixQ6XdRTuIbwmosou64VrPjlh+iEmvYewpLsRqhG2fncDD1lPuyy9SCdl6YW5fmmzPek3IM8l4UTiJkHun/onNG8YNvPpkXs2PMmSpUCnm6LNgygXO1XlQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHMbRHXy; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHMbRHXy"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c15a5b265so178261cf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Aug 2026 17:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786236601; cv=none;
        d=google.com; s=arc-20260327;
        b=D0tkeJyig5ncBmE7+AvsFQqEg1fpUPwXQx5scR58OmprEbEDrwTA/igSQUzbPVCxo+
         vyB+UQWIQuPdb57mkYOtBpDoAsmZ4o0JuQ8PsGkXZXBm6C7iRTmbCsoD6ufkoQhZZU5N
         lEssi07Ebk35G+rLMghulDszZslTdIw9NN6pkh0Uci6FhHlRdoQ3tSsOWpRasbYJ1LPw
         b6o/lHMgX/bzlyHMaC+ioASUK7qv/cjdPDXe1zbpfIrNspEvWBQKS/WUudzWmYGoMs6n
         AwQYcTQmuH3yRNqLvW12lCr8HzpBjIG859e6jNqSPnwJj5lPJRj/BjMRSaDga10WrdEJ
         3/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=glHudYQR7Sx8Ip0RwDHznG86gS5ZxNzd6JiJvbqbi6Y=;
        fh=OZHN+VKaRCOCnwc2M9RRlNuvRSn2ehemdeeWgHk8gv8=;
        b=O8/PQ/qkWJm1Ixxbyb6kN8QQ+YEi0pGLwcF+LwWu+NAtlgKwELbTUzHYCkI+klOwUw
         j27ZVw7yQFMqgXg7fnt/jcqC3BrCiFZ8g6otMw7SkdGyvruE6gyW8mut0h3TomTlPp3H
         2PmlJaB8PfsbKnXAjPR0Jiq4HkzgO2MF8ljI5Z03QUoKkThkrRurg7yamtFgFQpHwMW3
         EQJlnkK2oX2mw7rddaM1cQClX1gqFPEYM66661fAPKmBqzLGlp10YNPmiQstNcXum2PW
         VaIXXnpTugF7kxDZ1+itrQM2zoS8+XublkHKfsRbds4hpg9xCTAZU06qnTmhzo3u2cz1
         c7Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786236601; x=1786841401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=glHudYQR7Sx8Ip0RwDHznG86gS5ZxNzd6JiJvbqbi6Y=;
        b=RHMbRHXy9rFNhQQ8XljF4g+kfCAGWx9flfFCbodoE+5eDaw13V75Z5OMW4wcl9KGn1
         Rk8PWRvZkU23L9XZJci3ZCx4kn+77YaLaH7kKDKpZAYH5Vtb5Rw7uzO8DxrzDPwsDGR7
         8uqgEcA1raSOjHi3YfuuVe+gk0mvxUMzsG8kamBmBv975Zxt3qhLmW6mlvMYMhSuf2Ng
         lCcWTRBoSDxlEoyc98uUC6nnaUAhCv9NK7Juf5KfRcqkPxNjbuUAtrPEgjP/1pv8gSn7
         NZe2IbVig7o0klHumnUzFpTN/3Zxp3MqAMeN244lUJvRGObo0SZrYKvR2rq060Jy9vcS
         HPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786236601; x=1786841401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=glHudYQR7Sx8Ip0RwDHznG86gS5ZxNzd6JiJvbqbi6Y=;
        b=c1+XNeOsh9HhPT2wpIQCRCqo5Zbdz0z9WU6HiMhM6qS+5S5yq/6rdzMWpr9AbDKvuT
         9vTjjmWnJhBOiWbTtpuEf51EJ2t5x2jNljr9w5nC4vJmKTlIzQ3yewG96NLmUEqOjsWt
         mBUpWgC7CuSjk4BKyw4DaZ2oQTYmmCRmqbfa3gRG/7Vg0DAUX2Pc1lY2aPLzw6eVRvuS
         W0fMfNBmQq++lJuzpBI2eiAvHFEjKWXzMnLu/TGTc5DBtl0a1uQVWHeDJfiWQziuspMg
         4ghlO/7DXQrhS1lT3IUXM6Xd+suQJqRg0OOGmBmKqcu6gi0WNhd3eoQaJ9nQvI+F2sTW
         PvrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQZSuj5z5HFGtwxif/m+Co5sNTQ71HssEEAhtsPKJ+a2+MnOJBIlk7+h/6+nBs3XkuGZD2BAHRNt4E09U/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+X67UJtXbe3EhMs/mRqs7rdIA/Dy2w4HxM74K2FKv2iKnUle
	ftbCQYxuN+vRIWVL1Eqbyd53xCFCe9Y4g6gBgRkhu6pRaU1qFwQCHv8w3ngLcJcA+LE10G4iPyn
	W26XJsdfkx/+7ZIpWwqYHIVizLisbdwyAoR42ObmQ
X-Gm-Gg: AR+sD12Z/5SUeuDkH+90y9Zg0K9nxJUl2Vwx5qsvG3WcSgtyGwAoMOywcF58y1D5NTc
	n3hy1aAXP+goAFrLF1zjCa6CzYlHiOHMgsanf6MVJWVRwD+MKjMVJa9iZzPaSOfGVtHd3SHulIS
	3azZge4WrxkaV6t/D3YHoZh2kr9tkFc91HqA5c0Om6N+2tY2LbfCxbfCdTt03DN4I6djRQ51/2V
	FIOa5WGYnW67gBkhAbNXcjxmN4oQ+pdhKvzZ/t4N14BAtOWfvTcX6WGcw182t39wSqvcs3vBwKd
	MfVjzypsWOH48h04rkCgjSGSWhEEG0G+tSi9jalmGC4=
X-Received: by 2002:ac8:7f4f:0:b0:52b:4ec6:52ba with SMTP id
 d75a77b69052e-52d23c37702mr15746931cf.6.1786236600065; Sat, 08 Aug 2026
 17:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org> <20260806-b4-scalable-cow-virt-pgoff-v4-3-ab318a350404@kernel.org>
In-Reply-To: <20260806-b4-scalable-cow-virt-pgoff-v4-3-ab318a350404@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 8 Aug 2026 17:49:48 -0700
X-Gm-Features: AUfX_mw1Q82W2dZ-6X55NWg9zTGU5sEbnBW6U_FzEZzOIU5ZiJmeQXvgECKsKPA
Message-ID: <CAJuCfpGjE66Duhw0r8H0GKBFDExjroRar6n5MgVOOQjz4ZfTuA@mail.gmail.com>
Subject: Re: [PATCH v4 03/20] mm: introduce linear_anon_page_index()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 1:23=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> This function provides the anonymous equivalent of linear_page_index(),
> instead offsetting based on the anonymous page offset of the VMA.
>
> It is valid only for anonymous or MAP_PRIVATE file-backed mappings, in
> other words CoW mappings.
>
> For pure anon VMAs, this will be equal to linear_page_index().
>
> Assert that both of these invariants are true In linear_anon_page_index()

s/In/in

> and implement the algorithm in __linear_anon_page_index().
>
> Note that MAP_PRIVATE-/dev/zero mappings will satisfy vma_is_anonymous()
> but not fulfill this invariant, so when asserting this we check
> vma->vm_file to account for this.
>
> We do not update callsites yet, so no functional change intended.
>
> Also const-ify vma_is_anonymous() to make it compatible with the
> const-ified linear_anon_page_index().
>
> While we're here, update linear_page_index() to be more succinct.
>
> VMA userland tests are also updated accordingly.
>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  include/linux/mm.h              |  2 +-
>  include/linux/pagemap.h         | 40 +++++++++++++++++++++++++++++++++++=
++---
>  tools/testing/vma/include/dup.h | 25 ++++++++++++++++++++++++-
>  3 files changed, 62 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a3368c542947..da36a6cc907c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1556,7 +1556,7 @@ static inline void vma_desc_set_anonymous(struct vm=
_area_desc *desc)
>         desc->vm_ops =3D NULL;
>  }
>
> -static inline bool vma_is_anonymous(struct vm_area_struct *vma)
> +static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
>  {
>         return !vma->vm_ops;
>  }
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c6fc783aaee5..0adfa6605653 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1094,10 +1094,44 @@ static inline pgoff_t linear_page_delta(const str=
uct vm_area_struct *vma,
>  static inline pgoff_t linear_page_index(const struct vm_area_struct *vma=
,
>                                         const unsigned long address)
>  {
> -       pgoff_t pgoff;
> +       return linear_page_delta(vma, address) + vma_start_pgoff(vma);
> +}
> +
> +static inline pgoff_t __linear_anon_page_index(const struct vm_area_stru=
ct *vma,
> +               const unsigned long address)
> +{
> +       return linear_page_delta(vma, address) + vma_start_anon_pgoff(vma=
);
> +}
> +
> +/**
> + * linear_anon_page_index() - Determine the absolute anonymous page offs=
et of
> + * @address within @vma.
> + * @vma: An anonymous or MAP_PRIVATE file-backed VMA in which @address r=
esides.
> + * @address: The address whose absolute page offset is required.
> + *
> + * This returns the anonymous page offset of @address, which is the page=
 offset
> + * the address possessed at the time the VMA was first faulted.
> + *
> + * For anonymous mappings, this returns the same value as linear_page_in=
dex().
> + *
> + * For MAP_PRIVATE file-backed mappings, this returns the anonymous page=
 offset
> + * of @address, which is the page offset the address possessed at the ti=
me the
> + * VMA was first faulted.
> + *
> + * It is not valid to call this function for shared file-backed mappings=
.
> + *
> + * Returns: The absolute anonymous page offset of @address within @vma.
> + */
> +static inline pgoff_t linear_anon_page_index(const struct vm_area_struct=
 *vma,
> +               const unsigned long address)
> +{
> +       const pgoff_t pgoff =3D __linear_anon_page_index(vma, address);
> +
> +       VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));

As discussed off the list, this assertion works even for read-only
anon mappings because, as you said, "there's no such thing as a pure
anon mapping that is !VMA_MAYWRITE_BIT, there is no way to achieve
that."
It took me some time to see that after reading your discussion with
David at [1] and [2], and I don't think it's very intuitive. Could you
please add a comment explaining that? Maybe add a comment at
vma_is_cow_mapping() definition since you are using the same assertion
in another patch of this series?

[1] https://lore.kernel.org/linux-mm/anBjpdMicqaGADr-@lucifer/
[2] https://lore.kernel.org/linux-mm/anLyhaI6kW-EWk13@lucifer/



> +       /* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous=
. */
> +       if (vma_is_anonymous(vma) && !vma->vm_file)
> +               VM_WARN_ON_ONCE(pgoff !=3D linear_page_index(vma, address=
));
>
> -       pgoff =3D linear_page_delta(vma, address);
> -       pgoff +=3D vma_start_pgoff(vma);
>         return pgoff;
>  }
>
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 40ad83936b28..4c58487b764e 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1428,7 +1428,7 @@ static inline void vma_iter_set(struct vma_iterator=
 *vmi, unsigned long addr)
>         mas_set(&vmi->mas, addr);
>  }
>
> -static inline bool vma_is_anonymous(struct vm_area_struct *vma)
> +static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
>  {
>         return !vma->vm_ops;
>  }
> @@ -1621,3 +1621,26 @@ static inline pgprot_t vma_get_page_prot(const str=
uct vm_area_struct *vma)
>  {
>         return vma_flags_to_page_prot(vma->flags);
>  }
> +
> +static inline pgoff_t __linear_anon_page_index(const struct vm_area_stru=
ct *vma,
> +                                              const unsigned long addres=
s)
> +{
> +       pgoff_t pgoff;
> +
> +       pgoff =3D linear_page_delta(vma, address);
> +       pgoff +=3D vma_start_anon_pgoff(vma);
> +       return pgoff;
> +}
> +
> +static inline pgoff_t linear_anon_page_index(const struct vm_area_struct=
 *vma,
> +               const unsigned long address)
> +{
> +       const pgoff_t pgoff =3D __linear_anon_page_index(vma, address);
> +
> +       VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
> +       /* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous=
. */
> +       if (vma_is_anonymous(vma) && !vma->vm_file)
> +               VM_WARN_ON_ONCE(pgoff !=3D linear_page_index(vma, address=
));
> +
> +       return pgoff;
> +}
>
> --
> 2.55.0
>
