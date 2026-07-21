Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3AA54652
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651423; cv=pass; b=m6ruAZCAQuKuuTf4d2l3chEZnu09Y38vPcDufoMumMdO6gLlMtEJ45d60vOv+FlBBj9Ydi9VaOl3YdrT5AJVha0Nm7MU5I5dhTbTCShn9FKVGyJ3lVJkaGTKk4RagTzWEYC4QjCvthwFBrZlu8oFAErxJa2nyMS8zKaBp+z9KCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651423; c=relaxed/simple;
	bh=uWmbLZh30F399Y771R27vLwfkAuPIC6zueDl2Fu0NE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhxIyTEol+CeVNtmHH79eXEw940gaAv+1D+w/PSyLoCchRbdYdK9yk3/fr00Ktv8sMgxI5KrpQ9gafWVMXURPldwWP++ZCVXYEIipq8XzotBWvhQokuMi3QOF0FtJmZiaDGiaRuodLga6+yftkLHirKFGdwTr3oZ/GFyV/0RR58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xdh/EjCF; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xdh/EjCF"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so233245e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 09:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784651420; cv=none;
        d=google.com; s=arc-20260327;
        b=C4jogv99QyBODClGfPcQL1gvYO0OtsZD+ucJV9NK/tM58eqY081XPtpSUPmPgpwyp0
         CWgxKvlfF33KAiC0p2x7LnNeOTsERqqoImkXsLHUYyB1Ben2dy2YN0+RKIrV4d4432Lt
         0HPpgEQ4MZsolPdX4yekVoF/g5f92udcOpZWLgtQ2OfrA7T+oTCDChroMRGex37esTHx
         lE7YUSFcu7S2uNcWk3VcS5YsBTZHVI3JU2IKDG3pExgWr9ICNDAR2oYXHeeECAFVSkF+
         SRPGWBa7JbUEjEDqP72lXijesHXbe8WjEM9VQoW6qNJDLARRMvwEusecWxemzvDo0G5i
         N1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K8I7k49xOlGAEsFgikc29wjt1dOh1b3rtxl0U2LM82Y=;
        fh=+izUVIMkyMTgD2pHaC8TTek8fjScjhz2zRZYasrjAl0=;
        b=Mip1tboAwkTJ1AKSenuAGqBDxNYWRiBTjR1rI1wMl+7BGsT87GLvw1Z5ldrll7/2sv
         mEWFNxtOlNmV478VXSwvwA0Eo3fzjJAIhFe6ZO35pX1x1YAD4fE42r5FwKB4USCqA2Vx
         n52j/+fwiYKjmKzZb8Aym3oOGzGv5eaQtaz77KlxKtKBxlGzIx1BUKNCSivIGjKaTUZV
         WrI04Vols+rM3xpnAoX4cvSGulars4uToWJyP2NWoTDvwWGR9CqLzU3pDer6FvEyMPMP
         CqK5HvSY1nnBh7F/dCyHdvAaUTpmsKfOw++XtYShBmFRjajjvNQRP5oWsGJbaM79ASrD
         xxcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784651420; x=1785256220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K8I7k49xOlGAEsFgikc29wjt1dOh1b3rtxl0U2LM82Y=;
        b=Xdh/EjCFbeW4nB1mK8dRgnI8BgzQ3Q6sbcUGFbJkw2zHt0v4U7w72tSxC9Rb3Pjzoh
         RMBz4vmDja2dsIFjsa/DtO32gDg3Anjb+x47ASFVKP/xSDhWP3LgQ4SPSagLnGOpDh59
         P37/mtde5N1lA98dCxuHWycI2etFFy/yBXEnEcKz8R3Hv6RJEhUcKZRKnuqOh2lJ+CUm
         SMb/+aLLtnafgdWcPfBGlBEMVxPiCq9Hlmlg+ycWdxh5Y8D7uWhhUYS2tsyH+ynKg+XB
         bO44GqmzNJ8hNjlw4vcktl3pRkmN5Hlik/0QXzljT9eokz29GPwGbV1aGlbbvxbEi68r
         ZBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651420; x=1785256220;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K8I7k49xOlGAEsFgikc29wjt1dOh1b3rtxl0U2LM82Y=;
        b=blhD68TuNXPx64XirHmfVYxybD1bC8DjERJQDrHolXhFwUKrc1qsLLm64BvtvzzOMw
         z5k9j1o5EoRTmnKybtUf7/kHUh1LGRTxLd5M70++n/xlyA8gcYk0HrPhU8kcxiNFEHQi
         jXDW++3jVqSAwL2zolkYhN7j7/+Luv6TzjBmhSfHrtq4GKmnFmFUh9hC+vwrMgU+IBT8
         jsR+A8JEen4U581J0UQHRdDYDGMtlJB8pww8ZK0ibu6lGqSa8gSU8n3P2p0YB12mVRDn
         NjWTUC9buJWDKoBvg5icVj+rc5pz4B/FsTQTdN9B67x6hCEryo5AygPr+x+2oX9/O/Q6
         enHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjgcTNSvWN1kHrWYOvelveBlRKrxbUoDKeGlalKTvshTmqhn3vpXLPd9E0QsI+m43zZIGW/No2OBqmj2Dc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/pQmdVJPsVWx3oeeknBfCQFNRy5Ld2GII335c6kDvd+mgHHAn
	Os0Wu/oI7lmgT83PQpb1NDByJP45hYPT/Lcbm4WSNVD7hmOhAAhP2cxTwy+zinPlo7buY36/tdv
	XN8qXBHqLZLcKm4HrFs5Wz3tLiOU+pfM6Q9vWKRSe
