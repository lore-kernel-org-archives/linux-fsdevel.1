Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792799327;
	b=jee0a5FdjyKBLOzMSjFIn5skRlTH8qwHo2TsnmYeCial60dJMP4wweTMsHF5gS07rqnu
	 eADZrIy1rn6YMlN3KKdO60LEL7oi/8VsxkHmnQWqujYF11+PxU1Mw5IkgPWb6wBDHMsxW
	 7PsKVY1DqG05IDZhQ+mGiSgFHcoQDIixrtOvealC/gWH/xeJMEi9spINikDHUVKQ3mcJn
	 eL05eZkRY6IUaLiuQHlSvcuHckEnSCnqAjIOKfG/U+jnQkdRtOzxe0ozA9xMZP4kbjwBs
	 FeCTXCOxSp/DmUFGNBYEUUufYDB+5kaKk35ZHLFZ7gWPU3e/InO8kwTVT8I9a3J76Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792799327;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=0MCwWh/dgcRBm3UTwq46wb46c9L9CAfyaqtHx4MGw60=;
	b=gD9rvKulRTlUOgaU924QQUml8juUlSYPZLjHe6PLimqv1S06IFmfWzNgwW96MoWn8Tck
	 kWL0ozHKVhvjefHfLcwncy7FGrVJC76ZRBTJYxdZQBS4F7ngKwIZuZfO/CrvOtfjbdK1J
	 NU0XSMNtgJEwiufVJM3H/+LKu2z23PIILe5B+mAtEPX7pZZBLvxY779Qs7n0vdT5KsBo2
	 vly6ordzj78HQNLS6WnCz/0cql+vBaRSkTcNiafeM/HH/TaLN4t+8sZ1m4Lni/myZj5KS
	 UltPO0d0trMawGt0EFbQokzhifaK4HnNkexSvADW/5FHhddU4931JKXfbUow1IJ92oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=g7r4KcUe;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=v2PmoUlI;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F0606A31A;
	Fri, 23 Oct 2026 23:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D4F0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=g7r4KcUe;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=v2PmoUlI
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id E596526F7694;
	Sat, 24 Oct 2026 08:48:44 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792799324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0MCwWh/dgcRBm3UTwq46wb46c9L9CAfyaqtHx4MGw60=;
	b=g7r4KcUeCfOteVUN9ItEcv6DApg7DrzD7pr65y4JNb/biUSWrPuX3qrEZ4Ior7hYn/e9cM
	0lZyYrmblKZR5GvkCfC63UxbMI+OtQRzBI27yaZCQ/rbURI4gV1ITNC2onA7njAchFEuGQ
	+dtzUaGBarzN7f3Nlvwo7qxxYKQPiBZu5P1wlz3V9N7MdULBYyBq5hlKDz04waCGCYck1+
	js2JYEK29htNgapBlx8ZY5wjZavVzuMcly9sjph9U7ew5HYJrGQkpYsrsY+KORrewEn9Z3
	/2qx8zh/yerLjT0XE/uRIKyLE0+wA9zaStCroYu+lgBwdx4bAkyBU83HNLyJEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792799324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0MCwWh/dgcRBm3UTwq46wb46c9L9CAfyaqtHx4MGw60=;
	b=v2PmoUlIIzuckaqhlD1dgKxAA/ndHQasMQ6y0ziFQZG9DpYf/AL1lApD8Dh5Ew1NLGwYiH
	f+XVP7Ki1L9YcyBg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 5D4BAE00107;
	Sat, 24 Oct 2026 08:48:44 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 4A77E22000A7; Sat, 24 Oct 2026 08:48:44 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fat: preallocate space before expanding in
 fat_cont_expand()
In-Reply-To: <atvPYonyGRdK05zr@DESKTOP-PJTTJ93.localdomain>
References: <20261021154024.56868-1-matheus.aalmeida@inf.ufrgs.br>
	<87wlr8j2gs.fsf@mail.parknet.co.jp>
	<atvPYonyGRdK05zr@DESKTOP-PJTTJ93.localdomain>
