Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249301;
	b=G4caHcjhn38W9wMH/t5V6DJW6ayy8qewRRUiCcOEHiQINz9O49BIUbgd+KGR9feSsQME
	 0bfMHzgGb59VYUqICSc68mTvY2nz+KCW4n7gQXRJOw5H8hyjP2D+Fw+iu+7GPJjaLAsIj
	 t2YKYdCFmZP2f78yKCL8/IquDcdWgzEXwOzjgCL/SJYaLstWaLW6M7AApiwqH6X5SEQ5z
	 p7dtK48Z9LBCW6cq4qWoqN1riyGbWOPPIc9g/plrKb9tyfkxiEiKNTPEMOwJAck1N6P5h
	 f+TJWFYxYhuGCrpxSMDr970YWqwTP+m5Pe0eI52Vwbm4gT0HntmDIoDcHe1J7Hzi7Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249301;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rUkAN0D/BhV4eeepN5BkaPXtCpvrs73RQYqXxUHa58Y=;
	b=FNTemBYT6QzCdW1EiJia0ns8DImG20cw1WUQCG23W1HSAwyhCfemV+zYi/+Mzc7DP9tc
	 YS1shTuzoBeUWxo7pLf7ShfLwVaCa5NgSviderHtuaTiYKYc9qeqWAmiK7kAi+jNdOe+Y
	 CXRDuqkUxWLqGvIH5MTpv6CK4fTTtLowLwymGB6Ejlq17zfCuoYBOjn9qx8dNhAGaSHf9
	 9CbZdZ5n+cDhYISv4uMaxKfJth1YkHMB7Oa3FZelNXxPP1E/F0NFos8J75a9/TDM5BVWD
	 5eSUSKMa25oB2OezMiLuRozTSmDUWXn72Uo/CbVJV/VDyBnYxMOJ/BqmRAeOOmLzydA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="l1c5/v8l";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=TzTQAQZf;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C298606A5DB
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 18:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C298606A5DB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=l1c5/v8l;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=TzTQAQZf
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9I1jbv2957812
	for <linux-fsdevel@vger.kernel.org>; Mon, 9 Nov 2026 13:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=rUkA
	N0D/BhV4eeepN5BkaPXtCpvrs73RQYqXxUHa58Y=; b=l1c5/v8l49hmG858fai+
	UKKiQ9cU4c/8V70uMPbqdB6EqIOXK5UkRD67zYVJ7g9z5KskWJNjpCpK/5GCbEwZ
	OtFQRwfcBaaWbQeICmqIuzEsFQM3maFplPKYmMt4RnF0f/P41Skphkwcf+w2PsHV
	inDXihKZrJ2ip+R144IbTbMX/M+KgfSnB2XX/itGgslUqPKd8uYcdDwLrnmjoS9j
	USZhhvtSjUkCwxCP56zcLZrys8cs29eG8hL8Y0xgUvxqVJ3jTLBK1DFRHzRvrD5i
	BJONdkj1fWuvBAPtJTYtw1lJFf3jDBILj4iPygz4co7c0OqZMrIjUU4SuQGohGZQ
	lQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4huk3gg8um-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 13:34:59 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f37c94ceeso232510385a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 10:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794249298; x=1794854098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUkAN0D/BhV4eeepN5BkaPXtCpvrs73RQYqXxUHa58Y=;
        b=TzTQAQZfq0XjUPsPaOslkTzmhx3irVPF938FT70tcVsvI6v3NI1XZz5NvlPd7o6cFk
         eaFKyGOz23E/d76UJyJ9nIBP3L5j8WDAS4cSHn9Q1rNFL6IDBIwWgCfJgrOZohU4/UF3
         jrEeHTU1waD4fHO68HtTIQ26sq0lfxUXULaUBJYPklefoFBJdReKvD8lc6ez/pbU1jSB
         ZwDQTLet7vMUTm7N7ozc+3gmgp/STNO4l9j9Vm8QhHXA5AImB9UiQE9dshyTBmlpJkZj
         X6NZV/22syct225nemTs5+lkfpJpWkMLubsFMQO3//vFGNoFgkt3zo8aDANNondVPAp9
         lUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794249298; x=1794854098;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rUkAN0D/BhV4eeepN5BkaPXtCpvrs73RQYqXxUHa58Y=;
        b=gQ8Y93pchy58cOHx8xOMV+iaV8c2KpW9Iwofjx7XoMPQrOdcZcf3gAjxb0uQwMe947
         t1jDGuHU8T5FsgUQwUQXFKj9hktawzzAPIgia+OG0cUhOzeVzzThB5mZ1KdtuxFEx67a
         idIarfopYrFBLdMyNQVhi262afRyT8Wmw1AnXJGxzvvbZ12z2nF+ZnsucyXAsYFkyiqr
         JA19CCGlDyxddmAUEQRS22UFn8EFSTBPqU6f6aaBRyIzvMa2yPoToSUOY4VNB7+90+UN
         QhNVwtr1K095THN0eYORireKo/u33YpNg54nh6/Vw55wQaiZAYH9g1uwgDIbnJIV6AIA
         fcQA==
