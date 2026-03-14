Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E64277017
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773454221; cv=pass; b=DzVn0Y3NknUWgFukhnb1JQmpVsFbrkjYs4kJWZsbOyU8RdyqczZlEgj071JLrlXqZgjNlt+3ognnveIU+3+y32m0jA4gNgvtMTRSMVrx2G9KSOxkU7kdFkSmphiKHlCw0qGkyrln15wSDMIILr/PyQJ02H2rx+z9eFdD9Yu60Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773454221; c=relaxed/simple;
	bh=jAvG8sFJEgRcmVgL1rm13amBmKDkjng8TojTj8OQVAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3p2oysW4ThM536+q5kpeCnh7Adl4E1xDcVH/sZyrAv5GkYmfX0q8wkTIGLbM0df/w5XfTaaev7mLOg6wQ7lt9Z7h5P2G9ePtJ84ffAVjPUxXl4PB7Uq0wQXBm80nETRepwX/jNnreq/pGH+B84xjaIoITe/fXfA7OOxHy6/pqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=iC5UUvuI; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="iC5UUvuI"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso3491889d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 19:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773454219; cv=none;
        d=google.com; s=arc-20240605;
        b=b3W6vwpMkSvrJSUSku9fCFK5WhUCkY97/7aEHdMEQdL2KvKrJqOZulFSByErDl8ihd
         hHuXGPdM+XQSNocwfjPghR5XpDJgwzbhCifPpdMdcYfNoI2EFKS6VPTWMQM0ubVXEmos
         67lKP8KcoZ4I2Efc06jiszV3zxJ3Bec0wkk9H1/uFg072XMKCoFsNoexeh05q+PdY9sV
         9dzncemEV6c0xBuccq9GmpZGbPAzWms05dDDnBhNjULOvVs+QIz3hCBA30Gmr4bk9dNa
         4IpXZYN4rXVLFud9+o2/3tRN9nFWBrCvmoMeA88S7bkd1GBvl7/uieJOEWEszWonANmh
         lzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7ejtXFezvM4/MIrV0ExVdbB3cmL15fMSqz8fjmYgx6o=;
        fh=JGUlVe4US9H7uxUswjo6CPEX3icS5ldDzTGIOnJdJDs=;
        b=L44QVFlEKDk487wOzv9ZP6+6Hs4NznEY8VNMEqZc4UBIY5EbFc/tbYUfC4zcfRlU3Y
         0z5+sSvr+G4FCQXkmBzhaWX09TK5hXSpuCmDRqxrF5GP1clgCVo9XrtG+mUOWq81PJWJ
         l7Qsew9aDUTIHO2a30cM1fHZUHd3ET93zjefVjmcwTfImf/el863Z53o7Sjqtdh8yNUX
         0WCDXwQkI656LS9YrjOKoa+9Gh73vDDa5CRSct8bJRaOHfX917IVodEoqOytkkCTkJ51
         +6aX4iCSvw8bnKo+ivQTI8DZxFyej7W/Ka6668dr1iDK//CeeyiU7RCxhQ2OQYAxsSTM
         C0dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773454219; x=1774059019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ejtXFezvM4/MIrV0ExVdbB3cmL15fMSqz8fjmYgx6o=;
        b=iC5UUvuIkLX+bP/QrupGfwX3VN+lE4mi/VW8w2v6wH0a0OcUsh83QPU9Lm5s73Ow5C
         6xTo8y6+4Hw2ElekK5UuiH7EElnQCWcyehtU8ZcuE8H3D537LzIgyVmgAbJjNMPcat/Y
         ufgGd2ULCmI1DLOQ4z/B7hTf8Ysi7meykPEy/9LUZ+fEEofAN4BJJriv7wYH7JaA1yxt
         mvu5dgg1Gni0C489sXp+hz/ujUgRHaxbfijrwuk2iVB44lgkIzTAIGqv0ySW5qFCaXDV
         OvVOEU+amIa6ylo0K2pFpG4O/FldV2+1ByKBfPjCYyeXYfbj2ztAmhukZjEtPlaqGO1Z
         3uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773454219; x=1774059019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ejtXFezvM4/MIrV0ExVdbB3cmL15fMSqz8fjmYgx6o=;
        b=l8skfR3/BqBjO42U0YJPcknK8g0Hey7deiyAiQSyFB8ajC7v21zexJvcJlRZ/Oi0Yd
         XWZ7l0WDHsjqtRTZePOcHlci1EG7Th7BUQMrl0lXVzghcSMB/2OPu+pPTpyDCLNjjYDx
         98fdKvnhrwzRSHI6JKAykpGom5qapeIg4m1pn41/Fu325d9TQzB8mUhL0+168M6yJQL5
         nmJllAB1QUfXZpnMDRh8JjpTba6p0ha/XYbgQQubZ2PeXgbSAqryC9YTXhgj0u7STBzG
         BZJunnhvdcpc++CsWQN2KxrSZFg+l/Edi1MHV2PtkVuSqXNhsZRu/57Xaal4QrJRiwbe
         69KA==
X-Forwarded-Encrypted: i=1; AJvYcCWAalgmXz1kTa5liNBo1aklbNIeEMq8LmNCwrPCcxsx//PJvRQ/vAgREx2BxbqjqQaZebdRzwbLlHAyeuO8@vger.kernel.org
X-Gm-Message-State: AOJu0YzMIK17H7/2OoxiaIYDxgJ9X8vfhYVyDA9kKuzTiAGduQ4KCCdO
	8QM2/j/5lZLZGNUYG8tvOo/T4PWf9Io4/xq2VfWoSHxtJY7zJjDRL+cRbIZsE2k+Q+kIVN/QUbn
	wxz1iySCN2H+4wtidB4E3N8nDMZodmXLSBgmj67KCpw==
X-Gm-Gg: ATEYQzyffHqdm/Ege3m2hVZy+b2NvhrEk3KCX8ITk9Lipdm3Gi7bih29IV2ajm9Ws4Y
	2ei/g3wtw4hyHHewwjsHcV/smJroX7D+6sI9on104FBPsRWJFxRj2MxVbAXaqFsAEZEs/IO7YzF
	eeoJ6DG5d7ABvueve4KATL9wB7TGIlmwFMmp6jeMoDDK2TUTlsuRmOVXWempF1FgAuhU903n+So
	sP+cBg2yYcGVrv0ze1B+Dw1cbAt6Gn8xJxxezFoBY6AenhREXZ3imjZBmsL2O1K3sF4XQjY/Ym5
	m0z/F451PMN3NuZxxpHfFdos2DvSJZ+mtuFizCwp3gss6zJycDXq
X-Received: by 2002:a05:690c:6e08:b0:798:7498:4ae4 with SMTP id
 00721157ae682-79a1c1c3f38mr54139577b3.53.1773454218867; Fri, 13 Mar 2026
 19:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310145406.3073394-4-usama.arif@linux.dev>
 <20260313144213.95686-1-r@hev.cc> <d3f60289-3ea1-43ce-9271-58c8b79bf7a0@linux.dev>
In-Reply-To: <d3f60289-3ea1-43ce-9271-58c8b79bf7a0@linux.dev>
From: hev <r@hev.cc>
Date: Sat, 14 Mar 2026 10:10:08 +0800
X-Gm-Features: AaiRm51ZT-5Id2ShpKb8C4cESB_JJ6PpokKQgHEX0HKVk-NcE-akKpRzUvPAXoE
Message-ID: <CAHirt9g=drGaeNN7C1hbND4=zXQifhQyP4cUaCz27=tYpHYgfQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] elf: align ET_DYN base to exec folio order for
 contpte mapping
To: Usama Arif <usama.arif@linux.dev>
Cc: Liam.Howlett@oracle.com, ajd@linux.ibm.com, akpm@linux-foundation.org, 
	anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com, 
	david@kernel.org, dev.jain@arm.com, hannes@cmpxchg.org, jack@suse.cz, 
	kas@kernel.org, kees@kernel.org, kernel-team@meta.com, kevin.brodsky@arm.com, 
	lance.yang@linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, npache@redhat.com, 
	rmclure@linux.ibm.com, ryan.roberts@arm.com, shakeel.butt@linux.dev, 
	viro@zeniv.linux.org.uk, will@kernel.org, willy@infradead.org, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 3:47=E2=80=AFAM Usama Arif <usama.arif@linux.dev> w=
