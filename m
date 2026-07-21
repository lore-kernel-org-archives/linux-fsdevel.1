Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A873388890
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662768; cv=pass; b=MAc6JKKzc7aap6fw4qoSWNHSGZZVRmgoXmq01/NCg8Hm0GDp/BvjRAGheRo0iOpvT4a85FTYhqpAm+SnysTKJZQOyq3g+Xz+Djn5LieRbJqj4BBw1UqOBeuWWlg71C2F9CLnRjywcVHGVhxi7fquWNoY80SaEiVjL0au4LFohdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662768; c=relaxed/simple;
	bh=eLpB+1ra0XpPPhFSDBvcupwbpf9ADwhhQQSg2GKItwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRcWQx040WfnhFUeLrW6i5rPjvKUomLKmqaHwbgbUUUh3jkMD2PaLG2rUWMCWmUmTU5yUQ9gzTET7Mj9hLUOJGJYDx66bDy3atGSlPnlE8bTa12LL3YE9SRJD8rDYAPonXpXWe2u0nrQ9CVScu7vGe/0VzVbNOsqgaYwgYmQApk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FOcjIr8L; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOcjIr8L"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cede6375caso495605ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 12:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784662767; cv=none;
        d=google.com; s=arc-20260327;
        b=OsSB4IAxs3HjfQExBhBN/6kAQ5orKDsHQ+dXmeOl6Im/eTjbb43usu2/4sCajU1IaG
         TK90tIdGSt5vCC2A5xW+p4mmCLEPN8PbcChu3rj9ZRw0WKs3h1gAYBqvedCFRcxMG9N3
         1tPp0OaQCGqQ7tb5aS7z05zNHEw2xUMFzLosZSnVaxxDlBk9T2OEIeno8zN46FGzb3Y8
         wkoV7ncQG7AohhIxESH+0+selbKIf8aFJKtv+4Wh18zATege9XKEF3iOCNyGt+zxOXZV
         b1UmO0vgmZbjdwZbSGqQm1Wn526iYxzBXf5qInyMIIaTgOPyt9RDn6aHpyjkUi2zHcS6
         qieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yCbW+hyT0YYJ59cHhMMtVWtYX3c54CsBcbRYDK3kPr0=;
        fh=SCbCUns14ag291lwcHYg246KLfSgSHS2KtIf8kOdw0M=;
        b=op0VC6q4qfmC2twCIHKgD5ETfQXyEIc2AJe8RKnduBSxF/Aox1oBAM8Q0sP0jZXoN+
         ii437Bq5g1kIhfGPtNdwTKtaP2ISIyj6O8AXGgXV6Fl1p1xtTTySk5wgjjZZ1yF2s57F
         MC1VuW3gn60gtS3RGFoSbD35GZ/GrSPNOkJ12NeOSxWYWwwi47aupf2bGLW2ofWeUwXz
         fWsrrmeTbx31+Vz6blCyhXn2nkuMzGf8urtyAqWp+mXDVtWK0fKIlhsiK9L2YUV7O+mt
         vqFbJF+dF9AVPN17zsgMKQHmMB5alVt+qxJHE1SiYeIDpxO1QY0dA1liPMrDDEOEEzaD
         Sy5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784662767; x=1785267567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yCbW+hyT0YYJ59cHhMMtVWtYX3c54CsBcbRYDK3kPr0=;
        b=FOcjIr8Lfsa9n4O1ZjJJ0HAsE4h1dhtnQfneq1GhPdqy5B2ISbqOkD+nEyV4i3OiC/
         oaixEFktZkWuevgdtTHfq9S8QFMzZZCf/yyCpBekRZmD6rGMNpH9AI129vRzorHb+HCL
         /xCuKUBh2kgVbmgNFwrj+G8yXlmI19YN+llMwb2ysgsHZiH6JTMmZn/u7DyCcgnSM05X
         hLKCwXLpQUHFIhwPXEWCuHfH9/4PCmbsKBt0WTKz0QSgX3yvYS7HjgihYnK+HLYvTLKk
         QvY+Y3dfwOSCFRl8cvRuQiOzW2yzMRMxBfyxs2q+8kygFoCEYYICnglMDKYBTlQkgSBX
         cOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662767; x=1785267567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCbW+hyT0YYJ59cHhMMtVWtYX3c54CsBcbRYDK3kPr0=;
        b=XSofZQpaQyp000gdnpqCDfZ3HcqhDXUzj4sH2kRKLvcPLX+x7RxlFiKOqA1TIOB9+L
         hxHG+VGSwRdQkfQEKL5Bhesy0CI79BLF6H2w+ESTnesH4CPgS9urng47C2LU5+OUmqfg
         A3JJc53SdM/qMkW8N4IRRbcemISs+J0QaY4jbw1K6EN0shrBmpiv3EYovAYResGdFKhv
         lVELZZYBaKDUfS9HuHO6YD+bnRYEyRKnFUDlvGkzDBnTVTvkK4vqSmqea6MwnfEHoY2U
         3j06M5UJtYJ4oSKiE8FKO8r+VOaJaV3fVImwazKxkKsm0RdyKvWjGex1D50i4IfdkNKV
         Dk0w==
