Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72523D34A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849745; cv=pass; b=PgdSgs+eS4hGk8acYvHL4VES3odFzoJw8F5kZBwLjz+oMJC/GXlVc+GFAud4Pt1y8FvXezE1JrBMf/g1VEt3/Ww6Is+8fKTobixuEXr2ifUje25aIyoEUVZZudaPKlWwuD0SB1HkMv4SFgSboU7feHK+TQWrmf4Rgpsg19LJdxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849745; c=relaxed/simple;
	bh=Sn9jbrHlytwm6vm7UMn5Ci63+904PwFRZxmCisoVDck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlBj8EANnsnIhIEu5nCzv7Rl71vrWamnkJzgyUHKyj5ZbyjXzp8cADh0V0712xpRaGmzvuvcPeSRLSjgZLC7qenRS4kcfzUu5zabPFhkRxZOUpdySYn4k7XzivvcLznGGqMWLGr8dayDTb+k5AV0A44ukkb7HkYvCodK2uFOmnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wm0jPzpe; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wm0jPzpe"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-509069a7a7fso645211cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 09:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773849738; cv=none;
        d=google.com; s=arc-20240605;
        b=gNb5WkY5Qp9yVWa/pwn+5SiDl4KQwY2FPm0NiXcdUBiizwwyvfZHKWmElzeSNDtbw1
         nKdjZBYow6JccSG1BkupOOoyNAUPZX9tLtZORJOX/0EKMFUtvY9RFF5yZU6PFRRZFQNb
         G4Fwj591CqwES0vGGauO4YIxJvTYOgkao3Tsh7FSRXC7Hp5Q4dIuAdfthYxf8zdNMce0
         BTsqMgGP+IbhQhMLUDWquw5fJLG15SzNKboRi1Y7gMkyJydk7K+8HGTPrMl02DlSaX3K
         XYjtwsQmcLZlQvtCh4SLJhp1n9KozHdrrs7KoQdT29pXfup4StrHgmZiaafO1+kvcFRc
         dVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bBf0X4ZI8hrueKElVjOm/fdCiPNUuzJRpv2jzIUCVLI=;
        fh=J/bAKh4j62rFZxPmwBQxDY2VHWu/GwKurw21BOnL9CA=;
        b=Ug8xC6ybO+eTYV+f4X5do49mTOhC6xxeaoSoQey+5j1N0F9q128l1xuzExbSBlavfI
         Lz6cQZgjOC3KXTjeKc4KpV2/U0iSqFAffS2NgJkTMc6led07c+84kLGIKDcKJ1J4QrDy
         SXcsyG8Lw8yRYGgrcT+FuxFXY5ThbEmeLYzwROCdXSynIn68+8920rZvyAspPQ/q47dv
         iXZhxCDdTtXF/3dcpkVB4S+rSDtShQvu4r8y+49ivZhXLIDEt4a/Gpiz5qadCyndCAps
         kgQstplSe32uaYQt12yvKODYNDMa1ZifcG2KnWQ+VEMbdqTl7LExa7fQc7kobp0AIFei
         Fomw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773849738; x=1774454538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBf0X4ZI8hrueKElVjOm/fdCiPNUuzJRpv2jzIUCVLI=;
        b=Wm0jPzpeHp5dNdtnLhc5H1xUtQtEyN6dAuXQxuM0/SN+dHfWxkgkDLEv16Sd+NSk4R
         W3zwVULhxvCobeOJ60+FPx2K3eBstNvsz1o15jYru4GL4ux6NqrdChHlBZ9x8AUqIq29
         mSh4V0HHJ1KEDYe3hbSIWJt/zucGLqTxfR/1Gy6C4SU1SnJYyWvn9m69CcuCepH7L6C6
         n0wL88/pgPhUZ1Xwjk6REDhoOePUSYUBm/1TlDa4divFXSqbTArdZq/crK4tSKTSMu00
         OMs4vzIJDqWDaaZZ7G+XPePGtrej7nUQn43nj8Vez1JteO0v0mZPWyOk90/G2Tpzi1+W
         Y63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773849738; x=1774454538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBf0X4ZI8hrueKElVjOm/fdCiPNUuzJRpv2jzIUCVLI=;
        b=D2NDmXHjDYAjL5wwxKVBv54bpNUFVpeTWcFUqf6M7ykmVCjwqGZ/T/CjHJxD8RmW7G
         vM2kEsYJAd+ywoH7eThRU4ScOzBFRAeO5rEfzskF1OCF6Jkoy4p+gI37cZqGZOc/+HVF
         vRqspQbU9CyAfFhJ+HLsQJvxjK8IeP+MrsFCBSkT2ZVqFxIeoAooeu0deQUuQrAHsLxo
         94kCURT8Vd1WKQvnVfsQDT9QuW69JXHJwWSid9vPzOd2P3DNp96W4ViG5OmHgPY/TyzB
         CvEJL855ZcnsMBEP8OcxZp7v4VzVF3JX4rKLgJG5KOTotocIdWcR7GEJ7BNNHPyUR8iz
         n7bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxizpAERF4gkFmPNJ/gb73IPyVpVPZuUIQWw8vndEOBFSExwKMSlR0FRdmSt/h0mE8dz68urF9DcnqIyLd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+PFYshOT+iTnDaza1XJ+KVubgaCpFexwHnIKp/j73eq+G2okV
	r/FvCoJ1ms2ef7XXeErYwX7QaP4QdfMo1zQQOCMVlSjunF9/qy3+rrejaSYMC7DvIF5NEs4SD/W
	esbpoPvcsI8SnG8nIXJEuk/tEkRXQJNNEG9EzkjK/
