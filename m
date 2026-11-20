Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178185;
	b=YtjSkehXQz6a75k9r32/54xKCRMXhaCCXx/8YunVrHJVUDhwGGFmwPtpxWgKtfNnREoA
	 RiaCa5AqnSvo1mZn0E0MuvTn1mc5QGqB+iLPPpvh8oZJ2PVYWnXnZQJK6IWzbiyyGGQRZ
	 cxlswzmW5x5L49Wy2EAEs1LmErK7VkptSj9gLkaIdBFutzU/c64hFkFzSXfDOs0nNsaH2
	 mW92Mzwck+bY722IQ8JJrTJaK78R6FU3/QRwRFfkYOFunFExvdLh45c6Aovzt50dFSfWX
	 I4tXNyl+tbbBIaK1wBwpMZKPIeSCKOG5P+9N5oBY3w1EnJc27os1WWmpmFJ5L94rs1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178185;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=gsDaNW3c25zsIb9zJPUAJ/QgQHdmH3s0FFLrcb6FKlw=;
	b=J+0Yq44tQly+zA7in9MOfyltHzh802tSf/s4PZ+WcacCmFp0yLX8rZQ3C7DZj2KkUZuE
	 OBeMbyzAijoDIA4N0x8j4WfI/DJ9APSfLEX5bB1EeZIQui5rnyMvQApUqn/eFW23toHFV
	 hvqPfZ9AXNc93Bsdz4FvZZIXkGy4iJOZ3ZfB9NIVvuqZPAzf1GLm24I94vkSl3j5zjvSb
	 WYldb5P9POdGPqkYLja7blD+EQ02k9Bu8BUbdOGZQXySKEFMaWcIWr13bbQqe/YPrEGAU
	 zValDPF/TruQg54J9DqGC7oT+Uj/gEd5y5/znA2EE5+k+3k8V35Ab8v19wFf6V6XBdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=nGqt0Wn8;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=ECYTn7xR;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86855606A32A;
	Fri, 20 Nov 2026 12:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86855606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=nGqt0Wn8;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=ECYTn7xR
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 118D820BD282;
	Fri, 20 Nov 2026 21:36:17 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1795178177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsDaNW3c25zsIb9zJPUAJ/QgQHdmH3s0FFLrcb6FKlw=;
	b=nGqt0Wn84QZ0IaMMAZ8thWeKEFfLHbozAwGbdnI1OuomPYLsAALHIv+2o7sdBbG9g9AA6Y
	jdpjOkMevN/EyTMISVDtQ9pS5op48xL1AvefLNLmz9vgWabHlqKO09nz36r4BfA3xztb1t
	9sK+oULMOim/qRngOTjw2T992oiWk7XVv6vIS4izssHJ/Ii43ZPiAIBn/OCNmZ6nTpA3xe
	ebnzAcfvPxDryUpaW2DPS88LweR+/DRPjhySYw+Ol6OgX8njBJqt/up9vYWFW7pqzHJ3P+
	4JbimRBujR1bty1G2FxLSjBLjHm0Sz2Yt/8BKvMm0ekRqoWf5L2gswFGfeCaLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1795178177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsDaNW3c25zsIb9zJPUAJ/QgQHdmH3s0FFLrcb6FKlw=;
	b=ECYTn7xR4Fsm1PjIKG2lvMd99J9zTZuTv/iixBIqcY7s7wtnNloXQSXugcwlTL2KEyFX+o
	yqOgh76nL+vp3KDA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 7EDB0E00850;
	Fri, 20 Nov 2026 21:36:16 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 6F2EC220021D; Fri, 20 Nov 2026 21:36:16 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: Re: [PATCH v5] fat: make rename recovery safe after metadata write
 errors
In-Reply-To: <91d8a899-e768-4a4f-8f56-50a7b6f8a293@gmail.com>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
	<20260929090029.742579-1-krystianmkaniewski@gmail.com>
	<87ld8j4161.fsf@mail.parknet.co.jp>
	<1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com>
	<87bj90m6dq.fsf@mail.parknet.co.jp>
	<20261014082315.190262-1-krystianmkaniewski@gmail.com>
	<87qzhqvloo.fsf@mail.parknet.co.jp>
	<55a1f016-a7a2-469f-b481-37223d695f29@gmail.com>
	<87cxt921rc.fsf@mail.parknet.co.jp>
	<f9b27432-4104-4323-8cd7-e2cda73db2f9@gmail.com>
	<875wz11xfg.fsf@mail.parknet.co.jp>
	<c820357a-a7cf-4f4b-ab23-91530a12218b@gmail.com>
	<878q3uhv4h.fsf@mail.parknet.co.jp>
	<20261019145146.539233-1-krystianmkaniewski@gmail.com>
	<87wlrdy8ch.fsf@mail.parknet.co.jp>
	<2ba329a1-ad8c-4b6a-8dd6-1f93c85224c0@gmail.com>
	<20261102143013.492650-1-krystianmkaniewski@gmail.com>
	<87y0b3to5u.fsf@mail.parknet.co.jp>
	<91d8a899-e768-4a4f-8f56-50a7b6f8a293@gmail.com>
