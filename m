Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89E2304BDE
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491692; cv=none; b=BQDkh0paz+gpQJ7cVdl0yqgUNlgtTNn/1DwOdUB5PmoLPEwmo64ZWV+b0Hd4Cht5zgFjEUNsCTBiq9QDIL7sj+ulH0A3IYJ3bPe2zUFjMUwhuL5jRBmeTQa3uK4ojWOi5WCw9kK+Y1sNoRAIGXaWOWQ8gUCnL8NeyNr0QPTJjGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491692; c=relaxed/simple;
	bh=gV53TwSs0drt5X5gnSBlHKrw6+HA0vOx7vN5OP4e850=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayMNrrl/x49QSzg2M7amUtBQKl7oIg1hky0siwCmCRLJiSjo1aK+26Gexu5Vf6DKC7TXRLr5PX6fR2D2RIi+QsiI9hRFzwdLLyP7NzxuU1Z1kPOmbfSH/eFwPIJkLcl2n6zozm4Wn4xe24BapyI66NOp4AGWlenSbmheII5H9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=G2A9IOS3; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="G2A9IOS3"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MMRp89921009
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 19:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=SCJZ
	IS3EJwvEDcATBWIFn6gHp7ruxYI8VCEk1vbgm7Y=; b=G2A9IOS3JesynR/UdOCn
	/ut7BaIFp+bYt3cWcBDa1+1qX107hdOZAXsxXWg9TXcFIIQbTqVvqIeRJL3bUjRB
	UDu7592o6g/OwynE+EnnlBOTkWS2ZjX9GmRuW1agJFz/DlTmacfQAt/E5dOs6kpg
	XYQYlsbSRI5JZ9+o7MhW637PGbZF9haOkuwD+34B9dN4iOrRO418PwB5gjKphlWD
	4hY51YdLNL2I/qkxN9JZKz9Pq7doj2Mn4gI9amxgvsz+E5/mYktzg2FkrFBroOJp
	8rjK6HV2y0PoqI+nzlXQ/e7TXg02cUei9ufFo3UQVCp84CjljxoEdHozHaD8/A2K
	ew==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4easvr30f3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 19:14:49 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-914b5249bf6so345238385a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 16:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779491689; x=1780096489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCJZIS3EJwvEDcATBWIFn6gHp7ruxYI8VCEk1vbgm7Y=;
        b=nVhsnuNijogAb1dZinlt+LzmkwWJRRMoCxffqVMTZwqTJ6QnIHA/v7b56ryJkWBlbG
         yH5nUj5cVthHGDMzsUR8gGcneBp7usp90wMdBDPlTcZTUAQBF+fI6AW0NAEDB1iNE1Aj
         mkEWXDKDBxb85oPuoM365VcNdBEmSErmMFSNW60kIbbRPJJ2RZpm8T+erZ8IpyAh+4Ht
         Q+s6HpsByE/XFAyiSQAW9emLmYTeoXvOOgk1EoTdwlAEXwr8hIVTRT7jzxqG27ybGisk
         6LmhvnhVgVAhdSfIeux4utXop4HxPjwZcghp6d8IaqEcOcIUH6s5Mvr57YmxwKmddEbk
         fnvg==
X-Forwarded-Encrypted: i=1; AFNElJ8j0ZqG+vaQgcaBTQpMM9BGtv1BTQE3ny1mhs6dkKSUxK7qNLH+0CReGMhMif3SkIu2Gk5vutbuwhRW3imD@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQRLKHhQBKEd2tpJE5PFGTCAZv4UVUeRKX7lnjXGfNzQlmbSF
	ju0FJ4Zs/dvJw37mje0arG4LGMMoLUsl6ArJoMpoeYw63QLuxObIBayzK7iVV8fAwXbHuFGkO7D
	W3MVx86lxtyEqis52LkGLlS6Bx+7HqU0JUAexSW84Wx95q7cBENB1M3iBVAaJfJA=
