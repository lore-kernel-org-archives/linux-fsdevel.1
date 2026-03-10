Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60403B961B
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 03:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773114014; cv=pass; b=brG6aul5NKAB/eIqtLp97bZjf8x8bCjEb5uI4hyZV/ByxmZy4xmpaPzV3CvVg+ybPdaF906FKq4Qm0NlgZ9bCy8pGu7BhgAdDsyoTZAldfE0uMLyK8Uwafso6DGycvB6KVMe8hSAVFzpCVoPzRNNSsdmfhXFksxZcX87UoGt6uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773114014; c=relaxed/simple;
	bh=nrF7vlGYzrNGs/7YHhPH/NnJVLHS4kdieXhq3F5zpFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+piCNwzs1hjfPd4plkAl1dKxLTVwGG1esriSM6FZsi/7TEfO+fKweiABeEpEebUbAuyrx4b/XMthVCOsKKFex1xdL798DaUWoY4NY/L1JZ7QTAiznjJ84UehF9YePMqzSudfEzwrKvWmP9AvBrTcvdzr5VgAzZZE0cg75Ee920=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDGh/p7r; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDGh/p7r"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c738d327336so3011531a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 20:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773114012; cv=none;
        d=google.com; s=arc-20240605;
        b=AqmcMis2I1/LvnGp3AzlB/ahY92RWLWH7yGmda0y5cmnjJxFIcHQXsGSdOsN6tcOM+
         x1oc5tSo5VmVE91ssgSS3kZMqYjV404yzVABdofiExQSwATZY1PeHqtF1xLxGG1OTgkd
         ANsnEwGjZ08dWogMoZg0wUuqqRUURp7ve4rE1keH/7VQZWtxrntpKpL9TqDfKkL/cn61
         HPj8swp5LsUXwKkYxNQ3DNI/o1oDpjIwcw/ObWcc8ijN/R1+IKJee52vobEHKqf9b4Gt
         xmVg1ZLtHkFwcN6daFYQHWi4Ws5E46SMYRn83HNNzaqxQqsBd5CJq0RurE/+wZ1dkKKS
         ROiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1PR62EF1lAki6+/h7SawFbTNGruJi0XAMWivo94NRLc=;
        fh=srs/jCFTPS24fki7ACYyqirkKMWoiBq/x607RLYAD/Q=;
        b=FKsppPm3WuMKUhIz6emro4IkgFjBzFcVIZC1EuZoDGiAHqqBO75OQ7zVReojDZf8uK
         FSVcGCRuVfZ8NRd214MAfMgKIbtOe2Iv70FgM2taZybiymNR2AT/NtxcQ2ilrwzTr2Q0
         3MafY1EnoJJ3k3KmFlXejDIKa7+ocQq9PzAFI0YdgcyL35FpEdEPidjo+8CaaDakbzp2
         B7Eglt/NBPSwYixv7kqskIj3MMemzvrFEnQTqYJY0kjNF4QCci/1Ixg0zw/fCkqYHM8Q
         Yx2U4A/KxDKnmBPx0MnktPiAsePdihSUuBp7L4dO0lCn7+kKb00yDi9QKOeBEbY0GTKb
         6Gsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773114012; x=1773718812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PR62EF1lAki6+/h7SawFbTNGruJi0XAMWivo94NRLc=;
        b=LDGh/p7r4q4O4SNLhBjYnjbsAWHkfrcHUi/YqyWGyBQCMy8rpaRzIiI8nRaATiFmgz
         WXDg+LaLkXdxnNhVsYRPoomPfBjn9QcTAj0ZW5hBUdzM+ntlWClVGhP+Ai9TI//i4Qds
         uYmAjTuU9IOGx/qaBC3UJ93WjrpKdL464r+HcmOVwaIXypg1fMC/GdVhu2QWEp+EZnCK
         hNm3w6YGZxM8Vy2NmvRUnvtf0HwgJIM9+9Ymn8boWZiQsiUcItdrRpwGMaNdk01Wh3vS
         HcAfLdNtoHGrci7cbcR3NIWZSgpykecmktQp2Frk2R5n4f2C5LosFp2MJQuGjjSFDPL7
         aKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773114012; x=1773718812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PR62EF1lAki6+/h7SawFbTNGruJi0XAMWivo94NRLc=;
        b=FQgNvFBgLFia7xH9XHKbun5Va8n2i7T/oyDbvAeFis3Qn3lFQm/btqbLk0vdHTECh4
         7yW2Cz1y4B8nIZ/Yu4H+QKA58pEkrweweupol5gsEA3AFt6WEmK0rXkdqJw2LjICFQ40
         ah1LuMMIlMGBImRNoVQ0FzuCw1oyW7hPSAqOJbDryJ5uJXtz8mQhNQ1ZWntHklCecwmX
         DfYWETjSV2UMdfQ7owUqbFP5TPUuRWLr8uozkFJOHaXoe8dsCUFIflOCN+7uVaoJy2I1
         gR6i5WVyKI9HSJvgRyGW1XNCDSyiJ15YvrGU1jajHjAE0nAcXJXGwbcQqlqSAo14/RX/
         YJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCXI6QWSGa8eMbJr2hO0CpshrcfphBN2saOI1H9d0nsFz/nZsnOIjk5nzZR1CNSBX1xYgbAwSJjbN4/7cvWG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1FkwoWFD/fg9VPckXd9SbXLOEyzEWcVZT58/YAWR1sgbo7BDn
	gRGAtXG19upF4AUPCwVq+Ri5a27z85wvS+R828BY6VMOo5ucjb2OIDpnEILtgc/ZO2p0Nup3h4t
	T7v6d1+cWFpFyM1lx9tHyhFoEWRUL5eo=
