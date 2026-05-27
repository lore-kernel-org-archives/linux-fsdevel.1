Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D53BD246
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914032; cv=none; b=UAzgkvx6S2dtq9NeVGIhnLL46PNaWZX4WmVpcU5eOpgWTo1nDSiut1ogIMF2uNasHZbkIGcjJEC1igo/UsN7FrkyPdf85C5ohdqXFSwWNdMshvulsD5mDp5cnHPXZTsnYkiePpsRfkQcBC3Oq39V734bqiUXinHcRZNaYIBU0F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914032; c=relaxed/simple;
	bh=gMP7R6v1Amh6Zi8SoTuX6pfDtcyiFTCGp3EpKTqvvJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqKpIoAmrybL0MX219kH3opwLp2yxgJNW+LQlUyN91XrwLpA8AVBsUwS9R2xCqJlEKCTYmVydFK3ygxdfCRNwaDXMwWRu6ii8KL0E+RSGRKpqjA1e+BbBJ4Y/hPW6Vuq+/MSKcpMStF1txMDh0el7/tvBo4dWYWn114NIfwSYx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=SmBTxati; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="SmBTxati"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKULCS1479777
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 16:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=6KC0
	cJMVyIK8JE13Ui8TvnvRelSntfkQ4OQ6lx3l8rY=; b=SmBTxatiWeTLz1DCJzmJ
	ot74GFvA4nAVqUP28nFnrKGo0XI+NOcLHCLX/2nG6geVDp/CWh2SSVj7mvD9Iyz6
	H4gtr0kJPrdem9nRh9WsqcE0ajZlj/CfktNNQs5MaNMzuuYoKblfXAsLoa0O9PtX
	9/niq6SIkI4ViQpyQ2pAYxaODRM4qM/N5jGb837EdEAjmz71RA2Y1S74sfA2Pdfc
	wmNkN9+3Wc3gLeXDf38J0M9Jm2rU9sOBQ2dIFmqSnJLD5rzIth1v9q/l+ms4qJno
	GHpVeNb/SapO1ajiEZFJZM5Lw+p5F2L/PDIOKnd2WGAHA4pZ5qopdaTBICG5hmsy
	LQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4ee1k5uby9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 16:33:43 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-914c8954923so799851685a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 13:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779914022; x=1780518822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KC0cJMVyIK8JE13Ui8TvnvRelSntfkQ4OQ6lx3l8rY=;
        b=Q0wpwYpjypmH+DaVssBvhCEjI3Ne5ugNDZGitbVeJrfbBxwQMmATpxFIOwo30tUSRC
         DTbb8aCaG7Pdb7FgbSv2H0IH4uI2yf32qdw9C7zU67KJgfcFcifACu1J83p4csSYdHDS
         Hx+LQbKFxBSRIFsaZUdGOukHNmD5u+PwtCGFerU3HbSs7poi4JWeMrbv+PextdjgorBE
         A+02+HbsH/ydeZxA96hloFlurxK6NU4O33MwO1M/IYr65/S0BX5z84kVwMb184fBMO9e
         zESBH8Dhx/yr2e3IdUdKl8niAC6cP6FP8aPfGqpGceGsvH47Oq34IhySGJVLsvsLTznj
         151w==
X-Forwarded-Encrypted: i=1; AFNElJ95qKOMWbEzzAWH7lmmcgaGflp5cbbK34+xMdCXljak5UDoGLbNYf6h588m77C0Hc5ndp+2VnZrxW3Xvfuo@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxzRGe83qm9wQ3d011Ao63d8YnBTdMQQnJl/DaIgRpvPbhI4k
	shBHeb4mk+A2oNkBWpSWu38pa55ZyUuRLLl9XDr6mx+aqdUTaGc7TjMVc1nRDODZ5Em2ceW+QeA
	qOtrOqT34wOnOI/Z624jvE87Jxf5AGCJ8TpRcbJ09IoJsOk/2L1353/nSz+ubfaI=
X-Gm-Gg: Acq92OFwSULegU7ZLQykNqERfp5V+j7Nsnew22kRdu2ci+CHLdnqRXZfw/KjR9y27zY
	NUhRExJvq0IAqOkOUMp+iqlD0zOdNE3HGuDMkF0A/9Xk3j/Jh1+W8oLJj4lvJ2FCWhKi44geO2W
	zm26X2c0KbUUXe1PBE9TJine6XjsFj8plDLSm+lKdsIB00kPU9l9LO6X+Fym5WVhVuB8SvW5C4P
	Z+/R2x/3ZBN7mDb/+QPXi9S71PB8qkvishlFYX9whUHNzP7+xyIYJB16mazDma1bPIDKfR19WYA
	E/pn25Csg1oYSRCZf1rV9SbcodGo8kZznnQv2i+pHY1poTUEj4nfc5mC57GFBrbCVuE5elJpRMl
	yANF52OwqjiVg0k87UZ5RJ1BmyX+T5vwwL6nA706jDIOxJqEEg/4xsCM=
