Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457329;
	b=jissLssm8gtEI8FxGKZcGyLagMcuU2YYDqvwBp0Q0e9LTKZNypBIGhvgPDqiicOtktkV
	 XvNlPqnqKDobF5BmEnwpUQ8/6c0L9hjHh5tJS9OuA9zgd3SicGCdwg7T70D3UXA4Al6JS
	 IGBy8dc7XeDGduWXl+bK3Ow75XhSoIDrRyxaBDFpJPkCCM8zItVZ1f7nNKMlRctXnLhjx
	 OPyBAJfJ1LJJR2JHXI6d4xlczzeQB+8+hVJ/DuyBCetgRfNtjZMePeEOcTRdL/60soz5H
	 seBHPGY4hZrFY6Nk4+1q1dJWG76UCm9tS1beT4Raxuk74J7BY8+8wpO9CuPPpa6VCew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457329;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=u3sQi4xtlpiYhO3bpF1P7SP8mwOVTDdWI4IFsxaNYrg=;
	b=tOe2ZUSiF/DJUHxKKrjrd7Gnbp9ts7trooPTw9eN2e7yVH+z4dPCZVUaF3CRnnlgWNxD
	 cC5AAvsdqA/N7Ii4b8m4r9aCW8Rwjb/99pB369rKNzcQnOhy+fzzVhaSxixNF3zbciCgW
	 LyaioIBEhzPZ3wJF8vWomY/N35l5hflXEpQUT1xTCM4z+gd47IsvJ0ZykkKRGo0XQ6e3z
	 vt2O/edMat6W9LKK1sZUj1pDS7aszhFCw9D0vESiiFoyjRsl95HtiZcwc/FQc/M5P9NfQ
	 gEPugLbQqij8TpumaLD5m2FeR2sdL4EOAs+nuNRRdrU24pYIsIkGjK4wlvDrltPWJFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=QYxlGI6U;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E170606A31C;
	Thu, 12 Nov 2026 04:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E170606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=QYxlGI6U
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 20E5312110C;
	Thu, 12 Nov 2026 01:22:06 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794457326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u3sQi4xtlpiYhO3bpF1P7SP8mwOVTDdWI4IFsxaNYrg=;
	b=QYxlGI6UuybKqQO8XKsFjJERCexHOXCVBRm0f9cRH2oNKkySkDhgGOLGWjkK3YkkAzg3si
	LSIwNRMYOp7pIAVdM0xRqbMnWou9ChoRliEBKjw1OqTEmjNEv58vhZp7duMg5gtvtKjKqI
	JTls94LFpTcgX0vlGtFCivpO0P6dmeGh2AdLHJTd1prdeZAp0oCweRlaBcLzKranUsZhBp
	1bRTY0S8AQJL5oV7TQl/6Hk3tOMsb49EfQUyIUe4ZmHPSlE3joRZCizGWrVvH2V6eRBVGO
	HP0le+g/LWUybQmBjMkXlVilpympNxXAedZzA2Yj00sUVk3olaDyqkKZPJnx1w==
Date: Thu, 12 Nov 2026 01:22:03 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/8] fat: clean stale bdev buffers of newly allocated
 clusters
Message-ID: <avU-OqCcBQEnQR1C@DESKTOP-PJTTJ93.localdomain>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
 <20261031164326.278125-5-matheus.aalmeida@inf.ufrgs.br>
 <87ik27tlpi.fsf@mail.parknet.co.jp>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ik27tlpi.fsf@mail.parknet.co.jp>

