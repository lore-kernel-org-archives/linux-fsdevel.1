Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538F4B1D1C;
	Fri, 18 Sep 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727133; cv=none; b=SiiZ5YLFNSjd8jurIXEKvfRZaEsXjjIB+KVGUdWjFPR5PL2cRkZN2+U8/WwBpgwyVs3KmeoXrZjgObbMazuOcmGN7VyUfbRIPUOA8GT1w/uWXF7uIKz5QSE/gg+hppoDEmqiXrS1L25q9VGcdYMNDPYFWhwBevCB8x9ycKzbbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727133; c=relaxed/simple;
	bh=XCX7OD0MFSj63jeBdnj32V2m69meKqvW8/7zSh3AOsY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pc/q5UfVJGzw/aNKzd1z/Anekhj2vCnE/oQziv9s+pDObaiR9qGWIsnvKguHAmMlEpZGJQzes2r01N2Wr2/Ty1b345hrBHk2cw9JBJdmUzaYiXkisa+TUJHACHNxBQgpR4EHK2gMCQVVcAL2WugSUeI1tQ95RpEX8Dd3mvXJ1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgn07gul reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgn07gul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170481F000FF;
	Fri, 18 Sep 2026 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727130;
	bh=XCX7OD0MFSj63jeBdnj32V2m69meKqvW8/7zSh3AOsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bgn07gul2XbQMTEsRc4NB0SooXCoVClfKj7xYlHbS0pB2k+p9hs37drFAnbcjmF6s
	 4uQTP4i4RTHhMXyDNCKCVqtp09Vt4jf/2sZpt6hXCITDDYmNLKHl/7GEuioB10pBbq
	 KgC8pFhunF4pZVF52aAyqYLmVje7onyZnDtkoMo7M+n8lrWgnW2qD56PzJwaioLm4S
	 fHUW0/h/VQS1YQuMks/Kfw+mvY5dmMgMBMzsknhX/LGDPMoVKKagSg7iLX1wTh+7zx
	 SfTRxREogXbxKWtWO3h7HjVP9J++VI67o4Pb8NZxEUTXLM29u8MBaqpCcwe6O9eeSz
	 2AjhZSXEB/PNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/17] elf: Introduce elf64_phdr_size() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, lizhengyu3@huawei.com, dave.hansen@linux.intel.com, mark.rutland@arm.com, bgwin@google.com, npiggin@gmail.com, mingo@redhat.com, mclapinski@google.com, thuth@redhat.com, ruirui.yang@linux.dev, sourabhjain@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, catalin.marinas@arm.com, dakr@kernel.org, linux-kernel@vger.kernel.org, vishal.l.verma@intel.com, pasha.tatashin@soleen.com, robh@kernel.org, sshegde@linux.ibm.com, chao.gao@intel.com, rppt@kernel.org, seanjc@google.com, chleroy@kernel.org, liukexin@kylinos.cn, linux-mm@kvack.org, takahiro.akashi@linaro.org, piliu@redhat.com, akpm@linux-foundation.org, pratyush@kernel.org, ruanjinjie@huawei.com, kees@kernel.org, hpa@zytor.com, rafael@kernel.org, ritesh.list@gmail.com, blum@kernel.org, linux-arm-kernel@lists.infradead.org, coxu@redhat.com, maddy@linux.ibm.com, eric.devolder@oracle.com, palmer@rivosinc.com, tglx@kernel.org, adityag@linux.ibm.com, kas@kernel.org, chenhuacai@kernel.org, yeoreum.yun@
 arm.com, maqianga@uniontech.com, gshan@redhat.com, guodongtai@kylinos.cn, gregkh@linuxfoundation.org, x86@kernel.org, zhangtianyang@loongson.cn, jbouron@amazon.com, bp@alien8.de, tangyouling@kylinos.cn, loongarch@lists.linux.dev, james.morse@arm.com, ardb@kernel.org, mpe@ellerman.id.au, leitao@debian.org, will@kernel.org, baoquan.he@linux.dev, hbathini@linux.ibm.com, me@linux.beauty, graf@amazon.com, linux-fsdevel@vger.kernel.org, kernel@xen0n.name, driver-core@lists.linux.dev
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-15-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-15-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:25:26 +0000
Message-Id: <20260918102527.170481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> Add a common helper to compute the total size of an ELF64 header
> (Ehdr + program headers) from the number of program headers.
> Replace open-coded calculations in powerpc, x86, vmcore,
> and crash_core.
>=20
> On ppc64, struct elfhdr maps to elf64_hdr, so the powerpc change
> is a pure cleanup.
>=20
> No functional change intended.
>=20
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D14

