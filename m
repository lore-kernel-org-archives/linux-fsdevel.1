Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146681;
	b=3JDmt+G0E/TaANjAwe6ihY/ieR8CWIhzdvAA65yGywHqsBSssLAKL3zpp69yhIM66xyl
	 2f2dWADWmtdjveawOGXZrjufuY1eqcXY6coZGEAbTqgyx2e9q5/Z9KBaqf1erTdggqWCS
	 KCzp+tXEwe1/yx4oh0TOtG6/wetu4KP+vzK7yAIJeUdtfqBxUVBW+rANFbf2a9xolsKgW
	 SJuIz5axIZyoMzMdCrt/BcjaTZMUyhfT2thicsqHDGhlLQqdchYt54HPvdUh0ekogo921
	 kCvbApVNzPo/N7DNFfm9pKUaxg5cTOlPSjrJ1uh0GpBr1GMJiTBFcOCiW0/eki8BSJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146681;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=gQrw2hSlF1u+XTYFOeNSh4PkrEafTO3AC91G200zYAk=;
	b=bmrd+dFdmBXLJ+P9bNlg9eumi6wnqugrMeJlbq5P41P2q5SsCTO4umus6CV7Ji+7vF77
	 L51FdUixJIHpmW/l1Ytn3LRYuCf43VkxbOm3a2UuuNDgtwTwWVVK30QAYJM1671fbH9Zr
	 w7g9Dg02rEXQgCGmE8/pkWXutsU7s2S+BFyDPZOEVBWViJlZq0tqutEgtlKSJvdOL/mdY
	 fm78HZRUpooRtYFOb902Nywok1Dg5ecVBq7jFBHDc7fXErP+gHRve0G9V7OO1550tqDCN
	 rc2JIkk0OumkrH3BNCyV1cwfjYNUSyPzteiVgZ6PlZ+Yw2aG9KTybFQ7oqcQJO0CEXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=0y2oAFfU;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=SNGQ7Ymu;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D99606A31C;
	Sun,  8 Nov 2026 14:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4D99606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=0y2oAFfU;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=SNGQ7Ymu
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id D06CC20BD288;
	Sun,  8 Nov 2026 23:04:29 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1794146670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gQrw2hSlF1u+XTYFOeNSh4PkrEafTO3AC91G200zYAk=;
	b=0y2oAFfU5gfVhVr61Vp6DwDYoTa+QXOlneSjchai1h95+SPzIo/usLz9SGLW13TB8F/RnP
	7hihhj8QRYsjMzqGmUFx67+PPFMfbXFITeDrdPFLLyWL15/OhabpWaHlW5I2ruC8fKRbN2
	arwCtHxoJU7yhElvwUKhvcERjIHTgVO6QHySZLGkdKtGZPjcAaxuAtyMsBkDIOpTc6/3rV
	jqBmf59jcul1ThwhN+2NQRTAYO8i6bY8CG08tAwk8jvSx6AKuv353blKENmNgYXKsHzHmF
	sPfdx/seQESIwPH3PlOczYrGXveGg6U8MCJzEd2BSMxPnHEim+vRAwbnosOYeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1794146670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gQrw2hSlF1u+XTYFOeNSh4PkrEafTO3AC91G200zYAk=;
	b=SNGQ7Ymuy3+3CwOrcKhXyuvHncVwvsSyYfAR96IIz+kt6fGAFVn+XeQbu1czhuVCmFJTsI
	cZsoxEhExDByRTCg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 54E0CE001A6;
	Sun, 08 Nov 2026 23:04:29 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 46AD422001DF; Sun, 08 Nov 2026 23:04:29 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: Re: [PATCH v5] fat: make rename recovery safe after metadata write
 errors
In-Reply-To: <20261102143013.492650-1-krystianmkaniewski@gmail.com>
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
Date: Sun, 08 Nov 2026 23:04:29 +0900
Message-ID: <87y0b3to5u.fsf@mail.parknet.co.jp>
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

