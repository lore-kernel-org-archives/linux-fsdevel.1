Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08147A0C2;
	Mon, 21 Sep 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987928; cv=none; b=jmOBe14X82EScC8rlcEdJYcWqygTmDRq8N1GbvuLt6vvRb+Pk59uaIhi/lRnpBeGuuQFcXbS/9+Dgj9vYdJdT3ja6HWb5WsH9DdaITV0kfoUS9Geni51UVvMtlqQdxqq9C/jgU+jVklzvjww8AcKEhrIYuweCzqf5ZnR8SqL1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987928; c=relaxed/simple;
	bh=2yOjYAIF6je5Usz2jDPKonU9S52y0hEoyOxYx5vVbgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CDjDK7nrdORfni3Vy1/FCPLIqepmGWYWKAP4yLSCMBsxFm3LVM3nQleeCaAkWzpdMvVlWAd88xG6/KnnpgFYeu5+KaV1djLDlnBMG+DgflLmqL/0LE35gwx04Fa/AyAQyNgQtfQ4GS1pvuZIQFii8Tj4JY8m3CoFoXLDq1KFgpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2/ARBWL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2/ARBWL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5001F000FF;
	Mon, 21 Sep 2026 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789987926;
	bh=lKLJe92aVR8cHrhFneRg88j7sXG35q2Vmlm5uDiLVCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T2/ARBWLeGHSlrpe4bAuhGSmBr44RpxAcaS/cxFBl4fXDBa3EI5IlTzo24WpaT1Hq
	 qZOfLdgZPnNhOq20bPiPe/39LIway+9pUZTzPtxojeCaI3l1ryq5eRd2fbxJEubTKA
	 lH4Twe0HbBXnS089Sv0Xn9Gx0U//qlfNk+tqGJX83vwg2llOcXApa9MV5DYBgtVctS
	 bxkhQeGvJ21vi0su0SkSt/zm0POeIFDdrEKGRBe/FH/5FU8DXCp+R2FsGhhWZ0suHk
	 +MD2sD9GH75WQMXAEzreFe+cNwnprmgXVUe3lRD+9SAgKev1wo1fhBkPTJI4INcD+l
	 TIAXZ5Ufb4j3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vmcore: report the release of the crashed kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, kernel-team@meta.com
In-Reply-To: <20260921-kdump_print-v1-1-e445fec3177c@debian.org>
References: <20260921-kdump_print-v1-1-e445fec3177c@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:52:05 +0000
Message-Id: <20260921105205.9A5001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> kdump runs in a very small environment and cut-down set of drivers, and
> it can die before the dump lands: it runs out of memory, a device hangs
> on reset, or a watchdog fires while the dump is still being written out.
> This happens about a single high digit percentage on most of big scale
> datacenters.
>=20
> When that happens the only evidence left is what the capture kernel
> printed to the console, and that does not say which kernel crashed.
>=20
> A fleet typically pins one kdump image and boots it after crashes from
> many different production kernels, and it is useful to understand what
> are the combination of crashed kernel panic and succesful kdump
> collection.
>=20
> Whether the dump completes at all tends to depend on the kernel that
> died: memory pinned, devices in flight, dump size.
>=20
> The release is already recorded.  crash_save_vmcoreinfo_init() puts
> OSRELEASE=3D in the VMCOREINFO note, and by the time vmcore_init() has run
> parse_crash_elf_headers() that note sits in elfnotes_buf.  Walk the notes
> for it and print:
>=20
>   vmcore: dump is from kernel 7.3.0-rc3-next-20260917
>=20
> Given this is cheap and useful, I think it is worth adding to vmcore, to
> improve kdump monitoring.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-kdump_prin=
t-v1-1-e445fec3177c@debian.org?part=3D1

