Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16041413230
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910000; cv=none; b=QA9afKFN2QvQGo626aYMXf46q1DUKaJvTShWKX4dyeoZO8gmWHuIw4xvSzzZRHv1nxqYJY0vrKMKIAp3af3KaX71PFT7MUVo7VY9hcYq0mHCo9nlH2I7OzrBWTyIMLmjsRhSVzJKZ54AYb365XGBVj/uuKJj6XotMpmMdIhmtIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910000; c=relaxed/simple;
	bh=1uNtoEPn1axBBTz/xvu5DMTLl85+9t1E0I35mjRxhXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7S4Eps41YQzEmTWn+F35GBOPGOLykg0mmO4R8Po8b4oBAxXcJ31hlrPx9cs1tcViaJH8gQhmR/88gbhgnIHDq/lACjUrZSGG2ZLcY0IsaxkcPQh25rtNNH0pKmzR1I0MDSUpw1whBYYnrYPqAXgT0PNfkL4w2bSPGjTbRktPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ts9r5Kt5; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=SkbLOIUU; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ts9r5Kt5";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="SkbLOIUU"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DGYSxH3890830
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 12:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=YZtt
	3JvqXqsF3YecFG5xLUkWJg8SzoyuQA2ME3mmpjA=; b=ts9r5Kt5EGrbXR38GXpp
	ZnPuX+JbNirHfeJ4NgbbHUSviGCiz9g3ml1b6yrnPpZMlzOjOfar5SnFRmC9ntd+
	eFu3OjVBKjxqgkXkv4/3+oiiz1Ui3R0+t5F4NvUjry8kG761lc/kp9qbUZvBRNce
	So5UoKtNfZuhSresZUJSxcTrU0fzyk+jBOVVS6kRsLr5deg8zK3qf9/PG4zBgejq
	FAQzASdmU8GSbxLgV6i8MUU57EBe5WRaX/oxUaDNgrnILg1bNpOhx3Ohw4giHxUk
	PoYyOEhTJojgrMVNWtGG/kax1yeS9s3L2ePftQhuijDL97Ms/zV6TJJYMwF8ejeT
	qw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h9q1c0x8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 12:46:31 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b69ef6514so50643786d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791909991; x=1792514791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZtt3JvqXqsF3YecFG5xLUkWJg8SzoyuQA2ME3mmpjA=;
        b=SkbLOIUUII19jQ1Y2vmuIBCWufE00OEcaj+gzMsC7ysPZ+rHeaL5GmlhGbQ/6/SHVS
         Z4VDwfvnzL2FwvBp2LdSSw1nHCsU3WCBE6bp9EnOymBgFfw9BBik7g9C9mtiw5hgZ+KX
         PeG31J1P6ofLRFGsDS43v6iBLKs/KfkzON23OVY964SUTn761VmJHzE2Bx+nfSKlatia
         NaCgPWAVFEU+0dcIAE35cEdA/LrDNlY4pyh9u/a6vtvmFOQvZffV0pP0yg4d0RugolB3
         PqQDFFpJmHfrq5Ay8846g0ooCUieP2wlfjiPLGoTMNs+fI9yTt+NZLt7RkrCV6NNbu0A
         H5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909991; x=1792514791;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YZtt3JvqXqsF3YecFG5xLUkWJg8SzoyuQA2ME3mmpjA=;
        b=KoG22uiI4qxW0/QgqbP8C1Gsy2uKoV6BiEpOD3XBbG2/8a9qLBADbvQqUnOeCY+Hwf
         2Q44h7ZGnPQmkVVusi7vfmdz6E5FrTyd+IbgiSXIhnDGaI7ByntwiGt7icmzZmQl2Bhc
         7vCpmDP+xzggl8965pm1ilerePGGgmjfkf+PUHQ+jt3iH8G94Ru/QWZEhPw3RQPTD5Vk
         mVT9UaOcilWHsdQGNroNL8ov0d/tk9mjI36wbPBHbxl+DNcjqe0io8W6TtEdIxAg8+D5
         LD/FUlfuMvQNgrxZlZ345uPL3BUk+0v+TEfqeo0lQ68ryAxVncGcXuXDET/gEN3+tZgj
         xXHg==
