Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFAC483806;
	Tue,  1 Sep 2026 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293685; cv=none; b=hLAlfvByXnxNOBimIE09zPg/NH/GXIw3Y5RUcAoFZyAAOYCkNfhY9WlVVvHPL5Y/eTh69qaXj9RlPx3dfG7OWGstpEuZ7mmTMblxEDI265tN7GYLQu4Z1Ouhfjh8ZceOi3ToXyRmMZW5czN3Xftwx+xxJ3nV2tXtk+gEDsacikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293685; c=relaxed/simple;
	bh=1EQTWVE6vW13h9FuEqPnBJ3FGLWh6+X7UcUMlAUWCGU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=GA4lt8BvEzC4hvAXa7JU0EKTIYKO9Brlp/5Gg4ThWFNVavVIab6hC8WxLMUZ1ZFe7GjIaSYOlqwZy6tF+Fn8vQdkcpSNDDkydg2b/DkCsR4KilXglnZhPiQwPkZ6CgKvEwMWhBebD+ovh2eLv2zik+Uqwu9udJW3sapTF1E15B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK7KIXR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK7KIXR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30A11F000E9;
	Tue,  1 Sep 2026 20:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788293683;
	bh=XYAL/uAoi+EN4roiOHSrXabP2vbnl7qcOw3MP41npbU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=oK7KIXR6KUMFaGOJIUsL9dZOFAkwrVf2yKPCXU01KHGex01sBreWT258WZzUfcFn5
	 N93Z1YC0ijmCWwzdoNGAU4G9utTIZGp5IgWf8X4H4hbfF5zVWFBqKBg4YeUMPjN0IR
	 GRqaT6bQ/HcAeFBzveARB1bTlhtt6tGhp5xI9YMBwzO/d1SEgK960i+4ONjpEjdAwa
	 7tG2nwlX09g2Zqlhw5BescVjXG5aZz+VId6dbPlddwI3F+7kLFJCguutYFwbYGa2Rb
	 BvAnrQEVhQOr9OmQCQw70saSaDN2Yet3d9/+LJIvw+JtUjv3/nv6xht6k1tPEvBw4K
	 3vqUArPhf7QvA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 08/17] crash: Extract crash_get_memory_ranges()
 helper
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
 kees@kernel.org, thuth@redhat.com, gshan@redhat.com, jic23@kernel.org, 
 james.morse@arm.com, ardb@kernel.org, leitao@debian.org, 
 yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, coxu@redhat.com, 
 tangyouling@kylinos.cn, hbathini@linux.ibm.com, adityag@linux.ibm.com, 
 ionut.nechita@windriver.com, liaoyuanhong@vivo.com, seanjc@google.com, 
 fuqiang.wang@easystack.cn, makb@juniper.net, piliu@redhat.com, 
 ebiggers@kernel.org, jbouron@amazon.com, mclapinski@google.com, 
 me@linux.beauty, graf@amazon.com, bgwin@google.com, robh@kernel.org, 
 takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org
In-Reply-To: <20260826092541.3905933-9-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-9-ruanjinjie@huawei.com>
Date: Tue, 01 Sep 2026 23:14:00 +0300
Message-Id: <178829364020.3691424.10343800427604677653.b4-review@b4>
X-Mailer: b4 0.17-dev

Hi,

> Factor out the crash memory range collection logic from
> crash_prepare_headers() into a separate function. This allows
> the memory hotplug path to obtain and modify the range list
> (e.g. remove offlined memory) before generating the elfcorehdr.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index bc087124cd78e..619af312bd9a5 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -62,6 +62,7 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
>  extern int crash_prepare_headers(int need_kernel_map, void **addr,
>  				 unsigned long *sz, unsigned long *nr_mem_ranges);
>  extern int crash_exclude_core_ranges(struct crash_mem **cmem);
> +extern int crash_get_memory_ranges(struct crash_mem **mem_ranges);

No need for extern here as well.

-- 
Sincerely yours,
Mike.

