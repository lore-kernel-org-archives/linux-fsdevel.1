Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5A45D5FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816867; cv=none; b=kReRIaELGThc/wDNECwb4scf7oOX8G9n0UYsBLjlmFVD/W7oh/f3qVAv7EYF6Y+P0lhQ9nR9uhqbUGd92cYgd1AQBgCD/s7AsbEi7Ci1b0Fhl8uJhQWgVZIr/ESydq34RfkWIXNNHTMbVnOWFfg7HM4L5rgiTTakCNLSYJMqnbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816867; c=relaxed/simple;
	bh=uEGi+v5mIFyrmKaRy5WGx/AYHuXx6yiBnFc/1b89L48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HU4GRrAbEUCcBnk5Xg5rCVCNRzjNvvm+/2DKfcS4BazRaEaJM+3bp1J7F2F7cs6T5UDvwYXdkPvTjNzfvyrXGMhIYgq2roXb4yW0eEj/5rIyk3W2wDziafzVHYhzK40pDm+Hp3TgKRRFiDw1jae186Tz2aW/R2hViwa5aPcAGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=VXXBB2La; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=e3mflisL; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="VXXBB2La";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="e3mflisL"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CEgVT31408476
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 10:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=UItR
	iT5YnrQlpW+YOF3Po2aWsL1V37LtJ2ZFJ6itops=; b=VXXBB2La7ZHL/OX+CAYw
	rWLjjSej48q6f4A5cgmlHf5Mr0NNUo2B94piL0R88yzZZBII8EGaAtKpZnBkcu36
	zimSlT2nB9UiGmhj4dFOY/AbhEOp1sMFaw6QHHX8Ybv05SnuFrsabWfgpneBjEZu
	D4HmBiiiZqjlZsyHFWg63vmmwjDiJ029MZ2RQMO/PS19o59HteE76wpBQLkuV7hf
	QTO8p6/EesfA+WG1HYWTC2IClpGz4NOa4M8kOAkrroQTUgoNyJj/EhRwXyVBBs8V
	elxpwU2nED36s52pAMzdEhHrjUXm7frUQiFIV7k0/YmG5gwgbPyWqLrvCnd5EPzn
	RQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4h91hc83fr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 10:54:18 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91b7e7d5f56so23893396d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791816857; x=1792421657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UItRiT5YnrQlpW+YOF3Po2aWsL1V37LtJ2ZFJ6itops=;
        b=e3mflisLJY3ISi+J71KllE9KEkte0oVfOJzexCsO31UrOiQayqIRgyXXeZ0s9sq7vF
         RapX94/JZ/Acg2BqhqEFlP+h22Ozu/+CirRAz3aIwHUaUUgL9a55O4/pj5O4YiQGAyYK
         o+lUH40ASNJocBzxyKtjXDNV2GefqJC9A9pdI1cBkfKuqa8Z1iitetfYjH2HsKkFNJMr
         FMohveSc4Nk3Bb6AUpA8NaVQEIk311Fr66LbZOxgzpam3V6IZoSa5QxOBO0koS08umdw
         e27iwoqtsH6si2oSiPYpMzaZ474VlMqQ/9OH0TlRLSOJ7+xSjtOYb+mnfdEusct1CEvb
         2G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816857; x=1792421657;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UItRiT5YnrQlpW+YOF3Po2aWsL1V37LtJ2ZFJ6itops=;
        b=thPbv4+RGqLN4/y67zx4CeHL9lemW0V1cKYgVe9P8HZvz/kiiWSthmr/bsUzGk9yuM
         Ttad3UoM3b+OIVAcPcm+yE4CWVgqwFqXxmdxK0JGkEapo2x/IygVo7mQbBDNdmmHlDRW
         KX7cjh54xEoCcjmmdyTbWnlyTKS6CGOliFXEpNGFf1pr91Nxc8ggEehEJV2gXLASIZXo
         1/dsEM4mJ48v/t6LhepBy5ahTqmSXGe2mTj7gWsBwdUEOr8KMxG5WGlq+Ni147bPuKF3
         iYJqxkP93iWl9nIggzjzk6gHIq1RStUoFZ2kl9fUHK7GkNK3DYt/1CfhEN1tajDs/+ks
         CM+w==
