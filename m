Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970AA3845B0;
	Fri, 18 Sep 2026 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726946; cv=none; b=uz2f7cFTfLOEKZqURefejs0LIrcUhnFf2ZuGz5FRqkYKSRZqyHzUYCZ//4rciAMfhLJQPloAofmWeRrbKWGLd/hw0AkFP5nUkYD6og0y10LBUMTjdIOuy/vEfNFoAavm7zsdYsEalg+OLGX7u1gn0Da05ydnhIsSDRswhx3DIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726946; c=relaxed/simple;
	bh=sHYNy5wwK9fmryuUm9WuegCfsJ5nAR1Rndu3nKXnWCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ETxTpFI3KDFIFeiwowtLT7eFdG5D89V0xTEdMXH5Z66k33u7Wz+CL4Td5M9pOkw2fm+/UJxFruiYDFQ7X18jiNek3b1bEQ3t7owBUzRUmh58sTAC/qGYOldmp/RevcWjmXyBneG7n8x2FAO0ytMDic+ZERsaCOlKDlU68yNhmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc0rbtes reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc0rbtes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA691F000FF;
	Fri, 18 Sep 2026 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726945;
	bh=sHYNy5wwK9fmryuUm9WuegCfsJ5nAR1Rndu3nKXnWCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oc0rbtes9P5pCgieiV/VOaF4yxIo3bihzqlKgZzfBIMfnz2VHuU6zRiW4ajSUXtnm
	 uVE5FocXY1Yhiy4t8pnIJoR3/BnczzB9iCs51LhoCpGiksebj3Qt2pLRsukqoUpYEm
	 REf0NPHz8XkXAdp50l1exaR1wvGNu10DTsFYjcPy6aKz14s9a4O/je6de4IvC6GLg0
	 A1DaIKk9DyKxib5oxpK9DguKSuVOC9vs7GO3t+W6NbvNJEh57V+Ns6VoIsyvecixuE
	 bSGzwYp/Fe+PLbPTDSWWY8CwW7XXF44rEsII/FQ6ZPKK3hgeuSTBltWF4ZWzp1WTW9
	 X3l1tPtzei24Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/17] kexec: Fix CMA segment address translation
 with non-zero text_offset
Reply-To: sashiko-reviews@lists.linux.dev
To: loongarch@lists.linux.dev, pratyush@kernel.org, kas@kernel.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, kees@kernel.org, rppt@kernel.org, rafael@kernel.org, linux-mm@kvack.org, kernel@xen0n.name, dakr@kernel.org, maddy@linux.ibm.com, catalin.marinas@arm.com, robh@kernel.org, chleroy@kernel.org, ritesh.list@gmail.com, thuth@redhat.com, ruirui.yang@linux.dev, npiggin@gmail.com, mclapinski@google.com, graf@amazon.com, eric.devolder@oracle.com, vishal.l.verma@intel.com, leitao@debian.org, ardb@kernel.org, x86@kernel.org, bgwin@google.com, driver-core@lists.linux.dev, me@linux.beauty, mpe@ellerman.id.au, chenhuacai@kernel.org, takahiro.akashi@linaro.org, james.morse@arm.com, chao.gao@intel.com, liukexin@kylinos.cn, seanjc@google.com, palmer@rivosinc.com, pasha.tatashin@soleen.com, gshan@redhat.com, hbathini@linux.ibm.com, coxu@redhat.com, will@kernel.org, ruanjinjie@huawei.com, maqianga@uniontech.com, piliu@redhat.com, guodongtai@kylinos.cn, baoquan.he@linux.dev, sourabhjain@linux.ibm.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutl
 and@arm.com, mingo@redhat.com, yeoreum.yun@arm.com, akpm@linux-foundation.org, bp@alien8.de, linuxppc-dev@lists.ozlabs.org, adityag@linux.ibm.com, hpa@zytor.com, zhangtianyang@loongson.cn, dave.hansen@linux.intel.com, lizhengyu3@huawei.com, tangyouling@kylinos.cn, blum@kernel.org, tglx@kernel.org, jbouron@amazon.com, linux-arm-kernel@lists.infradead.org, sshegde@linux.ibm.com, gregkh@linuxfoundation.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-2-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:22:21 +0000
Message-Id: <20260918102222.0EA691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> kimage_load_cma_segment() and kimage_map_segment() translate a CMA
> segment to a kernel virtual address with page_address(cma), ignoring
> segment->mem. But arm64's image_load() adds text_offset to segment->mem,
> so the kernel payload is copied to the wrong offset while image->start
> points past it, and kexec jumps into the middle of the kernel.
> kimage_map_segment() has the same problem for any CMA segment whose mem
> was moved.
>=20
> Add kimage_cma_vaddr() to translate a boot physical address inside a CMA
> segment to its virtual address, and use it in both places.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Pingfan Liu <piliu@redhat.com>
> Cc: Justinien Bouron <jbouron@amazon.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D1

