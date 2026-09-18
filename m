Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFD04D7D22;
	Fri, 18 Sep 2026 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726866; cv=none; b=QpdC8Eb2pzO326yf2qm+24YVbmAtHdgDHJ8hjTrRmkmq/rQ5Q1Odf/K5RkhLA9bLJK9EtH/xQv11mdXALYWj5DYdcJKmlfSqBYMIT+O3J8nvFegrVudbLf/dHNBzvrWrKDOaq5coryQBuSagRL9S1IKw6ly0t24+WwNrkLp5y+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726866; c=relaxed/simple;
	bh=ojRb2OtGZV+lNR54MP8W9kUbXEoKZ+Rzr9bvDWAKmSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dPJW5JRN3Q5KQAvFSuK7PuGWUnudl71pUMKwQAHKZ35AQ+Tch2FMPcYd/GSC05UkCLGZo2FnzwDnphj7cbmsiXmQKhITxIrRJhedN1NSK0AQ8/X8J3Wo51jV2XbFMp9x3WjG2jCdfXtXXfaIAc+5u7ZAJN5I41OLI9qL5gwGI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbhnGqJb reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbhnGqJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482D31F00893;
	Fri, 18 Sep 2026 10:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726865;
	bh=ojRb2OtGZV+lNR54MP8W9kUbXEoKZ+Rzr9bvDWAKmSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VbhnGqJbr+ybtK3Fnwjub4nxRMAkKMpEzatb5UyqR56xMFB6wzCkyGzg4dZWPmT3+
	 X+snAKFCSsw9hS3uDDtXyaV+a120iBx6doKN2SXy7kWsE6Ghr43NePclsslWz3X5jO
	 umM+Y1oZRe63NELb54DdiEkz9d+zMmZueH0FDcyiLWVV9cdWUYTG7WaCOZvG2X/7g/
	 a9oPJYB+Dy64zxGyUYebphSZ5ylo5LJpeevfZI8VBPaG8K99ZpvTAK5Kx+JWQnO/hy
	 0N1qcxBpGbuzeUsqKEcZ7LzQMrQi37y/VFurlQHxRKvV4Yc12NiNYAuI+ZMxmxdW8s
	 JCL5q8jJo+Sfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/17] LoongArch: kexec_file: Fix elf_headers memory
 leak in retry loop
Reply-To: sashiko-reviews@lists.linux.dev
To: leitao@debian.org, seanjc@google.com, kees@kernel.org, thuth@redhat.com, tglx@kernel.org, loongarch@lists.linux.dev, will@kernel.org, hbathini@linux.ibm.com, rppt@kernel.org, akpm@linux-foundation.org, chao.gao@intel.com, hpa@zytor.com, guodongtai@kylinos.cn, takahiro.akashi@linaro.org, maddy@linux.ibm.com, pratyush@kernel.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, zhangtianyang@loongson.cn, lizhengyu3@huawei.com, blum@kernel.org, x86@kernel.org, eric.devolder@oracle.com, catalin.marinas@arm.com, ruirui.yang@linux.dev, me@linux.beauty, adityag@linux.ibm.com, ruanjinjie@huawei.com, vishal.l.verma@intel.com, mark.rutland@arm.com, sourabhjain@linux.ibm.com, linux-kernel@vger.kernel.org, rafael@kernel.org, chenhuacai@kernel.org, pasha.tatashin@soleen.com, palmer@rivosinc.com, ritesh.list@gmail.com, kernel@xen0n.name, robh@kernel.org, dakr@kernel.org, james.morse@arm.com, mingo@redhat.com, tangyouling@kylinos.cn, mclapinski@google.com, linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, jbouron@amazon.com, sshegde@linux.ibm.com, graf@amazon.com, bgwin@google.com, bp@alien8.de, linux-mm@kvack.org, chleroy@kernel.org, piliu@redhat.com, maqianga@uniontech.com, gshan@redhat.com, yeoreum.yun@arm.com, coxu@redhat.com, mpe@ellerman.id.au, dave.hansen@linux.intel.com, npiggin@gmail.com, baoquan.he@linux.dev, kas@ker
 nel.org, liukexin@kylinos.cn, ardb@kernel.org, driver-core@lists.linux.dev, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-8-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-8-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:21:01 +0000
Message-Id: <20260918102102.482D31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> If load_other_segments() fails after image->elf_headers is assigned,
> the memory lifecycle is safely managed by the global kimage object
> and will be freed in arch_kimage_file_post_load_cleanup().
>=20
> However, during a retry loop in efi_kexec_load(), a subsequent iteration
> will allocate a new buffer and overwrite image->elf_headers. This
> permanently leaks the stale memory from the previous iteration before
> the global cleanup can track it.
>=20
> Fix this by explicitly freeing the stale `image->elf_headers` buffer
> before assigning the newly allocated headers.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 55d990f0084c ("LoongArch: Add EFI binary support for kexec_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D7

