Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508E1FF5E3
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788018441; cv=none; b=L2DYnpeQDGKwZ+QG0wZhoK1RZ3VUjbvR3ch6hDee8f7POKNlrlFmwE3ZbVrDfNSasjzI7YcRdhNKH0iFpGJHDuf0Z56H8zidN4z4B3FwgTXGplaAatIQFn4yvaqzXkcN8n1uhz8ZG1jruUABtrhZP4G5n9/Wyzo6B0WSz/29moY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788018441; c=relaxed/simple;
	bh=xxpR0ksxkA/ONSsugSlrSih0kyNuN6ltaN0MKPNAGsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXUv0liM3UAlv3931aN2i1dnDKgkU5yieeA64jvkOy1eEgcAzxxQY7ld1uhtKlkkCIOQ8To5+Ml0Id9ASYF/bjtspelr12hlo7DppIYg0F4DJKSEWKBZSzvBJ2cg2a6Wrf/lMBvO7MVNGwHygs38HZWk78IQlGGoTZXfE55YqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Gu2zFIuG; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=yULeJS8f; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Gu2zFIuG";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="yULeJS8f"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67TEesqW855754
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 11:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=TFVW
	lDwfNWxgPSj86otvED5lH0a6QKBTMoQ7ChKGCcU=; b=Gu2zFIuGUDCk+rJ2VDBk
	70a9GXKIRmd3CKMeiyckWv/D5MP7Zgaj/CA+sovdSkrETK1IrJb2qFnGnQEaNT3S
	N9KtoDtS2aWLMgdaZS8EG79pcfDMQu06yKTxqcmPhJVJAftER9ykGtp1pbja1UeX
	kUFeO1YwKQdpDr1sZdsz5l4M5OOqmQkrZTmdrHduJ4FxpamhWS1IQq9E37/oh+3q
	nZtzyUcZ5SRVAnnPNjuAJxQT4FXqYOGakyKLjlrLX5KwZ+Imu1kdoq89hPFZ5bjm
	jEkOlYV+J6fGeVEAdtwq+7wZe5VJJ9mAqHAPx4qs90lyy6hcLcj/IAjQH5/0tLN2
	0w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gbqxha9ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 11:25:58 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90cd2cadc62so21861346d6.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788017158; x=1788621958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFVWlDwfNWxgPSj86otvED5lH0a6QKBTMoQ7ChKGCcU=;
        b=yULeJS8fL6KgifqlmoIf/kgtzS3n1Sf2tAu/n0+TJqBq24CBHNegLJrwOAeJggMHkC
         MIW7LyzyjN/rpSO3TUjsRN+PebrGwyJ6YhC7dlk/Nsp9CUNYUYDKAuJe64bSMFsO2JH2
         l+Zzkixl48qyKz/QJeN6HOsorZ+4RoDA5X5nIfZB46tg7Pux14ql+UDp8EBhQ86RxElY
         x7k7tP27Hbpd7+Zydx8vMyyfOgb4WZGpgCK/7VeuoK0bX2ysfD8KIuJLNKfsLVlmUd0l
         YkNo/sy/ocRZAw9O2hGGKz34FhMovgDypqQj+W9DOWduxz+noNAXhqolaxcmLGoL0bLV
         RDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788017158; x=1788621958;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFVWlDwfNWxgPSj86otvED5lH0a6QKBTMoQ7ChKGCcU=;
        b=bpvGPZXyvsg6Jv9iFgJ+C2bD29oQcqP7PsrAUa+m0aSW8SQJ1EM9crlJ53uZrSOPND
         KnT3ou656INNpfFggN9EatumOXGk1xL2I798Uyu00VYw28TYrxCVjEWcn6M21I2lBUhk
         T3Aqr1KXsfatPqgbtBpy6Mto+0+EkYVDeBxDnYLPhNO7cnVNlvIuIcP22E8AwZMEhzJn
         xBHZyMg0oziUCtdN/scx181IoyeVa61qcwf6PBFmaStCi+JDEsAEKxq4M+CewZsL6//I
         qFz2C9aNBEdosaRIVSBQH1QPejZslAXhXJCLgwctLajEaQ3VLWSNbsi8GZ7PSuExAF9X
         TPKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1p0w26lS1ZsTlli69olJQLvP+hJ26pOQvfmYmN24XiSLXuIiq4oOiJd/F1DqLDU3/plW5fh2zRHItgDPi@vger.kernel.org
X-Gm-Message-State: AFuF++n01eBK1dkKNr3gF4Ci6OflCU61Jswcjp8rAaoWgZCmQjSxB5d0
	zfdSfu/YEWdPT4ghdZpSP5I+LqfU1eLSQO9IVSb2qfOJqynlB37/RE5oH3VziGWIF/6w3/K95R3
	j1UVCOR4gA5a1odSUURo1U06iPFBXC17HtvcmQ+ZtBe5GvPh1K25k5/IlcT9ONOc=
X-Gm-Gg: AR+sD11L4Hwa3c5UedyWXkbSX9ngtEUduyMQD+Ru5RREjHaF5fw/Q6AFZ6tOtqIH4M6
	wyAG+YPWTdiVJU20aOiWN2bAjjXXAeHn+/P/nmfDUvrA1Iv03QWdp61oG9laujqusSmprI5VB6L
	7p8FyEyI9a75ah8m+UxiajKhmZOQ05C8iAidB5ajNCThviLTYSHUWOgRoRvOEWd4D50tCCaKnPH
	CGP7Yk6Y9/YHaZGyc+hKByC5eNoyES3u6Z89NWi4Fsff42PynHGjacV6Yj/3H9HGicA7lKbRTWI
	P8hgTGDGK+wegfYZ/Kai3ecM4LwdR4MVLv8DGKIAP5LBBCxHm550DN9MSYXxko6vlePNR9e8nyH
	/epnVQDnnBQdFunDZDV973AeftQU+tX0ryxB8fxEnuXIDslM=
