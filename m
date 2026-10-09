Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D73D0BE5
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563600; cv=none; b=ro0NnCI6as9L5b5IG9GEDAx683AUUr6KpN0KBq9+PwZCq7M9yiEQ8lFXoJzShVgCVtN6kOHzs0m8zpHptoNpgeK9iinwp19Wn5ZBy9eVWNw4bm74LwCWs4P2NUkCiNiH8UDK0lgJinGP2SCww6++0PIy57xIMHpzBBiIRLgWzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563600; c=relaxed/simple;
	bh=DbRmeFKz9c5VWdWVaobKih64pVB21jZZPInaJVc30JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxxeNQh8Cl4vNmzwTmd5DSSKgL/sRuhJ4z8N4xJLS9SHVJXl7Kw3xcfAZaHGy882F6bSuvnKj572teTFB77GiApoQo1nPmteDbjROlxPP+wSz5WaxqbyJ9dqQQk4DGE2Kw2mlYJsfKRLe1xH6XVlMsv1TVjQodwSrJ7vh4BqGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=rEFR7Fpk; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Wh3AC7vf; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="rEFR7Fpk";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Wh3AC7vf"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699Euh884148893
	for <linux-fsdevel@vger.kernel.org>; Fri, 9 Oct 2026 12:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=wZe9
	a2En9o6BKVSoAfcVpFv08ixIGHqSssDdI/MA20s=; b=rEFR7FpkiI2zKlQkTGRv
	l8vaftdG6plJ6RIgfVd7tUGmSCNVI0yHL2nav1LLG/4/Tp96oP1HO6hBw77krAfV
	9DqRhdUIhNDvD1z/qofcFqXckmr+tx6RcME32VmKWs1SNElnfypOn9+7U4QOcUns
	TexzZt+UnyEoLfTaN6uDiyFo8LqHgFXd0x3Wi/+SnbSDDh5iUJT7ymk/xa/sdfEy
	5UiQfohU3fbl6c9Dqw20vsiuAMKQadsuyNDKWoFGqR6t1DkbKCbbXHD8NhlNFxAo
	qAlW6QKdi9aP0+tiuoXwUnj2abu4UzdUkxyPnXbo2E73uJzYUlLX+yU3+yszUfou
	Eg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4h6xqqtry9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 12:13:44 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9197553d398so122317006d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791562424; x=1792167224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZe9a2En9o6BKVSoAfcVpFv08ixIGHqSssDdI/MA20s=;
        b=Wh3AC7vfNz4ZoqbGbukZDwiKnCjMSD5r7Ml9z0mQfYyhftvfQTIm57nNe4tkaJMZEf
         YJvT2e+xNUoXtFn2MBf2ObElMoRaAXJhIWv2Lbi7lvPRIwaqGxjyhtSe9Ntkf2oAqMwi
         iW9ja65YIui61u7Yg+mkqfrLdjlFYcbC6eSxNIvJVYo5M/I+qTD1H2ikx/nlnCbA7+Nz
         pRz3FYrpAWIOm+gnTvKq5juZ+gyEzKuZmCWBhyiamVaIRwm24uHnDcQZqSo5ojGu/YKE
         6vwl5inSAWpUGJb5sI7anJxXEcPXkb5qS8pyFzHi+Dw4T0eYqmyQer9/l8LX9UFoC9Fa
         T6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562424; x=1792167224;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wZe9a2En9o6BKVSoAfcVpFv08ixIGHqSssDdI/MA20s=;
        b=0ASYfvDfe4qLkbvk6SCBh7N7+J+PgWYMNogZWOFMhOqCTP1Dn5ubkOchd1N3WrYE9F
         Zs82CIlv5doT8w6AK5Kg21IeNamV8618Yb3kvgY4FMthLUz3n3z4puJhB6+EsHvJWCNb
         5xw0WKjx8e9zPx2h52x1geu2wvRJqEF6K+Ersv7GWd6YVjymmrXPj2IUMGyzjshrqVpH
         aF8oRJg45MHs+YdsYgJ8FJ3N86iuXnhNOrqro2DM/UremEcav9GJaslnw4NGS5mcMYOn
         9yabdWzSGW5ZNm/2eqqaWKUTCfK1SPmPnebo7YvZ/PB3KYDAUSKmWQywURn9ctDl2Zay
         6NBA==
X-Forwarded-Encrypted: i=1; AKwUvByhnaSB+suZ/+eMaKZ6Y6avB/8h8LTNdc38QkzhkXYPpk1E6Kf0v+wJbOgu4rBxHo9UWX9/ctidMS0gA8Sy@vger.kernel.org
X-Gm-Message-State: AFuF++naRNdA8JQiGW+ijhgTpxyJ5YSILlcBZdLlTvqFPMysuz1Rx+G6
	0xM5398zUHgZQpCp4owJkRTmEiP1lu7pS1i2e/Mu5Du9O/9RofCD49qELNQOjGeZmsl0yCREqCb
	e4IzqHxaNKQOq6bCK4WBIQjaOz74viSxBR2b1Jz6ryGxIeyFQdCzb3fSdwQGBjmU=
X-Gm-Gg: AYBFou3VCXxWby59EXvJI5c6M7WlAJ7Jdxwfv7BpRGsLYNvuWsK2C2gQJcYLuLX8aE6
	/kvsUKc4Rh8Qk64zL4S5NBrRR8Kvbtr5kJdadqwsy/CkKIOIjxjJvvt9j+yMZlm9gvy5scY6UF6
	+uCrOjbYZ1OzTS+XhpgyLKQXJ1LjvqkFYzGm3Sx95gbk1Wqyfb2e5djwxWgEA+5IEdFW+qAxiqb
	j2vJpW957gk7mkAuzNG3uTPmB3lb9DreFMFUVraKyvCkZ77KxH/xBxhn9mzGFO0/z9EQTz5+pLE
	ujI2/Ym71CARvoGiDeZ2v1ptRbgxHdi6VnwtrdOzTXNraZMa0NvMg4dJKtLB8O66Jwao0fkJDAj
	f7P7VfMaDvpFMplvFKbPNtHCiViWlz/v9pZx6+eZhEBGYqVn7