X-Gm-Gg: ATEYQzzHrZY/w9lsQOt+yR3ANVlGGquxE7fmgNxjR7H4ieka8vDWu3GhM2rjwH6zIa+
	6g95lhOQb3r3rAadBdjwL1L6r0AaqDmtKduD1uK+yj74905MKKIdQwulOEjcFQJrA3VRA9mUZ3P
	o4cc1bpVXeZxHn5jEJSRyoTr0l9aSwrqNO944x8/oGG5IpKLLxTRQfLvYX8lqOx8YTYHQEqaPO6
	CoEo04eHoCXRblZkGdzUSvTQ7wECWhOIBxtOA57kGfHXqbx67rnIDqdlShNZ0ZfCm2wRBXdRiDw
	DFHdZAk=
X-Received: by 2002:a05:6a21:9ccb:b0:395:291b:f555 with SMTP id
 adf61e73a8af0-398590ebdaamr11794026637.69.1773114012045; Mon, 09 Mar 2026
 20:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa5NmA25QsFDMhof@hyeyoo> <20260309072219.22653-1-harry.yoo@oracle.com>
In-Reply-To: <20260309072219.22653-1-harry.yoo@oracle.com>
From: Zw Tang <shicenci@gmail.com>
Date: Tue, 10 Mar 2026 11:40:00 +0800
X-Gm-Features: AaiRm51P9s3DC7FjytFC4I2paYZUeQw-qAwJyjCHl-40jBVff_9Gjy4xmE9iqAQ
Message-ID: <CAPHJ_VLzRECge4=L5RRqZyf-Sou8APi=Sc=d0brBAMdj3UC_Cw@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: fix an incorrect check in obj_exts_alloc_size()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, hao.li@linux.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@kernel.org, 
	cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, 
	viro@zeniv.linux.org.uk, surenb@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Harry,

Thanks for the patch.

I tested it on my environment with the original syzkaller reproducer,
and the warning no longer reproduces after applying the patch.

Kernel version tested: v7.0-rc2

Tested-by: Zw Tang shicenci@gmail.com

Best regards,
Zw Tang

Harry Yoo <harry.yoo@oracle.com> =E4=BA=8E2026=E5=B9=B43=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=B8=80 15:22=E5=86=99=E9=81=93=EF=BC=9A
>
> obj_exts_alloc_size() prevents recursive allocation of slabobj_ext
> array from the same cache, to avoid creating slabs that are never freed.
>
> There is one mistake that returns the original size when memory
> allocation profiling is disabled. The assumption was that
> memcg-triggered slabobj_ext allocation is always served from
> KMALLOC_CGROUP type. But this is wrong [1]: when the caller specifies
> both __GFP_RECLAIMABLE and __GFP_ACCOUNT with SLUB_TINY enabled, the
> allocation is served from normal kmalloc. This is because kmalloc_type()
> prioritizes __GFP_RECLAIMABLE over __GFP_ACCOUNT, and SLUB_TINY aliases
> KMALLOC_RECLAIM with KMALLOC_NORMAL.
>
> As a result, the recursion guard is bypassed and the problematic slabs
> can be created. Fix this by removing the mem_alloc_profiling_enabled()
> check entirely. The remaining is_kmalloc_normal() check is still
> sufficient to detect whether the cache is of KMALLOC_NORMAL type and
> avoid bumping the size if it's not.
>
> Without SLUB_TINY, no functional change intended.
> With SLUB_TINY, allocations with __GFP_ACCOUNT|__GFP_RECLAIMABLE
> now allocate a larger array if the sizes equal.
>
> Reported-by: Zw Tang <shicenci@gmail.com>
> Fixes: 280ea9c3154b ("mm/slab: avoid allocating slabobj_ext array from it=
s own slab")
> Closes: https://lore.kernel.org/linux-mm/CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C=
0gFxC6xGOG0ZLHgPmnA@mail.gmail.com [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>
> Zw Tang, could you please confirm that the warning disappears
> on your test environment, with this patch applied?
>
>  mm/slub.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 20cb4f3b636d..6371838d2352 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2119,13 +2119,6 @@ static inline size_t obj_exts_alloc_size(struct km=
em_cache *s,
>         size_t sz =3D sizeof(struct slabobj_ext) * slab->objects;
>         struct kmem_cache *obj_exts_cache;
>
> -       /*
> -        * slabobj_ext array for KMALLOC_CGROUP allocations
> -        * are served from KMALLOC_NORMAL caches.
> -        */
> -       if (!mem_alloc_profiling_enabled())
> -               return sz;
> -
>         if (sz > KMALLOC_MAX_CACHE_SIZE)
>                 return sz;
>
>
> base-commit: 6432f15c818cb30eec7c4ca378ecdebd9796f741
> --
> 2.43.0
>