X-Gm-Gg: ATEYQzwuGK1UIiv/KZBL8JX7nPWn5DWZf2+mOaSstl4HTDHKIAtAyFpIjqGXMkH47Za
	mR4bKZG0Wafee4aKa5uYSTEERXfENWSe+n9SfocSnK3S2bbSkJWGO9rfUtW4WjGPe6P/UHlt/zO
	GCoo5XpSRIn6qBKSU5pKxfAyOZkmCsZhsEkpzdQlaOtDGoflqSx6BNxAts1CpAM8I+zbyfLcGpx
	VFQWZ4aqmj3a3PgIKALpTrrC+FvvaDuN4rrByc/gxOZ3CaBJKQAsVZ2TQBm5rKOTuv/h9vJcNQX
	eOW/ntcasadm9e+IN45l3vm2DMzQSC0kPSNxYPhYdisF9C1l
X-Received: by 2002:ac8:5d4e:0:b0:4ff:c0e7:be9c with SMTP id
 d75a77b69052e-50b1462cacfmr16816931cf.0.1773849737454; Wed, 18 Mar 2026
 09:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773695307.git.ljs@kernel.org> <4e152e7b8e1a93baf0777628eef9409d031cf8f6.1773695307.git.ljs@kernel.org>
In-Reply-To: <4e152e7b8e1a93baf0777628eef9409d031cf8f6.1773695307.git.ljs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 18 Mar 2026 09:02:04 -0700
X-Gm-Features: AaiRm52kf0p9Fxu6EolM9nhc_2BIDOLEzyHhrKwtGPKlzkXo42y6XvhNDeOCJ6g
Message-ID: <CAJuCfpFd-d-E24d5-G6=dSYDpyHkwS=aXzGd6+SzyMkgssyPAw@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] mm: on remap assert that input range within the
 proposed VMA
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Bodo Stroesser <bostroesser@gmail.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
	linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 2:14=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> Now we have range_in_vma_desc(), update remap_pfn_range_prepare() to chec=
k
> whether the input range in contained within the specified VMA, so we can

s/in contained/is contained

> fail at prepare time if an invalid range is specified.
>
> This covers the I/O remap mmap actions also which ultimately call into th=
is
> function, and other mmap action types either already span the full VMA or
> check this already.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/memory.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 849d5d9eeb83..de0dd17759e2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3142,6 +3142,9 @@ int remap_pfn_range_prepare(struct vm_area_desc *de=
sc)
>         const bool is_cow =3D vma_desc_is_cow_mapping(desc);
>         int err;
>
> +       if (!range_in_vma_desc(desc, start, end))
> +               return -EFAULT;
> +
>         err =3D get_remap_pgoff(is_cow, start, end, desc->start, desc->en=
d, pfn,
>                               &desc->pgoff);
>         if (err)
> --
> 2.53.0
>