X-Received: by 2002:a05:622a:95:b0:519:8998:661b with SMTP id d75a77b69052e-52fb9640d64mr173116431cf.20.1788017157654;
        Sat, 29 Aug 2026 08:25:57 -0700 (PDT)
X-Received: by 2002:a05:622a:95:b0:519:8998:661b with SMTP id d75a77b69052e-52fb9640d64mr173115921cf.20.1788017157157;
        Sat, 29 Aug 2026 08:25:57 -0700 (PDT)
Received: from [192.168.0.175] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cca1ed292sm84339685e9.8.2026.08.29.08.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2026 08:25:56 -0700 (PDT)
Message-ID: <6672b30b-427f-45ed-a172-4c47a63d2c7c@columbia.edu>
Date: Sat, 29 Aug 2026 18:25:53 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] block: add task-context bio completion
 infrastructure
To: Barry Song <baohua@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale
 <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
 <20260730-blk-dontcache-v7-2-3e8e6850068d@columbia.edu>
 <CAGsJ_4wUvLoKGafR3U-ji1kUUaz6K_QdN6QxMT-apSaO5tXp0A@mail.gmail.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <CAGsJ_4wUvLoKGafR3U-ji1kUUaz6K_QdN6QxMT-apSaO5tXp0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEzMyBTYWx0ZWRfX98QDMyaGtg+r
 I4KZDfSIyqna7D2HHPZJ9Vpmwz3DwBi+VOiDUuizYVZcaXO4Nb/hLH1nCb7x8jhx8HLdFs0Lmb/
 hHbbUQTPgk3N6w0S5mXZ4emafAv7xumfWtCWxd5jvVdFll0lclcS
X-Proofpoint-ORIG-GUID: cs858SKfwQxcXZMIcQxhqTqVYPpH42sA
X-Proofpoint-GUID: cs858SKfwQxcXZMIcQxhqTqVYPpH42sA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEzMyBTYWx0ZWRfX49c1ISTyLTwr
 gKYzHrlKOGsSKgSbrfa6nYi7VL4992UjL4gyXj+KYI7HY4w924oENdjkrTIvPIwImUEthW5OTxd
 qeiSIUEjGidWrsbmZ37tLr8LmxzzWQTv2MEsqcn3yfr3mUYdTzz/652s6smKuks1gohxUUrVjzR
 HsiC5Coa/E5t2ggB/DRaRhZk0dbdmHq4VCh6smzCMbTB2rckTcyNYNmQP8IeasBbVjjyxYlssv4
 3CAoC0V6k0ElYt0UtnmUedimwqkMSLjz761Ny82jWriZu/BvvYy0THUowfAIMnQ//Sxot25soG5
 SAdE6K73ddX9znCcVbkv/4gh6gbywP+h0OLjyC+F0evj7QISqeX3rzavJZZaV0dzbWa5kZp4emO
 U1yMNhdYPiknYVKy4PNcU7BvPs2zy1CTgtGbMcSSzbdtkh/A7EiSgg5+hDXUiEhCsfs/9hCIeAt
 Ba1f3MiYTVOSo4/dzsg==
X-Authority-Analysis: v=2.4 cv=MJpQXsZl c=1 sm=1 tr=0 ts=6a92fa06 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=bN2RZfqcuyHWyQBaeeoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11890
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=10 bulkscore=10 adultscore=0
 impostorscore=10 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608290133

On 8/16/26 7:11 AM, Barry Song wrote:
> Hi Tal,
> 
> Thanks very much for the patch. I’m just a bit confused that
> folio_end_dropbehind() only requires in_task(), and nothing more.
> 
> void folio_end_dropbehind(struct folio *folio)
> {
>          if (!folio_test_dropbehind(folio))
>                  return;
> 
>          /*
>           * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
>           * but can happen if normal writeback just happens to find dirty folios
>           * that were created as part of uncached writeback, and that writeback
>           * would otherwise not need non-IRQ handling. Just skip the
>           * invalidation in that case.
>           */
>          if (in_task() && folio_trylock(folio)) {
>                  filemap_end_dropbehind(folio);
>                  folio_unlock(folio);
>          }
> }
> 
> But we’re applying a much stricter check with bio_in_atomic():
> 
> +static inline bool bio_in_atomic(void)
> +{
> +     if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
> +           return true;
> +     if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
> +           return true;
> +      return !preemptible();
> +}
> 
> I feel like something may be missing either in
> folio_end_dropbehind() itself or somewhere in the
> filesystem/block-device path.
> 
> Do you know why they don’t match each other?
> 
> Best Regards
> Barry
> 

Hi Barry,

Apologies for the delay.

As far as I can tell, the in_task() in folio_end_dropbehind() wasn't meant
to be a generic test for if it's safe to sleep, but rather filtered out the
known unsafe case of buffer_head writeback completing from IRQ context.
In contrast, the bio_in_atomic() check needs to be stricter since the bi_end_io()
callbacks could sleep or the callers could be holding locks, RCU, etc.

I see there's some more discussion about this at [1], but I suspect there are
other instances that are (incorrectly) using in_task() as a proxy for being able
to sleep (like f2fs_read_end_io(), but I haven't looked too closely at it).

Additionally, it probably only makes sense to use bio_in_atomic() when there's
some deferral path, since with CONFIG_PREEMPT_COUNT=n, it'll always return true.

Thanks,
Tal

[1]: https://lore.kernel.org/linux-fsdevel/20260829121335.3491374-1-qwjhust@gmail.com/T/
