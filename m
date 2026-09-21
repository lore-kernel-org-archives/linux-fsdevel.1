Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2644D031
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983843; cv=none; b=LyYT1EOKKc9Ly1qgKbpoFmDSVTrf4helKr39JZiRdsJeIIWn+35N4l67KHcXiuKKVDPitAeczgkztK10ZWccLoSxpTx2OXhY9K74EQPMTWCbryAun+4EZMg2PuN6IsUujzAuJVTIPRUAoaKREZ7WqhkQh+spYP8zkdzKOYvGdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983843; c=relaxed/simple;
	bh=ZDmeZ+1x5alOsdwMUDNjLyyvl3MfImYFWQKphv+Zn1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=uKs09LpBlCr8v8oOp5rSHJQtfYa+s82tZIcoNvkw8naFWx6+OaMS5xIaxCizt1q1qbiZQZ4R1ocGqYvL91LzlyhktTkP88DcFLQmxCvtpKmEKsY3zJAOeR3HNcYaPpmk0JpsEWsggpBUZUwI5Ju2WfSKRLqA2DWlBtoZUF2Afis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rHT7dB94; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rHT7dB94"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260921094359epoutp0491d2a4050e1e70b8c9686300a463e7af~XTNFsNLm_1219812198epoutp04f
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 09:43:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260921094359epoutp0491d2a4050e1e70b8c9686300a463e7af~XTNFsNLm_1219812198epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789983839;
	bh=ZDmeZ+1x5alOsdwMUDNjLyyvl3MfImYFWQKphv+Zn1w=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rHT7dB94XFxoO6SyZp73c0yx9yPH1Ln9V4RZXPFqU+RnVVSyEj3gmoKFEqW0eF65u
	 D1PzBhvsrcaLoA8b1eJHGf8F5DZfTVF/GrypPe5wAZnRHz9hvBBbP4fwF6lOKtffIx
	 aJh6jvgtuVe1dBaMclINlBG8Imm71CcfFyr4A4UA=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260921094358epcas5p48cdcea2addbf3fa1ea1bfeb9e7864aec~XTNFdD6KM2262722627epcas5p4Q;
	Mon, 21 Sep 2026 09:43:58 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.87]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4hpJG63pDvz3hhTG; Mon, 21 Sep
	2026 09:43:58 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260921094357epcas5p18cc9b52b28d800dce92413d3c7468566~XTNEaYSOH0686906869epcas5p1Z;
	Mon, 21 Sep 2026 09:43:57 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260921094356epsmtip283215ae5761267ba6ea5edb044daa404~XTNC6Zc3v2476124761epsmtip2o;
	Mon, 21 Sep 2026 09:43:56 +0000 (GMT)
Message-ID: <620c7870-67e9-49b0-a3cb-d8850d884f9b@samsung.com>
Date: Mon, 21 Sep 2026 15:13:54 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] xfs write streams
To: brauner@kernel.org, hch@lst.de, djwong@kernel.org, dgc@kernel.org,
	cem@kernel.org, jack@suse.cz, axboe@kernel.dk, kbusch@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260921093147.59935-1-joshi.k@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260921094357epcas5p18cc9b52b28d800dce92413d3c7468566
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260921093229epcas5p387ee10f88335ddc5fc930ca919769a60
References: <CGME20260921093229epcas5p387ee10f88335ddc5fc930ca919769a60@epcas5p3.samsung.com>
	<20260921093147.59935-1-joshi.k@samsung.com>

Patches are on top of 7.3-rc3.
Branch: https://github.com/SamsungDS/linux/tree/feat/xfs_fdp_v5
