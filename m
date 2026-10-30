Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334675;
	b=K92YnL1Q3R1smylZ5KuNOfYaoYXOR/dR0kMplyQJ/hGqLkfCn11jeUzb6Sv4/oXtDy3s
	 T6nuXNosvxbVQ1D9/CklGiKiDo+mvVqKBGiH1HuL4mL2G12zgKWZlP0GQ9vOckIeUQHp6
	 /VAoWuacct43gxyuBh3O8vYFlES0p++aVSuTJyPGWRrFqDTmXMsvwu4mIyjRq6MlFOCTc
	 NZFsKCdjvi2Ryaq69ZpSDSlN6B59Y5nxHC8ziTdTHZpk1Hfj8FOhIG+52LXiuX4UY2zWI
	 UKNbQBXE6SxiRFB5J4T/4JahPDHVcpa/E/SOijtBKpApg+BLAUehRQ3XEl88zJXDjig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334675;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=AyLCv3t0FodhJlTxvoBzkqHZ7t7IZvHquYdriLHYDEM=;
	b=XeJ/rPQGFYNiyfKHiuOPf2ekVra3Yy8SU21ltRH0yiGhy8LO6S8To/Yzq4mHu/Gjhm48
	 wDXZdfctiwncTMpWx2Gxv1dGdAsZMUBZE/l2mXVJcnsRoImpIEy4ZDNUq/oQkH96LM10d
	 lefLHuHVZok8IThGaiUrZTVMMTunapprqTgLeQk4qVVL3CNO49yc4xEoMOGgE9rEXQ2kj
	 L7jvJDnnN2j7fzqWrcdsn/P4MWA6/7BwnCmxw/fDNTfOHYAUsSJihD50e1HDHZNu8gSoy
	 v1eOqZNumz5ATfLVE+9Dp1whSHmfOhFD4YxR9jlc6s3D7QX19jZvjt2UR2aQIZQHEug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=Fzp0oJMR;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=+dJucND6;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F2606A31A;
	Fri, 30 Oct 2026 04:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 538F2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=Fzp0oJMR;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=+dJucND6
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 59EB726F7699;
	Fri, 30 Oct 2026 13:31:12 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793334672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AyLCv3t0FodhJlTxvoBzkqHZ7t7IZvHquYdriLHYDEM=;
	b=Fzp0oJMRtNX9VTfxDFBAdwzHAoncr1gHE7EMnUeTb5Ln3DJp07a0TrygFxGdKOCaHySknq
	2Q4moxGStazgbLC4FdZvhAKpV736Ii1KF8SjsfmRsJE88bIpR8T+hdaSWpaHTeWKdi00x+
	+8PyGnJxDMApcQRMPAN+3QxxFYDParaL7gXHgq2u/TITeC2584jqs+ZX1vG1G+Dxiag5G1
	TU75++Z0wLhMN58tBRQkvmexEMQkVXxvytbKcNsu6YopKtZ2IrK/Pc8uYlgTXPdZVnbpnt
	O/DuzSR2s0XwYIy+PeGHcsfQFz+YkF8zC8aXjCTnZsDRwYp9/EjH6YdwsGBgVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793334672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AyLCv3t0FodhJlTxvoBzkqHZ7t7IZvHquYdriLHYDEM=;
	b=+dJucND6owifUdGe1ntpj5HGiK2b82PG0SmwCaWMwRkmy+cO16Fhca2+3zL6BU7l6eE0jo
	+JBxz3eqnXBPT6Dw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 9A80EE000B0;
	Fri, 30 Oct 2026 13:31:11 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 92C7322001E2; Fri, 30 Oct 2026 13:31:11 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fat: fix parent link count when replacing a sibling
 directory
In-Reply-To: <20261029202352.59890-1-dennylin0707@gmail.com>
References: <20261029202352.59890-1-dennylin0707@gmail.com>
Date: Fri, 30 Oct 2026 13:31:11 +0900
Message-ID: <87y0bfstbk.fsf@mail.parknet.co.jp>
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

Hungyu Lin <dennylin0707@gmail.com> writes:

> vfat_rename() and do_msdos_rename() adjust parent link counts only when
> updating the dotdot entry for a move between different parents. Replacing
> an existing empty directory in the same parent also removes a
> subdirectory, but leaves the parent's link count unchanged.
>
> For example, renaming one of two sibling directories over the other
> leaves the parent with four links instead of three. stat and ls report
> the stale count, and find -links 3 does not match the parent.
>
> Drop the parent's link count for this case after the source entry has
> been removed successfully. Leave cross-parent renames, regular files
> and the existing error paths unchanged.
>
> As in rmdir, check that the parent's link count is at least three before
> decrementing it. Report a filesystem error if corrupted directory entries
> have left the count too low, rather than reducing it below two.
>
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
> Changes in v2:
> - Check the parent link count before decrementing it and report low
>   counts with fat_fs_error(), matching rmdir(), as noted by Sashiko.
> - Retain Hirofumi's Acked-by from v1.
>
> v1: https://lore.kernel.org/r/20261028211626.26103-1-dennylin0707@gmail.com
> Review: https://sashiko.dev/#/patchset/20261028211626.26103-1-dennylin0707@gmail.com
>  fs/fat/namei_msdos.c | 8 ++++++++
>  fs/fat/namei_vfat.c  | 8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index c7500c2859e0..97289c9d9261 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -565,6 +565,14 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  		(void)sync_inode_metadata(old_dir, 1);
>  
>  	if (new_inode) {
> +		if (is_dir && old_dir == new_dir) {
> +			if (old_dir->i_nlink >= 3)
> +				drop_nlink(old_dir);
> +			else
> +				fat_fs_error(old_dir->i_sb,
> +					     "parent dir link count too low (%u)",
> +					     old_dir->i_nlink);
> +		}
>  		drop_nlink(new_inode);
>  		if (is_dir)
>  			drop_nlink(new_inode);
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index ff7652bf0410..c4d5628c05fa 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -1011,6 +1011,14 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	vfat_update_dir_metadata(old_dir, &ts);
>  
>  	if (new_inode) {
> +		if (is_dir && old_dir == new_dir) {
> +			if (old_dir->i_nlink >= 3)
> +				drop_nlink(old_dir);
> +			else
> +				fat_fs_error(old_dir->i_sb,
> +					     "parent dir link count too low (%u)",
> +					     old_dir->i_nlink);
> +		}
>  		drop_nlink(new_inode);
>  		if (is_dir)
>  			drop_nlink(new_inode);

Thanks. Hm, how about move those same code to fat module

	fat_dir_drop_nlink()
        EXPORT_SYMBOL_GPL(fat_dir_drop_nlink)

as such function for 3 places?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
