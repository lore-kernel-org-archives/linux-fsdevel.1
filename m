Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29633557F3;
	Fri, 18 Sep 2026 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727482; cv=none; b=ZuaxUWw8lr2HCuEy2wYvyjpEncBfmAkFtdBCE/kczkv2tQoxb+Alil0kqAME6t1W1k0CmmKT5Zp6IOa8tC3xpXfQ+68Avz8YWaSL8NA9NFGnfgRcidfCrXBbDNM+wIyTmGQNT2b5pnE2ksXu3rgouB6qXaHhUhorAV1+KbV4KXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727482; c=relaxed/simple;
	bh=WohlUBKAOnI1ycYrmAz9a4uYAu2BUt+wB1nDP7KO/ug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L0p8ac2Yw3UMQBv8YWnqpKqz6ijTlDYjm5UGPIzVt4YwiIQUOpFsOHlqPmYNstKK7Cjf5zqtRChrkYY3tnhvkv3X9B22iVIbsU+adQD9S7yITHFspb7gxTx2EVcs0MLhgA04Q5/j3PKIbOzVPh68pUOsUBiO/YeziR1Qj/IKxzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4IsE2dE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4IsE2dE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741621F000FF;
	Fri, 18 Sep 2026 10:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727480;
	bh=WohlUBKAOnI1ycYrmAz9a4uYAu2BUt+wB1nDP7KO/ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4IsE2dENzW5204Qi8D7Aq+qhe6TkI4pWZ4xDgTIhfw9ed/XtIK5tfxl8+yCcICC4
	 Dymcq8txAd0AjT2q3l8IwlI8B563zHCLB5HMuAOnTzfCQwWuCfkN9buTwRaFNBwk6J
	 wIlawl87RShg2Qmf/1CfzSShnRYNoMz7czRzo6x2/vHe6XlthNlrzUQIGAB8olUV6V
	 q4OjPaCfD4y0E/Hg+Tkq/aCRCfI4ubLfdpHPFhkUF9Z5NsCCbEGKRRutdxEoTkrrCa
	 9xFhLj4ygDBWKboxOoR1+RkSeIIqSN3RTLAchc9X/WWqsc7PKxOpDuDrnt7bmhriSG
	 McaM840XqhQ4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/17] crash: Introduce crash_extra_elfcorehdr_size()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: hpa@zytor.com, robh@kernel.org, leitao@debian.org, linuxppc-dev@lists.ozlabs.org, tglx@kernel.org, rafael@kernel.org, thuth@redhat.com, dakr@kernel.org, driver-core@lists.linux.dev, kas@kernel.org, coxu@redhat.com, linux-fsdevel@vger.kernel.org, ruirui.yang@linux.dev, dave.hansen@linux.intel.com, kees@kernel.org, tangyouling@kylinos.cn, yeoreum.yun@arm.com, linux-mm@kvack.org, rppt@kernel.org, will@kernel.org, eric.devolder@oracle.com, ardb@kernel.org, linux-kernel@vger.kernel.org, chao.gao@intel.com, sshegde@linux.ibm.com, x86@kernel.org, hbathini@linux.ibm.com, liukexin@kylinos.cn, mingo@redhat.com, mclapinski@google.com, bgwin@google.com, james.morse@arm.com, pratyush@kernel.org, pasha.tatashin@soleen.com, loongarch@lists.linux.dev, kernel@xen0n.name, adityag@linux.ibm.com, npiggin@gmail.com, vishal.l.verma@intel.com, akpm@linux-foundation.org, ruanjinjie@huawei.com, lizhengyu3@huawei.com, linux-arm-kernel@lists.infradead.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, blum@kernel.org, takahiro.akashi@linaro.org, palmer@rivosinc.com, gshan@redhat.com, maqianga@uniontech.com, mark.rutland@arm.com, baoquan.he@linux.dev, jbouron@amazon.com, zhangtianyang@loongson.cn, ritesh.list@gmail.com, me@linux.beauty, mpe@ellerman.id.au, chleroy@kernel.org, piliu@redhat.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, graf@amazon.com, bp@alien8.de, chenhuacai@kernel.org, sourabhjain@linux.ibm.com, seanjc@google.com, guodongtai@kylinos.cn, maddy@linux.ibm.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-16-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-16-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:31:16 +0000
Message-Id: <20260918103117.741621F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> Extract the elfcorehdr extra space calculation from powerpc into a
> generic helper crash_extra_elfcorehdr_size() for use by other
> architectures like arm64.
>=20
> Strengthen the original powerpc check: instead of only checking
> the loose CONFIG_CRASH_MAX_MEMORY_RANGES, the new helper enforces
> a strict compile-time BUILD_BUG_ON() to guarantee that the absolute
> maximum theoretical number of ELF Program Headers will never exceed
> the ELF physical limit of PN_XNUM. This ensures absolute safety across
> all architectures with zero runtime overhead.
>=20
> The helper also provides a zero-size stub when crash memory hotplug
> is disabled.
>=20
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D15