Date: Fri, 20 Nov 2026 21:36:16 +0900
Message-ID: <87jym7fznj.fsf@mail.parknet.co.jp>
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

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> On 11/8/26 15:04, OGAWA Hirofumi wrote:
>>>
>>>  fs/fat/namei_msdos.c | 18 ++++++++++++----
>>>  fs/fat/namei_vfat.c  | 50 +++++++++++++++++++++++++++++++-------------
>>>  2 files changed, 49 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
>>> index d46d1a3851f25f..51d49a3ca93c14 100644
>>> --- a/fs/fat/namei_msdos.c
>>> +++ b/fs/fat/namei_msdos.c
>>> @@ -562,14 +562,20 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>>>  	return err;
>>>  
>>>  error_dotdot:
>>> -	/* data cluster is shared, serious corruption */
>>> +	/*
>>> +	 * Complete the remaining rollback. Report corruption only if a
>>> +	 * recovery step cannot be completed.
>>> +	 */
>>>  	corrupt = 1;
>>>  
>>> -	if (update_dotdot) {
>>> +	/* A failed sync write clears BH_Uptodate, leave that buffer alone. */
>>> +	if (update_dotdot && buffer_uptodate(dotdot_bh)) {
>>>  		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
>>>  		mmb_mark_buffer_dirty(dotdot_bh,
>>>  				      &MSDOS_I(old_inode)->i_metadata_bhs);
>>>  		corrupt |= sync_dirty_buffer(dotdot_bh);
>>> +	} else if (update_dotdot) {
>>> +		corrupt = err;
>>>  	}
>>>  error_inode:
>>>  	fat_detach(old_inode);
>>> @@ -577,11 +583,13 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>>>  	MSDOS_I(old_inode)->i_attrs = old_attrs;
>>>  	if (new_inode) {
>>>  		fat_attach(new_inode, new_i_pos);
>>> -		if (corrupt) {
>>> +		if (corrupt && buffer_uptodate(sinfo.bh)) {
>> 
>> This check is ok with sinfo.bh?
>> 
>
> Yes. For an existing destination, msdos_lookup() reaches fat_scan()
> through msdos_find(), while do_msdos_rename() calls fat_scan() with
> the same normalized 8.3 name. Both identify the same directory entry,
> so sinfo.i_pos equals new_i_pos and sinfo.bh is the buffer containing
> that entry.
>
>> 
>> I guess this check is needed for msdos too? If so, maybe we want the
>> helper function in fat module.
>> 
>> Thanks.
>
> I agree that a common FAT helper would be the right shape if this check
> were still needed. I prepared that version, but before sending v6 I
> noticed that the buffer write-error contract changed in v7.4-rc1.
>
> Commit 9f08e58149dc ("buffer: stop touching BH_Uptodate on write
> completion") no longer clears BH_Uptodate after a failed write. The
> failure is recorded in BH_Write_EIO instead. The same series changed
> fat_sync_bhs() in 8417ab622ffc ("fat: check for a metadata write error
> with buffer_write_io_error()"). The 9f08e58149dc commit message calls
> out the mark_buffer_dirty() warning from this report as the reason for
> the series.
>
> I reran the original C and syz reproducers and targeted metadata write
> faults on current mainline without a FAT patch. The writes still failed,
> but the !buffer_uptodate warning did not occur.
>
> This also means that changing the v5 checks mechanically to
> buffer_write_io_error() would not be correct. The new buffer semantics
> deliberately preserve the in-memory data so that a failed write can be
> retried. In particular, suppressing the second dotdot rollback in
> vfat_rename_exchange() would now remove valid recovery.
>
> My current conclusion is that I should not send a FAT v6 for mainline.
> Would you agree that 9f08e58149dc should be reported to syzbot as the
> fix and that this FAT series should be dropped?
>
> Older kernels that do not contain these buffer changes may still hit
> the warning. Since the warning is now addressed in the buffer layer,
> backporting the relevant v7.4 buffer changes may be preferable to
> adding a separate FAT recovery change.

OK. If there is no WARN_ON() anymore, it sounds good.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
