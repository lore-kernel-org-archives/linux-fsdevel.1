Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACC9352C2C
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777306992; cv=pass; b=uZ7fao5hraNz0GWMop7X6s1HokRtx6QGoGsXtux9YQ96AXF1dcnEwZZmgJtgkX7+f0aBqswtd589XN3iZG8s0x8Lg54wzuWZnf1tmBU+0gO9Owq7ntOEC5LETu+FiyO+mMce3LKYLUjUaavMqyH0XrHO1ggJAUD0JATvjafEfZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777306992; c=relaxed/simple;
	bh=+HFdjFqMEmhJ1jK6vhXmVTNc0PNxIZOBPQrKTd7NNGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaOWC3sKMLhapnYxN66D9b2L21DKyuoruYN77bQCshIHPXe05hWoZGATAfMLfDBBqZYP/nr4XuwzmGUeizWIeopX9hrPHybE0WeNX1FZ4cUBnPOHULoaRGlAFfhqskjQvyJrsP1Y+PfQaIC/aecnmul3+3ODzdu3TvdIxymv8Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJCPDVbe; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJCPDVbe"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b243198058so456925ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 09:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777306991; cv=none;
        d=google.com; s=arc-20240605;
        b=EZr7cC6awy7vyasSalHpMkHFzQSEegmAmi7mMr4NXF5DRjpVi8tu81RLlPhwI3tjFN
         O/SjYRBE+S1cE0Vwac2usOUvlNBChNrhh1lfmUDl2LcU2dWCOyn4xwsmuWoZEiqrP85q
         ilwgu+08FSeK+/xsnvvD/BQKZxOv0TRnBBskTQuDsDIIQQSFIdCixDfdswVGWj6tjXIB
         2aGVXouigRei2txtEG7KqqXx7H4ckKmu89elbu4jkDJOMUiGQElponVC3tuNia25QwCZ
         0SfW+4gnFcBRxUgRltMsVA9d48HGD+62E3s1x96ShNyKxBNFM7Qw8R8HbSNA6KamqjTE
         W/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=206Fh4X3dDRStaXDm8n9sC400Cq7S/zIhUvs0OOCjSY=;
        fh=0Ah3WK9i0iAFJXgobSlhZq+hzLoVBIKTKoHnMleItbI=;
        b=aRiROCHASRJTu2KnnoHTr7bJVwBUgNrgjs4T5vRhjpiPC9Xj/20MMGWVbWt4L2DmuO
         VZNeWcqPP6MTPGIH/s8oclSIK91d89OLq6mMkAhPdS+bMf6t2HwXzS/s4mkNyvcXqwBo
         7ms8CV+B/3zPs2hNIk6iiFtOQT9QBcJOcEMbAaNIUBekxv3y0gcTU5L56AEbec0ShEY9
         HjKXfq4Xf+LXuwo2Pw3AooJEvrHYDPyZz8w3T0sZIINl6OBmesOLwHxkt2fBHR0qRzl3
         0uMelLRLJ1gXkHWhFo88Z7O8V+kOkqiqQG6Pt4Z25LjxIputwa40zBB0jOpBdcdFINej
         pkFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777306991; x=1777911791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=206Fh4X3dDRStaXDm8n9sC400Cq7S/zIhUvs0OOCjSY=;
        b=lJCPDVbepFSCVqouBBkyQzZBXr360CC/qlmmtGkNwH4+uQKH0YbcZSiapxk+t2IlHB
         lBGohs8XTeIuZKE9BGoDNzz+PPG60OJw+UZ1KB1Umty5qDSMqRG5ya1LcAvMyv8qyje0
         dxhqLdVE2qG9l4X2Z316CdCel5vOp+QQnQmvbMT+VRHePUs4GyI6kmikgmHAIbUkhnSC
         /ccBc2+8fotB+MTD8WY75LrZ97KqBz7Oy5vCwXCJTO5rezcyNtp9B88w21e27pQ7T5Ku
         YMGpC7E/V9Kt9G5WMPYdF/w7sUlk9KgIEG5H2PSajiHyj5CcgIcr1W6lPqWVO0Ti36+S
         j9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777306991; x=1777911791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=206Fh4X3dDRStaXDm8n9sC400Cq7S/zIhUvs0OOCjSY=;
        b=ZM23q/gETP8jqlSu4cJa/ei7ES+KGQal3DzJCQQV8v3w4N6vagvt1FC7UYz56soJWW
         g4Htyt2bCvoU6wUJBWJO48VprOFTR0MnCaMG78aF8YmzDBohBe4SKczNogRO6Tt9niEi
         KbV1UIgH2YyCoIZv1/9vHcHy8y6FVAcPImA99OEcjhEDfbujauZUNOa8c0o6/EvsY4Ow
         CLBYIWYMPWhDnbZ5fF7qhjTmQy0n6hU9ntA/vY3jdUzWkWXsHQx53n8uyeOsfPlT+mHd
         9D4yaoo29X2eB0S+h/c8GtJ449hyH9dIMr+uZ15+EWhKodVENslMwIkptqkgnCxFDZ/k
         atbg==
X-Forwarded-Encrypted: i=1; AFNElJ9227KfFL5d7lfgPXo5UVAPHb3z/g3iliYa3MqvkVM+LdipOOjY3p7XanEgGwkkBnvX0Mr/oifG59PgyvHv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3yxH21WnJvetzHDjAU5d9+uSX0zbYo/b6Sj1PZ3rY4U6QKsL6
	RVGjNfEU4NzrE1739p43uqFqAgWdWG2DhHMB9G+gKqhMZA8tHgyCLqmGzYH6mGhShNgBBPFqGvl
	oF9uavDQJgtZnQw7ZRYQb/mbzNckdXhNOr4XaJsIy
