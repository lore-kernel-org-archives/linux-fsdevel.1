Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC25C381AF
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791589067; cv=none; b=twHUZ40PQgPD50Nj6WWXkvTMsnmgaCq0QpzfH/A9c2aDXrbe5CF2sKaNmITpfCIQPKVl0AQjg26apIL53iRNPXzzbvdHAa63oYwAiP2KcuFLX84YogrOw5SbxluKVBd86e0HwJjKO6mCgdHKnX7xG8iGZGQcfmnL7cx9ZvpOQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791589067; c=relaxed/simple;
	bh=OKodHFZEnI+FMKoK7JBIyi1U9X4CsecEkrxYzANxXz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwyP8es0dH9At4havuL2hBP1XIFJgQrvekDJt7q1AOMPHnW83PGYIrS07PAntqsmBIoe7ypymmOQQd6X07BO1zZDGrmV5dJYNHJ//TsbSMeYYv0ztMgX9850qUY6Gfm+7U72SGoj53yO91PH5bqtNp301/vAQbANQBf1jkFGlwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=F0bd4tpR; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=kd9U59rm; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="F0bd4tpR";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="kd9U59rm"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699MYSET557186
	for <linux-fsdevel@vger.kernel.org>; Fri, 9 Oct 2026 19:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Mw41
	Ih6nkA8nu506+XqGmwlrnZ/sLArqz6JBrx/ZQ/8=; b=F0bd4tpRaRd08v6gRl4k
	jlev/an4adj4/T8QMaJMelhn0rrE9LbnL7ue/gbLQT+nJIczpAsUfcfJkGkCn/XA
	xzQlc+cmmw2SJ9nw3lFmIXaGIiywjmNBvZ/U8mp5TKp7jkBouKTdEw6CWN8jvswV
	COzz0IKzwRTTPVUZJaUFglTJX3e1kaqrtvK3L/Qpg5qs5eWTiznlGx5IP51LPjx8
	DYbm2JjF7bvLg8BVqakzJxAOOQfC/yUSmsPTGn+tQNqZjFReeKMQeKZ41+nxx0Di
	hNL5uO2SDcdLfzMr4YYzMJR4fl0tZbPBUn6BmbEdMpOvxmfz7y8ROf4AIl1ZvV6d
	2w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4h74te2f1v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 19:37:43 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-917ae0d52d2so6946916d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 16:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791589063; x=1792193863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mw41Ih6nkA8nu506+XqGmwlrnZ/sLArqz6JBrx/ZQ/8=;
        b=kd9U59rmaqK07VrlzSlAGIGz84UpevpSKTIZJQhsOVi7W1tpoNiIZx8y6rosTFEOBu
         AQ8EiqYTIcDJFQWuHEON51Q+dmhM69sgkIazgQx0RgCjFpNOlLjV2zx4ILWCbC+vFgBo
         ck58ECFraMx7QUzq3zCrKCNveWBg3kcYhth3sHvjfE1qD2IlYG+bjs2e631d2cc4b/Vo
         JI4QtsrfF3zIf1Olf+1wEuHZlL7vP0zJXedoKs/2hPCZ+AAyVaQH3YfsqHXzaWvvWUI5
         2eSlxsYHdvD2KamZPcpH9XuD4KF7NKoi1rDm3LnRzGFyXnmDamzZYDmsNMvlnmycSljM
         5oBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791589063; x=1792193863;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mw41Ih6nkA8nu506+XqGmwlrnZ/sLArqz6JBrx/ZQ/8=;
        b=b8qVYMYjbOWtLXLqWdnGde2/6nv+U2FmYLbWgXLEHEcUqDyGlAnWZLkNyINCdaRoUp
         XqYZAYb98tltK86ltqMwf6ybw4WlUEdjDhISASNji/SrmuUUTlxX+0Du9amOR5yKiTCN
         3MG0DMHvCIf5Z316HeAIa3tD8pXmiXyTF6Kbphr4+hB3nWpDWmCOAUWLiZ7QRBlX7HjQ
         vsf9xp3SAhDSKD461Y2RKoFDzdOFBh9tFuY/CG12uJmhcpHJ7PpCMKjUFCqVZGOCf93B
         VQfCMlusa0cgPDiZaI5s6PWClhnM/jeWVi1Cd69cyeP4MSaDCsE1XigZxMTvdAcRhrHY
         qkuw==
