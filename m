Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51D3D9DB9
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018790; cv=pass; b=S7BT8ZAa/jcpxJcUa8aTWAbWH5on+xLbXK4mm7P9+D37MJMw/ykaxNKh0jUSF7Eai7OGJJ4GlzrfcbCj+88QFNzRxYYx1jHY5cDeayZZRnJs7dtl2c2xoHa/n6kxSyV1rpYswFOFVG59iWlY5gsYjDwas7SSLgUOmaAZUbJu57k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018790; c=relaxed/simple;
	bh=pVEVvA6SvgT2Dh8mJqmOM7GLvNQfJPqq+oL68yZfE50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDVx/2EoiPUfEIPP6W3PQ+r1fL+UUEfeRsxLrSZl+ty/Nr9nlRlSJ78OukJWrCIzApnoajQCFJ0aPvjeTIt2Vnl47Qe3VzJNrM8wyp3PH6qVeX1zwBH54v0njoOZM5XkqEv64OVy3aFP9WOMl9UwrYyDUkD7Rc6AhTX6oRKTYOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzSHOP66; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzSHOP66"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51765331535so2503351cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 08:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781018787; cv=none;
        d=google.com; s=arc-20240605;
        b=L3WHpNjgAwKTQAtRf4DWz2X+3n8zg2NvPqIb/zYUQpKVJkp8Trypw93Qd0qKLx4dvQ
         1/It+9G5S5H6Nrmvux0VmnxdLsJMCdNCEIjddCk/ADX7OBr2nTJVvMvYjYnLUvYgpdqN
         hlm7oUQhfkppsmCgTxvDqzPMsKrJBQDqBPPx8QQPpyt7x7jq7qUXAlld9fl5jDCaipHg
         yJZLwl228t4VY6lwIsW3Cdf04qxYZp8bs0d7EG84mzz0ZNNSLYJtmyB2WKiSxsF7kbhN
         KIKc9/nWRJ5A8HuGRP5VjfqY/uY9gG0+eAN6zW9qUOtOI1edYIwsIcV455b0eWvviZiJ
         XNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rY2o/b8cd6ANaJfQdcKOucxVpV0MJrStEBR6w1nR460=;
        fh=QVkzXVGOfLG9qx2ln668BO36W4pEc46/5uVZSQbgqGA=;
        b=JryQEl5n4r/mgMz0hXNAiEkcffZvQrlCTdtroqCtt81784PlNpdo6Q2RnYxmyTSAbH
         kB2BC18+icXNVkA0PzyN+nPZFbPPHd5dshE7EBhwoqFGvLi6wcJpqjYHRp4kRn6RL6Nj
         HH0Av2JJfy5f6/43w7F2IDZT8YrDJa2L2FnpplATSqQefvza9dTG3lYNT2mCLqAF9LDP
         briozyfco3rE9rzHXzxr4LP4BQf78aXjMK5JKY2837+Br9WH5y1J0DXBYtVhQLwjyNaw
         Zg8X2kBa5OkZAztjAodUiAuIVcPGIUCUkT9yGirh58zkT+8ViTFUzCQtTw2FczamxpyA
         dxkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781018787; x=1781623587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rY2o/b8cd6ANaJfQdcKOucxVpV0MJrStEBR6w1nR460=;
        b=JzSHOP66BFlWvJA9oU42VXpbvrz1Z70AJiIN/o7CdwbAO/uv42ITwLHjXs/71c87TD
         3G8WaipifAWp1Y3aZD9r1bvS8ON4xdqN+1On3wOcjTvBauVhlX+X4Mglm9aYgLiojL6G
         9b99YmXA9QVZZ21MwG2+yh+2phT3scTpw21F0/3nXJcjFUdc5auEdv3tFjb04pFapERn
         07pyuOTGrJd0XbB6yPDxSN06HgZMpLudRorJWvBxgrLp+NTrTJ3CEjJT4Nj3XbP2QOTz
         bI397KrkGbqKLU91nZ1ac6WAEOoUV8TcVWzqusqNMzUgWmgNgMewTSBNoWzxDW5g1mwp
         4n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018787; x=1781623587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rY2o/b8cd6ANaJfQdcKOucxVpV0MJrStEBR6w1nR460=;
        b=fcRsk3ZqhbQoMQBdzdWSshaYqwqRN73BKzrlUWqJAEm6/+ZbtnqgCVhz2rYtVXYTSq
         G/aWUkPl5cReCb/99BQxnAId2HmoRaHAchXe4oSwwRXi0sR+PUkcbT8oys5e0eH1YnK4
         Sg/S+9/+jfdpCVQalZ2miEN085Qv7dfMksx2nCqIit6Se5Q6kdSF/s/LCXuJtJp5us+U
         kFLdKRSXWJL1s5hbf0TpfdLo0w60LF5tyd2mxTNZR/3DrHd55tkp5Gsw2uWXKDhHMXYD
         w+XJf9SnqAUjNcrC0fFfljQyNsMnIy+jt/pSg9cNjG/5Wd1xPsQ6oLLyzg1gGds30PoL
         VUOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QjQPyqdnDans0ocQe/kpDY6pGW6VIkLQ1NPllas335U6QChiqddgCdjeS9LGFu1P50HmGceir+kNUUOGl@vger.kernel.org