X-Received: by 2002:a05:620a:19a9:b0:914:cf92:46fb with SMTP id af79cd13be357-914cf92496emr2456070685a.32.1779914022482;
        Wed, 27 May 2026 13:33:42 -0700 (PDT)
X-Received: by 2002:a05:620a:19a9:b0:914:cf92:46fb with SMTP id af79cd13be357-914cf92496emr2456065985a.32.1779914021933;
        Wed, 27 May 2026 13:33:41 -0700 (PDT)
Received: from [192.168.128.14] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f881f214sm574876685a.45.2026.05.27.13.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 13:33:41 -0700 (PDT)
Message-ID: <54c11673-3a84-46d0-bc75-a5036bb7805d@columbia.edu>
Date: Wed, 27 May 2026 16:33:40 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: Remove special jbd2 slabs
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Mike Rapoport (Microsoft)"
 <rppt@kernel.org>,
        Vlastimil Babka <vbabka@kernel.org>
References: <20260525201321.21717-1-willy@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260525201321.21717-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pEmFXeZZg2lW604zEwDIg5j5aX1Aw1so
X-Authority-Analysis: v=2.4 cv=EvTiaycA c=1 sm=1 tr=0 ts=6a175527 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=JfrnYn6hAAAA:8 a=TJp1niKblYMAAhlQyAIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: pEmFXeZZg2lW604zEwDIg5j5aX1Aw1so
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIwNSBTYWx0ZWRfX5q+jtefo5vy8
 asY44y6x7qeZuYGEDhW5ss7w+Xg/2g8IlMvXSqm3vhrlNkCBXYnACK6LHc6Wc9pgYLLquLXz9uk
 d5B/y97RrcfljzCkWhn9yYsD2iZqaopQ7tSDm27sgVdadRXOtWPUiFno8NdpqQLSkdkBhqnnWti
 md5PYfkH3pUUUlwh1e2zbCzWHDJ+0BVcNPXggIg7anzvhYqF5DEZt+2y5BhBGho8oE5TtkJq2LC
 JqgutbC/WGejS56EgkYcJUiJCwL8JitqLsCef32uGEL8b+NhJN20iE3/zdDyFEmtpN3FfBWHN1D
 fq0cMJ2O0m85XlWQfBL5TzyFzk87tHAFBhteZpfjQQ8cyxtmJE2OefhOCaiqGY/1FrZcix8Jr63
 FCCrIMYuS3vBcB3Q10Kp4o6F+EfqrFtlnR2JIWF5QswI+xh1k4ZtLIStE84dNJgwkcbXlg5j4OZ
 c1nGADmBXddg0Ln5sjg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11799
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=10 suspectscore=0 priorityscore=1501
 adultscore=0 bulkscore=10 malwarescore=0 clxscore=1015 impostorscore=10
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270205

On 5/25/26 4:13 PM, Matthew Wilcox (Oracle) wrote:

Hi,

One small comment below.