X-Gm-Gg: Acq92OF6fybd/e8s10n753KjTkE8Zn4hw0O2b9FHmfU9+ZpGOvrz/EI6cEQHpToDwki
	GIV/PlAYMBqgl5cQCXBqJGB7ofh92p7cICzpESmTlio3oTHhwhFnaFjdj2OuVcO26uUx4So18ZY
	5YJ9nFjBuQlBr9SezdAEaGutxC8mhpFAe04UiHOghGsNJ+z6aBzfUM7JRjpOD91/xH61nNfmu84
	qbFZFHgrxkmoz555+u1VCaWEVOsHCSCG+guu0PO1EW4I6D1Mnak3qoekJ+MyboYnbnxmGWwJhfO
	iteUozmEyAo0rtmFNcgCMpea9f51mLYOWqDkLMKLLN6GzidkhVCEVXDD5lVxX2+cwGOIwyvTVXI
	L9CPbOz39NLlvQA7qxA8TC19/Qsf+DF8lGBP3gAm4olu9nQUnRIujM3kXMxdFOhTINRWPf9nLp1
	M=
X-Received: by 2002:a05:620a:2909:b0:8f2:c47b:962e with SMTP id af79cd13be357-914b49f5399mr897288785a.49.1779491688925;
        Fri, 22 May 2026 16:14:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2909:b0:8f2:c47b:962e with SMTP id af79cd13be357-914b49f5399mr897283585a.49.1779491688439;
        Fri, 22 May 2026 16:14:48 -0700 (PDT)
Received: from [10.207.65.224] (nat-128-59-177-214.net.columbia.edu. [128.59.177.214])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9f4689sm249676485a.38.2026.05.22.16.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 16:14:47 -0700 (PDT)
Message-ID: <d98a35c1-882b-4752-a2c7-378872fc97a3@columbia.edu>
Date: Fri, 22 May 2026 19:14:46 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] buffer: add dropbehind writeback support
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Gao Xiang <xiang@kernel.org>
References: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
 <20260514-blk-dontcache-v6-3-782e2fa7477b@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260514-blk-dontcache-v6-3-782e2fa7477b@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OnSmv8fsDTEOyGi2FjKsrGtSVqC9VvOM
X-Proofpoint-GUID: OnSmv8fsDTEOyGi2FjKsrGtSVqC9VvOM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzMiBTYWx0ZWRfX6kmHgce6+kLM
 NBBWPNd4y/UpAw/dP79C2+h7Zk4zdWckJNs92k5m6WrnFgnJZXB/J7AmFwhwp7gsiAvo+TiY8RO
 BbsBDQG5YhEfgTSJqj3U3cadRdkGwFfkPg93LkMVU7+c/1cfaT3VSLLIowGuX7mp+pWGHQdbnaj
 DBZ8qhDTz0SDF7K4mq3IRGu0W6yEdU7+F6C3DOsfOvtGnGdmTaAeMe8AiGcqhnKk8vetMMF2Nw4
 nTD8BRfbxjVEbTki2YG/wLAB0qeIHl6OdlA/VgwHf3uBppV71KjBmReAlMJ+7AUVs5+VK9KN3xn
 /bj7XIbUMpI97DRqgT/POnj8a5oX0hZoPXPmYw2uKwdGpfkrFQkFXTsI2T0T/4J5pmvFEoIJ86D
 L8MubdQ1sEaA/I3XR4pNIyFHIe+H5xOiwWlVUkqx2WEOmNVYxiSQdWALVs5QfrmlrjUHWyyL5Os
 RSqWMGWuTml+5J3v0qw==
X-Authority-Analysis: v=2.4 cv=D8t37PRj c=1 sm=1 tr=0 ts=6a10e369 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=n4JpGxNP30DHW88kdRRHAg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=c92rfblmAAAA:8 a=lIN9f26y6YkxF9qERjMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11794
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0
 bulkscore=10 spamscore=0 adultscore=0 lowpriorityscore=10 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220232

