Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EB9379960
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703399; cv=pass; b=o0T9zUeihDnRTYpjeK8BUu3DBjut7COEtDbzy4K/2+r83pjmKR8MIYWaHNlszHpUr4M8oL4jyeimXHGV41cV7hqqsRaDmGKa3XETcFqB82YVbQ9CxUHg/ExS31Cv6bKeUp6hdb8JB+7Sb5neOTzFzBazV6Z6zaJOADvwK7OYdyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703399; c=relaxed/simple;
	bh=XTOZYOCHUctLkYMS5qNPCkNocPEUYtAP2iODWNe7Wt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqF4nrN7hdZor9LzBOuBFeq0+0VuScw5ZrNZ3x+wKWnVw+olu3yeAqFmTUVMq3P/hvYpvJyhSUCcGdlGUD441XdFWCi6E+O/lX4Fd2tUIw8LgOS4ddaFYxNLIJufmb74ZvdF/sFbrNPsQeeOdqWDX5zi1QqU57cg0EnPzkU4970=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eZ2/MpmH; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eZ2/MpmH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b062069f80so5536995ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 16:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773703396; cv=none;
        d=google.com; s=arc-20240605;
        b=iQxxsi+g38lasBP0RprK7Dw22jCGPSaeIwx3f259jLLWs76Z85yBu1hZYjKO/a8UaB
         3mmXL2vlP7qkYtozRnpB0td6jTO+EoVKPL2HNGVPEqgV88GM6fXesanTQA+QpTWMug/T
         hcoSjCq150p1oDvsGL+RXND6XuyHRJYYVIjMM/aGdAubdUPK5n+i9MoHiALKFGIuAYkW
         crwK0L5KjCRkwCMuiKNqJmyjcjjcmocsOVkRCXJk9C9x6oQ762jyvKw2jMhc34Z0uNUV
         Nsp8dz8rcMZbQuLqv2YqmZqVp9wOABkiaE5zIng3e1oyc+raq+hL0Jk8pqClklQY337m
         5psQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
        fh=lyLT1xrC+YA9dIwevotqZyaFIq6nXtszU/J+/pj+b3A=;
        b=R00EuMr8aC8KEJMSUaKgM9Q0SN6Ojkm8KTw9wGJI1j4vRl9P50Vh9HuGxcfSyhIyiH
         B5bcbyyd5Ce9F1ZDP2vVXQiFCfZFFWJuGy9dJPf+Mhb+W33HFtwzvPBvHAzpU8xEotIE
         ResfkdU06jU/U5ryvJK9W2pFONyE8VLn50B173I+mR9HvO1NeJtU12aaqpoS/VF99d10
         wOEdbqhg59yGsaxmGk7Ipx+PjajXDj/XSDZn4QutlgST0hnUK478I4OHqHuh0SBi1ygu
         9+cIGWjoJ6p81ZAOJagl635wkPKsOywQOqbyospRMwu1NYJIzUgna+RbAwcdp8WKx6QB
         4veQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773703396; x=1774308196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
        b=eZ2/MpmHOTbFFzLcyxFQukFAMHAT6YzxNyylE8gye2eZalHZH61rGfghB43hOFP5Xv
         i8LhnDq4eVj23kn8GYeN6ZuTHEnAtMqLvYP09F5fURs+lpwlM3ncS4FXsfjjksGdZXZV
         9yjImmUjtDqg7ttiY4suwVHEZ7MAy1KjYM+0rSeHBMpOY3NWRyv7xLZdiy2DaYBIu66y
         s01hTO2v+R0ZTDj9a4iTTP6Bb3UMZ40Y9cer+/SzSmu6By5v2qA9I/rfZuhJQM6P5IN7
         sDRDxWgE2TUkrdSS43j55tIFZuKCmHxFtrHB3fL8Z7Gg1rjgs/kYO9IDpoPQRvu7wc6e
         sW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773703396; x=1774308196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
        b=e02xrcLQhmu6tKrUaS1rU3jYk93fiSg1eKf8p5XSanloewclHIggyd5F2Pc8DsLP4E
         uV9EUAOWPSdgTWdX27k8uygixLTuI8iZU10ZZD0bQz1ga35Tzqm7B64u4m4ySP4Xu3tw
         Zk9BLmIV3OdtOh57f6B5mU7xZcaOIOIKXAu/uSAWzL5XBXtB0YBceXA7+CySRnitEveZ
         Wf+OxAz9SMXeMruy0TGFUAjTTKFtG8gulQDG2K7qcfZ+q3SZYUHFGiKzVS5WZOeeCJDf
         ZWjnFlBTXlGhYTJ2QjlfuMB4NNAYSLhb3CS/KsrfKNa4XlcGORWSPSjjYnNmTzzR+bS1
         SlXA==
X-Forwarded-Encrypted: i=1; AJvYcCUTLCaphyhCsZYtCl+lGOybOauy9aUoqDFZBZ//WroEU1KKZhI/cAjqrQVTsyDxMbkf3GOQIb0Xam8WoOh6@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmrZ2H8M4TbLSnTgANOHI1CbrU3rX+wprbohYdxYGWsWd0/vw
	3IRyaWX4I0NgvU74ICnBNxUwzT6R5u1+BtRKukxqbxopgaLLD9RNxBrectJIDTecLrZ3TrtJLN/
	JvXOQwm+lkX2ILbQJmubKazjax5wXGacvsSrrkLEy
