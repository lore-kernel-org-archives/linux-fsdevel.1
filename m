Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C7E4CCDEB;
	Fri, 18 Sep 2026 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726742; cv=none; b=YbG83CUF1kbdkrMeOJ+7sbMO/aNp0IJEUQXsDgKKNGHD3+6y+sj7bI7uoIEDO03mAxQR6I5YYrQQ0EYv4XxjYkqxQY0Va7PNpxDL4AxEK89CL1hKGNxUY+KqC+INVl/XqoRTw6DTJcBKw9wTMxnniu/GQ4dhE5K+LGgFomKjtUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726742; c=relaxed/simple;
	bh=w5fb2OONy/GtAEA2nh09Nc6VmArU5Yo8QzF94WDuj7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sR/7mSq162F59IvzHWakYxYJJ+rZ9NzwnW4ppNbp6oX+XnvVJkUhJK37PyfKC1jIJSMfWU0tlWfkuAk7MicBpKMONrm/g0bEhP0yRUdnJALJQpcdw8E7wmCK5XTY4g/duC77FZGT2FYm3eGRcwM+1ATdOlapYakqrMEnIuvGjMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj1qm4nu reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj1qm4nu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1441F000FF;
	Fri, 18 Sep 2026 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726733;
	bh=w5fb2OONy/GtAEA2nh09Nc6VmArU5Yo8QzF94WDuj7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lj1qm4nuzvY02T7ZQm88v8594RzQxLp2GRkXbWgVVtVBvfJ+6goLRgyhIpzhTJXQZ
	 2pCDF8LvVM9fJ6fKY4+uc/wQedLYCLDrjQbRopgkTtwyv4NIZXDsJsBsWAeToGhILW
	 qd7/SMXEZaj32E8uUi5oBjPfqyGM9+5tnt3G7yuecWX/qsPGerXYb2JIpM5s946iF7
	 yX0r6HiqXBjOBn9Vf8OIhbAyKlBkfCZ5xjd2UdjefGRfUDGraENXigs62wTGvXo/Nl
	 LkzE83NwKAHUJdQRZdZ5u09Z6Rm8qLlOmfxoay4Us/G2o7l2JK4cU7+i/D/m+wP5MR
	 vk5oADV1Jc8tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/17] kexec: Extract kexec_free_segment_cma() from
 kimage_free_cma()
Reply-To: sashiko-reviews@lists.linux.dev
To: x86@kernel.org, me@linux.beauty, vishal.l.verma@intel.com, npiggin@gmail.com, sourabhjain@linux.ibm.com, lizhengyu3@huawei.com, dakr@kernel.org, blum@kernel.org, linux-mm@kvack.org, dave.hansen@linux.intel.com, eric.devolder@oracle.com, adityag@linux.ibm.com, akpm@linux-foundation.org, will@kernel.org, takahiro.akashi@linaro.org, bgwin@google.com, catalin.marinas@arm.com, coxu@redhat.com, zhangtianyang@loongson.cn, driver-core@lists.linux.dev, kernel@xen0n.name, kees@kernel.org, hpa@zytor.com, kas@kernel.org, seanjc@google.com, linux-kernel@vger.kernel.org, mingo@redhat.com, ritesh.list@gmail.com, sshegde@linux.ibm.com, ruirui.yang@linux.dev, jbouron@amazon.com, leitao@debian.org, tglx@kernel.org, chenhuacai@kernel.org, hbathini@linux.ibm.com, james.morse@arm.com, mclapinski@google.com, palmer@rivosinc.com, ruanjinjie@huawei.com, linux-arm-kernel@lists.infradead.org, robh@kernel.org, linux-fsdevel@vger.kernel.org, maqianga@uniontech.com, gshan@redhat.com, chleroy@kernel.org, liuk
 exin@kylinos.cn, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, mpe@ellerman.id.au, pratyush@kernel.org, ardb@kernel.org, piliu@redhat.com, maddy@linux.ibm.com, yeoreum.yun@arm.com, loongarch@lists.linux.dev, baoquan.he@linux.dev, mark.rutland@arm.com, rppt@kernel.org, linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org, rafael@kernel.org, chao.gao@intel.com, graf@amazon.com, thuth@redhat.com, guodongtai@kylinos.cn, bp@alien8.de, pasha.tatashin@soleen.com, tangyouling@kylinos.cn
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-4-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:18:49 +0000
Message-Id: <20260918101850.7E1441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> kimage_free_cma() relies on image->nr_segments to iterate over segments.
> When an architecture loader (e.g., arm64) truncates nr_segments on a
> mid-way failure, CMA pages allocated beyond the new boundary become
> unreachable, causing silent memory leaks.
>=20
> Extract the per-segment freeing logic into the exported helper
> kexec_free_segment_cma(), so that architecture loaders can release
> individual segments before nr_segments is truncated. Refactor
> kimage_free_cma() to loop over the new helper, preserving existing
> behavior.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D3

