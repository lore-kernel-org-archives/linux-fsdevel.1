Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790516;
	b=aqGjM5+g1FIFPAIPN73Y7O+c/fJ2ZQseq9jPCavEF/77GgZIM+tZTMu/vjE7lBgTItRe
	 2F2yr7r1avD0PhK/wcNB8jzu+crPJAiLY5bRFUf1H7BaFHH8b0qldD7ZVXwxJP3voH1do
	 Q1Q+zsnv2v2fbRcOOhv1e1q5sZhP6DWp0tMnZiIkSHPVKBe2NyZDsAM/HYj6rLg5+RdAr
	 u/iITnNswldUnwEzn6A/5VfPqtJ7Xm63FBBlPDmbwvbEVLahgdFrm9byntRhe8x6B+EUJ
	 Y7qsFMEwreddDEaTpWuEGMWEeiwMRWBXQRzXayZjMQr8yk2MYqT7/Oey+VISHOYvg9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790516;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=NLqGpSkKZ0YeDUayv06WYbXNUC/yzg3Qww/jG1+UQKg=;
	b=3YCxcTp4Pj9KvYH5mk5FX9x7KOUzy//GcAFqQxa1EFK3Ey8PWnw3WSt3osunK/ifRWQx
	 uCZ+6PVsKT4tCDsjt5gSeqW7u2ZEUbqT8gNh2bC4rSIdj6DKvjQbvqg0SwFllgDjnExih
	 VWcXoED499c4dje5j9eM3ghFAqzNlbL+IZxvqblnXf0BHZ1fBZgDZjFHvFS717V7YZIO6
	 4Tc6sXdd/Uq8zp5HOBXjmJ3i9b0VITaDsUv3QUpuzJf0HEoQg+zJ5ogua46k028Ll0mCY
	 OeywgyHDbmUrkTlMivqVIKSbEA2EHChLHDpChFo+HUuvvavw/NA/+d8XNMg4inBC3qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=PDe6Oz2V;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1BD606A31B;
	Fri, 23 Oct 2026 21:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D1BD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=PDe6Oz2V
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id E4DDB120357;
	Fri, 23 Oct 2026 18:21:51 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1792790511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLqGpSkKZ0YeDUayv06WYbXNUC/yzg3Qww/jG1+UQKg=;
	b=PDe6Oz2VO2XfQBsSXATsvIcgh5rRnxqpXp8uJnvKOoMbhb2xIUt1ZwKtRg3xpNhyxPx4eQ
	Sy4wv1KUsqmivi6+wxUU7hYhbbKvbbM5Gjqh/1iqD9sSYiLbDeU6WAEoZ5XceItXFOnpit
	FZAr/iWfIRJDcekPCAoC73t0IGmZgU9pZWiL0iXvWHyHM/yH1MCzLnu0q28ujgWHaAWlVA
	YJvVZR0GrgrOOMDXcKlCu2rtXiZqNiqP5QMxumRLeCssDAqwu5dcHKJooGHdVZD4AooPwG
	BsgwK1GqxE7CfV3zV61L/jwdMBzvDdOSjddpX5RXbTI1P1DTLyvltBkkEaXZkA==
Date: Fri, 23 Oct 2026 18:21:48 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fat: preallocate space before expanding in
 fat_cont_expand()
Message-ID: <atvPYonyGRdK05zr@DESKTOP-PJTTJ93.localdomain>
References: <20261021154024.56868-1-matheus.aalmeida@inf.ufrgs.br>
 <87wlr8j2gs.fsf@mail.parknet.co.jp>
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
In-Reply-To: <87wlr8j2gs.fsf@mail.parknet.co.jp>