X-Gm-Gg: AeBDiesfvTvgB1WMdvmquWmSXdZJPjDXoaEMxBwg0+29mFRkBQ2eeqoU77GiR8Q3EiD
	NE0syhSGblBkak+Z1dnABYnd5fyfix80gtodI/kH1lM/VrWQqvpncbNk24O3ckDg4C2aGlumA+z
	eMijmWZg2moTnDxgTNJuXM9SyUN2pNmR8/JiCyp5M5YoNVOdznesbPZUA47SB1W/zxerykRFD1x
	13REw2LR6oAxbMemkxhgePHsdOt/hOnrQQodiSxxmYyop7gN1wtpCmg9Z5BkG6KkIVqhgva1IMX
	WdvP4YmlXfDlob/elccgIJ/FQPwNGcLbjatIP7Pbv8YmZGEs9fiIJRW8Zg==
X-Received: by 2002:a17:903:c05:b0:2b4:6529:7bae with SMTP id
 d9443c01a7336-2b97a4e7ca7mr51125ad.17.1777306989849; Mon, 27 Apr 2026
 09:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427030148.653228-1-fmayle@google.com> <c7f94ce6-1dfb-420a-b073-d86abeff1f76@kernel.org>
In-Reply-To: <c7f94ce6-1dfb-420a-b073-d86abeff1f76@kernel.org>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 27 Apr 2026 09:22:57 -0700
X-Gm-Features: AVHnY4I1vyG5MhQpN8fAKqxOe-avfjBnum1jR3fQl3SDDHUoZnLZAP_N2GaXCNE
Message-ID: <CAC_TJvcM11got-LcMo24OTN8uXa01oVvUX6HmVvrWMJWVSgEzQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: limit filemap_fault readahead to VMA boundaries
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Frederick Mayle <fmayle@google.com>, Jan Kara <jack@suse.cz>, Lorenzo Stoakes <ljs@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>, android-mm@google.com, 
	kernel-team@android.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 5:41=E2=80=AFAM 'David Hildenbrand (Arm)' via
android-mm <android-mm@google.com> wrote:
>
> On 4/27/26 05:01, Frederick Mayle wrote:
> > When a file mapping covers a strict subset of a file, an access to the
> > mapping can trigger readahead of file pages outside the mapped region.
> > Readahead is meant to prefetch pages likely to be accessed soon, but
> > these pages aren't accessible via the same means, so it fair to say we
> > don't have a good indicator they'll be accessed soon. Take an ELF file
> > for example: An access to the end of a program's read-only segment isn'=
t
> > a sign that nearby file contents will be accessed next (they are likely
> > to be mapped discontiguously, or not at all). The pressure from loading
> > these pages into the cache can evict more useful pages.
> >
> > To improve the behavior, make three changes:
> >
> > * Introduce a new readahead_control field, max_index, as a hard limit o=
n
> >   the readahead. The existing file_ra_state->size can't be used as a
> >   limit, it is more of a hint and can be increased by various
> >   heuristics.
> > * Set readahead_control->max_index to the end of the VMA in all of the
> >   readahead paths that can be triggered from a fault on a file mapping
> >   (both "sync" and "async" readahead).
> > * Limit the read-around range start to the VMA's start.
> >
> > Note that these changes only affect readahead triggered in the context
> > of a fault, they do not affect readahead triggered by read syscalls. If
> > a user mixes the two types of accesses, the behavior is expected to be
> > the following: if a fault causes readahead and places a PG_readahead
> > marker and then a read(2) syscall hits the PG_readahead marker, the
> > resulting async readahead *will not* be limited to the VMA end.
> > Conversely, if a read(2) syscall places a PG_readahead marker and then =
a
> > fault hits the marker, the async readahead *will* be limited to the VMA
> > end.
> >
> > There is an edge case that the above motivation glosses over: A single
> > file mapping might be backed by multiple VMAs. For example, a whole fil=
e
> > could be mapped RW, then part of the mapping made RO using mprotect.
> > This patch would hurt performance of a sequential faulted read of such =
a
> > mapping, the degree depending on how fragmented the VMAs are. A usage
> > pattern like that is likely rare and already suffering from sub-optimal
> > performance because, e.g., the fragmented VMAs limit the fault-around,
> > so each VMA boundary in a sequential faulted read would cause a minor
> > fault. Still, this patch would make it worse. See a previous discussion
> > of this topic at [1].
>
> I agree that workloads that do a lot of mprotect() magic likely do not de=
pend on
> readahead optimizations.
>
> But I'm sure we'll learn quickly if that is not the case :)

Hi David,

There is already this limit for the exec VMAs, so perhaps these use
cases are in fact rare enough; but we'll need to see ...

https://lore.kernel.org/all/20250609092729.274960-6-ryan.roberts@arm.com/

Frederick, could we also now remove that logic (EXEC mappings)? Maybe
in a follow up patch.

For this patch: Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

Thanks,
Kalesh

>
> --
> Cheers,
>
> David
>
> --
> You received this message because you are subscribed to the Google Groups=
 "android-mm" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to android-mm+unsubscribe@google.com.
> To view this discussion visit https://groups.google.com/a/google.com/d/ms=
gid/android-mm/c7f94ce6-1dfb-420a-b073-d86abeff1f76%40kernel.org.
