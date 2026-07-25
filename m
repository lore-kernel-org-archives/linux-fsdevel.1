Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145EF34572B
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994848; cv=none; b=Ib9300tkKfcFTCuDpGhzoxOCp2veoxI5G7iBZvORLK3JlFZYg7+JBtm3UtzleIFKYRKkG/uadbKDCHbAuYahzQWiafPGXMUHnJtzNZoSnq7rY4T0m0By2jcNctt210YAlolxqBGt+EMXxGuTG62f2k4yDmJ/Vts2S8iGEcNNDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994848; c=relaxed/simple;
	bh=3nVP/kakj1mDRq0taUq4hIFz3E9oEl6g7V0841JtQMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knpWtBAhjhzObx4knPxbl+7fKTNLKp+/Ook/kZE8yyL7xU855+EiwbloOzNoOpVRrs1xr4IeXNcNBEVuu7mXXc7cc+/dLyi9+0Hy2qIy9orOScZUZZ8Qd/sPAx8AXrntCmDb1qSiogUdx3qEALu9BA9CAPUxiiAdCAXuO+FU1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ZQjDvkn4; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZQjDvkn4"
X-KPN-MessageId: 0c6d650a-8841-11f1-a5a1-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0c6d650a-8841-11f1-a5a1-005056994fde;
	Sat, 25 Jul 2026 17:53:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=uvvy4ZDdcswg3rQnKPRfjVI+F4d66zq2fU5XaCFzDL8=;
	b=ZQjDvkn4iMfo/8VkPSOy8ljjN8hYriXoHoX7gYZsBFcX56/QwrXk8o/0or/YDqGfET+e8cNkBG229
	 32UFv58SwfqpN7VLCDxpPTEmdQqdWUrnUPo0dOx1BlWTHYFX21/biz8vxDlcHtSZTi2G/IQOYJU3g8
	 jNo/F2OpDNmFqUgOdClT7xlTOu8r3uvr1mU6Ysyi2bam5Fa8dFhxN4q4XZrW5LesgBQlcfA2gL8n/a
	 IsO3CRajx87Gt1V9w1i/to3V1x6CjPOCw9brL68wdkokxn0onM1sLdICQbGoHoG7vDJiBapUoxW2gJ
	 tqaKMgzhqtrYkOqXMGjGHsDvywKa7Rg==
X-KPN-MID: 33|SYoO7BKxnSp3q+Q2zAJ+7SXDVW4QgsJw++Dyl3VqxY6PIx6G5hp/NvmtqCLduSv
 E4W+IOvkTuabtk60FNEaL+nVQxHXTfohazi68c5Idzac=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|LdJrb658pFOTEgi/Onzb7Ly4knMgFixcDhSMTOsvwBDK9Z/O/vPiMUddWNpTtMl
 KBOn8kLU42qu8SIAjaWGm8g==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0c20c08f-8841-11f1-a789-00505699772e;
	Sat, 25 Jul 2026 17:53:58 +0200 (CEST)
Date: Sat, 25 Jul 2026 17:53:56 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 16/24] binfmt_misc: give the parse_command() results
 names
Message-ID: <amTcDFzdK5a2KB6A@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-16-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-16-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:17AM +0200, Christian Brauner wrote:
> parse_command() maps "0" to 1, "1" to 2 and "-1" to 3 and the write
> handlers switch on those bare numbers, leaving every reader to redo
> the mapping in their head. Name the commands and drop the per-case
> comments that only existed to translate the numbers back.
> 
> No functional change.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 06f4849cf1ad..1f2b1d136819 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -543,9 +543,17 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +/* Commands accepted by the /status and /<entry> files. */
> +enum bm_command {
> +	BM_CMD_IGNORE,	/* empty write */
> +	BM_CMD_DISABLE,	/* "0" */
> +	BM_CMD_ENABLE,	/* "1" */
> +	BM_CMD_REMOVE,	/* "-1" */
> +};
> +
>  /*
> - * Set status of entry/binfmt_misc:
> - * '1' enables, '0' disables and '-1' clears entry/binfmt_misc
> + * Parse what userspace wrote to /status or an entry file: '1' enables,
> + * '0' disables and '-1' removes the entry or all entries.
>   */
>  static int parse_command(const char __user *buffer, size_t count)
>  {
> @@ -556,15 +564,15 @@ static int parse_command(const char __user *buffer, size_t count)
>  	if (copy_from_user(s, buffer, count))
>  		return -EFAULT;
>  	if (!count)
> -		return 0;
> +		return BM_CMD_IGNORE;
>  	if (s[count - 1] == '\n')
>  		count--;
>  	if (count == 1 && s[0] == '0')
> -		return 1;
> +		return BM_CMD_DISABLE;
>  	if (count == 1 && s[0] == '1')
> -		return 2;
> +		return BM_CMD_ENABLE;
>  	if (count == 2 && s[0] == '-' && s[1] == '1')
> -		return 3;
> +		return BM_CMD_REMOVE;
>  	return -EINVAL;
>  }
>  
> @@ -717,16 +725,13 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  	int res = parse_command(buffer, count);
>  
>  	switch (res) {
> -	case 1:
> -		/* Disable this handler. */
> +	case BM_CMD_DISABLE:
>  		clear_bit(MISC_FMT_ENABLED_BIT, &e->flags);
>  		break;
> -	case 2:
> -		/* Enable this handler. */
> +	case BM_CMD_ENABLE:
>  		set_bit(MISC_FMT_ENABLED_BIT, &e->flags);
>  		break;
> -	case 3:
> -		/* Delete this handler. */
> +	case BM_CMD_REMOVE:
>  		inode = d_inode(inode->i_sb->s_root);
>  		inode_lock_nested(inode, I_MUTEX_PARENT);
>  
> @@ -866,16 +871,13 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  
>  	misc = i_binfmt_misc(file_inode(file));
>  	switch (res) {
> -	case 1:
> -		/* Disable all handlers. */
> +	case BM_CMD_DISABLE:
>  		WRITE_ONCE(misc->enabled, false);
>  		break;
> -	case 2:
> -		/* Enable all handlers. */
> +	case BM_CMD_ENABLE:
>  		WRITE_ONCE(misc->enabled, true);
>  		break;
> -	case 3:
> -		/* Delete all handlers. */
> +	case BM_CMD_REMOVE:
>  		inode = d_inode(file_inode(file)->i_sb->s_root);
>  		inode_lock_nested(inode, I_MUTEX_PARENT);
>  
> 
> -- 
> 2.53.0
> 

Good clean-up.

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
