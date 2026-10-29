Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253475;
	b=IiLbST5sJ1hbn6bF9H1Q343gI7jmEsm1jLIqmRLdcck5ZQOaDhpHM8qkvCUgWVMTeQAF
	 30XApzYGOOh24Cy00BjxqSGfMF/2ab+AsnrKiBjakGldtjoF9x0jdHguuLMBCVjyJdmQg
	 2rvA1BtgbWYjj7Jt2lcnLuAjWneO92b81tzi/wYiKkfjXdA/7ewuD59h6YK9Shh/0/INV
	 cUdm7gx1Vk6iMV4+NEq8FQU+YO8Dw0I/Vy+LoKIHsxRBg+E9JD7fdBv4+VAN+XhtEXddb
	 IEPgSu9DAbku92LzvHIzBmqj35fgJhOFI3zTyOAUMsXhARcsnc5RcnKlD5ycxxXBoTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253475;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ODZizC4DNALp0pG3plEEc33Bl6AIfhxBeOjG9ejqhwY=;
	b=nUwiMAlO/66IijtlEn2FVISHh7nkTEa1yrSMwZxbUsH6qtVT/iVPABfq73eUtNeI6wMd
	 2Zz8tQOUESawgvkfM259yJx02FxcT80MFvlekUPTFGInxmiT4fXrJ44AZGSvWfVj+s+e6
	 v5DQwN3gJd5Xg5bSj9aghdSZjap2yPDs+wBV/ZDepnwkWQQhwmKCYK9DftILpYaIy116n
	 s7U+v7nox+NrpxBUXe+bQ0XhDqLhh7OkgW315XeLV8wjDHCxFrkuZAkOhKZ4RGdu9Tz9G
	 KOKmHv1tna/3I7e9AXGHkA4TiRM0ZdjeJ5XlvF2SlgAki6NKsa4vOsseGYowMc/a5Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=mtxdL8eH;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b="jSpElDI/";
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191BF606A31A;
	Thu, 29 Oct 2026 05:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 191BF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=mtxdL8eH;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=jSpElDI/
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 36A1626F768B;
	Thu, 29 Oct 2026 14:57:44 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793253464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODZizC4DNALp0pG3plEEc33Bl6AIfhxBeOjG9ejqhwY=;
	b=mtxdL8eHOTi5aSSYUGn+YlpSoj9CuMSeXBOUl+1xvkGo3OEMxdZrQWle0S5LZcP6oqhYkz
	29ivcJXvSV+8qULnydxmVQybYwBvh2+PSQz2CxjHEwTcwmSXloWR1Ffrpgw3akI9VZssVO
	/EMFpi3i6XVB+jAC1+dXF2giRL+uHythNh7g2IdAK3gfYV52mPoNWELDlvEjlubmc1eNI5
	B7ApB9RG8Dvt7FWlHvotZpbXyNp75hVrQW3tNHaCWP1TNo1Mbap1qKZSrJ4anTyTrrhPSw
	TjhH4CZ+2xL5RHAZ7HePweUumjeb+NGB075qFXKysAMOu280tEejRNHp20a+Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793253464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODZizC4DNALp0pG3plEEc33Bl6AIfhxBeOjG9ejqhwY=;
	b=jSpElDI/u8QBxyJWIpkqYDuzKH6FGElen7Ij502g2MFxBRzwKu1w/DGXxEpHSOcniHPNQy
	JqKbXb4necYTx9Aw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id B5EF9E0077A;
	Thu, 29 Oct 2026 14:57:43 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id AC5AF22001E2; Thu, 29 Oct 2026 14:57:43 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hungyu Lin <dennylin0707@gmail.com>, brauner@kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: fix parent link count when replacing a sibling
 directory
In-Reply-To: <20261028211626.26103-1-dennylin0707@gmail.com>
References: <20261028211626.26103-1-dennylin0707@gmail.com>
Date: Thu, 29 Oct 2026 14:57:43 +0900
Message-ID: <87fqxpdp60.fsf@mail.parknet.co.jp>
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
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Looks good. Thanks.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/namei_msdos.c | 2 ++
>  fs/fat/namei_vfat.c  | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index c7500c2859e0..570dd75dd275 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -565,6 +565,8 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  		(void)sync_inode_metadata(old_dir, 1);
>  
>  	if (new_inode) {
> +		if (is_dir && old_dir == new_dir)
> +			drop_nlink(old_dir);
>  		drop_nlink(new_inode);
>  		if (is_dir)
>  			drop_nlink(new_inode);
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index ff7652bf0410..d7e2df5bf7e5 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -1011,6 +1011,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	vfat_update_dir_metadata(old_dir, &ts);
>  
>  	if (new_inode) {
> +		if (is_dir && old_dir == new_dir)
> +			drop_nlink(old_dir);
>  		drop_nlink(new_inode);
>  		if (is_dir)
>  			drop_nlink(new_inode);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