X-Forwarded-Encrypted: i=1; AL+hErGHPn0juVhcNZgPsWtxSL0zZuKnZDqDB3px1WguWakfchTh2H2jJEjYh8yk0qo/iDgBggnyyXIUqAn2Blk7@vger.kernel.org
X-Gm-Message-State: APuU4Z9U9CQ/Y1orFbQZ8xYd7QwF0HIWIK+9PlEp0QhJ/nSnxGlPmZeM
	kxtsO+DGGtPhy7ixAtdT5bUrWN3fhM4Wc+4DmWIbm/wU/UqilVShLZ92ldtgjlJnJlFFFGq3W3X
	Cnr4MeXAPa2lPs5aDhjbXHNZ/M14KQKm4//nBPJvDgpAww7hNZQhQgPFLrGZoVjUZewpVhAg=
X-Gm-Gg: AYBFou35D5eWv7QOzU8WUkwD+5UVpumY+3P4qoaOdgNhuTfxO2k/K+XKGP7x87z9jQ8
	Iv5j4nhY71DhajrD5W5HnCqRo7fTxH3AyA1/5wtVllZmn1seUzg7cOB1IaXu/RT2lfs9EkJdYYk
	sgljaRshCYoTYK4wXGVsVaVHzQg/Wb7Z9WHUY6+M2eis7oAPnykjE610bZ72QncgM0kFU1ZGY+g
	a2571gL34aGPxSekkNz3YsXcWe/4YTw+WmocjotziKnYBVcgVeIhfQ/wtsnxZa0qAhr3PDjA/pN
	uZjmNkYTpWYGdw+iz/Ocpa0P+TpaI1YLs3RUBZaitmHd4umPw8K91WbGHKvIb29eWmCXZHTu6w0
	kugCe2wvU7jsPYS6k8eQKM4QyBBhzObRpwaNPL+hKQXy+qh8NG1DOFnXthmlCx9AX7A7CxsGj7H
	ppplLOnn+OhZYjt0DD++zzyZw=
X-Received: by 2002:a05:620a:4050:b0:93c:3863:ff7f with SMTP id af79cd13be357-9479ee3c1b2mr70605585a.0.1794249298086;
        Mon, 09 Nov 2026 10:34:58 -0800 (PST)
X-Received: by 2002:a05:620a:4050:b0:93c:3863:ff7f with SMTP id af79cd13be357-9479ee3c1b2mr70601985a.0.1794249297669;
        Mon, 09 Nov 2026 10:34:57 -0800 (PST)
