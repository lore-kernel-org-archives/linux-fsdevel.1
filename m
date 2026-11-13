Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577145;
	b=J0om+ieC7pUDkeCHQ4ooFR9wR0jCq246pz0ovEcbvaeHcqhw/cjzgIkzolZRhbOG6M1d
	 fItS/0o+ER6NdgQRnUWad23Ovi3TWCo8rfZxDiZz+3JRqXH4lKSnYUCMgpRyVynUOLG/r
	 9R8D/nXUrNokAGvKhgaA/5rJfP1xgJaCQSEmcYM0HPyEODUD1xODvKFtoVxVZNeDRpQ0I
	 MxhsgIGU/g8W0y2K0zme0rcCPx86KtJdnAZFHIItqQR3GnKbEr9bjt77nMubSnXUT7tX5
	 bsjoHdhXUIbh6e2mJQ6y0tnokNt7fOlBd1QjRzg4VxxZn4V088+7K16W9GjCyG8KPyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577145;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:CMS-TYPE:cpgsPolicy:
	 X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=NzBJ5AbTlE8ZTabyHvWos0hW2NLkXgvujU6pHqIX+xI=;
	b=sSzZV04XVTRUS4evgoWQRdj/EZTxx0zTb6IfGAO0UHk8sQp2MDjxZX++7wp3U905/pli
	 fQfDP2OfBV4IMB8wIJqAG8+iGEuOY0CNlI7G29jjYOvILhcdDR05aQ3nFIRHSu5w7axlB
	 BrG7M7jeu6P5llz1GWcek5SLtoKMpg6gO1XnTrz6mmvVdt6/pYG4DFDAs/CYjnOqFpzAA
	 0/794QFsMCdL4FZSbIe9C8Wy32UlDGUMxZ6ERTt0SAHPGPIOwe+UqkNJyDyqybVvgBjdA
	 Zej9fkvUrZx9q7yJL+hJscTLtjtS8WbGF1TMiWMjK3RK7UVH6OXu3U/CUgs4IbvPXMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=L0OlGNgD;
	arc=none smtp.remote-ip=203.254.224.34
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FCF606A32E
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 13:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3FCF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=L0OlGNgD
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261113133901epoutp0485bb5db048f02f589d88a70dbe5de84b~nnmb-X3yK0497304973epoutp04g
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 13:39:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261113133901epoutp0485bb5db048f02f589d88a70dbe5de84b~nnmb-X3yK0497304973epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794577141;
	bh=NzBJ5AbTlE8ZTabyHvWos0hW2NLkXgvujU6pHqIX+xI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=L0OlGNgD/b+SUZfYqa2P3UlmObrRcFmRy1kuT9oPJkv6Up26E822RZAmrFcQuyl46
	 CJ8Vn0YBFjlvYFCPuhQSsTjlLtvci7hhsfs8fTvM5kLPHD0OsP9+ZGWAFwzhS4crwf
	 QvmGA1piR+DMPxlU/3AdsHuC+o7/yv4Wy1uH3jok=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20261113133901epcas5p2aedd842ae4367822c97cfef3e6f50e72~nnmbjEPuw2671126711epcas5p2r;
	Fri, 13 Nov 2026 13:39:01 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.87]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4jQyyr1t0rz6B9m4; Fri, 13 Nov
	2026 13:39:00 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20261113133859epcas5p2c61f07a35bafcadf1059fb7fb4d38435~nnmaNAh6u2671126711epcas5p2n;
	Fri, 13 Nov 2026 13:38:59 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261113133857epsmtip2de193dd520227debde94ff89972b8cc0~nnmYarzgA1779817798epsmtip2Q;
	Fri, 13 Nov 2026 13:38:57 +0000 (GMT)
Message-ID: <4a91a430-63c9-48ab-939d-e5fca0c2c794@samsung.com>
Date: Fri, 13 Nov 2026 19:08:57 +0530
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/4] xfs: report zoned write streams on realtime
 inheriting directories
To: Hans Holmberg <hans.holmberg@wdc.com>, brauner@kernel.org, hch@lst.de,
	djwong@kernel.org, dgc@kernel.org, cem@kernel.org, jack@suse.cz,
	axboe@kernel.dk, kbusch@kernel.org
Cc: dlemoal@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20261110103540.46876-4-hans.holmberg@wdc.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261113133859epcas5p2c61f07a35bafcadf1059fb7fb4d38435
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261110103609epcas5p29fd4cc009bfd3d367e16276cf9a00251
References: <20261103110640.1000095-1-anuj20.g@samsung.com>
	<20261110103540.46876-1-hans.holmberg@wdc.com>
	<CGME20261110103609epcas5p29fd4cc009bfd3d367e16276cf9a00251@epcas5p2.samsung.com>
	<20261110103540.46876-4-hans.holmberg@wdc.com>

On 11/10/2026 4:05 PM, Hans Holmberg wrote:
> On zoned file systems the data device usually only holds metadata, and
> mkfs sets the realtime inherit flag on the root directory so that all
> regular files are realtime files.  Report and allocate write streams
> from the zoned pool for directories with the realtime inherit flag set,
> so that streams queried or allocated through a directory can be used
> for the files created in it.

Thinking to have this behavior for non-zoned RT as well; that will make 
it consistent for applications. Any directory with realtime inherit flag 
would report/allocate streams from realtime pool and not from data pool.