X-Forwarded-Encrypted: i=1; AKwUvBw+NqrfKH5ZQExBircx25APYFr9+c4AHbqg5RgJB5efrLzJ/OyptG+4WMKMebpNz7pd/GxqchmYoLdUjrPr@vger.kernel.org
X-Gm-Message-State: AFq9FYIkpeiCOzXXNpsWoKkYdOeVKkp92ekxfJJFrx2pAf80xJxJH7Hr
	0svJwgl8lOWqZMu0S6UlvTE5f07f6M5sWg7CsnGD94zLbUcbx1MWl6AErfZ359TJevq/zXtJUhf
	tXW6zaOUfb7E2oeZlK0CrmkDqqe/zoXX2Ac+5XQiZwb6wmSGIKrlarNcrxzMYw+h3uF6OqcI=
X-Gm-Gg: AYBFou16UMIJbH3OyJzGZ6PvqNxjqsezdK3JHl5jtx1yR6i2hzLeopGDRFlQhf/5r+N
	i8fQwJnDTgEgaQ0bR2m5tu+b8RROlmWwvc+m1CqpHAAF7Bk7SkSQzv7+76wcpLg/8EXBcBmW0te
	hxfhWHbgklwu9ygvvf7XvURAuQrPDAH8yCBSIIKUFipvdl+2BPrccKiI+flQ03jGv8MhlfaYEN6
	aeMm3ZRNPLaHPDh1Fny7cTYGvkkB4+4c+Yz2bD5I3RUUsUtMCivlLmPU877XBYODhyZkIT3zTdy
	tEnPxeTAi6L/4Qesn0OeOVEs/0ySD1zQpwItW5HTYE1oKrtFbI1idFYT9F01KNvCzfFhVUD1/Bg
	6erHtAAb+AKZbT3YzX8bTQU0gAtF1FGf7Wvp1h92Cqw4rUA==
X-Received: by 2002:a05:6214:2524:b0:914:507:80d2 with SMTP id 6a1803df08f44-91b55540f93mr229040396d6.33.1791909990993;
        Tue, 13 Oct 2026 09:46:30 -0700 (PDT)
X-Received: by 2002:a05:6214:2524:b0:914:507:80d2 with SMTP id 6a1803df08f44-91b55540f93mr229039816d6.33.1791909990385;
        Tue, 13 Oct 2026 09:46:30 -0700 (PDT)
