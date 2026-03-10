Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30C63C9434
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166035; cv=none; b=J6paG4A3wSmjrU/WQoBwvL5ia/v9hHjAM3/C0t7lUPKBMk/nH63mqqluTa3giY84KRzmv4tq7oN18VBbtqLk+eNRnpgtafbfR5rChDQTPZPBrks6B8Y/tepJiiDPS1R4+QO0ocNGQuJm/izKMttUdzi+3qu7cqCDNzjDn5qkJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166035; c=relaxed/simple;
	bh=l4nrvtOwMnATkG6GbrTHRrQMB/LTTdtEZMdiPZBqCGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=tOFK2iNbaRPiexIfTkfqWLt1NMO4vsn40EeoI9HC97ZnChV3akJYzrTx5f3R4WZDuaCKBHqW/hZOiymRnPN1jKSpqvtfG4lIBJglpINj4GHZavxv9BQ/Q7l17+0Xl/kwWyOM7LLNhhKyz/uDlqGNxZs9QvW2JWTjeLGPk2xuMvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=F602lhcr; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F602lhcr"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260310180709epoutp01a010f2f027944121d5ca20c8e3c4f341~bjRvrboWI1331913319epoutp01B
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 18:07:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260310180709epoutp01a010f2f027944121d5ca20c8e3c4f341~bjRvrboWI1331913319epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773166029;
	bh=P7lYmPRcKg8ULahNVwYm3PvDr3zluuJjRv5/e5R8iMY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=F602lhcruzJ4aDZ14TgUYJscTOLdkkk5h3YYGDlTr1avtTXv5xpM489UVVMcxa7e5
	 bT0ofmKB1BrOp0h8zMLIT6jVqtRk/2oLtlvQXXyRrqUq0W+l5BMlBROHiq3/zgF3FN
	 X+G0j5cjoL37RvIWOwHZwx4l6ATgi1XC9hwKI69U=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260310180708epcas5p39bdf8bc4836431a18e37116e238cd1ca~bjRvUhKkV2071520715epcas5p3J;
	Tue, 10 Mar 2026 18:07:08 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.88]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fVhfh00SLz6B9m4; Tue, 10 Mar
	2026 18:07:08 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260310180707epcas5p1f94300a63c8ad5dc1880b65043c4b9e9~bjRt9_LWG2989629896epcas5p1m;
	Tue, 10 Mar 2026 18:07:07 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260310180705epsmtip2d44a0aab66967f836aeb47768046c02c~bjRsVjL-d2111621116epsmtip2u;
	Tue, 10 Mar 2026 18:07:05 +0000 (GMT)
Message-ID: <8ed220ee-c88d-44fd-b189-759a58130460@samsung.com>
Date: Tue, 10 Mar 2026 23:37:04 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] xfs: implement write-stream management support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, jack@suse.cz, cem@kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260309163839.GG6033@frogsfrogsfrogs>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260310180707epcas5p1f94300a63c8ad5dc1880b65043c4b9e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260309053432epcas5p48e0273c8829a735ed987d1a02fcccac4
References: <20260309052944.156054-1-joshi.k@samsung.com>
	<CGME20260309053432epcas5p48e0273c8829a735ed987d1a02fcccac4@epcas5p4.samsung.com>
	<20260309052944.156054-4-joshi.k@samsung.com>
	<20260309163839.GG6033@frogsfrogsfrogs>

On 3/9/2026 10:08 PM, Darrick J. Wong wrote:
>> +int
>> +xfs_inode_max_write_streams(
>> +	struct xfs_inode	*ip)
>> +{
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +	struct block_device	*bdev;
>> +
>> +	if (XFS_IS_REALTIME_INODE(ip))
>> +		bdev = mp->m_rtdev_targp ? mp->m_rtdev_targp->bt_bdev : NULL;
> Uhh if this is a realtime inode then there had better be an
> m_rtdev_targp to dereference.
> 
> Also... this is xfs_inode_buftarg().

Thanks, I would use that.

>> +	else
>> +		bdev = mp->m_ddev_targp->bt_bdev;
>> +
>> +	if (!bdev)
>> +		return 0;
>> +
>> +	return bdev_max_write_streams(bdev);
>> +}
>> +
>> +uint8_t
>> +xfs_inode_get_write_stream(
>> +	struct xfs_inode	*ip)
>> +{
>> +	uint8_t		stream_id;
>> +
>> +	xfs_ilock(ip, XFS_ILOCK_SHARED);
>> +	stream_id = ip->i_write_stream;
>> +	xfs_iunlock(ip, XFS_ILOCK_SHARED);
>> +
>> +	return stream_id;
>> +}
>> +
>> +int
>> +xfs_inode_set_write_stream(
>> +	struct xfs_inode	*ip,
>> +	uint8_t			stream_id)
>> +{
>> +	if (stream_id > xfs_inode_max_write_streams(ip))
> Inodes can change devices, so this needs to go under the ILOCK.

Indeed.

>> +		return -EINVAL;
>> +
>> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
>> +	ip->i_write_stream =  stream_id;
>> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * These two are wrapper routines around the xfs_ilock() routine used to
>>    * centralize some grungy code.  They are used in places that wish to lock the
>> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
>> index bd6d33557194..9f6cab729924 100644
>> --- a/fs/xfs/xfs_inode.h
>> +++ b/fs/xfs/xfs_inode.h
>> @@ -38,6 +38,9 @@ typedef struct xfs_inode {
>>   	struct xfs_ifork	i_df;		/* data fork */
>>   	struct xfs_ifork	i_af;		/* attribute fork */
>>   
>> +	/* Write stream information */
>> +	uint8_t			i_write_stream;
> I'm confused, bdev_max_write_streams returns an unsigned short, but this
> is a uint8_t field.  How are we supposed to deal with truncation issues?

Right, in my head I was thinking "bi_write_stream" which is u8. Will 
change in v3.