X-Gm-Message-State: AOJu0YyMnlr6fo0760FtuJNCt7i1OOYwKSwRhEi2YA16Pe7kMrI+fIaM
	s4gAWvwj+vBbzzpDv0v6VOsJJtnL+NIJx2zEHEq2lbglvxeHMqjHfDdDmnFc8ybg+rs0xBOW58V
	kYqPUcTkGZLrrOfXNRugz0HtVrZbJ5HfoTw9ZdHXM
X-Gm-Gg: Acq92OGYtj8I0DD11zSN5q2vjL+pONXVnrymUxq/xU17nwVk7nJ0+1R8WVwvthKjb1W
	KTN1zmWVAANwEMFKH7pm42+OBXlOJVHIDqlkxxGSCDl0R2DRS/Jqbrsd4ux5XqtlKs76q/FRhMr
	fXOLJdt6vfONfhLtyyvhG3G/By8HFq89UEusoOGMyPWdf4IqN+1/LE0f6hxT0Nf5E+Lm+uJ0jws
	f5POMyXcYFa2EJc8EUVDpOrfpomM08VCl8SGN5uJeBF6Mt9GmgPsmm/8khSXddZ4eF6VOmDf5Kb
	ATUopsH8AZKJxiMWAks5jpHU1lEop8t8Y4sKcqcMEMUFbs80
X-Received: by 2002:ac8:7fce:0:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-51797ffe81bmr33892121cf.5.1781018786362; Tue, 09 Jun 2026
 08:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527110147.17815-1-tao.wangtao@honor.com> <70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org>
 <CAGsJ_4zg8+pVDwtsJtxxiC1ahJ9MR56Ue8VXCt_VrQgcXES2uQ@mail.gmail.com>
 <273d02a1af954b8c9f4da7fb74e6b4cb@honor.com> <CAGsJ_4xTMsV8fJVfhshDQp4=Ax2f_+b6yR873cEP11bjcEa_5Q@mail.gmail.com>
 <3031859912bb43a7ab16ec63863914ab@honor.com>
In-Reply-To: <3031859912bb43a7ab16ec63863914ab@honor.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Jun 2026 08:26:14 -0700
X-Gm-Features: AVVi8Cd0phUCN63P78bsofAEIxBfBidiXphGPaa4I2_plf94aKBqa4-HMso_0rc
Message-ID: <CAJuCfpG6-PkWpRqr7m5evzTy9s8LyV3nW3TScOyjqWb+maVBkA@mail.gmail.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma creation
To: wangtao <tao.wangtao@honor.com>
Cc: Barry Song <21cnbao@gmail.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, 
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "willy@infradead.org" <willy@infradead.org>, 
	"sj@kernel.org" <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>, 
	"luizcap@redhat.com" <luizcap@redhat.com>, 
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>, 
	"ljs@kernel.org" <ljs@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"liam@infradead.org" <liam@infradead.org>, "vbabka@kernel.org" <vbabka@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>, 
	"riel@surriel.com" <riel@surriel.com>, "harry@kernel.org" <harry@kernel.org>, 
	"jannh@google.com" <jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"ziy@nvidia.com" <ziy@nvidia.com>, 
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, "npache@redhat.com" <npache@redhat.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"lance.yang@linux.dev" <lance.yang@linux.dev>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"matthew.brost@intel.com" <matthew.brost@intel.com>, 
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, "rakie.kim@sk.com" <rakie.kim@sk.com>, 
	"byungchul@sk.com" <byungchul@sk.com>, "gourry@gourry.net" <gourry@gourry.net>, 
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, "apopple@nvidia.com" <apopple@nvidia.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryncsn@gmail.com" <ryncsn@gmail.com>, "jparsana@google.com" <jparsana@google.com>, 
	"dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>, 
	wangzicheng <wangzicheng@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 12:35=E2=80=AFAM wangtao <tao.wangtao@honor.com> wro=
