Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B4547051;
	Fri, 18 Sep 2026 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727821; cv=none; b=CR+U/GiChs9HAmbzaZRj4VEy2BSzXsphZ+80gQEuUVq3aLsfkxm5va+ht2dV973i7izSvTWDKnQxDBOmBgDJnG46fYNMsdY7iVj63GXzgBJVBwYhXwCSVe5K8Yb2HLyNgNE8Br0iS2WLpu+7nIXkb/Lr7VjFjcovLcd/RzIi2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727821; c=relaxed/simple;
	bh=5RyNVO5DR5qB1QeVmYuSCtPN+hmp+JhvY6FFQsgUgvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s7/VP/QrZe7F9Qog6HZ8kqPZCEqli50wh+bxx63K6m+LY9UXBhoRItCNRU7snOyv2rKI6++zM21grXfYXF64F7Vb5bhARyS3jisO9Lhc4Rw8s6PFtQehT2r25guf37Uc86JDab0S+9ogfuaQIkwtYrX0kplDZJvWcqKI15MkZzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q42qAzt7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q42qAzt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC341F000FF;
	Fri, 18 Sep 2026 10:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727819;
	bh=Lw9zS0Z5XTShZWdFIGichHAPl+WNOp2mTX9Vx2b9uGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q42qAzt7wO+OFo6NAoDwEE1MDA4cRI3i/Jy/Qfuq0/wpgUimD8W/1lqVrecho7Kou
	 WabJVL20LNw0REudcaOdeeb+T4PExYxgh/OrdVdLoMnod1bxNeVKjrL//TlXvOHr0x
	 uQHhG+p4fnpTaLGkuKPKt0lF/tSHSWpnsQUDz0yCQ6i6NLviOmP5AwbmF7hifJoymO
	 a/dj9wKcgweN0UsrgQ7dl0KBXGcJZvkPwCfEnGRPKB6PFdnVB0tUKh1QamLTWNKEsV
	 B4ughp0yGBPUNdq905IDJDtq0MYVx2RWuc4ruH3JiWRRurjm5VB3sZIQTW+1rluU58
	 6VzR/lgTAk56Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/17] arm64: crash: Add crash hotplug support
Reply-To: sashiko-reviews@lists.linux.dev
To: tglx@kernel.org, ritesh.list@gmail.com, mark.rutland@arm.com, chao.gao@intel.com, kas@kernel.org, linuxppc-dev@lists.ozlabs.org, yeoreum.yun@arm.com, x86@kernel.org, baoquan.he@linux.dev, hbathini@linux.ibm.com, sourabhjain@linux.ibm.com, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, jbouron@amazon.com, dave.hansen@linux.intel.com, rafael@kernel.org, coxu@redhat.com, akpm@linux-foundation.org, gshan@redhat.com, vishal.l.verma@intel.com, ruirui.yang@linux.dev, seanjc@google.com, bgwin@google.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, chenhuacai@kernel.org, pasha.tatashin@soleen.com, kees@kernel.org, me@linux.beauty, npiggin@gmail.com, maddy@linux.ibm.com, ruanjinjie@huawei.com, thuth@redhat.com, graf@amazon.com, palmer@rivosinc.com, chleroy@kernel.org, guodongtai@kylinos.cn, zhangtianyang@loongson.cn, eric.devolder@oracle.com, catalin.marinas@arm.com, leitao@debian.org, driver-core@lists.linux.dev, piliu@redhat.com, kernel@xen0n.name, dakr@kernel.org, pratyush@kernel.org, sshegde@linux.ibm.com, tangyouling@kylinos.cn, adityag@linux.ibm.com, rppt@kernel.org, mclapinski@google.com, takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org, will@kernel.org, ardb@kernel.org, gregkh@linuxfoundation.org, lizhengyu3@huawei.com, linux-mm@kvack.org, james.morse@arm.com, linux-fsdevel@vger.kernel.org, mpe@ellerman.id.au, mingo@redhat.com, bp@alien8.de, blum@kernel.org, robh@kernel.org, hpa@zytor.com, liukexin@kylinos.cn, maqianga@uniontech.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-18-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-18-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:36:56 +0000
Message-Id: <20260918103657.0CC341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kexec: arch_crash_get_elfcorehdr_size() exports undersized buffer =
when MEMORY_HOTPLUG is disabled
--

commit fd293f9cfd1a12554d9352f4ad58fc9f85721fa3
Author: Jinjie Ruan <ruanjinjie@huawei.com>
arm64: crash: Add crash hotplug support

This commit introduces kernel mechanisms to update only the elfcorehdr
on memory hotplug events for arm64. It adds ARCH_SUPPORTS_CRASH_HOTPLUG=20
and implements arch-specific functions to handle memory hotplug, avoiding
full kdump image reloads from userspace.

Link: https://lore.kernel.org/all/20240529133446.28446-1-Jonathan.Cameron@h=
uawei.com/

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5a51b0ef9440..96de2660b1cbb 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1720,6 +1720,9 @@ config ARCH_DEFAULT_CRASH_DUMP
>  config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>  	def_bool CRASH_RESERVE
> =20
> +config ARCH_SUPPORTS_CRASH_HOTPLUG
> +	def_bool y
> +

[Severity: High]
Does unconditionally enabling ARCH_SUPPORTS_CRASH_HOTPLUG here expose an
undersized buffer to userspace when CONFIG_MEMORY_HOTPLUG is disabled?

Since CONFIG_HOTPLUG_CPU natively selects CONFIG_CRASH_HOTPLUG on
architectures that support it, having this default to 'y' allows
CRASH_HOTPLUG to be active even without MEMORY_HOTPLUG. This leads to the
size calculation issue below.

[ ... ]
> diff --git a/arch/arm64/kernel/crash.c b/arch/arm64/kernel/crash.c
> new file mode 100644
> index 0000000000000..08dc9b952498e
> --- /dev/null
> +++ b/arch/arm64/kernel/crash.c
[ ... ]
> +unsigned int arch_crash_get_elfcorehdr_size(void)
> +{
> +	unsigned long phdr_cnt;
> +
> +	/* A program header for possible CPUs, vmcoreinfo and kernel_map */
> +	phdr_cnt =3D 2 + num_possible_cpus();
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		phdr_cnt +=3D CONFIG_CRASH_MAX_MEMORY_RANGES;
> +

[Severity: High]
Is this calculation missing the static memory ranges when
CONFIG_MEMORY_HOTPLUG is disabled?

If compiled with CONFIG_HOTPLUG_CPU=3Dy (which natively selects
CONFIG_CRASH_HOTPLUG) and CONFIG_MEMORY_HOTPLUG=3Dn, phdr_cnt is computed as
exactly 2 + num_possible_cpus(). This does not account for the mandatory
memblock ranges from arch_get_system_nr_ranges().=20

Unlike x86 or powerpc which might survive this due to heavily padded
CONFIG_NR_CPUS_DEFAULT values, arm64's precise num_possible_cpus() leaves
zero headroom. As a result, the exported maximum elfcorehdr size is strictly
smaller than the required size to hold static memory ranges, and any attempt
to arm kdump (kexec -p) will fail because kexec-tools cannot load the crash
kernel into the undersized segment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D17
