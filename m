Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BD158F068
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988122; cv=none; b=Z7XHGbfGY7x1lV9p044MdCMtW3u6ex4pQjETb+baFAo19zAGhwnea+IFcafMzczKep1xM7OPy6Oc3PHorBLJbwP6arTFjzclU0TWseEF9j+keMzc1WnNDwrbPo07dx2bHqMrdtCh1AE5mBvToNi9Zj1ezbTcBYcxokP8zQWsLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988122; c=relaxed/simple;
	bh=v6XN1bSzrdiOZsy+gxDBorIxvgzRZF1Y/gKavtMSJdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VthHx39mOxJDv6334LJ67qgocTqD7ah7UvD9s/rhH5LNMaRyRV3R0ysmvlacZLtKv5ac1L3HExJdjpG5/tyvLEEkhgmXEgZrHlIyGWLgYmpw69QivPxaNE9OfTyb343AkLf2BNguRqe41oBECUcpsUU2Hl3JkS3TkiUhTwhipog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=coTraDnG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrgxgPCb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coTraDnG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrgxgPCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788988119;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeCu1I7ci4XqifONO9NCiEC08kQGS9StekRATuRZUpY=;
	b=coTraDnGs/wAD8KBc82xncnv4L+tv6tvaG8lrH7NRfim4G3CLJ9XNx5MAHhdtFvfOrmTg4
	WE5fEJGK4KMe0TPhpzBVOpHVaISsia7XAW42t8Ep2WyqTwl3hVlX74pbCAyukTl6nxdyLt
	zNKbdSLZWufU5I91ecKHh8Ze66HliK4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-5fKz0iGnM02rTY_9VpRaMw-1; Wed, 09 Sep 2026 17:08:38 -0400
X-MC-Unique: 5fKz0iGnM02rTY_9VpRaMw-1
X-Mimecast-MFC-AGG-ID: 5fKz0iGnM02rTY_9VpRaMw_1788988118
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ef04756caso127448121cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 14:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788988118; x=1789592918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JeCu1I7ci4XqifONO9NCiEC08kQGS9StekRATuRZUpY=;
        b=hrgxgPCbI+s2W6pD4vzacl4WpRBvQfuv4h0IzPeK3MG2bd7YCv9lzyixwuWci6j4zC
         VDWCz3ZdETVEeyMEnmPFtKukP58YhG6WXGO91YyfdHEqCgUO01ehWMaxAYdaGwHhh7WP
         bCrcsCQKeGli+uI0sbi7DY9YsLmw/2pNRB+ELdcWLMm3hawoWzCdDfcMssftK5ltNXmR
         ZtISmNxU3Hrodujh6PmggJg4/v1lyxj7nZLTu9a5I16r4k9ZVKjOpM33Xi85hWQgyo1C
         wRvO+fQ7L7VYbQqSnrxEdUgAKKUz3E3qKnjI1PPNsfe98EsDKJvnwMXYZjZLk5X6Npdr
         zUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988118; x=1789592918;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JeCu1I7ci4XqifONO9NCiEC08kQGS9StekRATuRZUpY=;
        b=KMdAQDCPv1uU7AuTjhTjXMiWfDVa6sSsNGl0dD2holSx58tC9hcD5ennqyBna2pk9F
         Bg8cwnq/3H26GAyIHkyl0MnsoLPA7kK56vAuoVIJAgev8yLhlmY/6DO5iXndzTVqWZNz
         evxTVKEwEsIjKZYOcbGRmEE5cwqnrBZmch9FZqmyKrrHxwhr0dDF75O6Ch31HgbSQVAY
         CwYMMGUFUfMqSZrUZnEnRzkAZoQKuges+gkMZ1Ajj7WYKvVft5C5IWiDitKjFZUkMKtF
         pnEHjw4ZhYE/TPBA/bfvomzWlR6ebLsPPRJb8Nas7jqGs/Q/IXfVwKdOhP+VnCniGPgI
         J0aQ==
X-Forwarded-Encrypted: i=1; AKwUvByXRG/lwtQFveu4Cvhuz5tyrDZuL+dmuUx9aH8wxJWUMbFyzqAdMbfpKGrWmyplXCjjlf+MdQXugWRVgg/c@vger.kernel.org
X-Gm-Message-State: AFuF++k7tEaOyBbUy3h4GL/DZ2kkQJ4LjO/PKXuq2VwjtFcnrXMM3RPo
	Neh6e18mSbo2fQQpQijl50y6UHD4KaddPjlRez/C/5umlMWSNvB8FbjXR1AR+NAW+ZYLq/CNjTm
	ASDmQokB84d8t6u2jRtevBfasN0BTgZItUVIUnBjvbr2aGw4XmihBmnjCj91jvp5avn8=
X-Gm-Gg: AYBFou3G6nKZRnSdUFZkDluQ1cBG5ej8wx65PIk6YR0LKoPXigw+RFdg3QIXb7Hrcps
	uyBt17AZqpe+EM98RMDeAVG8RlQaKVil/t5vQUp1zhr3ENAT7Cmh1inyHi3BJQSLCXl1bULlX03
	74sasxFHH4FRnZPEIIvVVy/MNXfQcKWMMr/3rfSc5nXv+/fCb1r86KTEwi96mWtx5ey0Wauesg5
	CGV7JQ/r9Dq3KzxzRlQoZ0pwmI74MSDlFIRQKThNXDQAuWk/y82cDU3HBIrIJEJpNrSZXZ/iYdd
	kqcBzrvAqni/roBbCD7cBKIGJLpncDzwNmlSPwtH1LOKiS8BgpLRiVHY7WFtVs4C0D2P8CvCy1/
	Lpf9tkdtJq4aOKG10yr0lo8ChLYr1WMVsRVAegIrf
