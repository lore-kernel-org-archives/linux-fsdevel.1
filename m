Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429A22D0607
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022769; cv=none; b=kWNSd/v5keG6XVtkcNLQJU813Wlx4y9ChscNEG6hnBBnbsYaC2R1kGbjhVmuTpy4/5xdOzdrpzkAl2Ob8xc+wCKopKoyHk4Bn2nY4F8tys0sZZ+8CMj6NMBh+4NbgNw89u5k0HVPPMuq2BwtlTAFNtAMsXTOgeAAHTlyx2vejC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022769; c=relaxed/simple;
	bh=OLsaMT2vBszvOZchto/ovN8mjdTsAVuH0SiS+E1dSq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgS4iBDCc+RtcngKyq+75C+PQlY45MqjMK/f6Z87UaJr82iD65dPS/OgGGWUVFjddghWN6PkG8RZ6AJUV829kkwKzfgbOFFtdHa765HcioTL89Q5KeEMp29wnDm6SmtqbDvVlnm958EXiasSBh6bjoh6tslrvZt8VFF114dcvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=O3ArLKrN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="O3ArLKrN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b04d051664so17366975ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1774022768; x=1774627568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmXHGaQzfs+IJLxwCsEE0bxv5XGFAsVai52fKs2Msxw=;
        b=O3ArLKrNXCX1+Sd9TtuUGvEfIuPP1pVS5yY3Vy+607yUJUaFBKXCgkxMStRMwM5+Iq
         DBjsc+p66sNO/NXoFtYi/25gN9d4PuehaIa097juylzrdx99X5wCp6XfuMPVhJdisTjE
         lyo/grGtF34hFoIsPR4qHd1qEzo7o9knjkxx2dZP4QF9jdAAuDwxzPsD4up9/rpmf5DQ
         aTaTD4BvkkW9PIMno6aGclxCJmAgTZ8VAt5l4B/n4WKK+VWbtLYJ2DGMXhSjVjrjC7Wf
         oJRDxDcdcjos3c1DXOpfSDx6iZvUctqlihc2yVaqHx5PKoy/GPVUMcd582y5f2xh/AS2
         JoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774022768; x=1774627568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MmXHGaQzfs+IJLxwCsEE0bxv5XGFAsVai52fKs2Msxw=;
        b=i3ptY1Lb8XLuArMb5louf7HCyhEG/BEYuGCl0CP0Q/hh6Z2xWJ/1U/RBEy+NMOfYxk
         bCpEZ6Em69/ZwhcPtB81+xZPxmLDK2p1mfBhSgSe2LzIgCQp08T3AvRK5/S8jOox15CJ
         K0HIRbVZwvLomoHWEbkwEuswFMO64Fd5cOvrvcUJOx6G35CdmJ0BjDRH32kZHQH2aVP6
         3l6uqntqtKpKA0wxpH3BFWs5Jxo3G0z+xg7/fLqaY7g3VwuyMu2XjrvEEcjWJ5QQXOzl
         3Y80m/jz/bx7/AynDlznIwF4fXYjtDcLpQeC3sXXVoEvOnHY7afzLb3SDN8/fBqi7Qt8
         BfYA==
X-Forwarded-Encrypted: i=1; AJvYcCUXLP+2PSs9lqClENRo8kVGZ3WJQI68bnJwvClyAdUqSGurMYDwn1OSKcy3BSHzqKTpyn50zhXS9HzU7pTB@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnz+affJwYOU6lffWYt3szDlsZOuUfor8rYb0iy802F2Nwfqn
	bJhQrrD+C8sFKFCBeyPETsINVs+GpYVVU/vJVYE+OZbQPNxIyr28OhSPIkv3w//hyjQ=
X-Gm-Gg: ATEYQzzIXptG7atrUaJhW9Vphqw0rWp0myIA4qIozWL1DIde30v9SZtwIABxOy64Okw
	CT3bM/OoPimrqbZtxdaupgDkaPeBbz2s8fTbL6pHO+vI60MIplUOcMC3iC8E128jcNY+5ddFExS
	Ne3diaElUEffoeoRurQtgZ89RJmkEhuFHF2hKrIS5dijVZWIted6db92C48maMrOTyjltSWChle
	xBIY9z3yMaqHy4+yJYruuBGvKaxo2Bb31cs920Rhu3LVznwMPdVEwtj7e8VoE5KScGXKhi8B9+l
	4i3tG1NUm3q1+QGtUAWnTtv+vBjLX19/LN7trdYhuX8mRS/gHQ1emRip5v+gh8HBjmRzy9qTt5e
	WrgUHOPF9ioCEeTQQv1YNDTqOmE7JFULcIVeS84SUzU9kELUaNtobF6CUNyGKTnBlWmkWmiZXKL
	tj