Date: Sat, 24 Oct 2026 08:48:44 +0900
Message-ID: <877bj8q8pv.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> On Fri, Oct 23, 2026 at 04:33:23PM +0900, OGAWA Hirofumi wrote:
>>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>>
>>> The fat_cont_expand() implementation leaves allocation of new clusters
>>> to generic_cont_expand_simple(). This path does many small cluster
>>> allocations, harming performance.
>>>
>>> Preallocate cluster space in fat_cont_expand(). Move preallocation to
>>> a new fat_preallocate() helper used by both fat_cont_expand() and
>>> fat_fallocate(FALLOC_FL_KEEP_SIZE).
>>>
>>> Benchmarking was done under QEMU/KVM with a virtio-blk device using
>>> cache=none. Each result is the arithmetic mean of the listed samples.
>>>
>>> start = now_ns();
>>> for (unsigned i = 0; i < count; i++) {
>>>     if (truncate_mode)
>>>         ftruncate(fds[i], bytes);
>>>     else
>>>         fallocate(fds[i], 0, 0, bytes);
>>> }
>>> elapsed = now_ns() - start;
>>>
>>> 16 files, 512-byte clusters:
>>> length    mode      sync?    before    after    improvement    samples
>>> 256MiB    ftruncate no       9.576s    5.345s   1.79x          10
>>> 256MiB    fallocate no       9.634s    5.640s   1.71x          10
>>> 1MiB      ftruncate yes      58.66s    0.362s   162.15x        5
>>> 1MiB      fallocate yes      61.36s    0.390s   157.15x        5
>>>
>>> 128 files, 512-byte clusters:
>>> length    mode      sync?    before    after    improvement    samples
>>> 512KiB    ftruncate no       0.433s    0.352s   1.23x          10
>>> 512KiB    fallocate no       0.446s    0.393s   1.13x          10
>>> 64KiB     ftruncate yes      31.32s    0.429s   73.00x         10
>>> 64KiB     fallocate yes      29.59s    0.410s   72.42x         10
>>>
>>> 16 files, 4096-byte clusters:
>>> length    mode      sync?    before    after    improvement    samples
>>> 256MiB    ftruncate no       5.181s    4.417s   1.17x          10
>>> 256MiB    fallocate no       5.166s    4.442s   1.16x          10
>>> 1MiB      ftruncate yes      9.294s    0.111s   84.06x         10
>>> 1MiB      fallocate yes      8.710s    0.110s   79.36x         10
>>>
>>> The biggest improvement is on filesystems with a small cluster size and
>>> on synchronous mounts.
>>>
>>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>>> ---
>>>
>>> Changes in v2:
>>> - fat_cont_expand(): Hold truncate_lock around fat_truncate_blocks().
>>>
>>> This patch depends on:
>>> https://lore.kernel.org/linux-fsdevel/20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br/T/#t
>>>
>>>  fs/fat/file.c | 56 ++++++++++++++++++++++++++++++++++-----------------
>>>  1 file changed, 37 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/fs/fat/file.c b/fs/fat/file.c
>>> index 3aa541c6b127..dd0ae795dc14 100644
>>> --- a/fs/fat/file.c
>>> +++ b/fs/fat/file.c
>>> @@ -217,15 +217,50 @@ const struct file_operations fat_file_operations = {
>>>  	.setlease	= generic_setlease,
>>>  };
>>>  
>>> +static int fat_preallocate(struct inode *inode, loff_t new_size)
>>> +{
>>> +	int nr_cluster; /* Number of clusters to be allocated */
>>> +	loff_t mm_bytes; /* Number of bytes to be allocated for file */
>>> +	loff_t ondisksize; /* block aligned on-disk size in bytes*/
>>> +	struct super_block *sb = inode->i_sb;
>>> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>>> +
>>> +	ondisksize = inode->i_blocks << 9;
>>> +	if (new_size <= ondisksize)
>>> +		return 0;
>>> +
>>> +	/* First compute the number of clusters to be allocated */
>>> +	mm_bytes = new_size - ondisksize;
>>> +	nr_cluster = (mm_bytes + (sbi->cluster_size - 1)) >>
>>> +		     sbi->cluster_bits;
>>> +
>>> +	/* Allocate the clusters. We are not zeroing them out */
>>> +	return fat_add_clusters(inode, nr_cluster);
>>> +}
>>> +
>>>  static int fat_cont_expand(struct inode *inode, loff_t size)
>>>  {
>>>  	struct address_space *mapping = inode->i_mapping;
>>>  	loff_t start = inode->i_size, count = size - inode->i_size;
>>>  	int err;
>>>  
>>> -	err = generic_cont_expand_simple(inode, size);
>>> +	/*
>>> +	 * Preallocating space here is more efficient than during
>>> +	 * generic_cont_expand_simple() because of batching.
>>> +	 */
>>> +	err = inode_newsize_ok(inode, size);
>>>  	if (err)
>>>  		goto out;
>>> +	err = fat_preallocate(inode, size);
>>> +	if (err)
>>> +		goto out;
>>> +	err = generic_cont_expand_simple(inode, size);
>>> +	if (err) {
>>> +		down_write(&MSDOS_I(inode)->truncate_lock);
>>> +		fat_truncate_blocks(inode, inode->i_size);
>>> +		up_write(&MSDOS_I(inode)->truncate_lock);
>>
>>Is this fat_truncate_blocks() really required?
>>
> Yes. generic_cont_expand_simple() calls inode_newsize_ok() as well,
> which happens before fat_write_failed() can run and clean up. Another
> thread could lower RLIMIT_FSIZE between the FAT and generic checks and
> return without cleaning up.

If the reason is only for inode_newsize_ok(), we would be able to add
fat_cont_expand_simple() or such instead.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
