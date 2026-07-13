Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C21F94F
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957028; cv=none; b=FltYGFY+KhWGeBVV3lfmsgjhgPju6n7+G5o6zB/LAea9EiVQA9SPWfyR/sQSPAGe+IXdn21mk6KfYbdSerfMQr0asSkEn71/+tj1vX3YP6liFPLcuJmTycn6wtTpoFI8FoKMT3oHbiGpiSNZic5W6kduSNg9yp+nG6qp4+U2BOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957028; c=relaxed/simple;
	bh=c1k+YywMytpobfBdfNt0N7ycJk+BelwnOB7+XLdola0=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=nhWR5Hbr35M0MoeuvGD/oL4J6whmH+O1bZK+larj/eHVooJkbVq34R0FmSgFTJB2vk55Pd6FZPU+tvu/KpkUNv01tE6ODxvZyRMs5QO7uQ/Yb9Rr8kFxD29H1KXoRFTbBjoVTP5Ak+oCmQls7RxiEDYdkSYhBIv9pxUkLV8xios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=M+Ztpudu; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="M+Ztpudu"
X-KPN-MessageId: b0cc2a96-7ed0-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b0cc2a96-7ed0-11f1-9e8e-005056999439;
	Mon, 13 Jul 2026 17:37:00 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id b0cb4996-7ed0-11f1-ae77-0050569981f5;
	Mon, 13 Jul 2026 17:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=z7iYbdk08/SO6ak8ENRjTJ7N4N2a+8SgdlqY3j6ZrV4=;
	b=M+ZtpuduE6/r8QXwNqzKguUwYyTermOWvtaeQ1kPbMZh6vERpYSo7NYydZV3H3KPSdxT6u3j0+N3r
	 yWgfP5FEeGqnN76GLfc1ycITxHXfpFgnnyFZgqbfTu4w9reOT0tZbG2DbIEbQpZ+j/h+YvkNVOHBkM
	 4jJSqTXkoMlEDnnI1o+sFrJAJcpfr27cvhoQwYtbF1GfZNhN1tRVc2sBk2pX094NiDPDzHSEnHTkRW
	 4Gy/n6FMEm7nTSCQu6Ox4Tamf8UoXGzGjItDQB065p59jpwp3p/W2MJX9SM7xS1l++r6BDU8CAb7YS
	 8ltTfUUNEeQUtOc5yJFryCJwAMVynsQ==
X-KPN-MID: 33|VAU8edeQisvdTLWryhcbavCgFvcRPf+Iy+hBmO2Dm4/iiDlg4KEPMQevQscaoo2
 ign2VVpIR0/spUZcdfxc7CXM7h6k6p8h7AxrV7v027Cg=
X-CMASSUN: 33|+CdYBof127RImTv93VXdqck47pUU0jXgKRI90T+wHBZXlPVsNrJAorSw3EeV7ea
 XpHwBb8zRAeVtB5ZVZYZqAQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id b0b9b5de-7ed0-11f1-8edb-00505699eff2;
	Mon, 13 Jul 2026 17:37:00 +0200 (CEST)
Date: Mon, 13 Jul 2026 17:37:00 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Message-ID: <60688943.878762.1783957020842@kpc.webmail.kpnmail.nl>
Subject: Re: [PATCH v3 13/24] binfmt_misc: factor out the entry matching
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

On Fri, Jul 10, 2026 at 11:33:14AM +0200, Christian Brauner wrote:
> search_binfmt_handler() open-codes both match types in one loop body
> with the maskless magic comparison spelled as a manual xor loop that
> is just memcmp() in disguise. Move the extension and magic checks
> into helpers so the walk reads as policy - skip disabled entries,
> match by entry type - and the maskless case actually uses memcmp().
> 
> No functional change.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 50 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 23a2020d9266..6a56f40f23ae 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -78,6 +78,29 @@ static struct file_system_type bm_fs_type;
>   */
>  #define MAX_REGISTER_LENGTH 1920
>  
> +/* Check if @e's magic matches @bprm's buffer, applying the mask if set. */
> +static bool entry_matches_magic(const struct binfmt_misc_entry *e,
> +				const struct linux_binprm *bprm)
> +{
> +	const char *s = bprm->buf + e->offset;
> +	int i;
> +
> +	if (!e->mask)
> +		return !memcmp(s, e->magic, e->size);
> +
> +	for (i = 0; i < e->size; i++)
> +		if ((s[i] ^ e->magic[i]) & e->mask[i])
> +			return false;

I guess there is no helper to do this word-based?

> +	return true;
> +}
> +
> +/* Check if @e's registered extension matches @ext, NULL if there is none. */
> +static bool entry_matches_extension(const struct binfmt_misc_entry *e,
> +				    const char *ext)
> +{
> +	return ext && !strcmp(e->magic, ext);
> +}
> +
>  /**
>   * search_binfmt_handler - search for a binary handler for @bprm
>   * @misc: handle to binfmt_misc instance
> @@ -93,38 +116,23 @@ static struct file_system_type bm_fs_type;
>  static struct binfmt_misc_entry *
>  search_binfmt_handler(struct binfmt_misc *misc, struct linux_binprm *bprm)
>  {
> -	char *p = strrchr(bprm->interp, '.');
> +	char *dot = strrchr(bprm->interp, '.');
> +	const char *ext = dot ? dot + 1 : NULL;
>  	struct binfmt_misc_entry *e;
>  
>  	/* Walk all the registered handlers. */
>  	hlist_for_each_entry_rcu(e, &misc->entries, node) {
> -		char *s;
> -		int j;
> -
>  		/* Make sure this one is currently enabled. */
>  		if (!test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
>  			continue;
>  
> -		/* Do matching based on extension if applicable. */
> -		if (!test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
> -			if (p && !strcmp(e->magic, p + 1))
> +		if (test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
> +			if (entry_matches_magic(e, bprm))
>  				return e;
> -			continue;
> -		}
> -
> -		/* Do matching based on magic & mask. */
> -		s = bprm->buf + e->offset;
> -		if (e->mask) {
> -			for (j = 0; j < e->size; j++)
> -				if ((*s++ ^ e->magic[j]) & e->mask[j])
> -					break;
>  		} else {
> -			for (j = 0; j < e->size; j++)
> -				if ((*s++ ^ e->magic[j]))
> -					break;
> +			if (entry_matches_extension(e, ext))
> +				return e;

Why not use else if here?

>  		}
> -		if (j == e->size)
> -			return e;
>  	}
>  
>  	return NULL;
> 
> -- 
> 2.53.0
> 

Nice clean-up.

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
