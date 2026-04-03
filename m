Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881B386427
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206088; cv=none; b=GT2ymu/2bzqxCEPtwFkkXr84/wvVWagd8SsOoQKWx3rPmHFsoI9pX7O2uUFnquXgSihYXSUTj4ZU1wULVwAnPz+ROQJklyHRDUxm9FMsIIH4EW/gwL046amlzhaskxPFcw7ZnjkOpqocVrq0QccYLQ0OJnT91O88QlXu9DU7EPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206088; c=relaxed/simple;
	bh=zU/t5KipFIQbsAF3m0SISO2xS6NUB5j16fX32drG91Y=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=YC/J8uRlopUERKHM+ZcyOexajvkU7frC5BYMN+ntpXkK0ihU/pACb3SSOmKbClNHnf+9dRZZuJR4UCLfkozcYsbudJu5s240u06vO47iFM7Ev6lRn/meM7c7E4LZxA/my03FW2paKCSnPAmZcc4J4iVoapvyAiNWnob805ICjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Op/dJeiE; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Op/dJeiE"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260403084803epoutp04814db5015a60ff98a05a2016ec6195f6~izIcaggDL0087200872epoutp043
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 08:48:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260403084803epoutp04814db5015a60ff98a05a2016ec6195f6~izIcaggDL0087200872epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1775206083;
	bh=hLWX87A32xwXRwZ3/1uIiPb7RxKgSeVT/Xov7YP57I4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Op/dJeiEik+97xfNv51iToB9Zbhc2z1YlME6PudnVjVVhXHs9/vehUtYmy4Rz76J+
	 iJxaaK9QYRw06Fn76l3UgKZ0VqSo9USXxRs1JlKQ/S98sTlB+C+j6iqz6vr0HRzK+8
	 FaigXMG4b9WpHExNNR0YEKouSbtUNE9SuT5fBYd8=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20260403084803epcas1p1979c6f19f9a8118595f375e37a647099~izIcIShdX2366923669epcas1p1G;
	Fri,  3 Apr 2026 08:48:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fnC6W3CwXz2SSKX; Fri,  3 Apr
	2026 08:48:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20260403083841epcas1p37e1d9119f679976d4a965faa33fc7f8e~izAQSjX1_0342003420epcas1p3q;
	Fri,  3 Apr 2026 08:38:41 +0000 (GMT)
Received: from W11PB11713 (unknown [10.91.160.69]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260403083840epsmtip1396997d24b7e1797661d25ca2afc09e5~izAQPEgTI1195811958epsmtip1w;
	Fri,  3 Apr 2026 08:38:40 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Chi Zhiling'" <chizhiling@163.com>, "'Namjae Jeon'"
	<linkinjeon@kernel.org>, "'Yuezhang Mo'" <yuezhang.mo@sony.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "'Chi
 Zhiling'" <chizhiling@kylinos.cn>, <cpgs@samsung.com>,
	<sj1557.seo@samsung.com>
In-Reply-To: <20260403080538.361663-1-chizhiling@163.com>
Subject: RE: [PATCH v3 0/6] exfat: unify FAT chain walking helpers
Date: Fri, 3 Apr 2026 17:38:40 +0900
Message-ID: <1368594774.61775206083439.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJYPEif2iJoO64af6gWLEDtNAYxEQKy9/iMtMB5VyA=
Content-Language: ko
X-CMS-MailID: 20260403083841epcas1p37e1d9119f679976d4a965faa33fc7f8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260403080638epcas1p34e96a9d3f74f963d1085f67399f51da2
References: <CGME20260403080638epcas1p34e96a9d3f74f963d1085f67399f51da2@epcas1p3.samsung.com>
	<20260403080538.361663-1-chizhiling@163.com>

> This series introduces and uses two new helpers to simplify FAT chain
> walking logic across the exfat driver:
> 
> 1. exfat_fat_walk - walks FAT chain by a given step, handling both
>    ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes
> 
> 2. exfat_chain_advance - walks an exfat_chain structure by a given step,
>    updating both ->dir and ->size fields atomically with proper boundary
>    checking
> 
> These helpers replace open-coded cluster walking logic in dir.c, namei.c
> and inode.c, improving code readability and ensuring consistent error
> handling for corrupted FAT chains.
> 
> Also includes a fix for incorrect directory checksum when renaming a file
> to a shorter name.
> 
> ---
> 
> Changes in v3:
> - rework exfat_chain_advance
> - add error handling in exfat_find_location
> - misc tweaks

The patch-set looks good to me:
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

Thanks.
> 
> v1:https://lore.kernel.org/linux-fsdevel/20260331091113.20882-1-
> chizhiling@163.com/
> v2:https://lore.kernel.org/linux-fsdevel/20260401071138.114836-1-
> chizhiling@163.com/
> 
> 
> Chi Zhiling (6):
>   exfat: fix incorrect directory checksum after rename to shorter name
>   exfat: introduce exfat_cluster_walk helper
>   exfat: use exfat_cluster_walk helper
>   exfat: remove NULL cache pointer case in exfat_ent_get
>   exfat: introduce exfat_chain_advance helper
>   exfat: use exfat_chain_advance helper
> 
>  fs/exfat/dir.c      | 119 +++++++++++---------------------------------
>  fs/exfat/exfat_fs.h |  44 +++++++++++++++-
>  fs/exfat/fatent.c   |  23 ++++-----
>  fs/exfat/inode.c    |  11 +---
>  fs/exfat/namei.c    |  28 +++--------
>  5 files changed, 91 insertions(+), 134 deletions(-)
> 
> 
> base-commit: 4129a3a2751cba8511cee5d13145223662a8e019
> --
> 2.43.0