X-Received: by 2002:ac8:5cc1:0:b0:530:b2e2:2f1 with SMTP id d75a77b69052e-530b2e23739mr27765611cf.51.1788988117889;
        Wed, 09 Sep 2026 14:08:37 -0700 (PDT)
X-Received: by 2002:ac8:5cc1:0:b0:530:b2e2:2f1 with SMTP id d75a77b69052e-530b2e23739mr27764751cf.51.1788988117237;
        Wed, 09 Sep 2026 14:08:37 -0700 (PDT)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9104049d30asm153786676d6.0.2026.09.09.14.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 14:08:36 -0700 (PDT)
Message-ID: <317dd59c-819f-4bbe-a196-3946c30eb0a3@redhat.com>
Date: Wed, 9 Sep 2026 16:08:34 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sorenson@redhat.com
Subject: Re: netfs_read_gaps(): aliased sink folio makes the read destination
 unreadable, SIGBUS on cifs with signing
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Jeff Layton <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
 CIFS <linux-cifs@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <afd68097-b2b2-47e5-889b-fb077e7a9247@redhat.com>
 <a385053c-1c4a-4060-a3bb-befa007ddb33@redhat.com>
 <1714046.1788952509@warthog.procyon.org.uk>
 <1730052.1788974127@warthog.procyon.org.uk>
Content-Language: en-US
From: Frank Sorenson <sorenson@redhat.com>
In-Reply-To: <1730052.1788974127@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/26 12:15 PM, David Howells wrote:
> Try #3...
>
> David

retested successfully with v3


Frank

> ---
> commit 05abad6ef207137fd3a2559d6ac242d1f94c60aa
> Author: David Howells <dhowells@redhat.com>
> Date:   Wed Sep 9 11:36:30 2026 +0100
>
>      netfs: Fix netfs_read_gaps() to use separate sink folios
>      
>      Fix netfs_read_gaps() to use separate folios rather than re-using a single
>      sink folio to discard the unwanted data so that cifs checksum checking sees
>      all the data that was fetched.
>      
>      Fixes: 7f84a7b9892d ("netfs: Make netfs_read_folio() handle streaming-write pages")
>      Reported-by: Frank Sorenson <sorenson@redhat.com>
>      Closes: https://lore.kernel.org/r/a385053c-1c4a-4060-a3bb-befa007ddb33@redhat.com/
>      Signed-off-by: David Howells <dhowells@redhat.com>
>      Tested-by: Frank Sorenson <sorenson@redhat.com>
>      cc: Paulo Alcantara <pc@manguebit.org>
>      cc: Namjae Jeon <linkinjeon@kernel.org>
>      cc: netfs@lists.linux.dev
>      cc: linux-cifs@vger.kernel.org
>      cc: linux-fsdevel@vger.kernel.org
>
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 424df70a5c30..105194de6e13 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -482,15 +482,14 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
>   	struct netfs_group *group = netfs_folio_group(folio);
>   	struct netfs_folio *finfo = netfs_folio_info(folio);
>   	struct netfs_inode *ctx = netfs_inode(mapping->host);
> -	struct folio *sink = NULL;
> -	struct bio_vec *bvec;
> +	struct bio_vec *bvec = NULL;
>   	unsigned int from = finfo->dirty_offset;
>   	unsigned int to = from + finfo->dirty_len;
> -	unsigned int off = 0, i = 0;
> +	unsigned int off = 0;
>   	size_t flen = folio_size(folio);
>   	size_t nr_bvec = flen / PAGE_SIZE + 2;
>   	size_t part;
> -	int ret;
> +	int ret, i = 0, sink_from = -1, sink_to = -1;
>   
>   	_enter("%lx", folio->index);
>   
> @@ -515,24 +514,23 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
>   	if (!bvec)
>   		goto discard;
>   
> -	sink = folio_alloc(GFP_KERNEL, 0);
> -	if (!sink) {
> -		kfree(bvec);
> -		goto discard;
> -	}
> -
>   	trace_netfs_folio(folio, netfs_folio_trace_read_gaps);
>   
> -	rreq->direct_bv = bvec;
> -	rreq->direct_bv_count = nr_bvec;
>   	if (from > 0) {
>   		bvec_set_folio(&bvec[i++], folio, from, 0);
>   		off = from;
>   	}
> +	sink_from = i;
>   	while (off < to) {
> +		struct folio *sink = folio_alloc(GFP_KERNEL, 0);
> +
> +		if (!sink)
> +			goto discard;
>   		part = min_t(size_t, to - off, PAGE_SIZE);
> -		bvec_set_folio(&bvec[i++], sink, part, 0);
> +		bvec_set_folio(&bvec[i], sink, part, 0);
>   		off += part;
> +		sink_to = i;
> +		i++;
>   	}
>   	if (to < flen)
>   		bvec_set_folio(&bvec[i++], folio, flen - to, to);
> @@ -553,8 +551,10 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
>   		folio_mark_uptodate(folio);
>   	}
>   
> -	if (sink)
> -		folio_put(sink);
> +	if (sink_to >= 0)
> +		for (; sink_from <= sink_to; sink_from++)
> +			folio_put(bvec_folio(&bvec[sink_from]));
> +	kfree(bvec);
>   	folio_unlock(folio);
>   	netfs_put_request(rreq, netfs_rreq_trace_put_return);
>   	return ret < 0 ? ret : 0;
> @@ -563,6 +563,10 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
>   	netfs_put_failed_request(rreq);
>   alloc_error:
>   	folio_unlock(folio);
> +	if (sink_to >= 0)
> +		for (; sink_from <= sink_to; sink_from++)
> +			folio_put(bvec_folio(&bvec[sink_from]));
> +	kfree(bvec);
>   	return ret;
>   }
>   

-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat

