Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264393;
	b=UGgeKNVut0SBXJ2e3uWMODJf74kalxWDhe1Kelrq1X6qr1EhNVd2uanW2kjGYtvO4DRr
	 FevCCt/jb20N+s+gJBH/AmXeXy1mJi1Xa8+DhkEu7n7OIaEdfoDkTQ2QOxGOg5pBUDZu1
	 qLUVKFkUBlpGd2KE4ocNQluyupYfXmJD/sxBN+s+CZBSHCZvsmSc1rk9l1KUnJviHhPYp
	 ONuiaKrCkNJu0mN8CvMwfeHTTPTn2933Vd56wsCZeZ9LM8+xt3MGIlfzG1ArLkwl1UQf2
	 nMrX6kUhDtX37cFJFA/VyQYB6HWJF4jn9+UGOquMmW/3l8oQTPcYP6U3idd/As4mTvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264393;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WIZBljhWyOjAV704JqzV8vhFcRwS8d3hm/gLxcJtn20=;
	b=mG5EH8VLDKfbg9gmbJueyPVR78X6T69XoZTx5zGPHZI8OfCf1uqcTCE90A1V9neQ1/Ah
	 0csKVp6CJne1/pbkeRNBpiZy6Y2aH5/6sIDHwbsXqMqcICiVLEDpWeSY0u8LByWEPUBnp
	 7BIunS1c+qDWpapAvtQ1qNRzCMVJ4de3zmNqoZZWTvq+acHcNwHPjhbbaxCB+sZfc6BFP
	 zPt7onSBCxUg0XP9GhkV4UcxYY2RsRksYJT0wbP7+p2sPbMouBwJ/w9vgtsZp3wxwIpj4
	 qaQI87FCWeYsZPz3Y1ADWTHIL4P5Ecd/1Aj5dDScO432cY+0IKK1CLY42c4zi87+9tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=rJPYJ+Pf;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=0enM7fbI;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E5606A325
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 22:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C6E5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=rJPYJ+Pf;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=0enM7fbI
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9MRlx43003206
	for <linux-fsdevel@vger.kernel.org>; Mon, 9 Nov 2026 17:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=WIZB
	ljhWyOjAV704JqzV8vhFcRwS8d3hm/gLxcJtn20=; b=rJPYJ+PfHhoR2aC5ddre
	KeX0TdnGyNff0y44edc9qO8omnXiG0NrT5sfljaWfFAbsoL94MHrzXPazE3d+qFT
	/SKQftG+Rknkszqx3bWtOTlRrOoqsD/qf1W7Pani/bgd3TS8I22tMOP8VJ5rRj10
	l9M9Nu8XtoWOYmt5kHgVpCOWVmo9hHIiaGFMK8XsGzXv7eVyeq5gtDm9v8p8wJWJ
	bSzVKEkv/r88EFjHPXlneH6gL9V9wgG7s3ylcsavjTXCEIPoyRKkPBLPwA4foQe5
	VkG4/vTvUMZWQKljuE5sEeZynPzCtkcnfE372yfe2FTqyT24VAmBfWGBCf405lJL
	uA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4huhda3jcm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 17:46:31 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91eb3a63064so29739256d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 14:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794264390; x=1794869190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WIZBljhWyOjAV704JqzV8vhFcRwS8d3hm/gLxcJtn20=;
        b=0enM7fbIEkgCaPHnwROs1AH+cT8C2XUcCsXLOvY0FNHtdlsJTHTXomRcBL2cs6p99B
         jwtZ22W0o+vlGDwzmc7juR2+s5sw2UgSUSLcfgsW8SREua//529cOBkGMx72FFyAIaoz
         m+dhgkl4Ic7F34MIlY1YAoisB6ujfzRxxGO7pKYE6J3qXDedlDM4/ZZPMQfd/TsY1FoF
         TVfGm9FYineb6HKUXZdXw7+o+EuULwwDBXTiOwaP15VhRDjAWZoTT1vZoqy0OWnWFOIB
         FlKAtgI8FATZ4nqzVjbnR7HnNJX/CvwrbhXfwXCgbUmBKdhP8nxmak5G7iOLfFqvHOgR
         QRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794264390; x=1794869190;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WIZBljhWyOjAV704JqzV8vhFcRwS8d3hm/gLxcJtn20=;
        b=SWH5g5AqpZZaUY6rAWXxjjSrbVIDqNKCAkbFGOV+PTN6vPpXAFxhlSO0SWlG2fNwzX
         shOqrDimmE8NQqKi/kzKqIoejBYgqv64S6+l9SPOTKIXMm2C7IPPI1q5xQsCLc+0JNQY
         fw9RwpGp28eIYwtyJIn8iDq7StHkftHjn7L38cli62pG/NRRMBaGP7PVwT+fjvzyRXYS
         Eji4V+FdhYSNBexPJorarF3OfCDaicSdf/q8xpgQq+VLvl5M4hpKKVMkdwWwrcs/EKuc
         YMe1fW8z2jyAm2GIXP9/FBIrIWRm5qya54Ya1qslxPZcoUvxkk8oasIhtymwgU9zrST6
         WHrg==