rote:
>
>
>
> On 13/03/2026 17:42, WANG Rui wrote:
> > Hi Usama,
> >
>
> Hello!
>
> > Glad to see you're pushing on this, I'm also following it. I first noti=
ced this when rustc's perf regressed after a binutils upgrade. I'm trying t=
o make ld.so to aware THP and adjust PT_LOAD alignment to increase the chan=
ces of shared libraries being mapped by THP [1]. As you're probably seen, I=
'm doing something similar in the kernel to improve it for executables [2].
>
> For us it came about because we use 64K page size on ARM, and none of the
> text sections were getting hugified (because PMD size is 512M). I went wi=
th
> exec_folio_order() =3D cont-pte size (2M) for 16K and 64K as we can get b=
oth page
> fault benefit (which might not be that important) and iTLB coverage (due =
to
> cont-pte).
> x86 already faults in at 2M (HPAGE_PMD_ORDER) due to force_thp_readahead =
path in
> do_sync_mmap_readahead() so the memory pressure introduced in ARM won't b=
e worse
> than what already exists in x86.
>
> >
> >> +                    if (exec_folio_order())
> >> +                            alignment =3D max(alignment,
> >> +                                    (unsigned long)PAGE_SIZE << exec_=
folio_order());
> >
> > I=E2=80=99m curious, does it make sense to add some constraints here, l=
ike only increasing p_align when the segment length, virtual address, and f=
ile offset are all huge-aligned, as I did in my patch? This has come up sev=
eral times in the glibc review, where increasing alignment was noted to red=
uce ASLR entropy.
> >
>
> Yes I think this makes sense!
>
> Although maybe we should check all segments with PT_LOAD. So maybe someth=
ing
> like below over this series?
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 2d2b3e9fd474f..a0e83b541a7d8 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1116,10 +1116,30 @@ static int load_elf_binary(struct linux_binprm *b=
prm)
>                          * the hardware cannot coalesce PTEs (e.g. arm64
>                          * contpte) even though the physical memory and
>                          * file offset are correctly aligned.
> +                        *
> +                        * Only increase alignment when at least one
> +                        * PT_LOAD segment is large enough to contain a
> +                        * full folio and has its file offset and virtual
> +                        * address folio-aligned. This avoids reducing
> +                        * ASLR entropy for small binaries that cannot
> +                        * benefit from contpte mapping.
>                          */
> -                       if (exec_folio_order())
> -                               alignment =3D max(alignment,
> -                                       (unsigned long)PAGE_SIZE << exec_=
folio_order());
> +                       if (exec_folio_order()) {
> +                               unsigned long folio_sz =3D PAGE_SIZE << e=
xec_folio_order();
> +
> +                               for (i =3D 0; i < elf_ex->e_phnum; i++) {
> +                                       if (elf_phdata[i].p_type !=3D PT_=
LOAD)
> +                                               continue;
> +                                       if (elf_phdata[i].p_filesz < foli=
o_sz)
> +                                               continue;
> +                                       if (!IS_ALIGNED(elf_phdata[i].p_v=
addr, folio_sz))
> +                                               continue;
> +                                       if (!IS_ALIGNED(elf_phdata[i].p_o=
ffset, folio_sz))
> +                                               continue;
> +                                       alignment =3D max(alignment, foli=
o_sz);
> +                                       break;
> +                               }
> +                       }

I think this logic should live in maximum_alignment(), so we don't
have to walk the segments twice. It might be better to move it into a
separate helper, something like should_align_to_exec_folio()?

>
>                         /**
>                          * DOC: PIE handling
>
> > [1] https://sourceware.org/pipermail/libc-alpha/2026-March/175776.html
> > [2] https://lore.kernel.org/linux-fsdevel/20260313005211.882831-1-r@hev=
.cc
> >
> > Thanks,
> > Rui
>