Received: from [10.207.116.169] (nat-128-59-178-16.net.columbia.edu. [128.59.178.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e7f3bsm34634485a.37.2026.11.09.10.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 10:34:57 -0800 (PST)
Message-ID: <c27b9521-7c4f-41ff-88f8-55313b5f395c@columbia.edu>
Date: Mon, 9 Nov 2026 13:34:56 -0500
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
Subject: Re: [PATCH 2/2] iomap: remove the atomic write length check in
 iomap_dio_bio_iter_one()
To: John Garry <john.garry@linux.dev>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
 <20261107-blkdev-atomic-bounce-v1-2-f66344262096@columbia.edu>
 <3fc46788-d86d-44c5-8606-385d96fede4d@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <3fc46788-d86d-44c5-8606-385d96fede4d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3NCBTYWx0ZWRfXyxLPHrIKh8X5
 vtwRzq3z+PwJ8eSofsNUuHFCqGWhnyi3pfd10JfoXiCXontcakRZPQF4ayRaBZ1kR6WxLSJvf90
 h9b0aetlVolIN7zC+XvUYiwsUTXkR8cLpjllNRUD99sdbzJfZ/lG
X-Authority-Analysis: v=2.4 cv=RotQvymK c=1 sm=1 tr=0 ts=6af21253 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Gl6UJ28otdLh1ydVN8wMBg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=ADIp8eLfD24IfaEPE4MA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: U6jqjqARG3TeI625ypeHIinhh5mT7iWw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3NCBTYWx0ZWRfX9aKjU5yX7I1R
 4rGHvDp7viKI993SrMb32B3A5kNlG3Hb4U7dWx4Jkv5LFMNNc+rolhBfY+snxcWzinbj3mlxX2t
 W1enZGkZBkXRL0mK1fu6ycTZ15b+wut5PdnNdpX2E2T4Hk1OAQZkKZWZoFL/spWP5fiLKhNvirB
 medSrGuToXa8SDk9DHV6G+HcM4IgKTt/sp8EtA84bZ0YAZLQw3dal9haAPAvzYT34CV7AQ8VtyG
 ZMbiHPdOn+OR7jhQrKKOb0tjAzPnWjcwx5EqYMB6E0sTAxBUxzdvgP1zYZHKEUy3Hi5jI5labRP
 FtTXa53I7kSo00oWK/dOIbJc4NBAEbWlmYCcxdxgd012NJU2brCr0Kuoio7oMoNFqo3c/9AD+yM
 CbcEyn0sEd+Bn4a+469GURia0d7bdtQGJDdzs1yPvLF4myaF7/NGegPtOJS4izgFbujOhas4hMx
 GqIAO43h1/BFf5quqyA==
X-Proofpoint-ORIG-GUID: U6jqjqARG3TeI625ypeHIinhh5mT7iWw
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11961
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=10
 lowpriorityscore=10 adultscore=0 malwarescore=0 phishscore=0 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090074



On 11/8/26 12:06 PM, John Garry wrote:
> On 11/8/26 04:24, Tal Zussman wrote:
>> bio_iov_iter_get_pages() and bio_iov_iter_bounce_write() now fail a
>> REQ_ATOMIC bio that doesn't cover the whole iterator, so the bio here
>> always covers iomap_length() and the check can't trigger. Remove the
>> check.
>> 
>> Suggested-by: John Garry <john.garry@linux.dev>
>> Link: https://lore.kernel.org/all/82978d5c-3e08-48e9-bf0a-7913e1cd0507@linux.dev/
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> 
> Reviewed-by: John Garry <john.garry@linux.dev>
> 

Thanks!

> This looks ok. But I am just thinking that a CoW-based atomic write does
> not have the single bio restriction, so we don't need to fail the atomic
> in this case. However, we should have consistent rules for iovec's
> whether it's a block device or regular file for ext4 or xfs, so this
> makes sense.
> 
> thanks
> 
> BTW, you could be a real hero and add an xfstests case for this also.
> 

What specifically would you want to see tested? I can do an atomic write with
a partially unmapped buffer, with and without stable writes, and check that it
fails and that nothing is written.

>> ---
>>   fs/iomap/direct-io.c | 14 --------------
>>   1 file changed, 14 deletions(-)
>> 
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index ad041ac3252a..aca7cbaea4af 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -370,15 +370,6 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>>   		goto out_put_bio;
>>   	ret = bio->bi_iter.bi_size;
>>   
>> -	/*
>> -	 * An atomic write bio must cover the complete length.  If it doesn't,
>> -	 * error out.
>> -	 */
>> -	if ((op & REQ_ATOMIC) && WARN_ON_ONCE(ret != iomap_length(iter))) {
>> -		ret = -EINVAL;
>> -		goto out_bio_release_pages;
>> -	}
>> -
>>   	if (dio->flags & IOMAP_DIO_WRITE)
>>   		task_io_account_write(ret);
>>   	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
>> @@ -393,11 +384,6 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>>   	iomap_dio_submit_bio(iter, dio, bio, pos);
>>   	return ret;
>>   
>> -out_bio_release_pages:
>> -	if (dio->flags & IOMAP_DIO_BOUNCE)
>> -		bio_free_folios(bio);
>> -	else
>> -		bio_release_pages(bio, false);
>>   out_put_bio:
>>   	bio_put(bio);
>>   	return ret;
>> 
> 

