Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778930BF66
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959149; cv=none; b=RmaTqSqW/ty3T96TMP7pH/uwAe0CPEKBAIg+cz1KVd+3hQsO+M8V4d85mS/geJ+h8nnuaHaqNnu56nOzoq8ZcU9/99PAlHbZX+gFTTvjiM+7M2anx1MK9YetcFQkopPpLRNxjiaPRfHmYSAFEen00rj+8MYUTMnUI4ih57yRe1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959149; c=relaxed/simple;
	bh=3nVP/kakj1mDRq0taUq4hIFz3E9oEl6g7V0841JtQMI=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=AJpFVGid0KRS0Qo+Kp1FAjkXl3zZI9tw41scvTx7gmJMLxcb4aaFO+Eb0jBSMhbqgeLv5SggLrkikpSCbI55JY1FLpYrTnSHql1dgdNli67WTIHm1gvYMBMgZYu8x1YUxgGlasjxmh+AuFJIoKI585xnx7Vz158+5sCb4cj8SBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=S2SDCAzi; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="S2SDCAzi"
X-KPN-MessageId: a14ea19f-7ed5-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a14ea19f-7ed5-11f1-8f54-005056992ed3;
	Mon, 13 Jul 2026 18:12:22 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id a14db61c-7ed5-11f1-91b9-00505699891e;
	Mon, 13 Jul 2026 18:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=uvvy4ZDdcswg3rQnKPRfjVI+F4d66zq2fU5XaCFzDL8=;
	b=S2SDCAziLAg9r6MWME/lYJLz90ofesNJ9FnKgoBO2/CqTZYt4c5nkZAYCxhctvAJA2ZNamxuBBY+A
	 DmSk51UKtdnHH66U+J0aWGPud6BbrxOzutdTC4LaAOL4TY6E3MNKMMwcwCaOVseMNjyM9Bx1XsvWNn
	 8dawoTp8Tg1NymEB1c2Z7eYh5U9QUJML5jYSFfOa3KDjxbU60dAslnGEvMVeCs2wdO4mcaI4ndP9H2
	 tT0ua16OY/cTxVEd98XRaJoBhSV9rMhHezzZ1Uc9oVgm/8YuusghZB6zrKqSY+CWF7mz34R/SLI/14
	 39cDQH+pmq1moOR9HHRVWyVXKuEiNxQ==
X-KPN-MID: 33|+HnMd0YcGAo43cmLofG/obfA3lAPoEC9NW+TSFQUqLvyN8oiggDPo+ZoHf22YiG
 Fl4H6uCM97Ey8qxMiikQ0cA0MrAW5G0LtF+vrxJSO+Vw=
X-CMASSUN: 33|4agQlQn9Wb+VDsb/w2xyquW+nvSXN/XdwAQkvHi2aFgNCaKQ6CU4ZtHKcel4PqX
 CZknQFRghithrtUyHbbv3hw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id a1420070-7ed5-11f1-916a-005056995d6c;
	Mon, 13 Jul 2026 18:12:22 +0200 (CEST)
Date: Mon, 13 Jul 2026 18:12:22 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Message-ID: <1234615100.876439.1783959142374@kpc.webmail.kpnmail.nl>
Subject: Re: [PATCH v3 16/24] binfmt_misc: give the parse_command() results
 names
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

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