X-Forwarded-Encrypted: i=1; AHgh+RrKAqyNxPBfSp3iZWkFrbjHxOze9eHXor19g/trL1mJGJEEQ3MfLrsfBR1FafwpHvPijhGFdizsG8B7yJzq@vger.kernel.org
X-Gm-Message-State: AOJu0YwOrFPTQO09dvDQkpUL16kdzRmltEs+xtw6/3KHRXo7l/7BGcY0
	O0N5TKdIk4RV/R3IC1789ayBZF+h5KrI+SO+rWBQr1wWzAAJESMsMFenpJH/1JTCjZnz+TGgE2o
	vzuiCb9h4zoK4WFh3RLAsc+rg1JqXzuc/xLuTn2Ay
X-Gm-Gg: AR+sD11J4DcyoQ1M6PQF7rpMPr3aM2AbUSO7XiPXgSAC+G7015U8CRJI5H6QV6rpJS0
	nihTGmcqFfyhstYbQb2O3EEOFDeGjDbTg5/CLLEA+HKrFRPoYtb0W1pCJchHNno0pvsIr9ESZRH
	4MKKnzUr+VV8+NXSIbRx9hxqVpRsUuq0aPfBORoHyzMf6BLNKVxwSjR3w24kuBoYfyau0/vASbW
	yBhZwJzpFLyVXxBJIbWSP3DRJA/ZuAZJqA5BQ4TAAtzbL99+j3YQIJlv89YKKDCrG5aDSCQBwY=
X-Received: by 2002:a17:902:e353:b0:2c6:a078:bfb7 with SMTP id
 d9443c01a7336-2cf8f6acce5mr513685ad.7.1784662766027; Tue, 21 Jul 2026
 12:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721051903.691848-1-kaleshsingh@google.com> <CABdmKX24EKOaUoQZS-yR21v_yd=h1RVUQgq0wj+On-WcfE5dGw@mail.gmail.com>
In-Reply-To: <CABdmKX24EKOaUoQZS-yR21v_yd=h1RVUQgq0wj+On-WcfE5dGw@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 22 Jul 2026 04:39:12 +0900
X-Gm-Features: AUfX_mxY0poHAk-PpFaYBY8tiHZF8SXBr75d24KNRlY6OEQf1s0rkwVXmy8WYNc
Message-ID: <CAC_TJvdmxhCJ3h=JaJw2gT-oQRHVQP0gLN414DUsH5OZzm4qGw@mail.gmail.com>
Subject: Re: [PATCH] mm: proc/task_mmu: Use walk_page_range_vma() for smaps
To: "T.J. Mercier" <tjmercier@google.com>
Cc: surenb@google.com, akpm@linux-foundation.org, kernel-team@android.com, 
	android-mm@google.com, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:30=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Mon, Jul 20, 2026 at 10:19=E2=80=AFPM kaleshsingh via kernel-team
> <kernel-team@android.com> wrote:
> >
> > From: Kalesh Singh <kaleshsingh@google.com>
> >
> > Modify smap_gather_stats() to use walk_page_range_vma() instead of
> > walk_page_range() when walking page tables.
> >
> > walk_page_range() internally calls find_vma(), which asserts that
> > mmap_lock is held. This assertion fails when reading /proc/pid/smaps
> > under per-VMA locks (where mmap_lock is not held).
> >
> > walk_page_range_vma() walks a range within a single VMA and does not
> > use find_vma(). It relies on the VMA lock instead (when configured
> > with PGWALK_VMA_RDLOCK_VERIFY), making it compatible with per-VMA
> > locks.
> >
> > Fixes: ea3085dd7a4e ("fs/proc/task_mmu: read proc/pid/{smaps|numa_maps}=
 under per-vma lock")
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Liam R. Howlett <liam@infradead.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  fs/proc/task_mmu.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index d32408f7cd5e..5d301bdd05fc 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1369,9 +1369,12 @@ static void smap_gather_stats(struct proc_maps_p=
rivate *priv,
> >                               struct mem_size_stats *mss, unsigned long=
 start)
> >  {
> >         const struct mm_walk_ops *ops =3D get_smaps_walk_ops(priv);
> > +       unsigned long end =3D vma->vm_end;
> > +
> > +       start =3D start ?: vma->vm_start;
>
> Doesn't overwriting start here break the !start && (!shmem_swapped ||
> ... check below when smap_gather_stats is called with start =3D 0 as in
> show_smaps_rollup?

Hi Tj,

You are right, I should have updated it to start =3D=3D vm_start. I will
fix this in v2.

Thanks,
Kalesh


>
> >
> >         /* Invalid start */
> > -       if (start >=3D vma->vm_end)
> > +       if (start >=3D end)
> >                 return;
> >
> >         if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> > @@ -1401,10 +1404,7 @@ static void smap_gather_stats(struct proc_maps_p=
rivate *priv,
> >                 }
> >         }
> >
> > -       if (!start)
> > -               walk_page_vma(vma, ops, mss);
> > -       else
> > -               walk_page_range(vma->vm_mm, start, vma->vm_end, ops, ms=
s);
> > +       walk_page_range_vma(vma, start, end, ops, mss);
> >
> >         reacquire_rcu(priv);
> >  }
> >
> > base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
> > --
> > 2.55.0.229.g6434b31f56-goog
> >
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