X-Received: by 2002:a05:620a:a416:20b0:93e:c12c:9b76 with SMTP id af79cd13be357-93ec12c9f3cmr196781085a.81.1791562423663;
        Fri, 09 Oct 2026 09:13:43 -0700 (PDT)
X-Received: by 2002:a05:620a:a416:20b0:93e:c12c:9b76 with SMTP id af79cd13be357-93ec12c9f3cmr196774685a.81.1791562422959;
        Fri, 09 Oct 2026 09:13:42 -0700 (PDT)
Received: from [10.207.9.0] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9720f24sm221712985a.3.2026.10.09.09.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 09:13:38 -0700 (PDT)
Message-ID: <69a325f6-5641-4f12-b088-5e108b48ea97@columbia.edu>
Date: Fri, 9 Oct 2026 12:13:37 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] block device fixes for large block sizes,
 IOCB_NOWAIT, and direct I/O
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.garry@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
 <960b1305-c5a6-4554-8bab-1cf4244fa11b@kernel.dk>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <960b1305-c5a6-4554-8bab-1cf4244fa11b@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NCBTYWx0ZWRfXwfeHVf449TgX
 Bdfn2HZqD+A8eLh0RjUu/R5diRFbNvOnyEZ1lf55hx23OHRzjQEx5iEVR2foPxGN7L58SCGlQsT
 KTexttPv4Amxz1jMx9YhAyIM8QsvLe1mBYd7tMCJqxJ4+UVqEoxs
X-Proofpoint-GUID: -Six5mTqGaJAqueAywnpxSSyRAJ5XFDS
X-Proofpoint-ORIG-GUID: -Six5mTqGaJAqueAywnpxSSyRAJ5XFDS
X-Authority-Analysis: v=2.4 cv=I+/w19gg c=1 sm=1 tr=0 ts=6ac912b8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=kmbzLJUYW2F90v5fXl4A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NCBTYWx0ZWRfXzmFNAayQ1pZG
 5/xoYymXbPFMtaCya0E4nF7FXnkIZh3o7bmSNA6BRuCi0FlJKFVAtdmyND3M+Ge4kxanTmj5pEG
 3wUL7AX3J35YAjW71HF2/wUreRqyhZgNtfFyG76FRv9NeiN9IvBxrcdGx1SrsRKVYDIfdsFnm2s
 VPH92Upp3hzSTNIL42OGdQEQj1ipwgQJyuW8nChDmFy2HIrySH/LDwioLgBUFcvEhoFp26a1wa8
 oTDnm2f5a6oE3jCVuz2F+JjBhwj1Qy1Lctp4SJLKMgjDdROzuOWWxE6/15kKP+mPr5ZE1YGHL5w
 r7yNQq4YrWmmGB7pkt6r2BVwpFngU7/iV4vXo/2STlEMoOaa6WfevSMAdEykdihOIVzvkNieMwf
 eqO3n6aYSWHPkI4zzDis0W8yhIfTmxhbgd4/K2HDdaWN1ZDN+dCQT1iaZjU+USkCzCb76t+eu+u
 m7fghW6yJDVBMyddi8A==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 bulkscore=10 adultscore=0 lowpriorityscore=10 spamscore=0 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090064

On 10/7/26 10:05 AM, Jens Axboe wrote:
> On 9/23/26 5:56 PM, Tal Zussman wrote:
>> A set of independent fixes for the block device file operations. The
>> first two were found by Sashiko while reviewing the RWF_DONTCACHE series
>> [1]. The fourth and fifth were found by Sashiko's review of v1 of this
>> series, and the rest came from asking an LLM to find any similar or
>> related issues. Each issue has been reproduced, with the fixes resolving
>> the issues.
>> 
>> Patch 1 fixes silently lost mmap writes with CONFIG_BUFFER_HEAD=n.
>> 
>> Patches 2 and 3 take i_rwsem around the direct I/O write fallback and
>> the splice read path, which race set_blocksize() changing the mapping's
>> minimum folio order.
>> 
>> Patch 4 makes the buffered read path honor IOCB_NOWAIT instead of
>> blocking on i_rwsem.
>> 
>> Patch 5 makes IOCB_ATOMIC writes fail instead of tearing, and patch 6
>> stops the buffered fallback from retrying an atomic write. Block
>> devices can reject both paths into the fallback before submitting any
>> I/O, so we fail rather than issue a WARN() like ext4 does. Patch 7
>> makes iomap_file_buffered_write() reject IOCB_ATOMIC, so no other
>> buffered fallback can complete an atomic write either.
>> 
>> Patch 8 fixes leaked page pins in bio_iov_iter_align_down(), and patch
>> 9 removes dead metadata handling in the async direct I/O path.
>> 
>> These issues are currently unlikely to be hit in practice due to the
>> specific configurations required to trigger them.
>> 
>> The reproducer for patch 1 is in blktests as block/048, and tests for
>> patches 2, 3 and 8 are posted at [2].
> 
> This is based against the 7.3 series for some reason, can you please
> resend against the 7.4 based branch, for-7.4/block.
> 

Will do that shortly. I had assumed initially this would go in as fixes
for 7.3, hence basing it on the 7.3 branch.