X-Forwarded-Encrypted: i=1; AKwUvBxgX7uEvgMexKlOwN/KcOW9baJa40rJkHlKOnbDAj/bSTlViagnuOeRh8K8VEfzTiEsykjtGtE00s6y3Xz1@vger.kernel.org
X-Gm-Message-State: AFq9FYIZPyOSbUc28WIZ4h34tSPmrnC8YuyFCEQLBmDDqA1W1abp95ND
	sGVRK2humtymlGZk7VZ+jDHg+SHy69U1OMAb+wUFMJst5HuLB0E0zFUviyL0yBJ1YDTSCNm5k3y
	juNTmFJ3i9di1+h/UmMkDlZFHeNesmL1vGZrE30/DdsufsqU6PmM+C7fIktg7I6Q=
X-Gm-Gg: AYBFou0Q2fhufHganZ0x0hS0ht3tzCW/MjBvhFDCFkx1qMgRlcl4WTXEyrtZ7q2i0ax
	7hr9/ovpwarI0qXpF2NDeqf5QczNsl7+emvqvNNrp3sgw0F57IkGruIpobOvhe8Ikm3mVvVIAWq
	U7P1vBc/fDhkhGHxX6L4aRAD8A+Q6ptZENtOe64cas9vsNpwiWZ95RLmox9tCXlOmwxJ3G4wZf9
	PpTaizmGqfnDuencjqV3Hk0j5bdm4rMJOBb5uMt5zeg/QvAkQxZXGP1W8V/RKcHfaQ9zaucGeDn
	5vB/XRadPbMk5g9aRfSJwcIVcOXD8h4cTDxzoSxgSsjmPZtf0PWw2rva/scecogE6jZE1L5PIS5
	ehCrjGIieD075Orj+xmanGkMt4kgJhXFzH4kSSuFV+k/V3hwu
X-Received: by 2002:a05:6214:5c43:b0:914:4464:41b8 with SMTP id 6a1803df08f44-91b554f0b6bmr59818336d6.12.1791589062851;
        Fri, 09 Oct 2026 16:37:42 -0700 (PDT)
X-Received: by 2002:a05:6214:5c43:b0:914:4464:41b8 with SMTP id 6a1803df08f44-91b554f0b6bmr59818066d6.12.1791589062379;
        Fri, 09 Oct 2026 16:37:42 -0700 (PDT)
Received: from [10.207.9.0] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550e177csm30584396d6.47.2026.10.09.16.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 16:37:41 -0700 (PDT)
Message-ID: <6fcad27b-b13f-42c3-a400-89115a23af70@columbia.edu>
Date: Fri, 9 Oct 2026 19:37:40 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] ramfs: Use filemap_add_folio() on nommu systems
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc: Daniel Palmer <daniel@thingy.jp>, Lorenzo Stoakes <ljs@kernel.org>
References: <20261009165518.3863950-1-willy@infradead.org>
 <20261009165518.3863950-2-willy@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20261009165518.3863950-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MbbpmvUcbmPaoRXBAasGkqBJ2Rsur0Hc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5NCBTYWx0ZWRfX0Wu7koUqjSZH
 d/FX/3n2pw74XekohCP52YMPY23ckjHP1tkBt6vazsQNq+fyLrbB5OGDemYL0mQ/bnEfdH+z4Tb
 mBcdYtAOfoOU7DRFbj2Q+yVfkvibC8EfqsdpjCcU6SCin5yw83jl
X-Proofpoint-GUID: MbbpmvUcbmPaoRXBAasGkqBJ2Rsur0Hc
X-Authority-Analysis: v=2.4 cv=avMnmiZV c=1 sm=1 tr=0 ts=6ac97ac7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=EhlLoIHFiy2N6aASVCcA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5NCBTYWx0ZWRfX0Ac1zkoaFi/M
 qI1r+bolPPCFkClV90SQW/OP1wmvvj3g1n5L6dIIVRRVDeIH9WZKgNiYs2einbJl+On+x18gbFC
 kkNKFnOdoWe/I8Mc5jJIhYzHbOsoY1ovuA4uhmhf1x4bah1O552sk3gOgq+AX/LMwlCe3Q3ATIn
 UuXUadwp3ItQpZU0N2lJMn8nb9rbGyIE5cxmz4i/jqUa2FJpVJFAjPsCQyROBV7Tz9sMLtcHN9R
 FTDIb95+G1f4QetPkaCMgzfBwFPlKJGbIo6seKIAN1d5BYAZI5Ajd1JJfMEQNALYRoUhrOanIFe
 RPkh1UN/2KPTTOB+EDIz1B8NOIOsN5E1Q63UGuHjTkEh3bTdAOHiWwY5ghz8Y2zP5iufZeGVcOr
 bn9WbWnYpJAvzEAwZypdbRa1l+2DpNJdzhfzkPP2y+ciSjCKbK+cejLRRzZgIu52j8TGemR140A
 bhGnou4DrYcumuxIHeA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=10 impostorscore=10 suspectscore=0
 lowpriorityscore=10 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090094

