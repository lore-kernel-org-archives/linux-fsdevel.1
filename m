Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C52D4C227D;
	Fri, 18 Sep 2026 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727243; cv=none; b=oKRHiXqboBWrz378TPucs5+lhAvhLM5FsQUUY4Oo2Sn+THvMnwEbxVZL/mzwyvBLoWRkUafaUpi3vlYaAlNk4mqzBExMgsw68kU5fYdvzLhDntW93+q5B/coqo/ibwl5H29KMLHq7OJcare/0urNKYs2995GJrGvbwgchjY5q60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727243; c=relaxed/simple;
	bh=LUkDSbiAS248nMrWXNTNmtWkBultYX6rVLee+4HO2Ss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZaAdVUHea4GJovjxPV58C4Ak4yqJUp2qOUYrjRmi7hL/Q6qM6798DyvziCNmopqlH4rQ6h3q+1UgI9cjH9JaZWgMZDZckbSDwX9I3ndYOZtv/lXxBKyuOt9PZiV2Cdj7p3xCQufjA+7IEICLRl3JlAMeh4eQXfyt1roAaeQs1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du4xoU7X reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du4xoU7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789961F000FF;
	Fri, 18 Sep 2026 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727241;
	bh=LUkDSbiAS248nMrWXNTNmtWkBultYX6rVLee+4HO2Ss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Du4xoU7XjcM1TU6N/dTK544nfxc5Xy4BGBBLWmcwaBcwvbxAkfkHsVFrdqrAPsSNR
	 Snp5SQgQywMHtT1ZKAD43KdCSFT61Wt+I/i//Tba+e+t/o/RERKfZj8UnuqflMPSL5
	 ZmWlhVxdVtD7qwnw/a2BcP2WEBdw1L0n1RWhDgC0dZMVpk5r1PDqcihr9V0X5Zr8Be
	 O7jQ7y50yEdU+BmUnsJ/aCm5tAaCmg21Vg6fHxN3SuCeKnMkicaeMaKAlCbh1TiAVS
	 /bUGsZMlSdpCGcZHfnhBCEDyjCUSVrCSdPi1aHOlrHCZfjUtHuUzjSKPie2NGP+BB3
	 ZbhYbBud2KtTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/17] arm64: kexec_file: Simplify
 load_other_segments()
Reply-To: sashiko-reviews@lists.linux.dev
To: npiggin@gmail.com, vishal.l.verma@intel.com, kernel@xen0n.name, rafael@kernel.org, james.morse@arm.com, tangyouling@kylinos.cn, sourabhjain@linux.ibm.com, leitao@debian.org, coxu@redhat.com, palmer@rivosinc.com, linux-arm-kernel@lists.infradead.org, blum@kernel.org, baoquan.he@linux.dev, x86@kernel.org, jbouron@amazon.com, lizhengyu3@huawei.com, hbathini@linux.ibm.com, seanjc@google.com, dakr@kernel.org, sshegde@linux.ibm.com, pasha.tatashin@soleen.com, gshan@redhat.com, ritesh.list@gmail.com, piliu@redhat.com, chao.gao@intel.com, driver-core@lists.linux.dev, kees@kernel.org, kas@kernel.org, bp@alien8.de, mingo@redhat.com, bgwin@google.com, linux-kernel@vger.kernel.org, chenhuacai@kernel.org, linux-fsdevel@vger.kernel.org, maqianga@uniontech.com, zhangtianyang@loongson.cn, catalin.marinas@arm.com, maddy@linux.ibm.com, akpm@linux-foundation.org, yeoreum.yun@arm.com, loongarch@lists.linux.dev, ruirui.yang@linux.dev, graf@amazon.com, takahiro.akashi@linaro.org, mpe@ellerman.id.au, g
 uodongtai@kylinos.cn, linux-mm@kvack.org, gregkh@linuxfoundation.org, pratyush@kernel.org, liukexin@kylinos.cn, robh@kernel.org, dave.hansen@linux.intel.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, rppt@kernel.org, ruanjinjie@huawei.com, mclapinski@google.com, thuth@redhat.com, adityag@linux.ibm.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, mark.rutland@arm.com, will@kernel.org, hpa@zytor.com, me@linux.beauty, ardb@kernel.org, eric.devolder@oracle.com, tglx@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-17-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-17-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:27:18 +0000
Message-Id: <20260918102718.789961F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> Use `kbuf` fields directly in crash_prepare_headers() to eliminate
> the local variables "headers" and "headers_sz"..
>=20
> Advance the assignment to image->elf_headers before
> calling kexec_add_buffer(). If kexec_add_buffer() fails, the explicit
> vfree() in the error path can be removed, as the global infrastructure
> in arch_kimage_file_post_load_cleanup() will handle the cleanup.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D16

