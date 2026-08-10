Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B0364953
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378231; cv=none; b=fEXIeytaaTnUXHB4A+s2HAGwSg7kuZSc2iCv3YmSXsNzLIFO4nvmjmppj6R2y1/vErN9oRvb43wP97FxNzTM7xL5EsnqGb6bsixurKp8laUgi8WS0QEcKhm5FObd+n8v15lJnAtAOo35Wlg9KmXoym2s3C0Ifd7VLzKnDPXoKAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378231; c=relaxed/simple;
	bh=/AF03rHuJDyQBfFPu4ugDlBCG/z+8RMKjZwI9veqS/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RllVb9urXig+pHfWOGFOKocqt53tn1aveWrIktf6TUhDGZ38VtdTJnMFEyt6jCQcqfOAT5vokWjEbGf3/Eu+gmOfJ5OqET+juSnSqUJVagfRNyPbcUysIPnXqeTfdOFs/DWSmzY/weKc6syVY7NzSRoX1fIM+B1CVZ0Ars/svGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CyN46gAF; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CyN46gAF"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFjFYt3224790
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 12:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=f0bZ
	ditIahGukFZnD48c1dgtAdNiTQKz0eXUlzu/oaY=; b=CyN46gAFzGTv5sCQAiJ+
	xhJD7DYCrTeiGETf4yox+1+3CDtlrqNvkTFW4J4vobHmLbXUHDE3doFn2xz6glN6
	k3BaKUBMntJiRVVcyGVM+aPSYqFm+iaf0XYNNoNBeRDmY9JppLG3h/hrnHSqxXvv
	vjK8KVgvBMjsQt6iPYPncBt/4wLvSNnFasjiicrFClgJgyo8becIWZAI0ulxYnrR
	6gWJbEIwkZVX0gc0uqUhLZ6UiI8xM4a2dmU0T4jB029Z7GGdBlXVd/OkAW3bqRIn
	Cc8m/OyKwiMnlPkQ7RPRQxLQ1PMxJu4vRWd97Of20SU/QcoKr4fq6yE9zIqHq0a3
	1Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fy3jdbq3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 12:10:22 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5276aa86d00so20749951cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 09:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786378221; x=1786983021;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0bZditIahGukFZnD48c1dgtAdNiTQKz0eXUlzu/oaY=;
        b=B8+2kWsSnc9nOAfnlquBJkSIPZxJMc7byPlvahPXM5dRtp20nszwH7U95rR3rt3W5+
         zLdIQUwKfJnUAVu91x+0TBMEARqSyqj24DTvBI0VK25aEZ616W9m9vxrSimo/BQORNUM
         20EgehWawQbfLUjsD6Txcmgym88Ikzg3XGVZaILJna3VQXt73Z/AL0n78GdbZaw0r2ch
         Yyg2hI8xE0lSy8E8dGm9hw/hc4SDeigI86K0z6HJmmFgkYRJOX0z+I7dSGaMdFeOXyvY
         EPz6wn2W4eTLTvESoii6psrwVaXCp0z9Z7h9vnDg7aM6ri+unclB6Fg4oHh7IFPQ2IqX
         cXtA==
X-Forwarded-Encrypted: i=1; AHgh+RrEmFlTgi9qqMsnDPlVWqMGRAZ7lZf050rogpohut3AMqt7Y+vrwRb3XuUSuhlEKSTlfF2lXFlzyJAo9gLC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KJJfP6dgV5l+X3BkXHo8cKGKCLX4D9jdFf0wI1e6G97vd4UT
	frCKhdEX5ot5ISjkECxldLJLfMugb5KIPbKZS0BGyeSMCEEhN071VZxKrM/mAJ60GJomVLGvK3P
	6H4q4tjxmo4X1Xqc8wstzvzw1fIqplCONvMPtkGGanhNhPrDtK1gABwCIG65xl6g=
X-Gm-Gg: AR+sD13wpajr+oe0pdgfDMr+Axjhmb/29iAH73TluCONAnmDB8mMfYf8ppLrDIZROcu
	n0ybkWfm4HLbiTkXGwPfaJBwDv41ImLFrvCUFJB7/vN9mjKXEuw6tu08/E78pBwY6P8DzCASpRr
	fMxrER1M5Fzkb6abnpZe8lrsCjKBBf1VWFnqLZcydL/Y2Ehc/sT3TgRxffbHjzGWyeYcKW0l8gd
	4yPOk7ctBkGuXez1/9TySXW9eSyL2mL9JBrDZdiFzgAJQpi/1kb+Ej4m3n1KGinfiOu/nPSLZ0F
	zcrx/gzgapYDFItiYLjASqnvgcPkYybawFtiwA0WHfNJkote7vSE3e9lTie2iVrP5kUt3QISa21
	9b52BlX12UAjFX5RRPI6juJYJx2uWwt/2Dbj4AphzNLw6JU4dSRVStg==
X-Received: by 2002:ac8:7fc7:0:b0:519:89b6:78b4 with SMTP id d75a77b69052e-52d20a819bamr234404681cf.40.1786378221627;
        Mon, 10 Aug 2026 09:10:21 -0700 (PDT)