X-Forwarded-Encrypted: i=1; AL+hErFWrmgSgDAE/VidWl/ARQRjsO4bhJWIvd+phhR0X7u4EHXAeuVOm7Vs//u1NL+v6LEnawvVJPoPHyDujrmf@vger.kernel.org
X-Gm-Message-State: APuU4Z/mUkchIhTN5v3WYnh3Qu9iZ8rj1Id5d0mwP3giVipMnqMB3HE9
	DbFYSuIGv+6nZ0Rm5oAuv9K3wYlwTEJblh/wpWXFCELdyqWvl3eGLqXU4FK47Juah0LAQfY+dDW
	1EMgv4k8Ug8P3YQ9WltXvEy16iF//pme8QrKbKW8rQ6EZjfZuZu2cPUamgWjnAtwPBMFqmOs=
X-Gm-Gg: AYBFou17jHItMilXFHF6cbKyZGxmQRhjoEwUcOE48tahBFU+oJu1Lq79M1OSQic0uEj
	fWkv29gt54dq3/K5oz9EOgB+FJ91/8jEbfgpfh1YtqT9tgWtERXChv14rFGO89eHNFWUSoUNi7B
	pQ9h07/F4+YZkNmUefgPYwHpNVGWl1R9F3jD52Px/imgKBuyvjVt+2xE89NuF3GLDTsPyEoLox9
	ERU6Oal6WjBrSPyAxQds8lYccsTjlN77sKS00aZzjYB5uDrr/jR1PEksvSnRfUo3GDaN4udkXVj
	zkn1TlSupTz6iggbfXkrH5NhB41f3S78wYsV/Oha3L6qasukFy3VZhhJ86ooHd1AxV/WNt5+cZZ
	pCOorBxQLgws8pfaEOMxnVU0mB5PZH3MOqGy82XA9pex2pqGjCdEyBqKKrz/Nk/uDngLF421N7U
	UE0+PTZBQxSb8cxz69GNxfriE=
X-Received: by 2002:a05:6214:cc8:b0:914:cdbf:b6e with SMTP id 6a1803df08f44-91ef049b91amr14954436d6.22.1794264390516;
        Mon, 09 Nov 2026 14:46:30 -0800 (PST)
X-Received: by 2002:a05:6214:cc8:b0:914:cdbf:b6e with SMTP id 6a1803df08f44-91ef049b91amr14954056d6.22.1794264390014;
        Mon, 09 Nov 2026 14:46:30 -0800 (PST)
Received: from [10.207.116.169] (nat-128-59-178-16.net.columbia.edu. [128.59.178.16])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef031aaddsm7023636d6.3.2026.11.09.14.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 14:46:29 -0800 (PST)
Message-ID: <21793564-61f4-4d57-b375-1271ad9bc70c@columbia.edu>
Date: Mon, 9 Nov 2026 17:46:28 -0500
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
 <c27b9521-7c4f-41ff-88f8-55313b5f395c@columbia.edu>
 <4022d4f9-5e2e-45d1-b9b8-208c80f82ecf@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <4022d4f9-5e2e-45d1-b9b8-208c80f82ecf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NMVAaE6g c=1 sm=1 tr=0 ts=6af24d47 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=Gl6UJ28otdLh1ydVN8wMBg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=-APkALjPeVA3zQJKllEA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: Q4oY1OyRCDAu3RMm7T6gERqzdXVjQ_uC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5MCBTYWx0ZWRfX+cQ1jrziV6Nv
 5wqe4YNeQThFb9U8h/6h5s7yZAqZD03jLsv3yfuxZ6O44wAVJo6zftUw8HdaDyp/XuTpTYVPprH
 pO72/ykKjtYGOQ1M/SU2cLiPuRhuoy0o8rjnsUXi/RND8+Iv67cR
