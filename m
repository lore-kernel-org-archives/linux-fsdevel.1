Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74544F3EC7;
	Fri, 18 Sep 2026 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726606; cv=none; b=acnYeKKXOHtL+4BV+Mv9a3YmNIlmsbdbSfXsmUZ0ps/CzwgWtOU7lO8V1LOeJ1xkRoguYDG3eHqNAWpxvQFuw5Hw2ry4a1P6NsrW6dTHcHH7NoZunZGFiR6gj1WOL/4i1Rjl6lG5+by/29Myi+OTOPsPo4DZ9EuUb4IKmzLz7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726606; c=relaxed/simple;
	bh=IUDFRBGa2RG1qXFNOqbXn+eZ7VMhk9nNvTSQAVzvNNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F64HiWyJwHHYohIYMVEfMLMh6aglEQNoKEoAD1ZK35wEusk30+GictWf6g+SLG0HnJnDqLqyF5U53j7/pAKoY4+dRZ4Y3NKPQCYKMT38l1Vbb4ZAfjCbDM+Pi79lwNKumGt0jp6AvtR38Ktr+D+LryMt1yWJw1tSvR5hq/xn8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPNSou3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPNSou3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39531F000FF;
	Fri, 18 Sep 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726596;
	bh=IUDFRBGa2RG1qXFNOqbXn+eZ7VMhk9nNvTSQAVzvNNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cPNSou3IuShNKs2wqjrBJbH6XQctu6cWqLaMc++I1FCOeysna31efy1k8r1o8USDO
	 2KqcArHiYXdTZ+TCjG/tGsBMKjgm0re02mhBVnEtqMPm6TY1HXd/oDObyk5RBwAemO
	 jATEzxTr7dl4SGEuYHCs0/sMh9/aDZWRxCUGgiAaKdBlebXVmL6UJvtC61NzE0id6H
	 jhaWLG2USeHwgB16NAE4AhrbRZEmLVBnc7w0vh5qLGmVn+sfh2LwhNAQzWtMCKSqyr
	 Mu6jRStNkeupLKN8zuiSxlhEUKsG9ytbHpOCM4iRwDSrdR9sKb4gq/5t73W9G3xoen
	 jXkRNjs+uULHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/17] x86/crash: Fix massive out-of-bounds write on
 32-bit Highmem
Reply-To: sashiko-reviews@lists.linux.dev
To: ruirui.yang@linux.dev, rppt@kernel.org, bp@alien8.de, vishal.l.verma@intel.com, linux-arm-kernel@lists.infradead.org, yeoreum.yun@arm.com, chao.gao@intel.com, kernel@xen0n.name, tglx@kernel.org, takahiro.akashi@linaro.org, ritesh.list@gmail.com, hpa@zytor.com, sshegde@linux.ibm.com, kees@kernel.org, tangyouling@kylinos.cn, will@kernel.org, piliu@redhat.com, me@linux.beauty, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, maqianga@uniontech.com, gregkh@linuxfoundation.org, pasha.tatashin@soleen.com, npiggin@gmail.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, thuth@redhat.com, maddy@linux.ibm.com, blum@kernel.org, chenhuacai@kernel.org, mpe@ellerman.id.au, sourabhjain@linux.ibm.com, zhangtianyang@loongson.cn, robh@kernel.org, graf@amazon.com, seanjc@google.com, hbathini@linux.ibm.com, guodongtai@kylinos.cn, rafael@kernel.org, adityag@linux.ibm.com, kas@kernel.org, gshan@redhat.com, coxu@redhat.com, jbouron@amazon.com, liukexin@kylinos.cn, driver-core@lists.linux.dev, mclapinski@google.com, eric.devolder@oracle.com, linuxppc-dev@lists.ozlabs.org, dakr@kernel.org, dave.hansen@linux.intel.com, mingo@redhat.com, ruanjinjie@huawei.com, akpm@linux-foundation.org, ardb@kernel.org, bgwin@google.com, linux-kernel@vger.kernel.org, james.morse@arm.com, lizhengyu3@huawei.com, baoquan.he@linux.dev, loongarch@lists.linux.dev, x86@kernel.org, palmer@rivosinc.com, pratyush@kernel.org, catalin.marinas@arm.com, leitao@debian.org, mark.rutland@arm.com, chleroy@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-10-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-10-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:16:33 +0000
Message-Id: <20260918101633.F39531F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> On 32-bit x86 systems with HIGHMEM, kmap_local_page() only maps a single
> 4KB page. However, the elfcorehdr segment can span several pages (up to
> hundreds of kilobytes).
>=20
> The original code blindly copies 'elfsz' bytes at once via
> memcpy_flushcache(), overwriting adjacent fixmap entries or critical
> virtual addresses.
>=20
> Fix this by copying the new elfcorehdr page by page.
>=20
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Chao Gao <chao.gao@intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Eric DeVolder <eric.devolder@oracle.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
> Link: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%4=
0huawei.com
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D9