On 5/14/26 5:51 PM, Tal Zussman wrote:
> Add block_write_begin_iocb() which threads the kiocb through to
> __filemap_get_folio() so that buffer_head-based I/O can use DONTCACHE
> behavior. When the iocb has IOCB_DONTCACHE set, FGP_DONTCACHE is
> passed to mark the folio for dropbehind. The existing
> block_write_begin() is preserved as a wrapper that passes a NULL iocb.
> 
> Set BIO_COMPLETE_IN_TASK in submit_bh_wbc() when the folio has
> dropbehind set, so that buffer_head writeback completions get deferred
> to task context.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Responding to Sashiko review inline:

Link: https://sashiko.dev/#/patchset/20260514-blk-dontcache-v6-0-782e2fa7477b%40columbia.edu

> ---
>  fs/buffer.c                 | 19 +++++++++++++++++--
>  include/linux/buffer_head.h |  3 +++
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index b0b3792b1496..d0abaf44d782 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2138,14 +2138,19 @@ EXPORT_SYMBOL(block_commit_write);
>   *
>   * The filesystem needs to handle block truncation upon failure.
>   */
> -int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
> +int block_write_begin_iocb(const struct kiocb *iocb,
> +		struct address_space *mapping, loff_t pos, unsigned len,
>  		struct folio **foliop, get_block_t *get_block)
>  {
>  	pgoff_t index = pos >> PAGE_SHIFT;
> +	fgf_t fgp_flags = FGP_WRITEBEGIN;
>  	struct folio *folio;
>  	int status;
>  
> -	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> +	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
> +		fgp_flags |= FGP_DONTCACHE;
> +
> +	folio = __filemap_get_folio(mapping, index, fgp_flags,
>  			mapping_gfp_mask(mapping));
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
> @@ -2160,6 +2165,13 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
>  	*foliop = folio;
>  	return status;
>  }

Q: "Is an EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() needed for
block_write_begin_iocb()?
Since the legacy wrapper block_write_begin() remains exported, it appears
filesystems compiled as loadable modules (like ext4 or fat) will encounter
linker errors if they attempt to transition to the new API."

A: Can be added once filesystems want to use it.

> +
> +int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
> +		struct folio **foliop, get_block_t *get_block)
> +{
> +	return block_write_begin_iocb(NULL, mapping, pos, len, foliop,
> +				      get_block);
> +}
>  EXPORT_SYMBOL(block_write_begin);
>  
>  int block_write_end(loff_t pos, unsigned len, unsigned copied,
> @@ -2715,6 +2727,9 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
>  
>  	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
>  
> +	if (folio_test_dropbehind(bh->b_folio))
> +		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
> +

Q: "Does this add unnecessary workqueue overhead for read operations?
While task-context deferral is required for asynchronous writeback completions
to allow folio_end_writeback() to sleep and invalidate the folio, read
dropbehind invalidation is handled synchronously in the reader's task context
via filemap_end_dropbehind_read().
Could this be gated by an op == REQ_OP_WRITE or op_is_write(opf) check so
that read bio completions aren't forced into a workqueue?"

A: Seems worth adding a op_is_write(opf) check to avoid deferring read
dropbehind completions.

>  	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
>  		buffer_set_crypto_ctx(bio, bh, GFP_NOIO);
>  
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index e4939e33b4b5..4ce50882d621 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -260,6 +260,9 @@ int block_read_full_folio(struct folio *, get_block_t *);
>  bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
>  int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
>  		struct folio **foliop, get_block_t *get_block);
> +int block_write_begin_iocb(const struct kiocb *iocb,
> +		struct address_space *mapping, loff_t pos, unsigned len,
> +		struct folio **foliop, get_block_t *get_block);
>  int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  		get_block_t *get_block);
>  int block_write_end(loff_t pos, unsigned len, unsigned copied, struct folio *);
> 