te:
>
> > [...]
> > > > > I won't echo what has already been said in this thread (and I
> > > > > didn't manage to read all, unfortunately), but for such big and
> > > > > invasive work it's often best to get in touch with the community
> > > > > earlier. Otherwise, you might end up wasting your time.
> > > > >
> > > > > Ok, arguably, someone who writes that code learns a lot on the wa=
y.
> > > > > And if this code really was written by one developer only, I tip
> > > > > my hat! I'd be curious if that code already ran somewhere on some
> > > > > Android
> > > > kernel out there?
> > > >
> > > > I heard from Zicheng that they have been running this for months an=
d
> > > > it seems reasonably stable. Please correct me if I'm wrong, Zicheng
> > > > :-). This really should have been discussed with the community earl=
ier.
> > > >
> > > I initially developed and debugged this based on the Android GKI
> > > branch and did some preliminary testing on an Android phone.
> > >
> > > Since GKI generally only accepts features merged from the upstream
> > > community, and this memory saving could also benefit the community, I
> > > ported the patch to the Linux master branch.
> > >
> > > Because my English is not very good and I rarely participate in the
> > > community, I am not familiar with the community workflow. I did not
> > > send an email for discussion in advance with an RFC tag. I apologize =
again.
> > >
> >
> > No worries. I know someone who has worked on the Linux kernel for many,
> > many years and has excellent kernel expertise, yet has never submitted =
a
> > patch throughout his career for various reasons.
> >
> > I heard from Zicheng that you are HONOR's key MM expert and have been
> > guiding them on memory-management related work. That's really impressiv=
e.
> > Personally, I'd love to see more ideas and contributions from you in th=
e linux-
> > mm community.
> >
> > BTW, regarding my earlier suggestion about using GKI hooks=E2=80=94limi=
ting the
> > optimization to newly created VMAs and to applications that never call
> > fork()=E2=80=94do you have any ideas on what the smallest possible hook=
 change
> > would look like?
> Even if Android does not consider handling for 32-bit, KSM, or
> memory-failure, a large number of hooks are still required.
>
> A different implementation approach is also needed. For example, one
> or a set of anon_vma_locks could be used to mark whether a VMA is
> lazy, so that we can avoid modifying all places that dereference
> anon_vma. Reserved fields in vma could be used to record the root_vma
> and a reference count respectively.
>
> Roughly, hooks would be needed in the following places:
>
> 1. __vmf_anon_prepare: mark lazy_vma in the fault path.
> 2. __folio_set_anon and folio_move_anon_rmap: set mapping to lazy_vma.
> 3. rmap_walk_anon: handle rmap_walk for lazy_vma.
> 4. folio_get_anon_vma and put_anon_vma: add hooks to distinguish
>    lazy_vma handling.
> 5. anon_vma_fork: decide whether to upgrade pvma->anon_vma.
> 6. Add a hook in try_dup_anon_rmap to upgrade folio->mapping.
> 7. anon_vma_clone: handle links when src is a lazy_vma.
> 8. vm_area_alloc / vm_area_dup / vm_area_free: add VMA reference
>    counting.
> 9. mremap: handle upgrades in copy_vma and move_page_tables.
>
> If this can be restricted to apps only and the app never calls fork(),
> then 5 and 6 could also be removed.
>
> If each page's mapping in the page tables is synchronously updated
> when upgrading lazy_vma, then 4 and 5 could be merged into one.
>
> If lazy_vma is restricted to anonymous VMAs where
> vma_mapping_base(vma) =3D 0, then root_vma and the VMA reference count
> could also be removed.
>
> With this restriction, we could directly use folio->mapping to record
> mm, and locate the vma using folio->index, which would simplify this
> patch series.

After looking over the patchset I must agree with other reviewers that
it makes the already complicated rmap code much more complex. Adding
this into GKI as an out-of-tree patchset is an absolute non-starter. I
don't think you can refactor this logic to be contained in a vendor
module and without affecting the ABI, but even if you manage that
somehow, it would be a maintenance nightmare. I would rather spend
time backporting upstream-accepted solution than try to debug
unexpected custom behavior down the road. I believe Lorenzo's solution
will have similar memory savings and I suggest we all help it succeed.

On a separate note, it's very encouraging to see more Android partners
becoming active upstream. For years partners developed optimizations
in isolation without engaging with the community or sharing their
ideas. This is a very positive development which I believe will
benefit both the community and the engaging partners. From my own
experience, learning to collaborate upstream takes time, but once it's
done the experience is very rewarding and oftentimes even the biggest
critics turn into supporters. The key is to listen to the feedback,
ignore harsh words and realize that people here ultimately have the
same goals. So, don't be discouraged by this experience. I think the
biggest mistake here was the lack of prior discussions or RFCs for
such a big and invasive change.
Thanks,
Suren.

> >
> > Thanks
> > Barry
