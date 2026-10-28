Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793206481;
	b=zm/CjAzEgO9t9smT3YM0lpEZMnZ8XN1n6j0p4zuswDsjRk1tFZCm5Pg2i9DT/BcZhhSQ
	 CqVUkV9Izi1RhJX4kmzuXthN7VbUV0f4rUjtv1w4sgfxvPctqPwnqzXHBtBnDQmAVtq1M
	 qtl+IMmHVQYfmhA8GEz3MkVEGcjVWD3uQF5icgOhxvBo/QXdEGa8uWfmBoaJoJ/LDQ9HX
	 1Y5kATtfQyKuxOb1czRfBvZHUfxvUsyWCx5hIPHBKLM+wOckt1QXA75zFEXUn41ISaNVY
	 bBvfTQrTfVyxwSlMdBIR5TzuPwzGSmbwRwnkrQ/T7um0SHKzEa1BZmLaPJNbksBp1cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
	b=5JTN2S3egWA4W1XswJVq9JmZFJup+z0/MqyJtjfiXWabWzzdf+pBxIZJ51Okvitd8iEc
	 tkQXFxJ92tGEHaAUadogHbtttKgueOU4ssQfUUiT4l1GwK44+1OC2aj9udmYhVZOFFb6L
	 HqOhR8lK/mba3gip0R86Ga0bZ3O5VviJD7I1xw1Ejfj1r1alTvMaHM/jw1aZ5cmRgjahC
	 CxlnyLZl5Vvpj1lZ7euxDA43Gltc4xpVbfnDf0o/HnI8/v0ucAoq4W+rV3PrqipeA2BBy
	 a/j5eZ2W8KXeIbhEYAPGzUOns8is1bLU1AU7i/m17Yb4TcMNaphRAvgRGyIA+ozBglQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oj4eYMqF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A237606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A237606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oj4eYMqF
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c43fbcb4393so193636566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 09:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793206480; cv=none;
        d=google.com; s=arc-20260327;
        b=h8mGsN0HJc8XHfawHm+OqmHDSIM0r596vSOOsehS6bUuKBz/rFTShDl2b4wROXeEdj
         IQBrL6eAFpG9XJONuc6ZntkiNvSQ0Uw+PgTm3HgCyHG8bm64nA4RM2fQFMU0ZbWB7vHX
         qK8UrwEyFB8PbKuDO7FSuuZtTC8YKWlOaAqlQdaEGXRGUnac8gdc1fDPClnj88zx2gRg
         LG3n817E71wNPipXQ7gL98eaca7gSgB/tmzJDlOaYTo0Tnc1hKdhU4mTnPPwt8thLmi+
         CwELOzyJnFuASNv2qquL4PzEQ6NaXxy3DsA7r/k7ZrcGDznGEroSfSmjJDJJvvfbnzTw
         Eoig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        fh=u3fvtcFm3QiQeS9glTbDwzxqq0F29UDLT3nlklOX5JM=;
        b=L1rTI6hoOHQ/cB+N1YHG3AWvIx8Y3Be1bEE0XHHnLt/oi1xyAcZtEdravooKhgpOBi
         Z2SQ24s95OWOKl67eok3L7phKy5iJy9MdBZ/h06LlaC45pEJB9lO5WptAHztLfQuaziF
         OsQO7K2U/aYBW1TZ5jvY69t+ggCtdtMPGumSbdESEAeGq6EBLhM/8+0R6cOxpyo1pgQI
         Xe4c/ma0l2RkZIhA3dhed2QAkmrPbWzFosbGXG2JvBwE2Hw5OfiAJLMr/iZJYuFguScs
         87ycCerMJBMQE2ircgDRitU7OHqGMmHnvwOBVhob16wmpKFpXD9h+kfNTnCZug39X+B9
         B/AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206480; x=1793811280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        b=oj4eYMqFg7gHe9H2JcxnVX1xekmxsJ19PcyDmk/OMgjn5UXSCYYnXu7Ac1axMQ7SR9
         q4zcTyMTKwoBmlpjcyBns4x2YrJV/wZCM14e5QvikeiV0C+wKNF7KUibECOIrMdPWZb8
         TeeSnShwQLOPfWWedxcIMlWY8bdOdzbeIcmNlPYAeJPXpTRHI3uLnL51w/g/MSBgrYqU
         hM8NCxRBVHWjK69lGvL9PkV9slxoAJvbLHj55IQQFN7GfFG4bIrQO3qJDWc5uDOrVsDp
         Urwxbb1Ol2RkuzF1a7HS3sIe18QCl/MS8DkzaZbxu24cwwm8EY03lDrdPNjvlUvh/BZE
         LYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206480; x=1793811280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        b=Tjf/K5/NLp07gdUwtOv21aUaW2soCtwBR4BTvtrwT9bZ+fc8L+UJ00bUeFWA7KEls9
         HNy2jdTSG2ELTMNZnewnACBDmbME0IVtQ9OsXbjFqCXHhQ5pG9C/iTRBvWmpIVZ4KOqL
         1/5E6yBxWwhyuaO1plSJxDUZXZzIjMMPg3LZVBx/7ltEsMHcapYwZXiRmE/yfZE2SDK8
         YT3jEB9QOMNM/bA9z917yh4KS0LpXHMnuZfPqvJCDG+VewpsolIBk9gdspqRT9vIu22S
         yuld2ws93IQDKOsTh8Vj01xkfbVzvJ9w5CdLhGksODUnhzQAZPnk/LeE2E9Hwty5FIh6
         T+eQ==