X-Forwarded-Encrypted: i=1; AKwUvBwFzAbj292JEbk2mZHnFlBOB7s2gVTEtxNZybYbJUTWzvSh4GnXLuL7fKwGOdrR9Wgs/LWMh2b7aRgJxxEv@vger.kernel.org
X-Gm-Message-State: AFq9FYLZ7oFY4RTw0DPNbQPkm7IgQnsOXPj8TUqmXofgCsltadGbtM2M
	z2Tgsokim2BNT1yBRoiYOmtLGf9Ii0GP2h+pYJG9IAlkRpQNBypz7WqPB4K71+Mv0UO3uqAtLgP
	0LTBvu2JeWmKTRGVcrDo+C3VDJPhhESZs93ltSLIWuo5HQV99QPHwOg6lZrLHBD4=
X-Gm-Gg: AYBFou0qwKesVYEl0BVA8jdAB+1DJTh3+vEmX4415AB6Hm8E8RLh3OEcpUcAa0SCjSb
	be2twU7Nz1p9srIxS/MDUNSl1zAkCyVERPcRJ1I215fUuMXTo7H0sX1T9JGjMEK48+6uyu7/5GC
	2saXMP0JP/grKzO6uDRCFT4XhgqjKBEolYSAWcCn4HYDgTBr9h+ISF7DTfka49QN9pYU9pWj7OE
	NRNLzxnLD4ItovaVJ66XIU+EdJ7Okp22ZlPN7oBs5mqwyh2rnI2NoaV5JS0Y+WlKhXGKVvb6RA3
	CaWJEZEikT60gfGXllANXN+7JsJOPHbZ23nbHVV+FCOgoKW/UZOxTq7HhnhmY/+rLFlhJFtoGsI
	SltVW1cxVvxCQjr1lw6au2QnICqFM/mVgXOx+NjdIbs3yltx1
X-Received: by 2002:a05:620a:2b89:b0:93c:63f5:eab with SMTP id af79cd13be357-93ebd24f64emr1651502785a.31.1791816856999;
        Mon, 12 Oct 2026 07:54:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2b89:b0:93c:63f5:eab with SMTP id af79cd13be357-93ebd24f64emr1651494685a.31.1791816856101;
        Mon, 12 Oct 2026 07:54:16 -0700 (PDT)
