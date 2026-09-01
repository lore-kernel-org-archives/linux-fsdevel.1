Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31948AE1B;
	Tue,  1 Sep 2026 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293698; cv=none; b=d+22sV81w4VYwGqWU+CVBD/xQ1yc+Mg635ExLYgi0PKZPl/X1fgAz69Cw1jimoYWCMy73D/yjn/5oLKRuzDALtc2Gb+5iRvFI/T0nPoKYerFl6olDMnV6k6dUBIN0yTT4zuw0rxQwFi0kUVoT58YlPKDhpxbIznG4lNPZ5guGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293698; c=relaxed/simple;
	bh=VvsRXM0Yj78QB3+u/yAsxN4LdE3PS+yyr3oa6EcQpkI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YnIbA0Yy553ZDEjN3OCecVwDS/HjjdinyrIQr63nJGkuXGgdPq+rHjT/h2OBeAXyYaZ3kt28bYRyJ7ISPDvStoRKP1UrDDTWzIkM9HY4wDjnXtM/zvA3hfoQGYOyntCRaE1HobyKzu8gtxCZ9wHDmGgk/9zTvi8pTMYqw2kE/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bur9NIA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bur9NIA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C7A1F00A3A;
	Tue,  1 Sep 2026 20:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788293696;
	bh=f1/Jwq5+t6tQe5v6CVe+ERoBwhfQo9XFyVXChFbscQ0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bur9NIA5VjZqJ3jA9kvUAsKCinpmhYAyRbr8Hb1A0OQctcuO7N9DscX1sNVWHL1V7
	 T80F+vdakutewH2IMUKIulhBeYbTt74ZvhHoMosmzBE80N+qc3JJtFqfa+UOgi4b5H
	 nhJt07pq+F5fJOJSXkLDfT4qSN/I+piV60qOEI6PAZyKdu1ycpYXmW4JdbL3YGBRSO
	 QhxKekth0A8llYBOSGx9oqJNnoi3gtqRLBPJlVRvjImiywEubcsr5hoj1xB8ayZBwy
	 q8rGlbxN+AW6qnyVN4sOrSL4v4mH+oG0IpyaHj57TG+k/Vbf4tA5+oKuV69TJt709Q
	 ed/bhiUFFcOQA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 15/17] crash: Simplify CRASH_MAX_MEMORY_RANGES
 handling
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
In-Reply-To: <20260826092541.3905933-16-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-16-ruanjinjie@huawei.com>
Date: Tue, 01 Sep 2026 23:14:00 +0300
Message-Id: <178829364021.3691424.12328056849597833403.b4-review@b4>
X-Mailer: b4 0.17-dev

Hi,

> Set CRASH_MAX_MEMORY_RANGES to 0 when MEMORY_HOTPLUG is disabled, then
> remove the now unnecessary IS_ENABLED(CONFIG_MEMORY_HOTPLUG) checks in
> powerpc and x86 arch_crash_get_elfcorehdr_size().
> 
> No functional change intended.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index fc0105c7af4c3..c47e3f867ea1f 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -474,9 +474,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>  	unsigned long phdr_cnt;
>  
>  	/* A program header for possible CPUs + vmcoreinfo */
> -	phdr_cnt = num_possible_cpus() + 1;
> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> -		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
> +	phdr_cnt = num_possible_cpus() + 1 + CONFIG_CRASH_MAX_MEMORY_RANGES;
>  
>  	return elf64_phdr_size(phdr_cnt);
>  }
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 99eb8583d9321..116410ac90fb4 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -407,9 +407,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>  	unsigned int sz;
>  
>  	/* kernel_map, VMCOREINFO and maximum CPUs */
> -	sz = 2 + num_possible_cpus();
> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> -		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
> +	sz = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
>  	sz *= sizeof(Elf64_Phdr);
>  	return sz;
>  }
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index a97ed9605602f..e6251dfe451a8 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -160,7 +160,8 @@ config CRASH_HOTPLUG
>  
>  config CRASH_MAX_MEMORY_RANGES
>  	int "Specify the maximum number of memory regions for the elfcorehdr"
> -	default 8192
> +	default 8192 if MEMORY_HOTPLUG
> +	default 0 if !MEMORY_HOTPLUG

This only sets the default, but a user can change the value explicitly.

-- 
Sincerely yours,
Mike.