> When jbd2 was originally written, kmalloc() would not guarantee alignment
> for the requested memory.  Since commit 59bb47985c1d in 2019, kmalloc
> has guaranteed natural alignment for power-of-two allocations.  We can
> now remove the jbd2 special slabs and just use kmalloc() directly.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/jbd2/commit.c      |   8 ++-
>  fs/jbd2/journal.c     | 121 ++----------------------------------------
>  fs/jbd2/transaction.c |   8 +--
>  include/linux/jbd2.h  |   3 --
>  4 files changed, 11 insertions(+), 129 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 38f318bb4279..2e8dbc4547bb 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -514,10 +514,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		 * leave undo-committed data.
>  		 */
>  		if (jh->b_committed_data) {
> -			struct buffer_head *bh = jh2bh(jh);
> -
>  			spin_lock(&jh->b_state_lock);
> -			jbd2_free(jh->b_committed_data, bh->b_size);
> +			kfree(jh->b_committed_data);
>  			jh->b_committed_data = NULL;
>  			spin_unlock(&jh->b_state_lock);
>  		}
> @@ -978,7 +976,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		 * its triggers if they exist, so we can clear that too.
>  		 */
>  		if (jh->b_committed_data) {
> -			jbd2_free(jh->b_committed_data, bh->b_size);
> +			kfree(jh->b_committed_data);
>  			jh->b_committed_data = NULL;
>  			if (jh->b_frozen_data) {
>  				jh->b_committed_data = jh->b_frozen_data;
> @@ -986,7 +984,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  				jh->b_frozen_triggers = NULL;
>  			}
>  		} else if (jh->b_frozen_data) {
> -			jbd2_free(jh->b_frozen_data, bh->b_size);
> +			kfree(jh->b_frozen_data);
>  			jh->b_frozen_data = NULL;
>  			jh->b_frozen_triggers = NULL;
>  		}
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index a6616380ce38..ad10c8a92fa0 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -95,8 +95,6 @@ EXPORT_SYMBOL(jbd2_journal_release_jbd_inode);
>  EXPORT_SYMBOL(jbd2_journal_begin_ordered_truncate);
>  EXPORT_SYMBOL(jbd2_inode_cache);
>  
> -static int jbd2_journal_create_slab(size_t slab_size);
> -
>  #ifdef CONFIG_JBD2_DEBUG
>  void __jbd2_debug(int level, const char *file, const char *func,
>  		  unsigned int line, const char *fmt, ...)
> @@ -385,10 +383,10 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  			goto escape_done;
>  
>  		spin_unlock(&jh_in->b_state_lock);
> -		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS | __GFP_NOFAIL);
> +		tmp = kmalloc(bh_in->b_size, GFP_NOFS | __GFP_NOFAIL);
>  		spin_lock(&jh_in->b_state_lock);
>  		if (jh_in->b_frozen_data) {
> -			jbd2_free(tmp, bh_in->b_size);
> +			kfree(tmp);
>  			goto copy_done;
>  		}
>  
> @@ -2063,14 +2061,6 @@ EXPORT_SYMBOL(jbd2_journal_update_sb_errno);
>  int jbd2_journal_load(journal_t *journal)
>  {
>  	int err;
> -	journal_superblock_t *sb = journal->j_superblock;
> -
> -	/*
> -	 * Create a slab for this blocksize
> -	 */
> -	err = jbd2_journal_create_slab(be32_to_cpu(sb->s_blocksize));
> -	if (err)
> -		return err;
>  
>  	/* Let the recovery code check whether it needs to recover any
>  	 * data from the journal. */
> @@ -2698,108 +2688,6 @@ size_t journal_tag_bytes(journal_t *journal)
>  		return sz - sizeof(__u32);
>  }
>  
> -/*
> - * JBD memory management
> - *
> - * These functions are used to allocate block-sized chunks of memory
> - * used for making copies of buffer_head data.  Very often it will be
> - * page-sized chunks of data, but sometimes it will be in
> - * sub-page-size chunks.  (For example, 16k pages on Power systems
> - * with a 4k block file system.)  For blocks smaller than a page, we
> - * use a SLAB allocator.  There are slab caches for each block size,
> - * which are allocated at mount time, if necessary, and we only free
> - * (all of) the slab caches when/if the jbd2 module is unloaded.  For
> - * this reason we don't need to a mutex to protect access to
> - * jbd2_slab[] allocating or releasing memory; only in
> - * jbd2_journal_create_slab().
> - */
> -#define JBD2_MAX_SLABS 8
> -static struct kmem_cache *jbd2_slab[JBD2_MAX_SLABS];
> -
> -static const char *jbd2_slab_names[JBD2_MAX_SLABS] = {
> -	"jbd2_1k", "jbd2_2k", "jbd2_4k", "jbd2_8k",
> -	"jbd2_16k", "jbd2_32k", "jbd2_64k", "jbd2_128k"
> -};
> -
> -
> -static void jbd2_journal_destroy_slabs(void)
> -{
> -	int i;
> -
> -	for (i = 0; i < JBD2_MAX_SLABS; i++) {
> -		kmem_cache_destroy(jbd2_slab[i]);
> -		jbd2_slab[i] = NULL;
> -	}
> -}
> -
> -static int jbd2_journal_create_slab(size_t size)
> -{
> -	static DEFINE_MUTEX(jbd2_slab_create_mutex);
> -	int i = order_base_2(size) - 10;
> -	size_t slab_size;
> -
> -	if (size == PAGE_SIZE)
> -		return 0;
> -
> -	if (i >= JBD2_MAX_SLABS)
> -		return -EINVAL;
> -
> -	if (unlikely(i < 0))
> -		i = 0;
> -	mutex_lock(&jbd2_slab_create_mutex);
> -	if (jbd2_slab[i]) {
> -		mutex_unlock(&jbd2_slab_create_mutex);
> -		return 0;	/* Already created */
> -	}
> -
> -	slab_size = 1 << (i+10);
> -	jbd2_slab[i] = kmem_cache_create(jbd2_slab_names[i], slab_size,
> -					 slab_size, 0, NULL);
> -	mutex_unlock(&jbd2_slab_create_mutex);
> -	if (!jbd2_slab[i]) {
> -		printk(KERN_EMERG "JBD2: no memory for jbd2_slab cache\n");
> -		return -ENOMEM;
> -	}
> -	return 0;
> -}
> -
> -static struct kmem_cache *get_slab(size_t size)
> -{
> -	int i = order_base_2(size) - 10;
> -
> -	BUG_ON(i >= JBD2_MAX_SLABS);
> -	if (unlikely(i < 0))
> -		i = 0;
> -	BUG_ON(jbd2_slab[i] == NULL);
> -	return jbd2_slab[i];
> -}
> -
> -void *jbd2_alloc(size_t size, gfp_t flags)
> -{
> -	void *ptr;
> -
> -	BUG_ON(size & (size-1)); /* Must be a power of 2 */
> -
> -	if (size < PAGE_SIZE)
> -		ptr = kmem_cache_alloc(get_slab(size), flags);
> -	else
> -		ptr = (void *)__get_free_pages(flags, get_order(size));
> -
> -	/* Check alignment; SLUB has gotten this wrong in the past,
> -	 * and this can lead to user data corruption! */
> -	BUG_ON(((unsigned long) ptr) & (size-1));
> -
> -	return ptr;
> -}
> -
> -void jbd2_free(void *ptr, size_t size)
> -{
> -	if (size < PAGE_SIZE)
> -		kmem_cache_free(get_slab(size), ptr);
> -	else
> -		free_pages((unsigned long)ptr, get_order(size));
> -};
> -
>  /*
>   * Journal_head storage management
>   */
> @@ -2977,11 +2865,11 @@ static void journal_release_journal_head(struct journal_head *jh, size_t b_size)

