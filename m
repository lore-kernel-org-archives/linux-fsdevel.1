Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941543ED12F;
	Wed, 22 Apr 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868734; cv=none; b=j5Xif6krAnEhxeHut71UeMuYTQ+w3tBBeaqlBg8QLVR3GyClC3Jfp5fAkiOke0JjMQUtm2LgsDM//e4xABUL+9de+79gvYgDx2xRm/Mdlnsx+8+AGdGRmUV3g7YNTeyfaGTZii7AgTWNhAtMcsz0syOXIy9G22vcINOUZtbcBvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868734; c=relaxed/simple;
	bh=UaNd9osX5Lo+FK0Mf1eJnkC8fzUGafgdiYQQyDeBdRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbZ6KwQCQmHP1vETG5/dbsBZCmOkJuWRIHrVlO8VkXfgGWKOChKUMBOKJUq3ZIte9fM3SY73L1u+rYj7KPhmk2BZ2eiJx3vRuzSrJ5adlHjQtijU5ORIWsn/zN+Idw2S8QQ2eQF3iw7Ed6VX1bXzyCkyqIOuzOfJBdtW9R6GvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hJtQfLRj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hJtQfLRj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rf6Pl7oREn998+GQ9X2DpyuH9BF7RneDRF3kXuc+CoE=; b=hJtQfLRjgzHRiCTNZuOFj65DMQ
	9d2GGJI9m8aOSk6y8C2vzCT/qVlnNyYpJvsY33U25X5mYY5Zrm+dM4BwumNZoJ720FtS0/3/Q5BEy
	2d34Cx8bXy6M3UIP2BmeHatq3C/ElAnYQhHMMtHI2JVG+WEUZkJt2oLDNOzIeQ3RTOiDClhZ17wQd
	mGXazVOOBhOeX0srAHJrtj2BT1C5/VR9rE6+KJW74eGAcwOnCS6tzBPnNomWi4oGQlLxL2yJ/MaCf
	yKI+EoGjkes2UjuyWq1RXW+UmDYZKUqr+TGfKKJcKFo0NHnaXDQ5IjxQHZsHYBK1wFwATtGb90rxP
	oz5vSkYQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wFYn6-00000006CXc-2Z8B;
	Wed, 22 Apr 2026 14:43:00 +0000
Date: Wed, 22 Apr 2026 15:43:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: use QSTR() instead of QSTR_INIT() in
 fuse_get_dentry
Message-ID: <20260422144300.GK3518998@ZenIV>
References: <20260422123911.100979-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422123911.100979-3-thorsten.blum@linux.dev>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 22, 2026 at 02:39:12PM +0200, Thorsten Blum wrote:
> Drop the hard-coded length argument and use the simpler QSTR().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/fuse/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index deddfffb037f..d224bcba593b 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1113,7 +1113,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
>  	inode = ilookup5(sb, handle->nodeid, fuse_inode_eq, &handle->nodeid);
>  	if (!inode) {
>  		struct fuse_entry_out outarg;
> -		const struct qstr name = QSTR_INIT(".", 1);
> +		const struct qstr name = QSTR(".");
>  
>  		if (!fc->export_support)
>  			goto out_err;
> 

What's wrong with
                err = fuse_lookup_name(sb, handle->nodeid, &QSTR("."), &outarg,
				       &inode);
to start with?