On Sun, Nov 08, 2026 at 11:57:29PM +0900, OGAWA Hirofumi wrote:
>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>
>> Directory I/O uses buffer_heads on the block device, which may leave
>> stale buffers behind when clusters are freed and reused. The buffer_head
>> I/O paths currently call clean_bdev_aliases() for newly allocated blocks,
>> preventing stale buffers from overwriting new data.
>>
>> Buffered iomap I/O does not provide this protection. In preparation for
>> the buffered iomap conversion, clean bdev aliases on newly allocated
>> clusters, like exfat patch "exfat: clean stale bdev buffers of newly
>> allocated clusters".
>>
>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>> ---
>>  fs/fat/fatent.c | 34 ++++++++++++++++++++++++++++++++--
>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
>> index 4fa1fae5abf9..46899efa3cf8 100644
>> --- a/fs/fat/fatent.c
>> +++ b/fs/fat/fatent.c
>> @@ -523,6 +523,21 @@ static int fat_flush_bhs(struct super_block *sb, struct buffer_head **bhs,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Newly allocated clusters may still have dirty buffer_heads in the block
>> + * device mapping, e.g. the dentries of a directory that was just removed.
>> + * File data does not go through those buffers, so drop them; otherwise a
>> + * later flush of the block device writes them over the new data.
>> + */
>> +static void fat_clean_bdev_aliases(struct super_block *sb,
>> +				   unsigned int clu, unsigned int count)
>> +{
>> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>> +
>> +	clean_bdev_aliases(sb->s_bdev, fat_clus_to_blknr(sbi, clu),
>> +			   (sector_t)count * sbi->sec_per_clus);
>> +}
>> +
>>  static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster,
>>  				bool return_all)
>>  {
>> @@ -531,7 +546,7 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
>>  	const struct fatent_operations *ops = sbi->fatent_ops;
>>  	struct fat_entry fatent, prev_ent;
>>  	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
>> -	int i, count, err, nr_bhs, idx_clus;
>> +	int i, count, err, nr_bhs, idx_clus, cont_start, cont_len;
>>  
>>  	lock_fat(sbi);
>>  	if (sbi->free_clusters != -1 && sbi->free_clus_valid &&
>> @@ -540,14 +555,20 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
>>  		return -ENOSPC;
>>  	}
>>  
>> +	cont_len = 0;
>>  	err = nr_bhs = idx_clus = 0;
>>  	count = FAT_START_ENT;
>>  	fatent_init(&prev_ent);
>>  	fatent_init(&fatent);
>>  	fatent_set_entry(&fatent, sbi->prev_free + 1);
>>  	while (count < sbi->max_cluster) {
>> -		if (fatent.entry >= sbi->max_cluster)
>> +		if (fatent.entry >= sbi->max_cluster) {
>> +			if (cont_len) {
>> +				fat_clean_bdev_aliases(sb, cont_start, cont_len);
>> +				cont_len = 0;
>> +			}
>>  			fatent.entry = FAT_START_ENT;
>> +		}
>>  		fatent_set_entry(&fatent, fatent.entry);
>>  		err = fat_ent_read_block(sb, &fatent);
>>  		if (err)
>> @@ -573,6 +594,10 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
>>  					*cluster = entry;
>>  				idx_clus++;
>>  
>> +				if (cont_len == 0)
>> +					cont_start = entry;
>> +				cont_len++;
>> +
>>  				if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
>>  					err = fat_flush_bhs(sb, bhs, &nr_bhs,
>>  							    inode_needs_sync(inode));
>> @@ -589,6 +614,9 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
>>  				 * so we can still use the prev_ent.
>>  				 */
>>  				prev_ent = fatent;
>> +			} else if (cont_len) {
>> +				fat_clean_bdev_aliases(sb, cont_start, cont_len);
>> +				cont_len = 0;
>>  			}
>>  			count++;
>>  			if (count == sbi->max_cluster)
>> @@ -602,6 +630,8 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
>>  	err = -ENOSPC;
>>  
>>  out:
>> +	if (cont_len)
>> +		fat_clean_bdev_aliases(sb, cont_start, cont_len);
>
>We would want to make as possible as shorter lock_fat. At least, this
>part can move outside of unlock_fat(sbi)?
>

Yes, this can be moved. Good catch.

>>  	unlock_fat(sbi);
>>  	mark_fsinfo_dirty(sb);
>>  	fatent_brelse(&fatent);

Thanks,
Matheus
