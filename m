Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7EC3932E0
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976718; cv=pass; b=iaF3/A7dVRMpmfN826vLETVKd/IdX73sBBa83aVBfDlpaBQ2b6kTnxK5ZmyKxugZ0i8O7tahTz7J7ACxbG+USqzPKqGsdtIcCTlwgVmUptxKicOMuRXe1c8mBJT3lb4QSbZQy2su3s6cyuqqUl7JDtql5sYFEuTGoJyBNtZ9kH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976718; c=relaxed/simple;
	bh=JRXhqW59z21YiMqvUCuekToa2vzhPkgw74fnfba6haM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDYWvB8gMcvJuhuaawSa21uZRztDbHuDcOw+fLoaXjqN9AZP6fCqYbpypQMdKMKI87CT1TWbg3MjC7+HqJYMCoptktU5xv/3IkxhscZAPcRrb2jinLoYAwaxcgwa7gA9iFaISij6+n5/QWLDCg0nipXamNODQLDYD3+NLtWijPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ThkbCVCu; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ThkbCVCu"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so330051cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 10:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788976715; cv=none;
        d=google.com; s=arc-20260327;
        b=GW5+waE+RFQ6Cfz3aOPJN+20R/p3x8xEI3sxbvCLnj3V0MTARKxy76EJjCEP5gE9dw
         0+vweGfsQqhX2BfCnBAIcj0SJEiihB5Xv7vdrmSseZ6uMx8Q2R+VgnCRDFk+wMsPwngU
         iRIlx/PDrzKwcVnEVa5XXogEzbpKzJPcqzH8a4HW3/ClvcbVhWX4g7cLsuNbYRzaGYB+
         Tsa/EMe84ESed2pFU1CLyd/W3suln6eqloSi6pXKYV/VLcpK0Lpuq/3z8oFa7pkaYBg+
         3bsg2uBs6xnfAsTBHk7Sa45Ue3PiEgek09YOS29eb/zMsoZVvdSfwwOq6swBMo93cAQN
         K5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VtyfnipbLRML4sk/n+Uiphvnw4FabEDfuHO2cvdrWcQ=;
        fh=2i56u4v9paUiDdG82i1cAzyimAPsfbrjkLSE5TBYkFA=;
        b=ecOzWXDXcoMcvdpM2nj5TFLvEPt9WWY/rITFzUoMGI6oS4XxQD+x98Awmj9SizXmW4
         TzxDpvOSCZqXi+oFX9+jc7+FacOagjsqEi30mUKr0bNOiEaij7wBEau1aCpuJ3l0bd1p
         SLldXNjkIfsq3iD+Fx9kTgQspjH4Irsy4v8VrtAnwI0hmpP3kVAD0Sy7QVj0iT9+yEvy
         YNe7TZTtuBpm7a9xIDkj6VhHhHbtx75FJyUhQA1dsLhenE7qF8lKRYYS8QE05Krxt330
         ddg0N8y/k/HMJG+OF3lrayXQo8dY3730yI+QWpG+dpXWbBOiPlhgAEHSRn0dKjdz8HPd
         3knw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788976715; x=1789581515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VtyfnipbLRML4sk/n+Uiphvnw4FabEDfuHO2cvdrWcQ=;
        b=ThkbCVCuWFTqWEAFPKaEE+z9jHFEaru/IsdvRYRqILaJ+TT9G3myLaKsd79a+Q/9Ml
         e4NpdWpvg5jR+2mTd9bT5OP0jGrwD13+3WDnvAwlTLQxGlY1rOJcgesAASrCFXjmIr2G
         pPkqLJfnynbwV0OsGjtNcFBFe3kHwauUsjEVLI06/Ic4Z6D6IV1lq4C/KmO4Sv/7ztnw
         KzhBYKFZggtqzO9dmox4dZ8yZC9J1Km9U6cP62HWqjB9808T1WajpD7mYmdwBuVs5JlT
         ADMp8MrHsxvbBTt61a+CBXOApJMI3Xope+djFyxmCmvaTBedRuNN5KhJJQpqtbF9kX9i
         kQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976715; x=1789581515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VtyfnipbLRML4sk/n+Uiphvnw4FabEDfuHO2cvdrWcQ=;
        b=FtAiD18T6tA7i4t0BymFI6QplEIm9Ask475lmXGtTl7OVTgiIYTUmth/DAt48Z62tC
         w4WEdcP6KARDUXzaSveEF+3bxEp2IyQ+5ijxysYRzeo5d2X9fOz/ClTrDGikFE2rwecn
         YwKxuOgn33GE4RGmfCv8O1hAW5tMJYnPcBKXWiPYHIC/MkuPh4IZee/dNJreJAlAph9S
         WFMd15bcwFNWNgsG52TyUbpUWvWO8sRklZpwtyinONGcvwTgtDuECtkW4ZuUlmzhkEXC
         CcMhDtEQH8OvsbV9ogn3Funkxo/VP1yVQazuwN5jSAT/LwdeIPqLeASYRlHCm3EsNTqd
         /xMA==