X-Proofpoint-GUID: Q4oY1OyRCDAu3RMm7T6gERqzdXVjQ_uC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5MCBTYWx0ZWRfXx5D31Ihblpjt
 GNcIyi8HlVDxIAT5dYKA5s7r/l8garM2yJQhq8sekcBvurRs8hbP0aq1Q35+dYOqmHQp+CIxu6F
 zVDvTTpp8TwbD69qoYxXDEg4QlvpQhoS8nr6YuWbVDMrJQT/2tOkXFc9Maq9SdsQ5RYNVUrwjzB
 K40Bg7fNBBa4tC1sjrBs0pTc10+ByJ8+5iFXUH0FxJzgtYNWaNpi39oZL4v5wsBuJutTeHH/6JQ
 4VcITyF4KiL9KZ4nqQz26c/cdD2HwoCdCKPZw5nzkQFR+4jFKjmaGBgU2J5rMxxV2dYg65ARe3z
 64QkhxnwFOH41YASOu+pMLpatF9vswHcvyDt05f/b67XzINtIGvRJAJ6cf93yrPeulQoZ2ef797
 yrJm8b9ZGTlDQGjyXqEJJCJixuQIx0GLV9n6LVh94ccbYMvhJh39JSCcNdWsfJfguwLI7go41Jz
 S2F3L0qvozD2C3CJ1aQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11961
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=10 bulkscore=10 impostorscore=10 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090090

On 11/9/26 1:44 PM, John Garry wrote:
>> 
>>> This looks ok. But I am just thinking that a CoW-based atomic write does
>>> not have the single bio restriction, so we don't need to fail the atomic
>>> in this case. However, we should have consistent rules for iovec's
>>> whether it's a block device or regular file for ext4 or xfs, so this
>>> makes sense.
>>>
>>> thanks
>>>
>>> BTW, you could be a real hero and add an xfstests case for this also.
>>>
>> 
>> What specifically would you want to see tested? I can do an atomic write with
>> a partially unmapped buffer, with and without stable writes, and check that it
>> fails and that nothing is written.
> 
> Just something similar to the blktests case which you added.
> 

Sounds good, I'll add it to the queue.

> BTW, have you tested this partially-unmapped case for CoW-based atomics
> on xfs? You can just do that by setting atomic_wr=0
> 

Yeah, I just tested it. It behaves as expected: returns -EFAULT with the file
unchanged, both with and without bouncing.

The single-bio check depends on REQ_ATOMIC, which only the HW atomic path sets,
so it doesn't apply to CoW writes, both before and after this series.

In terms of consistency, the unmapped buffer returns -EINVAL on the non-bounce
HW path (from bio_iov_iter_get_pages()) but -EFAULT for all other paths. That
should probably be made consistent across HW and SW and bounce vs. non-bounce,
but that's a separate change.

Thanks,
Tal


> Thanks,
> John
> 
>> 
>>>> ---
>>>>    fs/iomap/direct-io.c | 14 --------------
>>>>    1 file changed, 14 deletions(-)
>>>>
>>>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>>>> index ad041ac3252a..aca7cbaea4af 100644
>>>> --- a/fs/iomap/direct-io.c
>>>> +++ b/fs/iomap/direct-io.c
>>>> @@ -370,15 +370,6 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>>>>    		goto out_put_bio;
>>>>    	ret = bio->bi_iter.bi_size;
>>>>    
>>>> -	/*
>>>> -	 * An atomic write bio must cover the complete length.  If it doesn't,
>>>> -	 * error out.
>>>> -	 */
>>>> -	if ((op & REQ_ATOMIC) && WARN_ON_ONCE(ret != iomap_length(iter))) {
>>>> -		ret = -EINVAL;
>>>> -		goto out_bio_release_pages;
>>>> -	}
>>>> -
>>>>    	if (dio->flags & IOMAP_DIO_WRITE)
>>>>    		task_io_account_write(ret);
>>>>    	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
>>>> @@ -393,11 +384,6 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>>>>    	iomap_dio_submit_bio(iter, dio, bio, pos);
>>>>    	return ret;
>>>>    
>>>> -out_bio_release_pages:
>>>> -	if (dio->flags & IOMAP_DIO_BOUNCE)
>>>> -		bio_free_folios(bio);
>>>> -	else
>>>> -		bio_release_pages(bio, false);
>>>>    out_put_bio:
>>>>    	bio_put(bio);
>>>>    	return ret;
>>>>
>>>
>> 
> 