X-Gm-Gg: AfdE7cnf10i0FE73q8yhYxnJzYf97cXP0kJ0P5v7+DHXNN4xbMF3Horh24gjKuyz/SF
	aIaDn1UZ0/JcO25Qz6qmaPUdkbK605NONoQ5J/vpBbIPmNibq1ahK51pMcpFhCs2klzseE7wE1w
	5an7Cx9u2MNBYMmVf0TS1UDSyMXDhroxekDcDZsGF6jA9NrKB96zktO2yCk0DnpE9j2I97dN07U
	Cx5+altU02/LNhkuRmibfO1LGUgX+VmWRgKh6AbplZI227e7N4mbBWvs+aqp2SNHXLW+Tky+fyk
	9GNo+0vOxIdhfXe2xJbsIp4DzC10QZKSBAFo3DGGPSlTawl6
X-Received: by 2002:a05:600c:300b:b0:495:4747:548b with SMTP id
 5b1f17b1804b1-495642ea594mr1347465e9.0.1784651419676; Tue, 21 Jul 2026
 09:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721051903.691848-1-kaleshsingh@google.com>
In-Reply-To: <20260721051903.691848-1-kaleshsingh@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 21 Jul 2026 09:30:07 -0700
X-Gm-Features: AUfX_mwWPFeWGLweXqPq4OiKKz55TnsI3WKSOz-d3Exi3YhhjXQ1vIBnXVtyYOk
Message-ID: <CABdmKX24EKOaUoQZS-yR21v_yd=h1RVUQgq0wj+On-WcfE5dGw@mail.gmail.com>
Subject: Re: [PATCH] mm: proc/task_mmu: Use walk_page_range_vma() for smaps
To: kaleshsingh@google.com
Cc: surenb@google.com, akpm@linux-foundation.org, kernel-team@android.com, 
	android-mm@google.com, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 10:19=E2=80=AFPM kaleshsingh via kernel-team
<kernel-team@android.com> wrote:
>
> From: Kalesh Singh <kaleshsingh@google.com>
>
> Modify smap_gather_stats() to use walk_page_range_vma() instead of
> walk_page_range() when walking page tables.
>
> walk_page_range() internally calls find_vma(), which asserts that
> mmap_lock is held. This assertion fails when reading /proc/pid/smaps
> under per-VMA locks (where mmap_lock is not held).
>
> walk_page_range_vma() walks a range within a single VMA and does not
> use find_vma(). It relies on the VMA lock instead (when configured
> with PGWALK_VMA_RDLOCK_VERIFY), making it compatible with per-VMA
> locks.
>
> Fixes: ea3085dd7a4e ("fs/proc/task_mmu: read proc/pid/{smaps|numa_maps} u=
nder per-vma lock")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  fs/proc/task_mmu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index d32408f7cd5e..5d301bdd05fc 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1369,9 +1369,12 @@ static void smap_gather_stats(struct proc_maps_pri=
vate *priv,
>                               struct mem_size_stats *mss, unsigned long s=
tart)
>  {
>         const struct mm_walk_ops *ops =3D get_smaps_walk_ops(priv);
> +       unsigned long end =3D vma->vm_end;
> +
> +       start =3D start ?: vma->vm_start;

Doesn't overwriting start here break the !start && (!shmem_swapped ||
... check below when smap_gather_stats is called with start =3D 0 as in
show_smaps_rollup?

>
>         /* Invalid start */
> -       if (start >=3D vma->vm_end)
> +       if (start >=3D end)
>                 return;
>
>         if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> @@ -1401,10 +1404,7 @@ static void smap_gather_stats(struct proc_maps_pri=
vate *priv,
>                 }
>         }
>
> -       if (!start)
> -               walk_page_vma(vma, ops, mss);
> -       else
> -               walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss)=
;
> +       walk_page_range_vma(vma, start, end, ops, mss);
>
>         reacquire_rcu(priv);
>  }
>
> base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
> --
> 2.55.0.229.g6434b31f56-goog
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
