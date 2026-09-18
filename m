Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F84C226D;
	Fri, 18 Sep 2026 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726612; cv=none; b=JJeOfDcBn1SYFV3zo3dUhaAVrglma+bewHht66h+ryA2+S/jQgsGpEJC6MstCqknLV58g8b39lFHCXxKxBjWLqMiN4G2BqeQsgTpdtccHfXKKuTyA+YhSqn0Hq5jHdfvwF3Dn+k8CEuhzfMt+Qn76LpkNnLstZ1O5rjvEzOEMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726612; c=relaxed/simple;
	bh=UDxOdOM4SxQI/SRvITcvClpR4kJ1LyTAVJnnNy5mOjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o0uyltrQ19WeVaErbzIXWLwK777wmjTqzntXToZhrV+D7OwP0VOJeKU6R1Bj38PwntvjBByOJuGWydSDCkvmMMY20HrClEcz/jJYWL1Mk5/isIyr/kfJeQK14NFpvCmP4oqkU+34eZn1V+2yzxyb+P2mAj9zqY0Vbu9UmEltAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh+Pxjuh reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh+Pxjuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27101F00898;
	Fri, 18 Sep 2026 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726605;
	bh=UDxOdOM4SxQI/SRvITcvClpR4kJ1LyTAVJnnNy5mOjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qh+PxjuhUYtQuTeeOL6D5uiL1736me4lgCC18Dyr540KpX1gn7g2viekAqDkINVeW
	 V16ZuYKknpyPGGG3APdOEwuMAA9Mi2X01p1YlM68ibSO/A8gHWKdpYguVle1KPxGUW
	 SwSHBlhTwmXypnGgRbnUrfbCkHZj8vLURNJsaxUScCCy2zq0L8WhG7YW/LanxlaQ30
	 Y9ixgrAUskPcxu43UTAsVmm1yKlQoJ86LJsqXWxWO2wBCStypE1LKZLL4qmNA3jhPT
	 N93ecpuLle22qWqJDfk1PgsNhWBnUkKlE/ktYVKnz6zp5EwRIw2pWOt96ZTKfbwF6+
	 Dj/abVCxxaFWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/17] kexec: Record allocated CMA pages to fix
 release size mismatch
Reply-To: sashiko-reviews@lists.linux.dev
To: gregkh@linuxfoundation.org, dakr@kernel.org, maddy@linux.ibm.com, mingo@redhat.com, bp@alien8.de, ruanjinjie@huawei.com, ardb@kernel.org, robh@kernel.org, vishal.l.verma@intel.com, me@linux.beauty, kas@kernel.org, bgwin@google.com, linux-kernel@vger.kernel.org, chleroy@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, will@kernel.org, rafael@kernel.org, lizhengyu3@huawei.com, hpa@zytor.com, yeoreum.yun@arm.com, tangyouling@kylinos.cn, graf@amazon.com, eric.devolder@oracle.com, sshegde@linux.ibm.com, kernel@xen0n.name, loongarch@lists.linux.dev, gshan@redhat.com, thuth@redhat.com, linux-mm@kvack.org, sourabhjain@linux.ibm.com, hbathini@linux.ibm.com, ritesh.list@gmail.com, mark.rutland@arm.com, adityag@linux.ibm.com, guodongtai@kylinos.cn, catalin.marinas@arm.com, maqianga@uniontech.com, seanjc@google.com, kees@kernel.org, dave.hansen@linux.intel.com, ruirui.yang@linux.dev, x86@kernel.org, palmer@rivosinc.com, piliu@redhat.com, pratyush@kernel.org, james.morse@arm.com, tglx@kerne
 l.org, jbouron@amazon.com, zhangtianyang@loongson.cn, driver-core@lists.linux.dev, linux-arm-kernel@lists.infradead.org, chao.gao@intel.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, liukexin@kylinos.cn, linux-fsdevel@vger.kernel.org, blum@kernel.org, npiggin@gmail.com, leitao@debian.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, pasha.tatashin@soleen.com, mclapinski@google.com, chenhuacai@kernel.org, coxu@redhat.com, takahiro.akashi@linaro.org, akpm@linux-foundation.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-3-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:16:41 +0000
Message-Id: <20260918101641.D27101F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> The CMA pages allocated for a kexec segment are released using the
> segment's memsz to calculate the number of pages. However, some
> architecture loaders modify the segment's memsz after allocation
> (e.g. arm64 subtracts text_offset), causing the release function to
> free fewer pages than were originally allocated, leaking the remaining
> CMA pages.
>=20
> Add a per-segment `segment_cma_pages` array to store the number of
> pages actually allocated from CMA. Populate it during
> kexec_add_buffer() using the aligned memsz, and use it in
> kimage_free_cma() to accurately release all allocated pages.
>=20
> This avoids relying on the potentially modified segment->memsz and
> prevents silent CMA memory leaks.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Brian Mak <makb@juniper.net>
> Cc: Pingfan Liu <piliu@redhat.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Justinien Bouron <jbouron@amazon.com>
> Cc: Li Chen <me@linux.beauty>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D2