X-Gm-Gg: ATEYQzxm7YNbjAiKjkIfAQW0MnSKHGqwwqdlLvBavVn8SZaUr7mKCATUGwi9dNF1elW
	P+DapLpd8MfRHbrEZMZVBDTPkZf88vedUWcctzEhbvB8x+4XwMvRPOUFb5k5mNHDFp+BAiQ56pL
	e+CvqaVR6tOl1BrYAJFo7HtmhkR2iu9yM7BoUM8Nywu6rSjJmHWMgXH5FlEJq7fFSsqeK/WCoRW
	BEz7odqM4arxQrjblQjKjWg6/vv1r4uCKLAjmpEYWsNP/Bc6SSxCpDy7WjYVfEwbNVFAchYXJyu
	lq4pHTuz61VO7OXuWA==
X-Received: by 2002:a17:902:ea06:b0:2b0:5c3f:c0d8 with SMTP id
 d9443c01a7336-2b05c3fc4damr40223235ad.47.1773703396327; Mon, 16 Mar 2026
 16:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773665966.git.ljs@kernel.org> <063af0422d99bee0195589aa63f8f44edaf409fa.1773665966.git.ljs@kernel.org>
In-Reply-To: <063af0422d99bee0195589aa63f8f44edaf409fa.1773665966.git.ljs@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Mar 2026 19:23:04 -0400
X-Gm-Features: AaiRm50DdYFqfixz3H6HRwMmLfdf5osoLUZfr0b1blDqz3IzGNPvd_xOI_ajOas
Message-ID: <CAHC9VhR2T8ujtfvz-HgkgSFByptTLmhbCYS+scY53aYg=sgfqw@mail.gmail.com>
Subject: Re: [PATCH v2 17/23] mm: convert do_brk_flags() to use vma_flags_t
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 9:09=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> In order to be able to do this, we need to change VM_DATA_DEFAULT_FLAGS a=
nd
> friends and update the architecture-specific definitions also.
>
> We then have to update some KSM logic to handle VMA flags, and introduce
> VMA_STACK_FLAGS to define the vma_flags_t equivalent of VM_STACK_FLAGS.
>
> We also introduce two helper functions for use during the time we are
> converting legacy flags to vma_flags_t values - vma_flags_to_legacy() and
> legacy_to_vma_flags().
>
> This enables us to iteratively make changes to break these changes up int=
o
> separate parts.
>
> We use these explicitly here to keep VM_STACK_FLAGS around for certain
> users which need to maintain the legacy vm_flags_t values for the time
> being.
>
> We are no longer able to rely on the simple VM_xxx being set to zero if t=
he
> feature is not enabled, so in the case of VM_DROPPABLE we introduce
> VMA_DROPPABLE as the vma_flags_t equivalent, which is set to
> EMPTY_VMA_FLAGS if the droppable flag is not available.
>
> While we're here, we make the description of do_brk_flags() into a kdoc
> comment, as it almost was already.
>
> We use vma_flags_to_legacy() to not need to update the vm_get_page_prot()
> logic as this time.
>
> Note that in create_init_stack_vma() we have to replace the BUILD_BUG_ON(=
)
> with a VM_WARN_ON_ONCE() as the tested values are no longer build time
> available.
>
> We also update mprotect_fixup() to use VMA flags where possible, though w=
e
> have to live with a little duplication between vm_flags_t and vma_flags_t
> values for the time being until further conversions are made.
>
> Finally, we update the VMA tests to reflect these changes.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> ---
>  arch/arc/include/asm/page.h        |  2 +-
>  arch/arm/include/asm/page.h        |  2 +-
>  arch/arm64/include/asm/page.h      |  3 +-
>  arch/hexagon/include/asm/page.h    |  2 +-
>  arch/loongarch/include/asm/page.h  |  2 +-
>  arch/mips/include/asm/page.h       |  2 +-
>  arch/nios2/include/asm/page.h      |  2 +-
>  arch/powerpc/include/asm/page.h    |  4 +--
>  arch/powerpc/include/asm/page_32.h |  2 +-
>  arch/powerpc/include/asm/page_64.h | 12 ++++----
>  arch/riscv/include/asm/page.h      |  2 +-
>  arch/s390/include/asm/page.h       |  2 +-
>  arch/x86/include/asm/page_types.h  |  2 +-
>  arch/x86/um/asm/vm-flags.h         |  4 +--
>  include/linux/ksm.h                | 10 +++----
>  include/linux/mm.h                 | 47 ++++++++++++++++++------------
>  mm/internal.h                      |  3 ++
>  mm/ksm.c                           | 43 ++++++++++++++-------------
>  mm/mmap.c                          | 13 +++++----
>  mm/mprotect.c                      | 46 +++++++++++++++++------------
>  mm/mremap.c                        |  6 ++--
>  mm/vma.c                           | 34 +++++++++++----------
>  mm/vma.h                           | 14 +++++++--
>  mm/vma_exec.c                      |  5 ++--
>  security/selinux/hooks.c           |  4 ++-
>  tools/testing/vma/include/custom.h |  3 --
>  tools/testing/vma/include/dup.h    | 42 ++++++++++++++------------
>  tools/testing/vma/include/stubs.h  |  9 +++---
>  tools/testing/vma/tests/merge.c    |  3 +-
>  29 files changed, 186 insertions(+), 139 deletions(-)

Not that the SELinux changes are really all that significant, but they
look fine to me.

Acked-by: Paul Moore <paul@paul-moore.com> (SELinux)

--=20
paul-moore.com