Received: from [10.207.9.0] (nat-128-59-177-43.net.columbia.edu. [128.59.177.43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b92b86sm29693496d6.30.2026.10.13.09.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 09:46:29 -0700 (PDT)
Message-ID: <4f60231d-5f3d-4094-b578-31efa9d088c5@columbia.edu>
Date: Tue, 13 Oct 2026 12:46:29 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cramfs: convert cramfs_blkdev_read() to use folios
To: Nicolas Pitre <nico@fluxnic.net>, Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260906-cramfs-blkdev-read-folio-v1-1-1be99a82be55@columbia.edu>
 <810d7901-b897-4880-a8d4-d80fe0f8770b@columbia.edu>
 <eb5ff8ee-cc80-f8f8-0602-ccb9ad4a1b12@fluxnic.net>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <eb5ff8ee-cc80-f8f8-0602-ccb9ad4a1b12@fluxnic.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R8GWitRX c=1 sm=1 tr=0 ts=6ace6067 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=lXeS3XHMKYhu4Q0xF1pUDQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=dg4UtMH5AAAA:8 a=wIN2Qo1HbR48bUUB9JIA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=byNfn09xH3PuSfgbYLsR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2NSBTYWx0ZWRfXwbajS7MNmCJw
 QBH60bv2hDkpqc6xjFKfmNQ09mUcDOlvgmzCV0L0epw6xYc7ENPo3ARJFKgvEfTvwCKip9p/KB9
 IovKcaXc6in7MGRKKei5tiw6v6ofSwQWjJjiHwwenUWIYCpm9/JO
X-Proofpoint-GUID: 6SVpqkRIaKB8FX4zyqnaywFjx8UQ9bn-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2NSBTYWx0ZWRfX+CfbQBW7QC0Q
 sMzaFBtDNpBvuosOzyoHgD65dJZwLRqu+kCnf8SbzTSs5SpBvIfaClzClEAbMEhDxSH+pv/vFYL
 uWoNZ+37gLBdWJE2rp0kGz5yCpyfttBekJNCk3ornoOLc1rlIUE5ySAypjhPMNrdAUOqoeb+56Y
 YHsIbArIQHNlWYQPgho318gD0SjSijG4b8lN7Ao7AUVovh1z0Q636otZdvU4ERbhWHmNvc472ca
 2Zj76mXW++kjAbYom7Bl+8XeMEiFY9Qak8MuqarFPe4UzT4BtuUrg3A3ojRNBXufRiLGDBZKE+3
 ZAWUyUg4T+UsOrKN+fFs7sqaY8Eqw8aXj+9ucdnk0yN6RYNbH9uibTcWlClidjBQE+8VROgGKWV
 fxbMmN/aGDsUbK4bHDVB3idh1Q1P10cC/+znnq4QsDd/l2VwkMrTiu5K0XXZxTyYMSlWbkwwzVm
 WbOI6/Spm4BBbO4g42g==
X-Proofpoint-ORIG-GUID: 6SVpqkRIaKB8FX4zyqnaywFjx8UQ9bn-
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11934
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=10
 bulkscore=10 lowpriorityscore=10 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130065

On 10/12/26 12:16 PM, Nicolas Pitre wrote:
> On Mon, 12 Oct 2026, Tal Zussman wrote:
> 
>> On 9/6/26 7:45 PM, Tal Zussman wrote:
>> > Read the block device pages through read_mapping_folio() and copy with
>> > memcpy_from_folio() instead of going through a page.
>> > 
>> > Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> > ---
>> >  fs/cramfs/inode.c | 23 +++++++++++++----------
>> >  1 file changed, 13 insertions(+), 10 deletions(-)
>> > 
>> 
>> Following up on this - I don't see a cramfs tree, so could this go
>> through vfs if everything looks ok? It gets us one step closer to
>> removing read_mapping_page().
>> 
>> Thanks,
>> Tal
> 
> Yes, please forward to the vfs tree.
> 
> Acked-by: Nicolas Pitre <nico@fluxnic.net>
> 
Thanks!

Christian, could you please pick this up?

> 
>> > diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
>> > index d4cd03f4f60d..b55eb3bd29c1 100644
>> > --- a/fs/cramfs/inode.c
>> > +++ b/fs/cramfs/inode.c
>> > @@ -194,7 +194,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>> >  {
>> >  	struct address_space *mapping = sb->s_bdev->bd_mapping;
>> >  	struct file_ra_state ra = {};
>> > -	struct page *pages[BLKS_PER_BUF];
>> > +	struct folio *folios[BLKS_PER_BUF];
>> >  	unsigned i, blocknr, buffer;
>> >  	unsigned long devsize;
>> >  	char *data;
>> > @@ -227,15 +227,15 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>> >  	page_cache_sync_readahead(mapping, &ra, NULL, blocknr, BLKS_PER_BUF);
>> >  
>> >  	for (i = 0; i < BLKS_PER_BUF; i++) {
>> > -		struct page *page = NULL;
>> > +		struct folio *folio = NULL;
>> >  
>> >  		if (blocknr + i < devsize) {
>> > -			page = read_mapping_page(mapping, blocknr + i, NULL);
>> > +			folio = read_mapping_folio(mapping, blocknr + i, NULL);
>> >  			/* synchronous error? */
>> > -			if (IS_ERR(page))
>> > -				page = NULL;
>> > +			if (IS_ERR(folio))
>> > +				folio = NULL;
>> >  		}
>> > -		pages[i] = page;
>> > +		folios[i] = folio;
>> >  	}
>> >  
>> >  	buffer = next_buffer;
>> > @@ -245,11 +245,14 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>> >  
>> >  	data = read_buffers[buffer];
>> >  	for (i = 0; i < BLKS_PER_BUF; i++) {
>> > -		struct page *page = pages[i];
>> > +		struct folio *folio = folios[i];
>> >  
>> > -		if (page) {
>> > -			memcpy_from_page(data, page, 0, PAGE_SIZE);
>> > -			put_page(page);
>> > +		if (folio) {
>> > +			size_t offset = offset_in_folio(folio,
>> > +					(loff_t)(blocknr + i) << PAGE_SHIFT);
>> > +
>> > +			memcpy_from_folio(data, folio, offset, PAGE_SIZE);
>> > +			folio_put(folio);
>> >  		} else
>> >  			memset(data, 0, PAGE_SIZE);
>> >  		data += PAGE_SIZE;
>> > 
>> > ---
>> > base-commit: df2908090cda368b01ff43709f51890076c56157
>> > change-id: 20260906-cramfs-blkdev-read-folio-16fecf6908ac
>> > 
>> > Best regards,
>> > --  
>> > Tal Zussman <tz2294@columbia.edu>
>> 
>> 
> 

