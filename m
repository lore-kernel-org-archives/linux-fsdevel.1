Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E6B3B9613
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223204; cv=none; b=gTGMSTk3TJ2XzTPGyid/1DjjMoTFmo5qt75qIeC9AVBk7WdktGBKDknY0Za40bY1DwXM3h5Ci7DaEWoItRArRCGyxB5jSAMsuThpmXvUm8SG6HlaK7Z02KbxSrNKW45vqROycp/DgmfZp1Hk0MJfvYGUuFu6FWuykSuEo21LSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223204; c=relaxed/simple;
	bh=7rYiKTJSnrqhvBMz53ZyYJyJZW0D1QKmq+9RLzJG5nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=eKoa9tJ1Yq+/PdRwhGYsMl3T2oXF5QbfTPpomRJseHZsZ+fMXfjLGrH9MWq9IlRrlH0DvMfxGYjyCnQvvV4s+yiE0iUtCohhV/qXN3Zbqx28bnrgg+URHjXJ//KbTa4fqrmtuPXzi0iF3FH6yNtp7BSkXPLNNe4yhOYs25oEJ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=K5Smn0S7; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K5Smn0S7"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260311100000epoutp0305bc77de42392eba786f41e35e2a3909~bwRr-7quP0749407494epoutp03E
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 10:00:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260311100000epoutp0305bc77de42392eba786f41e35e2a3909~bwRr-7quP0749407494epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773223200;
	bh=5DgdO1v/Pl1U1lb65+YSIbM4d52v6X1UwmX/0Kwiuu4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=K5Smn0S7uT4uKZzXfzM4gPCsQIizNclUzLsdRUtUrd21HDT6cmSUHskc+ka71AFF3
	 GPajGQpxs91yfUcI3zuTDnUdfXyTBSWvOtjdX/5rnpgXV0og7EufSlUistp4QWsB9e
	 EZHqt4mjHG/mrcPsG64A0lMEJvPbSK+ZDXKlFzgk=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260311095959epcas5p491677075d5ff7dbdc08c73ddfe4c7c60~bwRrniWtR1220812208epcas5p4r;
	Wed, 11 Mar 2026 09:59:59 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4fW5p63H51z3hhT4; Wed, 11 Mar
	2026 09:59:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260311095958epcas5p2118dc88ab775ff238a70ef6b1fe04c61~bwRqJFhWc2599025990epcas5p27;
	Wed, 11 Mar 2026 09:59:58 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260311095956epsmtip183c83727d593b19a7f209049e1ece705~bwRok-6Kk2507725077epsmtip1o;
	Wed, 11 Mar 2026 09:59:56 +0000 (GMT)
Message-ID: <77c3948e-19a8-4ee5-961b-0321dde708aa@samsung.com>
Date: Wed, 11 Mar 2026 15:29:55 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] xfs: steer allocation using write stream
To: Dave Chinner <dgc@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, djwong@kernel.org, jack@suse.cz,
	cem@kernel.org, kbusch@kernel.org, axboe@kernel.dk,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <abCe5psWHgYIKkR0@dread>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260311095958epcas5p2118dc88ab775ff238a70ef6b1fe04c61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260309053434epcas5p308acff894c6735e382c0e5e1e737c9de
References: <20260309052944.156054-1-joshi.k@samsung.com>
	<CGME20260309053434epcas5p308acff894c6735e382c0e5e1e737c9de@epcas5p3.samsung.com>
	<20260309052944.156054-5-joshi.k@samsung.com> <aa-whgDFL7h8-gIl@dread>
	<7a4f9902-d87d-4032-9df0-efa807c6aade@samsung.com> <abCe5psWHgYIKkR0@dread>

On 3/11/2026 4:14 AM, Dave Chinner wrote:
> Yes, I know. I understand what you are trying to do and why. What
> I'm telling you - as an XFS allocator expert - how to implement it a
> way that fits into the existing XFS allocator policy framework.
> 
> As I said, the existing filestreams allocator stream association is
> not an exact match to what are trying to do. It is, however, trivial
> to modify the filestreams stream-to-ag association behaviour to
> match what you are trying to do.

Yes, I am already inclined to explore that direction. Thanks for all the 
inputs on how to properly fit this into the existing  XFS allocator 
policy framework.