Received: from [10.207.9.0] (nat-128-59-178-231.net.columbia.edu. [128.59.178.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50287a2sm2852485a.20.2026.10.12.07.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 07:54:14 -0700 (PDT)
Message-ID: <810d7901-b897-4880-a8d4-d80fe0f8770b@columbia.edu>
Date: Mon, 12 Oct 2026 10:54:14 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cramfs: convert cramfs_blkdev_read() to use folios
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260906-cramfs-blkdev-read-folio-v1-1-1be99a82be55@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260906-cramfs-blkdev-read-folio-v1-1-1be99a82be55@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 23RLRtJO8tEKgcqfRPLn8m2L1mQGN6I5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OSBTYWx0ZWRfX/fDmq3+7Ugkb
 +ubPIuJd8NbyN2wZ8bKIPSPmAHTwsSMgULAMOKOu6FX6P1XNf30HzfiyzU7ntm2ebE0oHllE3JZ
 QkyGk7Ys1TlI9IsedS22Y2oNLM3jvV6lZplprHtw+f2QkLzbt9fe
X-Authority-Analysis: v=2.4 cv=Wue+otfv c=1 sm=1 tr=0 ts=6accf49a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=9fnr1hFzp71kSIFw8uYQYA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=PQBzku6fbGuEC0B3IqIA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 23RLRtJO8tEKgcqfRPLn8m2L1mQGN6I5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OSBTYWx0ZWRfX1gVWncy6vDLD
 R51+kto/JOE4inlc40AjxQOT96lxK5+S/lpEQNljUWeQsJYGihcHaQLXKvrHkeT5T68E278TykO
 VaqamiH5ROY11wRrGaaHWzSa/3HDs1WXvJ/C7e1GWdnk7LLrLgE+u/r5T9n0YHxZkkA8ByVmvYz
 m7paKaBoo6O9UINT+3tOK8U+L++18UAIRn+o0wbZ2dVl0StxNibPLUVsYw1jYbSSb2jGa6BqVSQ
 naFRLhQLSO7XoHXLr5geyNIeSDeY2ZXlLmgBPQ4xadwNtCaVWHuUIB93fqAoAB+LbRLwbVW3xZa
 MbvXlDHsdqY3+WMRtB2LIqJUekiMiEs8ZZ+ojgDZnwwDxP1gASjXOh8+/H6yMzJb+hIUW8K2rkI
 dlmoVIhVYDbgmR4ulhl9Yfz3ScLaITgH4CIJNWloEWn7icAyMzAeElPXTxYfZ3oOuNJO3fazhF0
 mgPG+3d7ug/d3mThlRA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11933
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=10 priorityscore=1501 lowpriorityscore=10 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120059

On 9/6/26 7:45 PM, Tal Zussman wrote:
> Read the block device pages through read_mapping_folio() and copy with
> memcpy_from_folio() instead of going through a page.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/cramfs/inode.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 

Following up on this - I don't see a cramfs tree, so could this go
through vfs if everything looks ok? It gets us one step closer to
removing read_mapping_page().

Thanks,
Tal

> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index d4cd03f4f60d..b55eb3bd29c1 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -194,7 +194,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>  {
>  	struct address_space *mapping = sb->s_bdev->bd_mapping;
>  	struct file_ra_state ra = {};
> -	struct page *pages[BLKS_PER_BUF];
> +	struct folio *folios[BLKS_PER_BUF];
>  	unsigned i, blocknr, buffer;
>  	unsigned long devsize;
>  	char *data;
> @@ -227,15 +227,15 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>  	page_cache_sync_readahead(mapping, &ra, NULL, blocknr, BLKS_PER_BUF);
>  
>  	for (i = 0; i < BLKS_PER_BUF; i++) {
> -		struct page *page = NULL;
> +		struct folio *folio = NULL;
>  
>  		if (blocknr + i < devsize) {
> -			page = read_mapping_page(mapping, blocknr + i, NULL);
> +			folio = read_mapping_folio(mapping, blocknr + i, NULL);
>  			/* synchronous error? */
> -			if (IS_ERR(page))
> -				page = NULL;
> +			if (IS_ERR(folio))
> +				folio = NULL;
>  		}
> -		pages[i] = page;
> +		folios[i] = folio;
>  	}
>  
>  	buffer = next_buffer;
> @@ -245,11 +245,14 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>  
>  	data = read_buffers[buffer];
>  	for (i = 0; i < BLKS_PER_BUF; i++) {
> -		struct page *page = pages[i];
> +		struct folio *folio = folios[i];
>  
> -		if (page) {
> -			memcpy_from_page(data, page, 0, PAGE_SIZE);
> -			put_page(page);
> +		if (folio) {
> +			size_t offset = offset_in_folio(folio,
> +					(loff_t)(blocknr + i) << PAGE_SHIFT);
> +
> +			memcpy_from_folio(data, folio, offset, PAGE_SIZE);
> +			folio_put(folio);
>  		} else
>  			memset(data, 0, PAGE_SIZE);
>  		data += PAGE_SIZE;
> 
> ---
> base-commit: df2908090cda368b01ff43709f51890076c56157
> change-id: 20260906-cramfs-blkdev-read-folio-16fecf6908ac
> 
> Best regards,
> --  
> Tal Zussman <tz2294@columbia.edu>