On Fri, Oct 23, 2026 at 04:33:23PM +0900, OGAWA Hirofumi wrote:
>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>
>> The fat_cont_expand() implementation leaves allocation of new clusters
>> to generic_cont_expand_simple(). This path does many small cluster
>> allocations, harming performance.
>>
>> Preallocate cluster space in fat_cont_expand(). Move preallocation to
>> a new fat_preallocate() helper used by both fat_cont_expand() and
>> fat_fallocate(FALLOC_FL_KEEP_SIZE).
>>
>> Benchmarking was done under QEMU/KVM with a virtio-blk device using
>> cache=none. Each result is the arithmetic mean of the listed samples.
>>
>> start = now_ns();
>> for (unsigned i = 0; i < count; i++) {
>>     if (truncate_mode)
>>         ftruncate(fds[i], bytes);
>>     else
>>         fallocate(fds[i], 0, 0, bytes);
>> }
>> elapsed = now_ns() - start;
>>
>> 16 files, 512-byte clusters:
>> length    mode      sync?    before    after    improvement    samples
>> 256MiB    ftruncate no       9.576s    5.345s   1.79x          10
>> 256MiB    fallocate no       9.634s    5.640s   1.71x          10
>> 1MiB      ftruncate yes      58.66s    0.362s   162.15x        5
>> 1MiB      fallocate yes      61.36s    0.390s   157.15x        5
>>
>> 128 files, 512-byte clusters:
>> length    mode      sync?    before    after    improvement    samples
>> 512KiB    ftruncate no       0.433s    0.352s   1.23x          10
>> 512KiB    fallocate no       0.446s    0.393s   1.13x          10
>> 64KiB     ftruncate yes      31.32s    0.429s   73.00x         10
>> 64KiB     fallocate yes      29.59s    0.410s   72.42x         10
>>
>> 16 files, 4096-byte clusters:
>> length    mode      sync?    before    after    improvement    samples
>> 256MiB    ftruncate no       5.181s    4.417s   1.17x          10
>> 256MiB    fallocate no       5.166s    4.442s   1.16x          10
>> 1MiB      ftruncate yes      9.294s    0.111s   84.06x         10
>> 1MiB      fallocate yes      8.710s    0.110s   79.36x         10
>>
>> The biggest improvement is on filesystems with a small cluster size and
>> on synchronous mounts.
>>
>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>> ---
>>
>> Changes in v2:
>> - fat_cont_expand(): Hold truncate_lock around fat_truncate_blocks().
>>
>> This patch depends on:
>> https://lore.kernel.org/linux-fsdevel/20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br/T/#t
>>
>>  fs/fat/file.c | 56 ++++++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 37 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/fat/file.c b/fs/fat/file.c
>> index 3aa541c6b127..dd0ae795dc14 100644
>> --- a/fs/fat/file.c
>> +++ b/fs/fat/file.c
>> @@ -217,15 +217,50 @@ const struct file_operations fat_file_operations = {
>>  	.setlease	= generic_setlease,
>>  };
>>  
>> +static int fat_preallocate(struct inode *inode, loff_t new_size)
>> +{
>> +	int nr_cluster; /* Number of clusters to be allocated */
>> +	loff_t mm_bytes; /* Number of bytes to be allocated for file */
>> +	loff_t ondisksize; /* block aligned on-disk size in bytes*/
>> +	struct super_block *sb = inode->i_sb;
>> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>> +
>> +	ondisksize = inode->i_blocks << 9;
>> +	if (new_size <= ondisksize)
>> +		return 0;
>> +
>> +	/* First compute the number of clusters to be allocated */
>> +	mm_bytes = new_size - ondisksize;
>> +	nr_cluster = (mm_bytes + (sbi->cluster_size - 1)) >>
>> +		     sbi->cluster_bits;
>> +
>> +	/* Allocate the clusters. We are not zeroing them out */
>> +	return fat_add_clusters(inode, nr_cluster);
>> +}
>> +
>>  static int fat_cont_expand(struct inode *inode, loff_t size)
>>  {
>>  	struct address_space *mapping = inode->i_mapping;
>>  	loff_t start = inode->i_size, count = size - inode->i_size;
>>  	int err;
>>  
>> -	err = generic_cont_expand_simple(inode, size);
>> +	/*
>> +	 * Preallocating space here is more efficient than during
>> +	 * generic_cont_expand_simple() because of batching.
>> +	 */
>> +	err = inode_newsize_ok(inode, size);
>>  	if (err)
>>  		goto out;
>> +	err = fat_preallocate(inode, size);
>> +	if (err)
>> +		goto out;
>> +	err = generic_cont_expand_simple(inode, size);
>> +	if (err) {
>> +		down_write(&MSDOS_I(inode)->truncate_lock);
>> +		fat_truncate_blocks(inode, inode->i_size);
>> +		up_write(&MSDOS_I(inode)->truncate_lock);
>
>Is this fat_truncate_blocks() really required?
>
Yes. generic_cont_expand_simple() calls inode_newsize_ok() as well,
which happens before fat_write_failed() can run and clean up. Another
thread could lower RLIMIT_FSIZE between the FAT and generic checks and
return without cleaning up.

Thanks,
Matheus
>> +		goto out;
>> +	}
>>  
>>  	fat_truncate_time(inode, NULL, FAT_UPDATE_CMTIME);
>>  	mark_inode_dirty(inode);
>> @@ -263,12 +298,7 @@ static int fat_cont_expand(struct inode *inode, loff_t size)
>>  static long fat_fallocate(struct file *file, int mode,
>>  			  loff_t offset, loff_t len)
>>  {
>> -	int nr_cluster; /* Number of clusters to be allocated */
>> -	loff_t mm_bytes; /* Number of bytes to be allocated for file */
>> -	loff_t ondisksize; /* block aligned on-disk size in bytes*/
>>  	struct inode *inode = file->f_mapping->host;
>> -	struct super_block *sb = inode->i_sb;
>> -	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>>  	int err = 0;
>>  
>>  	/* No support for hole punch or other fallocate flags. */
>> @@ -281,19 +311,7 @@ static long fat_fallocate(struct file *file, int mode,
>>  
>>  	inode_lock(inode);
>>  	if (mode & FALLOC_FL_KEEP_SIZE) {
>> -		ondisksize = inode->i_blocks << 9;
>> -		if ((offset + len) <= ondisksize)
>> -			goto error;
>> -
>> -		/* First compute the number of clusters to be allocated */
>> -		mm_bytes = offset + len - ondisksize;
>> -		nr_cluster = (mm_bytes + (sbi->cluster_size - 1)) >>
>> -			sbi->cluster_bits;
>> -
>> -		/* Allocate the clusters. We are not zeroing them out */
>> -		err = fat_add_clusters(inode, nr_cluster);
>> -		if (err)
>> -			goto error;
>> +		err = fat_preallocate(inode, offset + len);
>>  	} else {
>>  		if ((offset + len) <= i_size_read(inode))
>>  			goto error;
>
>-- 
>OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