X-Forwarded-Encrypted: i=1; AKwUvByDbbliIYEuT4rqoz6ImeJP8wYme+xv8XIPSC7fz9+ixCLBawICbBw9TRb/NY7tRIQ/hr4jc7tnMa6dmD1l@vger.kernel.org
X-Gm-Message-State: AFq9FYKz0mECPHjOcd3d8SM4tgvCRTMyRGsJBUhqLEDXA7OZWxJrBBSa
	VtqJbuIba2Ds11tXirQSV2Pzokmk2GkZ6RzpXTO3BUw3HhpQHSAvg0EoXopm3u250Gfi4MvWQCX
	VTm6yjh8U+XtmBijC+EG09TmFMBOHNhI=
X-Gm-Gg: AYBFou3e4Pr0YHdb6PwGy0T8Oic77AJxPJWQtCNaID5sseA40R7gHVTNbiGbIISsaf6
	zctnd3Rt7s1n7ikikk7K/c5+b803Mta2bWHjzefZBVcN135PouWYqkoypdnF4WLBevBy/DzZBdK
	4/L/5irjqD4eHOVcYeKSPbS3wxUUPvwwNy2tgnz6e3P5Qz0LD9JXRaTYFj9BZCta17kEHSNc6/v
	AX5pdymYy22tCweQg6RDmRAB9aYV2wTO2hmjDGTLNzr6fjSIyUBXvl38EXo9W1gZxlMhjrrh7da
	x2KWQAsS2xzH0TPhtyC3Y83L0+ytkZEtbj5UM11WTAEAYPBluYrddbytNP67wJ9Z5wX6N+l49c0
	C5+55YH6YiSDLcvf+BF6dys+ZoGMaSAlflYATGShs4adUtcsl7V4fy4oUt8ca2FAukb32aA==
X-Received: by 2002:a17:906:f586:b0:c46:5973:2a1c with SMTP id
 a640c23a62f3a-c49be00bf7amr248310266b.37.1793206479455; Wed, 28 Oct 2026
 09:54:39 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org> <auBbKP8UNI9talDL@gremlin> <e5766fe2-6cbb-45bc-bc57-87314c130de8@kernel.org>
In-Reply-To: <e5766fe2-6cbb-45bc-bc57-87314c130de8@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 29 Oct 2026 00:54:01 +0800
X-Gm-Features: AclHuK9Ir5cjQUbkmvsMXXN1XNQvMKyhNeup0qo5sC4qB6sDOiJzphX3Pz6BQcc
Message-ID: <CAMgjq7DzLFcznTqVaRneoN+qa9StPTvcBwHMdLM52ZbfZ-ffEQ@mail.gmail.com>
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking PUD
 and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 3:07=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/27/26 09:06, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Oct 27, 2026 at 12:17:21AM +0100, David Hildenbrand (Arm) wrote=
:
> >> From: Josef Bacik <josef@toxicpanda.com>
> >>
> >> MGLRU passes stack copies of page-table entries in walk_pud_range() an=
d
> >> walk_pmd_range() when walking to the next level. These copies can beco=
me
> >> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a P=
TE
> >> table concurrently.
> >>
> >> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> >> support page table walks"). Likely, earlier locking masked the latent
> >> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> >> retract_page_tables() without mmap or vma lock") allowed concurrent
> >> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg lock=
ing
> >> for MGLRU") dropped the walker's outer RCU protection.
> >>
> >> The fix is simple, so just fix the original commit so we don't have to
> >> speculate. To fix it, pass the actual PMD/PUD pointers. This restores =
the
> >> RCU-protected lookup and validation against the live PMD. Note that th=
e PUD
> >> handling is required as well to handle folded page tables correctly in=
 all
> >> cases.
> >>
> >> Fix generated by an LLM and sent by Josef Bacik in private.
> >>
> >> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> [ david: handle walk_pud_range() as well, clarify+simplify description=
,
> >>          adjust Fixes: ]
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> >
> > God, terrible. And why does MGLRU feel it needs its own independent pag=
e
> > walking mechanism?...
>
> It's all a big mess. I think at LSF/MM there was some talk of using that =
also
> for traditional LRU, but I guess it might take a while ...

Right, there are reasons, MGLRU's page table walker uses a bloom
filter and have some zig-zag avoidance. It would be nice to fold that
into the generic walker eventually, but it=E2=80=99s not a high priority ri=
ght
now, but we=E2=80=99ll get there eventually. And using that for CLRU lacks
support for lazy promotion so I'm not very sure about that, but still
things are being unified bit by bit, so it will at least looks better
step by step. :)