X-Received: by 2002:a17:903:22d1:b0:2b0:6e8f:8e85 with SMTP id d9443c01a7336-2b0826d73e8mr36730865ad.5.1774022767505;
        Fri, 20 Mar 2026 09:06:07 -0700 (PDT)
Received: from gpc ([2400:8902:e002:ded5:78c1:8178:95c1:6ca3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656b51sm32785625ad.54.2026.03.20.09.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:06:06 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: usama.arif@linux.dev
Cc: Liam.Howlett@oracle.com,
	ajd@linux.ibm.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	david@kernel.org,
	dev.jain@arm.com,
	jack@suse.cz,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.l,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	npache@redhat.com,
	pasha.tatashin@soleen.com,
	r@hev.cc,
	rmclure@linux.ibm.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	vbabka@kernel.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH v2 3/4] elf: align ET_DYN base to max folio size for PTE coalescing
Date: Sat, 21 Mar 2026 00:05:18 +0800
Message-ID: <20260320160519.80962-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320140315.979307-4-usama.arif@linux.dev>
References: <20260320140315.979307-4-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Usama,

On Fri, Mar 20, 2026 at 10:04 PM Usama Arif <usama.arif@linux.dev> wrote:
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 8e89cc5b28200..042af81766fcd 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -49,6 +49,7 @@
>  #include <uapi/linux/rseq.h>
>  #include <asm/param.h>
>  #include <asm/page.h>
> +#include <linux/pagemap.h>
>
>  #ifndef ELF_COMPAT
>  #define ELF_COMPAT 0
> @@ -488,19 +489,51 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
>         return 0;
>  }
>
> -static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
> +static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr,
> +                                      struct file *filp)
>  {
>         unsigned long alignment = 0;
> +       unsigned long max_folio_size = PAGE_SIZE;
>         int i;
>
> +       if (filp && filp->f_mapping)
> +               max_folio_size = mapping_max_folio_size(filp->f_mapping);

From experiments (with 16K base pages), mapping_max_folio_size() appears to
depend on the filesystem. It returns 8M on ext4, while on btrfs it always
falls back to PAGE_SIZE (it seems CONFIG_BTRFS_EXPERIMENTAL=y may change this).
This looks overly conservative and ends up missing practical optimization
opportunities.

> +
>         for (i = 0; i < nr; i++) {
>                 if (cmds[i].p_type == PT_LOAD) {
>                         unsigned long p_align = cmds[i].p_align;
> +                       unsigned long size;
>
>                         /* skip non-power of two alignments as invalid */
>                         if (!is_power_of_2(p_align))
>                                 continue;
>                         alignment = max(alignment, p_align);
> +
> +                       /*
> +                        * Try to align the binary to the largest folio
> +                        * size that the page cache supports, so the
> +                        * hardware can coalesce PTEs (e.g. arm64
> +                        * contpte) or use PMD mappings for large folios.
> +                        *
> +                        * Use the largest power-of-2 that fits within
> +                        * the segment size, capped by what the page
> +                        * cache will allocate. Only align when the
> +                        * segment's virtual address and file offset are
> +                        * already aligned to the folio size, as
> +                        * misalignment would prevent coalescing anyway.
> +                        *
> +                        * The segment size check avoids reducing ASLR
> +                        * entropy for small binaries that cannot
> +                        * benefit.
> +                        */
> +                       if (!cmds[i].p_filesz)
> +                               continue;
> +                       size = rounddown_pow_of_two(cmds[i].p_filesz);
> +                       size = min(size, max_folio_size);
> +                       if (size > PAGE_SIZE &&
> +                           IS_ALIGNED(cmds[i].p_vaddr, size) &&
> +                           IS_ALIGNED(cmds[i].p_offset, size))
> +                               alignment = max(alignment, size);

In my patch [1], by aligning eligible segments to PMD_SIZE, THP can quickly
collapse them into large mappings with minimal warmup. That doesn’t happen
with the current behavior. I think allowing a reasonably sized PMD (say <= 32M)
is worth considering. All we really need here is to ensure virtual address
alignment. The rest can be left to THP under always, which can decide whether
to collapse or not based on memory pressure and other factors.

[1] https://lore.kernel.org/linux-fsdevel/20260313005211.882831-1-r@hev.cc

>                 }
>         }
>
> @@ -1104,7 +1137,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>                         }
>
>                         /* Calculate any requested alignment. */
> -                       alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
> +                       alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum,
> +                                                     bprm->file);
>
>                         /**
>                          * DOC: PIE handling
> --
> 2.52.0
>

Thanks,
Rui