X-Received: by 2002:ac8:7fc7:0:b0:519:89b6:78b4 with SMTP id d75a77b69052e-52d20a819bamr234403791cf.40.1786378221085;
        Mon, 10 Aug 2026 09:10:21 -0700 (PDT)
Received: from [192.168.0.165] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997402a89bsm4159805e9.0.2026.08.10.09.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 09:10:19 -0700 (PDT)
Message-ID: <8eb00a03-d6c6-423e-9768-48fd2566f11d@columbia.edu>
Date: Mon, 10 Aug 2026 19:10:16 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RWF_DONTCACHE regression fix for xfs
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
        Christoph Hellwig <hch@lst.de>
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
 <annkDbhXBEeMoNVT@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <annkDbhXBEeMoNVT@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzOSBTYWx0ZWRfX4LgZxjD7325w
 fg6SyLNjGmm9KU+S41NJ40vhEDUBwwoMHugQzx8lghMN5cXjqq153uUQlR4EDZRDaBEFdQvCfm4
 0FJaOwaJHeKVechd09s3PRP4SBFAuvqZJ/k1Uz/J/uC0FdOzhk42
X-Proofpoint-GUID: xtb3d5YG7fqNeFGlegzxVI-BCJ4cptp4
X-Proofpoint-ORIG-GUID: xtb3d5YG7fqNeFGlegzxVI-BCJ4cptp4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzOSBTYWx0ZWRfXwhpn7NP8anqp
 jBDfni+Qf4m7c8kasd/hOcYX5oMlKr+ELzkoJOhIsRhpcJWshtXoBwHmiKo7g3EiQVYFfxuhYNo
 rlX8sjYlQUwgQXU24Jttoi4G8dObjGWWvfptclJ1utLuKRR8sh+O6c90KR6WKuGn4+UZB4nKczE
 9LMbXUyom2IWQ5PiTIFTH6oy74qNpjN56lZxpSAx3U+QMOivrtvuVZvFV0KJ+IQAkvV5Ss0O/ux
 4+8KmoUiRDC5i/d9BQNcPwFXwW96pBxImF8dTLJMpXxK+nxbl++IqArnCtZN0cRu4CpNG9urPNR
 9DNJc0dIdSL2sqsF98OXx0Ubd5DW8avxwzGk/Zhk0eKVn1VEWwCu3bkP3RtLt/zoFGBAs8/2Z86
 UgFAWaLHemjY8H2ovzv2p++P0OmyQImSxW85ye5JSqrNoqxTry8Rh6QV3jmQntWVDoTHn8wx9oW
 XTuH1Mefn6Uos41rojQ==
X-Authority-Analysis: v=2.4 cv=JPQLdcKb c=1 sm=1 tr=0 ts=6a79f7ee cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=dys9yn6NND9hJ5TNHOUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11871
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=10 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=10 clxscore=1015
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100139

On 8/10/26 10:45 AM, Christoph Hellwig wrote:
> Below is Tal's suggested fixup for xfs with the whitespace damage fixeѕ.
> It should probably be attributed to Tal instead.  Can you handled it
> from here and send it to Jens with your signoff/authorship to avoid
> the performance regression in XFS?
> 

Yes, will do shortly. Thanks Christoph!

> From: Christoph Hellwig <hch@lst.de>
> Subject: xfs: avoid double deferrals for RWF_DONTCACHE writes
> 
> XFS already defers some writes to a workqueue when transactions are
> needed to process the I/O completion.  Disable the block layer bio
> task completion in this case to avoid a major performance drop.
> 
> Fixes: efbde6f9f449 ("iomap: use BIO_COMPLETE_IN_TASK for dropbehind writeback")
> ---
>   fs/xfs/xfs_aops.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index f73e26d9c9f9..059846a8d65c 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -372,10 +372,14 @@ xfs_writeback_submit(
>   	}
>   
>   	/*
> -	 * Send ioends that might require a transaction to the completion wq.
> +	 * Send ioends that might require a transaction to the completion wq,
> +	 * and disable the block layer task completion for them as there is no
> +	 * need to defer twice.
>   	 */
> -	if (xfs_ioend_needs_wq_completion(ioend))
> +	if (xfs_ioend_needs_wq_completion(ioend)) {
>   		ioend->io_bio.bi_end_io = xfs_end_bio;
> +		bio_clear_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
> +	}
>   
>   	return iomap_ioend_writeback_submit(wpc, error);
>   }
> @@ -481,7 +485,14 @@ xfs_zoned_writeback_submit(
>   {
>   	struct iomap_ioend		*ioend = wpc->wb_ctx;
>   
> +	/*
> +	 * Defer all completions to our workqueue as all zoned writes require a
> +	 * transaction to be persisted.  This also means we never need the block
> +	 * layer in-task completion for a task context.
> +	 */
>   	ioend->io_bio.bi_end_io = xfs_end_bio;
> +	bio_clear_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
> +
>   	if (error) {
>   		ioend->io_bio.bi_status = errno_to_blk_status(error);
>   		bio_endio(&ioend->io_bio);
> -- 
> 2.53.0
> 

