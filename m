Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532840D576
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781430087; cv=none; b=X0p+WdoZ9hwPq0TaXt3pojDysNKRVp0He9qvHDvgL3lniQhUTtcWGd63wRgZyvtUKznlqYJF+gtyl834qc1Sx6PxVZIOuDiNs2CVbJwpcXvQrrOcXfAmizomXNH/k5mGYyJgGt6uxSBeNCmNHjadyA1eMDL8hPrOY20qee/q7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781430087; c=relaxed/simple;
	bh=htRbPhnmI0Q7zbPGHmmpYE56eD5t0fPvtymFYGdYU6s=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=mpWd4Ea2/L7N6nED5zVMI4iGpZd4KFhvQNcGLY7u8isDq0BsbvFJJa/0j7RFFiF8nctSk9ibZuO6LVBukprVwian85eIhM8GHcCxgPLfi6drLUbK24BxHq99yCe3zXECsBzirnAGki7yQLgmOqX4PguOYsPqAyNVuS/ceGQUTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ACpzmtzP; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ACpzmtzP"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260614094117epoutp0482f795b8fb050e6bda6ffb20f268144e~46TePukL52388123881epoutp048
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 09:41:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260614094117epoutp0482f795b8fb050e6bda6ffb20f268144e~46TePukL52388123881epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781430077;
	bh=c10yNbrFXneieObebopqp/M64tMqvfZfGb2DL9uARpU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=ACpzmtzPo6vx5D8oo0J1Rsen72nmsVDCM/fg2P3+uVpqmpTsd08JZw9pRQzmu0nY4
	 QigRZL8mTcayAd9LEK4rAinqOEPMul1gMVUXWnSf6RO2oXM7j6eq77L3rhjNZEETBe
	 j9wfQikFQaFD3n88CWgPv94Iz7CJU3oMKAk67yvM=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20260614094116epcas1p3e4df91a880840d7890a32249c04094dd~46TdXuXo40905809058epcas1p3q;
	Sun, 14 Jun 2026 09:41:16 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.119]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4gdSth275lz2SSKX; Sun, 14 Jun
	2026 09:41:16 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260614094114epcas1p1c29a2c017e9791fd43aeda4327663d7a~46Tb3Mc0e2304723047epcas1p18;
	Sun, 14 Jun 2026 09:41:14 +0000 (GMT)
Received: from W11PB11713 (unknown [10.91.160.69]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260614094114epsmtip234d9e533518cdc49407ae4a83304adee~46TbyT6vY0889608896epsmtip2Y;
	Sun, 14 Jun 2026 09:41:14 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Yang Wen'" <anmuxixixi@gmail.com>, <linkinjeon@kernel.org>
Cc: <yuezhang.mo@sony.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cpgs@samsung.com>,
	<sj1557.seo@samsung.com>, <sjdev.seo@gmail.com>
In-Reply-To: <20260613133856.238740-1-anmuxixixi@gmail.com>
Subject: RE: [PATCH v2 0/1] exfat: reduce directory scans during file
 creation
Date: Sun, 14 Jun 2026 18:41:14 +0900
Message-ID: <000001dcfbe1$f1341d10$d39c5730$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGbhcuwXyd99kU9K9PfQeBinsaqrQKSFDtBtqwjvUA=
Content-Language: ko
X-CMS-MailID: 20260614094114epcas1p1c29a2c017e9791fd43aeda4327663d7a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-711,N
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260613133917epcas1p183cb2d5b2c82fa1651a96364cd8efda8
References: <CGME20260613133917epcas1p183cb2d5b2c82fa1651a96364cd8efda8@epcas1p1.samsung.com>
	<20260613133856.238740-1-anmuxixixi@gmail.com>

> Creating files in a large exfat directory may require repeated linear
> directory scans.
> 
> After an empty-entry hint is used successfully, the remaining contiguous
> empty entries are not retained for the next create operation.
> This can cause subsequent operations to rediscover available directory
> space.
> 
> In a test creating 20,000 files with random names and sizes between 1 KiB
> and 4 KiB in one directory, the elapsed time changed as follows:
> 
>   Before: 3879 seconds
>   After:  3050 seconds
Hello, Yang Wen,

As Namjae reviewed, we intentionally drop the dentry in LOOKUP_CREATE to
maintain the case of newly created filenames. Therefore, when creating
a new file, a brute-force search of the entire directory is required,
and the hint value is naturally updated during this process.

For this reason, I believe this current patch will not improve performance
and is an unnecessary operation. Is there any performance gain with the
current patch, excluding the dropped part?

> 
> ---
> 
> Changes since v1:
> - Drop the LOOKUP_CREATE negative dentry change.
> - Make exfat_cache_next_empty_entry() return void and skip caching if
>   exfat_chain_advance() fails.
> 
> Yang Wen (1):
>   exfat: preserve the next empty-entry hint after allocation
> 
>  fs/exfat/namei.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> --
> 2.34.1


