Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36BC4B44B4;
	Fri, 18 Sep 2026 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726279; cv=none; b=beZfXtijSbyURuUMhSWQXp1bBPx/Yr3yShPBoThQpSCwBEHvt4iulL1zdEiYwPcwEq8WG1uG0sjoWOksce9Q4PukUoCFlkRiYf+Gmm1zFkTXgytgI0YFFiqyA5bcemSgz+efvEE/Av9fUzAVhbP3s9J2M30i/GRyyU9S4cvX0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726279; c=relaxed/simple;
	bh=EbvgUlDhMfv5xqDyq41yarwe4vF9IcejR9w9IshiD48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S3irTf8kSZuYnos3QVqLoLLFZ75nA9umR/6Z4HdCaURkPehGKCvjqWPjnPXANvY0Sew27bZDqzsIdLe+QmOYIXVNkrz83iOXUaTaltnCrKqRN9DnlnAQNadCOV+9yybv+8lbzpG9oZScnWLhRdltvpeUW+S9F18Ze//ZANfi5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llH/FkFI reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llH/FkFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCD41F000FF;
	Fri, 18 Sep 2026 10:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726277;
	bh=EbvgUlDhMfv5xqDyq41yarwe4vF9IcejR9w9IshiD48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=llH/FkFITAB5xWYHwFUPLbdE2EaF3GC1eSoCiDjrZavq4ujmqfQALeKu52aFVVMuR
	 pBuHSv80cKI3j9Mho4y3xdPug+GfNG/zgAkh8wZ7OoahnhoGS7E5dhRdqhsQ+I51pr
	 f7NWcn+fOKRoo9iweVcxsXDWvRhgpceUNC6h8Ptlkps8SWZs2CmTh5980BC6sEHNlB
	 0CM2Rk/czy1YuvNhpd/QUpJNpu47BkJRGDZBlBtd4x1ODrJ76w2qvFvIEJ442SLha5
	 zUwFARxcYBBM4yGx2Endjllgko7Mxt/Jea4yXamZO8XPgdLllRtjg2f1JDx3w8mdGp
	 uPU0nMOTpRphQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/17] crash: Extract crash_get_memory_ranges()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: maddy@linux.ibm.com, tglx@kernel.org, loongarch@lists.linux.dev, hbathini@linux.ibm.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, guodongtai@kylinos.cn, jbouron@amazon.com, thuth@redhat.com, mark.rutland@arm.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, gshan@redhat.com, sourabhjain@linux.ibm.com, chao.gao@intel.com, piliu@redhat.com, eric.devolder@oracle.com, baoquan.he@linux.dev, pratyush@kernel.org, ruirui.yang@linux.dev, bgwin@google.com, chenhuacai@kernel.org, linux-arm-kernel@lists.infradead.org, maqianga@uniontech.com, bp@alien8.de, tangyouling@kylinos.cn, mingo@redhat.com, driver-core@lists.linux.dev, blum@kernel.org, takahiro.akashi@linaro.org, coxu@redhat.com, linux-mm@kvack.org, palmer@rivosinc.com, akpm@linux-foundation.org, ruanjinjie@huawei.com, vishal.l.verma@intel.com, npiggin@gmail.com, dave.hansen@linux.intel.com, liukexin@kylinos.cn, hpa@zytor.com, chleroy@kernel.org, sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, robh@kernel.org, lizhengyu3@huawei.com, leitao@debian.org, yeoreum.yun@arm.com, kees@kernel.org, linux-fsdevel@vger.kernel.org, mclapinski@google.com, james.morse@arm.com, pasha.tatashin@soleen.com, dakr@kernel.org, will@kernel.org, zhangtianyang@loongson.cn, me@lin
 ux.beauty, ritesh.list@gmail.com, gregkh@linuxfoundation.org, kernel@xen0n.name, seanjc@google.com, x86@kernel.org, rppt@kernel.org, rafael@kernel.org, graf@amazon.com, adityag@linux.ibm.com, mpe@ellerman.id.au, ardb@kernel.org, kas@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-11-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-11-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:11:14 +0000
Message-Id: <20260918101115.1FCD41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> Factor out the crash memory range collection logic from
> crash_prepare_headers() into a separate function. This allows
> the memory hotplug path to obtain and modify the range list
> (e.g. remove offlined memory) before generating the elfcorehdr.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D10