X-Forwarded-Encrypted: i=1; AKwUvBzqIl+Utzt4XuY5a8GH3xWQEMor1H+JOMrJ0PcFdtWgu1goLig6N9mXFb3fpFp6VR06gOQZr+L0QUsQQsc1@vger.kernel.org
X-Gm-Message-State: AFuF++l7Xc/50rqzy7fEWnlEvbrA3Gzhlvcr4i6gd57E7NEQ2Mxhy9Xx
	m4DRMuar32cs1pShp42ZGiPyRQMs+6c+ajBP2jC6Vxx77BeRBWwlV9OzwK8CkgdHgcTY9aflTZV
	rwmbvRjLFoYfw4E6SEj8OshsoUVrywDhiuZNEqKdL
X-Gm-Gg: AYBFou3keKin2CWD2pc1czJXgz+zjf6fsUwTA+EhiFauAf7yxtS8Q1OryuKR0ptP4aT
	01VBGj1Rsldemk/sb9dGiky4guFlrc452/Qy+K6E3oGtC9E9Q8FytUbKyqGlzriBXbQUT9QBtaR
	wvjYQJnbufWwdXudyG0MVzPp4gOSKm5QktTJleCgQdriGL7SCuL15W+CbymPiHseRyQZsDY2nH0
	X+zPFZOe+2y7F7BWvRtDzP/qFuZM9XbIpISqlQ8LJzH+UaLsLRRCd63KgZFBeX0FlzPyHWUryOX
	lkhtj8pChcVTELbezgaylc4pwXb/VgGEOGtP8c4pmpqbRerL/PTklW9cqg==
X-Received: by 2002:ac8:5902:0:b0:52f:6e06:89ac with SMTP id
 d75a77b69052e-530a5f960b4mr16181111cf.13.1788976714583; Wed, 09 Sep 2026
 10:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com> <20260907063918.3432401-5-surenb@google.com>
 <19e428e5-d8bc-4abb-b052-e23442464cba@kernel.org>
In-Reply-To: <19e428e5-d8bc-4abb-b052-e23442464cba@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Sep 2026 10:58:23 -0700
X-Gm-Features: AcwNN1WVxGfkg-5L9FLh7hjIInMIQxAx4dVdpUE-xaU-wRib3CwQ8jMs5cxEvbE
Message-ID: <CAJuCfpF-xeED3zVL9YyCwrTUxcYXw4s6gVcCYY8p7rx_09mgLg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 10:23=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
>
> > -     vma_start =3D vma->vm_start;
> > -     do {
> > -             smap_gather_stats(priv, vma, &mss, vma->vm_start);
> > -             last_vma_end =3D vma->vm_end;
> > +     if (!IS_ERR(vma) && vma !=3D get_gate_vma(lock_ctx->mm))
> > +             vma_start =3D vma->vm_start;
> > +
> > +     while (vma) {
> > +             if (IS_ERR(vma)) {
> > +                     ret =3D PTR_ERR(vma);
> > +                     goto out_unlock;
> > +             }
> > +
>
> Can we add a comment whey we break (and not e.g., continue) whenw e hit t=
he gate
> VMA?
>
> (I seriously don't kmow ... should I know? :) )

The way m_next() is implemented, the gate VMA always placed at the end
of the address space, so the next VMA will be NULL and we can break
once we see the gate. But now that I'm looking closer into this code,
reading smaps_rollup file does not invoke m_next(), so we should never
encounter a gate VMA (it's not in the maple tree, so for_each_vma()
should never return it). I think I can remove the special handling for
that case.

Thanks for the question, David! It made me realize we can simplify this fur=
ther.

>
> > +             if (vma =3D=3D get_gate_vma(lock_ctx->mm))
> > +                     break;
> >
> >               /*
> > -              * Release mmap_lock temporarily if someone wants to
> > -              * access it for write request.
> > +              * If after retaking the lock, already reported VMA grew =
or
> > +              * merged with the next one, smap_gather_stats() will gat=
her
> > +              * stats for the remaining portion by starting at last_vm=
a_end.
> >                */
> > -             if (mmap_lock_is_contended(mm)) {
> > -                     vma_iter_invalidate(&vmi);
> > -                     unlock_ctx_mm(&priv->lock_ctx);
> > -                     ret =3D lock_ctx_mm(&priv->lock_ctx);
> > -                     if (ret) {
> > -                             release_task_mempolicy(priv);
> > -                             goto out_put_mm;
> > -                     }
> > +             smap_gather_stats(priv, vma, &mss, last_vma_end);
> > +             last_vma_end =3D vma->vm_end;
>
> I skimmed over the remaining bits, hoping the VMA lock experts will revie=
w in
> detail :)

Thanks! I'll wait another day and if there are no more comments, I
will post the next version.

>
> --
> Cheers,
>
> David
>