On 10/9/26 12:55 PM, Matthew Wilcox (Oracle) wrote:
> 
> Don't send this upstream yet.
> 
> Need CONFIG_LARGE_FOLIO first.
> Need to enable CONFIG_LARGE_FOLIO on nommu
> Need to handle errors from folio_split()
> ---
>   fs/ramfs/file-nommu.c | 53 ++++++++++++++-----------------------------
>   1 file changed, 17 insertions(+), 36 deletions(-)
> 

You beat me to it ;)

I looked at this a couple months ago but clearly there were some issues...
I'll detail what I tried below, but I think this is better (apart from a
couple small things).

Instead of folio_alloc() and folio_split(), I just did alloc_pages_exact()
and virt_to_folio() on each page of the returned allocation. This avoided
the THP dependency but also added pages to the page cache as order-0 pages,
which kept the loop and was generally ugly. So I like this version more.

However, since we can add a large folio to the page cache with this approach,
I think we need to fix up ramfs_nommu_get_unmapped_area() for large folios,
as it doesn't account for the requested offset when doing the pfn checks and
incrementing nr_pages for the contiguous range check. It could probably be
simplified by using filemap_get_folio() and folio_next_index() instead of
filemap_get_folios_contig().

With that, I think we could also pretty easily enable large folios for
regular ramfs files. It's just a matter of adding fgf_set_order() to
simple_write_begin() and mapping_set_large_folios() in 
ramfs_get_inode(). Is that worth doing?

> diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
> index fb471bf88ab7..92f33bc7a49c 100644
> --- a/fs/ramfs/file-nommu.c
> +++ b/fs/ramfs/file-nommu.c
> @@ -61,8 +61,8 @@ const struct inode_operations ramfs_file_inode_operations = {
>    */
>   int ramfs_nommu_expand_for_mapping(struct inode *inode, size_t newsize)
>   {
> -	unsigned long npages, xpages, loop;
> -	struct page *pages;
> +	unsigned long npages;
> +	struct folio *folio;
>   	unsigned order;
>   	void *data;
>   	int ret;
> @@ -82,49 +82,30 @@ int ramfs_nommu_expand_for_mapping(struct inode *inode, size_t newsize)
>   
>   	i_size_write(inode, newsize);
>   
> -	/* allocate enough contiguous pages to be able to satisfy the
> -	 * request */
> -	pages = alloc_pages(gfp, order);
> -	if (!pages)
> +	folio = folio_alloc(gfp, order);
> +	if (!folio)
>   		return -ENOMEM;
>   
> -	/* split the high-order page into an array of single pages */
> -	xpages = 1UL << order;
> -	npages = (newsize + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -
> -	split_page(pages, order);
> -
> -	/* trim off any pages we don't actually require */
> -	for (loop = npages; loop < xpages; loop++)
> -		__free_page(pages + loop);
> +	ret = filemap_add_folio(inode->i_mapping, folio, 0, gfp);
> +	if (ret < 0)
> +		goto out;
>   
>   	/* clear the memory we allocated */
> +	npages = (newsize + PAGE_SIZE - 1) >> PAGE_SHIFT;
>   	newsize = PAGE_SIZE * npages;
> -	data = page_address(pages);
> +	data = folio_address(folio);
>   	memset(data, 0, newsize);

Should this become folio_zero_range()? I don't think it functionally
matters, but it looks like nommu arm does implement flush_dcache_page(),
so... I don't know...

>   
> -	/* attach all the pages to the inode's address space */
> -	for (loop = 0; loop < npages; loop++) {
> -		struct page *page = pages + loop;
> -
> -		ret = add_to_page_cache_lru(page, inode->i_mapping, loop,
> -					gfp);
> -		if (ret < 0)
> -			goto add_error;
> -
> -		/* prevent the page from being discarded on memory pressure */
> -		SetPageDirty(page);
> -		SetPageUptodate(page);
> -
> -		unlock_page(page);
> -		put_page(page);
> -	}
> +	folio_mark_dirty(folio);
> +	folio_mark_uptodate(folio);
>   
> -	return 0;
> +	/* trim off any pages we don't actually require */
> +	if (!is_power_of_2(npages))
> +		folio_split(folio, 0, folio_page(folio, npages), NULL);
> +	folio_unlock(folio);
>   
> -add_error:
> -	while (loop < npages)
> -		__free_page(pages + loop++);
> +out:
> +	folio_put(folio);
>   	return ret;
>   }
>   
> -- 
> 2.47.3
> 