> A failed synchronous FAT metadata write clears BH_Uptodate. Rename
> recovery can then modify and dirty the same retained buffer, which
> triggers the !buffer_uptodate warning in mark_buffer_dirty().
>
> Check the retained buffers in the rename error paths and skip only the
> recovery step whose buffer is no longer uptodate. The other steps run as
> before, including the rollback after a failed source-entry removal,
> where only the source-entry buffer failed. VFAT keeps no slot
> information for a replaced entry. Resolve its saved position with a
> cache-only lookup before dirtying the inode, because FAT inode
> writeback would otherwise reread and retry a failed block.
>
> For exchange, do not rewrite the dotdot buffer whose write failed,
> restore an earlier dotdot update only while its buffer is uptodate, and
> restore both inode positions as before. A skipped step is reported as
> filesystem corruption, and the original error is returned.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
> ---
> Changes in v5:
> - Check buffer_uptodate() directly in the rename error paths and drop the
>   helper and the buffer lock of v4.
> - Skip only the recovery step of a buffer that is no longer uptodate and
>   keep the rest of the existing recovery, also after a failed dotdot write
>   and in exchange.
> - Keep the existing rollback after a failed source-entry removal. The reply
>   to v4 proposed stopping there, but fat_remove_entries() fails only when
>   the old_sinfo buffer write fails, so the source entry is still in place.
>   Stopping left an invalid ".." entry and shared clusters in my tests,
>   while the existing rollback leaves the filesystem clean.
> - Look up the cached VFAT target entry block from its inode position,
>   because that path has no slot information.
> - Clarify the recovery-state comments without changing behavior.
>
> v4: https://lore.kernel.org/all/20261019145146.539233-1-krystianmkaniewski@gmail.com/
>
>  fs/fat/namei_msdos.c | 18 ++++++++++++----
>  fs/fat/namei_vfat.c  | 50 +++++++++++++++++++++++++++++++-------------
>  2 files changed, 49 insertions(+), 19 deletions(-)
>
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index d46d1a3851f25f..51d49a3ca93c14 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -562,14 +562,20 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  	return err;
>  
>  error_dotdot:
> -	/* data cluster is shared, serious corruption */
> +	/*
> +	 * Complete the remaining rollback. Report corruption only if a
> +	 * recovery step cannot be completed.
> +	 */
>  	corrupt = 1;
>  
> -	if (update_dotdot) {
> +	/* A failed sync write clears BH_Uptodate, leave that buffer alone. */
> +	if (update_dotdot && buffer_uptodate(dotdot_bh)) {
>  		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
>  		mmb_mark_buffer_dirty(dotdot_bh,
>  				      &MSDOS_I(old_inode)->i_metadata_bhs);
>  		corrupt |= sync_dirty_buffer(dotdot_bh);
> +	} else if (update_dotdot) {
> +		corrupt = err;
>  	}
>  error_inode:
>  	fat_detach(old_inode);
> @@ -577,11 +583,13 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  	MSDOS_I(old_inode)->i_attrs = old_attrs;
>  	if (new_inode) {
>  		fat_attach(new_inode, new_i_pos);
> -		if (corrupt) {
> +		if (corrupt && buffer_uptodate(sinfo.bh)) {

This check is ok with sinfo.bh?

>  			mark_inode_dirty(new_inode);
>  			corrupt |= sync_inode_metadata(new_inode, 1);
> +		} else if (corrupt) {
> +			corrupt = err;
>  		}
> -	} else {
> +	} else if (buffer_uptodate(sinfo.bh)) {
>  		/*
>  		 * If new entry was not sharing the data cluster, it
>  		 * shouldn't be serious corruption.

[...]

>  error_inode:
>  	fat_detach(old_inode);
> @@ -1023,10 +1029,27 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	if (new_inode) {
>  		fat_attach(new_inode, new_i_pos);
>  		if (corrupt) {
> -			mark_inode_dirty(new_inode);
> -			corrupt |= sync_inode_metadata(new_inode, 1);
> +			struct buffer_head *target_bh;
> +			sector_t blocknr;
> +			int offset;
> +
> +			/*
> +			 * A replaced entry has no slot info. Use its saved
> +			 * position for a cache-only lookup so recovery does
> +			 * not reread a failed block.
> +			 */
> +			fat_get_blknr_offset(MSDOS_SB(sb), new_i_pos,
> +					     &blocknr, &offset);
> +			target_bh = sb_find_get_block_nonatomic(sb, blocknr);
> +			if (target_bh && buffer_uptodate(target_bh)) {
> +				mark_inode_dirty(new_inode);
> +				corrupt |= sync_inode_metadata(new_inode, 1);
> +			} else {
> +				corrupt = err;
> +			}
> +			brelse(target_bh);
>  		}

[...]

I guess this check is needed for msdos too? If so, maybe we want the
helper function in fat module.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
