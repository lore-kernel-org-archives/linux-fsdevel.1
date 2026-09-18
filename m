Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3AF492502;
	Fri, 18 Sep 2026 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726746; cv=none; b=Kctz+kaTFLpnJCvIxBIE+2F9dcZmH33nElszwX2zCiwgbMBt44l89Zoc1hr5xZUvfzylVpR3ujwq1T9MTjDzy9WBgCEZqhydT5DMDVPlLfGRxms40+TXOygz1XUErgdd3OIAulNTDOFiYXf9cZ+k2pp8rYHK97/Xptf/2Uudk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726746; c=relaxed/simple;
	bh=Rqnh50ypEVFT5a+D28kaRAZjWeTUwOVoXD4Kp4ZAXkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ry/MPo6oVhFYAIMCKKOBaK/kTiyXdKROXNyaAdfBnRvcC/OE5sG8kknKDIBcUvhIJYIMWZW+YjFwhKvsgt8oUhhOPixdYqlCHMVAGsP0onPh71E9DndCUpn0QPywCPT2QflPNSSwEnn7dp79ZAZ4o9k6jTuzs1EzVIAWwjRrheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nih+Cgdh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nih+Cgdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A10E1F00898;
	Fri, 18 Sep 2026 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726737;
	bh=NK4q4bMTc4NtuqUZq2p2ouZ93CvhS6B9qDA0XHB+AQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nih+CgdhGnLO8TOeDlPBdKPirdBoHe0i3bMXikC3kG5yEMeDAdT/7gzT4yWuBpvZx
	 W7cUWDlxizNzUCQLwfXs94uynL6mjAM7ePcKxhgXkPT+1qBU4XiAVkZUxCID7DY2Jb
	 +goXUKIBVWZDUgSR4iPriXVvwYXN8d8X9H82/VSmmMSLI/OoaAUWelD4FsQaZZammh
	 eYyGUgPR2fj74PNv1XQ3/oKvNKleNUqhIx12OPwpZiHqNhqR9DXO1fQvv8HQ/XlO0M
	 vmZ3I07NIFGVT6o1Dcu0cuUd02YdMq7cV0HFTHOA46CJjQwBsUjh8NbSWls+LhVb5U
	 tjgTt00+qSZbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/17] LoongArch: kexec_file: Fix a modified_cmdline
 leak
Reply-To: sashiko-reviews@lists.linux.dev
To: rafael@kernel.org, mingo@redhat.com, leitao@debian.org, graf@amazon.com, ritesh.list@gmail.com, coxu@redhat.com, sshegde@linux.ibm.com, catalin.marinas@arm.com, bp@alien8.de, blum@kernel.org, chao.gao@intel.com, linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org, jbouron@amazon.com, eric.devolder@oracle.com, palmer@rivosinc.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, hbathini@linux.ibm.com, rppt@kernel.org, james.morse@arm.com, will@kernel.org, maddy@linux.ibm.com, chleroy@kernel.org, dave.hansen@linux.intel.com, sourabhjain@linux.ibm.com, mpe@ellerman.id.au, baoquan.he@linux.dev, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, gshan@redhat.com, gregkh@linuxfoundation.org, lizhengyu3@huawei.com, adityag@linux.ibm.com, tglx@kernel.org, guodongtai@kylinos.cn, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, me@linux.beauty, hpa@zytor.com, x86@kernel.org, piliu@redhat.com, ardb@kernel.org, takahiro.akashi@linaro.org, npiggin@gmail.com, maqianga@uniontech.com, mclapinski@google.com, yeoreum.yun@arm.com, kernel@xen0n.name, vishal.l.verma@intel.com, bgwin@google.com, driver-core@lists.linux.dev, seanjc@google.com, kas@kernel.org, tangyouling@kylinos.cn, pasha.tatashin@soleen.com, zhangtianyang@loongson.cn, ruanjinjie@huawei.com, ruirui.yang@linux.dev, kees@kernel.org, thuth@redhat.com, linux-arm-kernel@lists.infradead.org, liukexin@kylinos.cn, dakr@kernel.org, pratyush@kernel.org, robh@kernel.org, mark.rutland@arm.com, loongarch@lists.linux.dev
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-9-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:18:54 +0000
Message-Id: <20260918101854.7A10E1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> load_other_segments() allocates modified_cmdline and stores it in
> image->arch.cmdline_ptr.  machine_kexec_prepare() then copies it to
> KEXEC_CMDLINE_ADDR and overwrites the pointer, so the heap buffer is
> leaked on every successful kexec_file_load().
>=20
> Free the buffer after the copy.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Kexin Liu <liukexin@kylinos.cn>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: Qiang Ma <maqianga@uniontech.com>
> Cc: Tianyang Zhang <zhangtianyang@loongson.cn>
> Cc: George Guo <guodongtai@kylinos.cn>
> Cc: stable@vger.kernel.org
> Fixes: d162feec6b6e ("LoongArch: Add preparatory infrastructure for kexec=
_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D8

