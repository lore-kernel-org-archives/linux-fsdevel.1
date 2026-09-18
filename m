Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722C4C6811;
	Fri, 18 Sep 2026 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726623; cv=none; b=U2EXLacHytXIl4Z/i3w4fxCmNFa1U43iocWVomGW3HYM+0juU5SQgranmn+D+x/2ssCTvvB6Aj+wMO5Z8MgYafdzZPqrOxyXmUBm74tgyESWyqu9vpenj+y9fSJsUjWopD/uNw8gw2/UMJWuePYTtE7Sy2NEXeDTt1NwwHh4aDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726623; c=relaxed/simple;
	bh=VuJOT4kdOpRvZM5empbp0YF0BApQR/2NER1H6HyuVXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AhE0lIYuT5Pgc7NhNTWmLhebkYcoMJcvAu1lnQMRX+bvmH2+FJ9K9qY/ujA3uUORMwSk8wOmlNOSHB61z4fpkckl1jBl/aX5KxPh9Q/FZaxyjR5GrjvISqz06cal8w8CIQ2frPqzm1wTFKffL8g7sH/3DU8HsQ5g8/5YslwyJz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9JXfNnK reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9JXfNnK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC741F000FF;
	Fri, 18 Sep 2026 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726613;
	bh=VuJOT4kdOpRvZM5empbp0YF0BApQR/2NER1H6HyuVXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i9JXfNnKptQjjq63WxDdIuBBUCCL146Poh1RSC+XdoWWB0Fy9dhH0a6kLZUmX1w+W
	 qF3REZ2mxGCNIiOaSwVwjNNaV6NjoRH0sNjvZWq3XRPs6dKW4AZDk1Yede6r8fqzyx
	 o80qLR6AMuSO9xrYinfK9dWCY6zzP/z7rF1NstRvN9oRwP7A4igRkbL4/CMivPIyT9
	 wnnCcsZ+tEz1MqTHyJ+d9y56CfkfVre+2Dy56b5WhLwcyAKGultFUGWzcdJ07WiKeU
	 rZjGFcwvdwgNrDGSmopMB7dJJ/e/9den7VyfEVj7fDrOGtONqMyz83JtmkWwNL2swS
	 Lx0epawLg3Kpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/17] arm64: kexec_file: Fix elf_headers memory leak
 in retry loop
Reply-To: sashiko-reviews@lists.linux.dev
To: maqianga@uniontech.com, dave.hansen@linux.intel.com, dakr@kernel.org, pratyush@kernel.org, vishal.l.verma@intel.com, mark.rutland@arm.com, hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, kernel@xen0n.name, mpe@ellerman.id.au, sourabhjain@linux.ibm.com, eric.devolder@oracle.com, linux-fsdevel@vger.kernel.org, gshan@redhat.com, x86@kernel.org, hpa@zytor.com, lizhengyu3@huawei.com, kees@kernel.org, adityag@linux.ibm.com, ruirui.yang@linux.dev, yeoreum.yun@arm.com, chao.gao@intel.com, ardb@kernel.org, piliu@redhat.com, graf@amazon.com, james.morse@arm.com, zhangtianyang@loongson.cn, tglx@kernel.org, will@kernel.org, rppt@kernel.org, rafael@kernel.org, pasha.tatashin@soleen.com, thuth@redhat.com, akpm@linux-foundation.org, blum@kernel.org, palmer@rivosinc.com, coxu@redhat.com, linux-arm-kernel@lists.infradead.org, chenhuacai@kernel.org, robh@kernel.org, seanjc@google.com, linux-kernel@vger.kernel.org, bp@alien8.de, takahiro.akashi@linaro.org, bgwin@google.com, maddy@linux.ibm.c
 om, linux-mm@kvack.org, liukexin@kylinos.cn, catalin.marinas@arm.com, chleroy@kernel.org, mingo@redhat.com, ruanjinjie@huawei.com, tangyouling@kylinos.cn, jbouron@amazon.com, ritesh.list@gmail.com, sshegde@linux.ibm.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, gregkh@linuxfoundation.org, leitao@debian.org, me@linux.beauty, baoquan.he@linux.dev, loongarch@lists.linux.dev, npiggin@gmail.com, kas@kernel.org, mclapinski@google.com, guodongtai@kylinos.cn, driver-core@lists.linux.dev
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-6-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:16:50 +0000
Message-Id: <20260918101650.9FC741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> If load_other_segments() fails after image->elf_headers is assigned,
> the memory lifecycle is safely managed by the global kimage object
> and will be freed in arch_kimage_file_post_load_cleanup().
>=20
> However, during a retry loop in image_load(), a subsequent iteration
> will allocate a new buffer and overwrite image->elf_headers. This
> permanently leaks the stale memory from the previous iteration before
> the global cleanup can track it.
>=20
> Fix this by explicitly freeing the stale `image->elf_headers` buffer
> before assigning the newly allocated headers.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 108aa503657e ("arm64: kexec_file: try more regions if loading segm=
ents fails")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D5

