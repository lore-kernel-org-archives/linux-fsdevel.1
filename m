Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B504EDCC3;
	Fri, 18 Sep 2026 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726631; cv=none; b=R0A2lN07F0kTzPh9EzOjFCZLTQ0x47EBA9Juqb3iBInz+XvNkYiApq6GAEMVYsnt4YppRfYnKeuWjskSFiz96YgYgiF8jUACJR5ctR7XFTNoGHjMqwiRYbFq8WnvJuK7YhbCanzOfE5W5tOvG68Eh0uHrLmO0yrLT+I2iM0HiEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726631; c=relaxed/simple;
	bh=ifyrwe6h27+ZjrRKqNws8Hoy5jINQJxAWqPe8NSyJco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p1A2cCYQCU9jN3hVJFsjs2FXVAUXStIFn2QPLSsg+D1yzo3m3QJpjaNt3YeWXWE+hOFBGYP7/b1nOE6rinQLaVMedY8/vwH3rMDsCxxqI6WjpKxARdELf6L0bul48thNffYayviDsEHhoBIe78sDcgy5X4f4k7p0DclSia+yp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMj01Alh reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMj01Alh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667AE1F00899;
	Fri, 18 Sep 2026 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726617;
	bh=ifyrwe6h27+ZjrRKqNws8Hoy5jINQJxAWqPe8NSyJco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BMj01AlhbDDpoLoXxwn9PPhookstPQzvNzHcu3cfhmO/Vm1xskm1uSEn1VcRtOM63
	 v4FbuEGxl6N6K4hGy9mp3VPfdcYEi9Lt7ZAbiZrOOZJ0H76sH7Yfj41EFFY4kifUUJ
	 U1nyr9h3Wc6OFP7bzybInQVTbPMdB7n385RxAbDMpf0E0z2qmIOuSmMJLA0mzCgRn0
	 REbqAaRoOj6TTCGDA3UVM3ORDYou5nsQBAirRmO25yhfVyCRZefWSTyLWDBVZMDXh7
	 ivKDTJnqkoWlyNwdABc2086K40l/8qfUK9FEg1TIu4WwHLNY/RUoSJ/8Qc7TZFokWg
	 jmShFPclYOnug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/17] LoongArch: kexec_file: Fix CMA page leaks in
 segment placement retry loops
Reply-To: sashiko-reviews@lists.linux.dev
To: maqianga@uniontech.com, mpe@ellerman.id.au, akpm@linux-foundation.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, graf@amazon.com, vishal.l.verma@intel.com, me@linux.beauty, mclapinski@google.com, hpa@zytor.com, sshegde@linux.ibm.com, yeoreum.yun@arm.com, pratyush@kernel.org, eric.devolder@oracle.com, gshan@redhat.com, bgwin@google.com, guodongtai@kylinos.cn, ruirui.yang@linux.dev, ruanjinjie@huawei.com, kernel@xen0n.name, piliu@redhat.com, driver-core@lists.linux.dev, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, lizhengyu3@huawei.com, james.morse@arm.com, chenhuacai@kernel.org, sourabhjain@linux.ibm.com, adityag@linux.ibm.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, robh@kernel.org, npiggin@gmail.com, dakr@kernel.org, ritesh.list@gmail.com, takahiro.akashi@linaro.org, thuth@redhat.com, linux-mm@kvack.org, liukexin@kylinos.cn, palmer@rivosinc.com, rppt@kernel.org, x86@kernel.org, coxu@redhat.com, loongarch@lists.linux.dev, bp@alien8.
 de, ardb@kernel.org, zhangtianyang@loongson.cn, chleroy@kernel.org, chao.gao@intel.com, linuxppc-dev@lists.ozlabs.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, maddy@linux.ibm.com, blum@kernel.org, seanjc@google.com, gregkh@linuxfoundation.org, baoquan.he@linux.dev, pasha.tatashin@soleen.com, rafael@kernel.org, tglx@kernel.org, kas@kernel.org, hbathini@linux.ibm.com, tangyouling@kylinos.cn, jbouron@amazon.com, kees@kernel.org, will@kernel.org, leitao@debian.org, mingo@redhat.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-7-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:16:54 +0000
Message-Id: <20260918101654.667AE1F00899@smtp.kernel.org>
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
135-1-ruanjinjie@huawei.com?part=3D6