I think the b_size parameter can be removed from journal_release_journal_head()
and its single caller now.

>  {
>  	if (jh->b_frozen_data) {
>  		printk(KERN_WARNING "%s: freeing b_frozen_data\n", __func__);
> -		jbd2_free(jh->b_frozen_data, b_size);
> +		kfree(jh->b_frozen_data);
>  	}
>  	if (jh->b_committed_data) {
>  		printk(KERN_WARNING "%s: freeing b_committed_data\n", __func__);
> -		jbd2_free(jh->b_committed_data, b_size);
> +		kfree(jh->b_committed_data);
>  	}
>  	journal_free_journal_head(jh);
>  }
> @@ -3142,7 +3030,6 @@ static void jbd2_journal_destroy_caches(void)
>  	jbd2_journal_destroy_handle_cache();
>  	jbd2_journal_destroy_inode_cache();
>  	jbd2_journal_destroy_transaction_cache();
> -	jbd2_journal_destroy_slabs();
>  }
>  
>  static int __init journal_init(void)
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 4885903bbd10..48ddb566d12d 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1131,7 +1131,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>  		if (!frozen_buffer) {
>  			JBUFFER_TRACE(jh, "allocate memory for buffer");
>  			spin_unlock(&jh->b_state_lock);
> -			frozen_buffer = jbd2_alloc(jh2bh(jh)->b_size,
> +			frozen_buffer = kmalloc(jh2bh(jh)->b_size,
>  						   GFP_NOFS | __GFP_NOFAIL);
>  			goto repeat;
>  		}
> @@ -1159,7 +1159,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>  
>  out:
>  	if (unlikely(frozen_buffer))	/* It's usually NULL */
> -		jbd2_free(frozen_buffer, bh->b_size);
> +		kfree(frozen_buffer);
>  
>  	JBUFFER_TRACE(jh, "exit");
>  	return error;
> @@ -1424,7 +1424,7 @@ int jbd2_journal_get_undo_access(handle_t *handle, struct buffer_head *bh)
>  
>  repeat:
>  	if (!jh->b_committed_data)
> -		committed_data = jbd2_alloc(jh2bh(jh)->b_size,
> +		committed_data = kmalloc(jh2bh(jh)->b_size,
>  					    GFP_NOFS|__GFP_NOFAIL);
>  
>  	spin_lock(&jh->b_state_lock);
> @@ -1445,7 +1445,7 @@ int jbd2_journal_get_undo_access(handle_t *handle, struct buffer_head *bh)
>  out:
>  	jbd2_journal_put_journal_head(jh);
>  	if (unlikely(committed_data))
> -		jbd2_free(committed_data, bh->b_size);
> +		kfree(committed_data);
>  	return err;
>  }
>  
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 7e785aa6d35d..b68561187e90 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -63,9 +63,6 @@ void __jbd2_debug(int level, const char *file, const char *func,
>  #define jbd2_debug(n, fmt, a...)  no_printk(fmt, ##a)
>  #endif
>  
> -extern void *jbd2_alloc(size_t size, gfp_t flags);
> -extern void jbd2_free(void *ptr, size_t size);
> -
>  #define JBD2_MIN_JOURNAL_BLOCKS 1024
>  #define JBD2_DEFAULT_FAST_COMMIT_BLOCKS 256
>  

