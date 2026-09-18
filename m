Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BE4DE720;
	Fri, 18 Sep 2026 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726525; cv=none; b=KbWoXDZICaDrUSC7GxaHiWuk0+d1uQaT4DS4QPakvq+UTF4xbxjdmWUkheV4Wb5+/W6aXUwfp57cOdsKxPxbKQh6q/Zv6Xx6s7X0Gb03CvyIQyBZgFURX3OMCigUmhG1pwVkeXA+gmqRJf36pBbnQAIoA/hzqR8DPdV5BxX2iM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726525; c=relaxed/simple;
	bh=iiUFRlHhVLGHO4P1JeUzTqnMBZGqjCg6ljFaVKDtmKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rRdVAVwdpzmBVqEzTk+xQntRr4ypIk+kX13Vtrjeh8OX/Kc6HREeADYRe6hOx5qVzTLAA4/5sB3zxFxvQdlwY4lKydee8v48/4zohSBSfexUH22AhLJSWWqHPPTEhv6D87lDghIFPf+WxqP5XzcXkzzK1hj6BGT3MwMDdg0Rv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYMe2VxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYMe2VxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48821F000FF;
	Fri, 18 Sep 2026 10:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726522;
	bh=iiUFRlHhVLGHO4P1JeUzTqnMBZGqjCg6ljFaVKDtmKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CYMe2VxQKqjM48Qh1JiWT2P3UEJVuCac8ysLzJ+dZag32Ft9bAVcpGOMZ4HScYKSA
	 LrzLpuhoEMI3GtAYTsLW4jh/gRtnUoW+N9rRyYlYOyTXKJIrjz1QkFNSAmTri9KxtQ
	 YgAizPYMs6Pk+zAZ7x1uzNN3yUFr4LYNxPNrUJBDLylaSStamwvu6mgyHmTx6JLyky
	 SPUYmfalqSRbW2mY7QLXGTOAMq7KZrFu0mnGpoTqq6Cjx1Umnw5Hk54MIt5dBLGeyO
	 rCce++XRc1mltvKKrrut+TtgQ5n+bH85UTxblml2GEicEU8TJBSTEJtZaIOC4yTjcM
	 xr7wJo3WI5ZMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/17] arm64: kexec_file: Fix CMA page leaks in
 segment placement retry loops
Reply-To: sashiko-reviews@lists.linux.dev
To: ruanjinjie@huawei.com, graf@amazon.com, gshan@redhat.com, pasha.tatashin@soleen.com, catalin.marinas@arm.com, tglx@kernel.org, pratyush@kernel.org, ruirui.yang@linux.dev, linux-arm-kernel@lists.infradead.org, bgwin@google.com, palmer@rivosinc.com, mpe@ellerman.id.au, hbathini@linux.ibm.com, hpa@zytor.com, sourabhjain@linux.ibm.com, robh@kernel.org, adityag@linux.ibm.com, zhangtianyang@loongson.cn, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, guodongtai@kylinos.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org, me@linux.beauty, x86@kernel.org, ritesh.list@gmail.com, eric.devolder@oracle.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, blum@kernel.org, coxu@redhat.com, rafael@kernel.org, jbouron@amazon.com, rppt@kernel.org, tangyouling@kylinos.cn, maqianga@uniontech.com, sshegde@linux.ibm.com, kernel@xen0n.name, dakr@kernel.org, thuth@redhat.com, seanjc@google.com, npiggin@gmail.com, vishal.l.verma@intel.com, chao.gao@intel.com, liukexin@kylinos.cn, piliu@redhat.com, linuxppc-dev@lists.ozlabs.org, takahiro.akashi@linaro.org, kees@kernel.org, baoquan.he@linux.dev, james.morse@arm.com, yeoreum.yun@arm.com, dave.hansen@linux.intel.com, driver-core@lists.linux.dev, ardb@kernel.org, gregkh@linuxfoundation.org, leitao@debian.org, chenhuacai@kernel.org, kas@kernel.org, loongarch@lists.linux.dev, mclapinski@google.com, bp@alien8.de, lizhengyu3@huawei.com, mingo@redhat.com, will@kernel.org, mark.rutland@arm.com, maddy@linux.ibm.com, chleroy@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-5-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:15:18 +0000
Message-Id: <20260918101518.D48821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> During kexec image placement retry loops, any midway failure causes
> the loader to truncate `image->nr_segments` back to its initial state
> to purge the failed segments.
>=20
> However, this truncation introduces a memory leak. The CMA pages
> allocated via kexec_add_buffer() during the failed attempt are tracked
> in the `image->segment_cma` array. Because the subsequent cleanup paths
> only iterate up to the truncated `nr_segments` boundary, these allocated
> CMA pages outside the new boundary are permanently leaked.
>=20
> Fix this by explicitly releasing the associated CMA buffers in
> the failure paths before `image->nr_segments` is reduced.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 07d24902977e4 ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D4

