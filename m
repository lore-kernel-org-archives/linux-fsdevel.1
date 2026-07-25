Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A012C11E4
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784999127; cv=none; b=qMpGbrcONFjOeOz+rFN3t6DbkDEuS8SCS+dTNdpSnc99soa4JoLk0jB8FO05C12gbOEfiu4LW3VBdCOhXOB/ADmyjiSMm9UKRcaLGBoSh+YcX+9WcE4MIQ3Gotyt9AZQF+313Mc5LTbZ7b7kxF3Q1n009736nZbUZEZGXES6gZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784999127; c=relaxed/simple;
	bh=iFy8aQxr8xfoG5vZX07n3hAKimrwZKRHKPFmvKdVjQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW1ZvNDIO4OTeX05LxkWrP2nxJROqevjfHUFXq4OR/GWQGrAyz5E01CcTkbvETQsIrMn9a11JFG5V8q1ED0q3c3V4rIVLr+HRqCyHrLFQDNDOvPOHljDJmHBwmoFJyyCz66aMBGzxIna90VTlyi23QhheS7b8utE04XLQydYFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=oU9qHniG; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="oU9qHniG"
X-KPN-MessageId: 03e2031c-884b-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 03e2031c-884b-11f1-a055-005056abad63;
	Sat, 25 Jul 2026 19:05:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=B6XPxv+MxSq1+WYAvq4MMYLo5D20W7j9Wvxo+BzxqVU=;
	b=oU9qHniGqYr/FL/6eUsu5gUo86zClJLCryBw0J7uwiIF9RkiVnbXHHnLhXp3pWXe0lwY/2h81AEj6
	 4odkWtPsKhxy1H56c4daDew+8RdhXJMI1/O+qKfybp0c2Mw/7DPrIsP9oIfR+ACHfwuvFE1zvaOWyl
	 lJ9xKIVtc4l5p6DytvFVJKYueCEE0UocY29wH6QliSL1MInUtDg1eDIOLaInBKu6zECedKFa75TReW
	 eztARNTJ59asrUlTkPl/PuL38PURON+WG9rZ0s2RJa2O0xNjvoJFHGvNdXf4zW+huixYNdlW1m3USZ
	 dpT1Ms78IxbkZQ4w2VLYiyYWlSAiJYg==
X-KPN-MID: 33|LAz/NOKuBCOKZ82d6IZV5VkY00Chl/LC8fT5yLiPjEMQ4H+RcAvlhZ5MFwumLhh
 J270cCbdobMY5I+/SBhCb+qR/2pkfO6zqwB16vvT9evc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|BEkd1q7v49v3m2XpgZ6uB15o7u2OD0oa6yOfjxWSNjDdsDyKE2ZPJnvg4R8nmbz
 fRJ5P/joExEGbZaUOQRsm2A==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 03afb612-884b-11f1-86b1-005056ab7584;
	Sat, 25 Jul 2026 19:05:19 +0200 (CEST)
Date: Sat, 25 Jul 2026 19:05:13 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 20/24] binfmt_misc: split the field parsing out of
 create_entry()
Message-ID: <amTrFbHSNq0lb3Jo@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-20-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-20-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:21AM +0200, Christian Brauner wrote:
> create_entry() is a two hundred line parser with the M and E field
> handling inlined as the two arms of its largest branch. Move them
> into parse_magic_fields() and parse_extension_fields() which return
> the new parse position or NULL so create_entry() itself reads like
> the register string grammar again.
> 
> The offset parsing loses a provably dead check on the way: after
> *s = '\0' and p = s the subsequent if (*p++) always reads the just
> written NUL byte and can never fail, it only obscured that the code
> simply advances past the delimiter.
> 
> With the field parsing gone every remaining failure unwinds the same
> way,

I see no causal connection here. I think you can separate the extraction
from the move to __free. That would be a bit neater.

> so hand the entry to __free(kfree), return errors directly and
> pass ownership out via no_free_ptr() on success instead of routing
> every exit through goto tails.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 225 ++++++++++++++++++++++++++-----------------------------
>  1 file changed, 108 insertions(+), 117 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 4cfd3ce5e47e..a9e1e0bbcc60 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -340,6 +340,95 @@ static char *check_special_flags(char *p, struct binfmt_misc_entry *e)
>  	}
>  }
>  
> +/* Parse the 'offset', 'magic' and 'mask' fields of an 'M' entry. */
> +static char *parse_magic_fields(struct binfmt_misc_entry *e, char *p, char del)
> +{
> +	char *s;
> +
> +	/* Parse the 'offset' field. */
> +	s = strchr(p, del);
> +	if (!s)
> +		return NULL;
> +	*s = '\0';
> +	if (p != s) {
> +		if (kstrtoint(p, 10, &e->offset) || e->offset < 0)
> +			return NULL;
> +	}
> +	p = s + 1;
> +	pr_debug("register: offset: %#x\n", e->offset);
> +
> +	/* Parse the 'magic' field. */
> +	e->magic = p;
> +	p = scanarg(p, del);
> +	if (!p || !e->magic[0])
> +		return NULL;
> +	print_hex_dump_debug(
> +		KBUILD_MODNAME ": register: magic[raw]: ",
> +		DUMP_PREFIX_NONE, 16, 1, e->magic, p - e->magic, true);
> +
> +	/* Parse the 'mask' field. */
> +	e->mask = p;
> +	p = scanarg(p, del);
> +	if (!p)
> +		return NULL;
> +	if (!e->mask[0]) {
> +		e->mask = NULL;
> +		pr_debug("register:  mask[raw]: none\n");
> +	} else {
> +		print_hex_dump_debug(
> +			KBUILD_MODNAME ": register:  mask[raw]: ",
> +			DUMP_PREFIX_NONE, 16, 1, e->mask, p - e->mask, true);
> +	}
> +
> +	/*
> +	 * Decode the magic & mask fields. Note: while we might have accepted
> +	 * embedded NUL bytes from above, the unescape helpers will stop at
> +	 * the first one they encounter.
> +	 */
> +	e->size = string_unescape_inplace(e->magic, UNESCAPE_HEX);
> +	if (e->mask && string_unescape_inplace(e->mask, UNESCAPE_HEX) != e->size)
> +		return NULL;
> +	if (e->size > BINPRM_BUF_SIZE || BINPRM_BUF_SIZE - e->size < e->offset)
> +		return NULL;
> +	pr_debug("register: magic/mask length: %i\n", e->size);
> +	print_hex_dump_debug(
> +		KBUILD_MODNAME ": register: magic[decoded]: ",
> +		DUMP_PREFIX_NONE, 16, 1, e->magic, e->size, true);
> +	if (e->mask)
> +		print_hex_dump_debug(
> +			KBUILD_MODNAME ": register:  mask[decoded]: ",
> +			DUMP_PREFIX_NONE, 16, 1, e->mask, e->size, true);
> +	return p;
> +}
> +
> +/* Parse the 'magic' field of an 'E' entry: the filename extension. */
> +static char *parse_extension_fields(struct binfmt_misc_entry *e, char *p,
> +				    char del)
> +{
> +	/* Skip the 'offset' field. */
> +	p = strchr(p, del);
> +	if (!p)
> +		return NULL;
> +	*p++ = '\0';
> +
> +	/* Parse the 'magic' field. */
> +	e->magic = p;
> +	p = strchr(p, del);
> +	if (!p)
> +		return NULL;
> +	*p++ = '\0';
> +	if (!e->magic[0] || strchr(e->magic, '/'))
> +		return NULL;
> +	pr_debug("register: extension: {%s}\n", e->magic);
> +
> +	/* Skip the 'mask' field. */
> +	p = strchr(p, del);
> +	if (!p)
> +		return NULL;
> +	*p++ = '\0';
> +	return p;
> +}
> +
>  /*
>   * This registers a new binary format, it recognises the syntax
>   * ':name:type:offset:magic:mask:interpreter:flags'
> @@ -348,29 +437,26 @@ static char *check_special_flags(char *p, struct binfmt_misc_entry *e)
>  static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  					      size_t count)
>  {
> -	struct binfmt_misc_entry *e;
> +	struct binfmt_misc_entry *e __free(kfree) = NULL;
>  	char *buf, *p;
>  	char del;
> -	int err;
>  
>  	pr_debug("register: received %zu bytes\n", count);
>  
>  	/* some sanity checks */
> -	err = -EINVAL;
>  	if ((count < 11) || (count > MAX_REGISTER_LENGTH))
> -		goto out;
> +		return ERR_PTR(-EINVAL);
>  
> -	err = -ENOMEM;
>  	e = kmalloc(struct_size(e, buf, count + MISC_DELIM_PAD),
>  		    GFP_KERNEL_ACCOUNT);
>  	if (!e)
> -		goto out;
> +		return ERR_PTR(-ENOMEM);
>  
>  	p = buf = e->buf;
>  
>  	memset(e, 0, sizeof(*e));
>  	if (copy_from_user(buf, buffer, count))
> -		goto efault;
> +		return ERR_PTR(-EFAULT);
>  
>  	del = *p++;	/* delimeter */
>  
> @@ -378,7 +464,7 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  
>  	/* A flag-char delimiter runs the flag scan off the buffer. */
>  	if (del == 'P' || del == 'O' || del == 'C' || del == 'F')
> -		goto einval;
> +		return ERR_PTR(-EINVAL);
>  
>  	/* Pad the buffer with the delim to simplify parsing below. */
>  	memset(buf + count, del, MISC_DELIM_PAD);
> @@ -387,13 +473,13 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  	e->name = p;
>  	p = strchr(p, del);
>  	if (!p)
> -		goto einval;
> +		return ERR_PTR(-EINVAL);
>  	*p++ = '\0';
>  	if (!e->name[0] ||
>  	    !strcmp(e->name, ".") ||
>  	    !strcmp(e->name, "..") ||
>  	    strchr(e->name, '/'))
> -		goto einval;
> +		return ERR_PTR(-EINVAL);
>  
>  	pr_debug("register: name: {%s}\n", e->name);
>  
> @@ -408,111 +494,26 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  		e->flags = BIT(MISC_FMT_ENABLED_BIT) | BIT(MISC_FMT_MAGIC_BIT);
>  		break;
>  	default:
> -		goto einval;
> +		return ERR_PTR(-EINVAL);
>  	}
>  	if (*p++ != del)
> -		goto einval;
> -
> -	if (test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
> -		/* Handle the 'M' (magic) format. */
> -		char *s;
> -
> -		/* Parse the 'offset' field. */
> -		s = strchr(p, del);
> -		if (!s)
> -			goto einval;
> -		*s = '\0';
> -		if (p != s) {
> -			int r = kstrtoint(p, 10, &e->offset);
> -			if (r != 0 || e->offset < 0)
> -				goto einval;
> -		}
> -		p = s;
> -		if (*p++)
> -			goto einval;
> -		pr_debug("register: offset: %#x\n", e->offset);
> -
> -		/* Parse the 'magic' field. */
> -		e->magic = p;
> -		p = scanarg(p, del);
> -		if (!p)
> -			goto einval;
> -		if (!e->magic[0])
> -			goto einval;
> -		print_hex_dump_debug(
> -			KBUILD_MODNAME ": register: magic[raw]: ",
> -			DUMP_PREFIX_NONE, 16, 1, e->magic, p - e->magic, true);
> -
> -		/* Parse the 'mask' field. */
> -		e->mask = p;
> -		p = scanarg(p, del);
> -		if (!p)
> -			goto einval;
> -		if (!e->mask[0]) {
> -			e->mask = NULL;
> -			pr_debug("register:  mask[raw]: none\n");
> -		} else {
> -			print_hex_dump_debug(
> -				KBUILD_MODNAME ": register:  mask[raw]: ",
> -				DUMP_PREFIX_NONE, 16, 1, e->mask, p - e->mask,
> -				true);
> -		}
> +		return ERR_PTR(-EINVAL);
>  
> -		/*
> -		 * Decode the magic & mask fields.
> -		 * Note: while we might have accepted embedded NUL bytes from
> -		 * above, the unescape helpers here will stop at the first one
> -		 * it encounters.
> -		 */
> -		e->size = string_unescape_inplace(e->magic, UNESCAPE_HEX);
> -		if (e->mask &&
> -		    string_unescape_inplace(e->mask, UNESCAPE_HEX) != e->size)
> -			goto einval;
> -		if (e->size > BINPRM_BUF_SIZE ||
> -		    BINPRM_BUF_SIZE - e->size < e->offset)
> -			goto einval;
> -		pr_debug("register: magic/mask length: %i\n", e->size);
> -		print_hex_dump_debug(
> -			KBUILD_MODNAME ": register: magic[decoded]: ",
> -			DUMP_PREFIX_NONE, 16, 1, e->magic, e->size, true);
> -		if (e->mask)
> -			print_hex_dump_debug(
> -				KBUILD_MODNAME ": register:  mask[decoded]: ",
> -				DUMP_PREFIX_NONE, 16, 1, e->mask, e->size, true);
> -	} else {
> -		/* Handle the 'E' (extension) format. */
> -
> -		/* Skip the 'offset' field. */
> -		p = strchr(p, del);
> -		if (!p)
> -			goto einval;
> -		*p++ = '\0';
> -
> -		/* Parse the 'magic' field. */
> -		e->magic = p;
> -		p = strchr(p, del);
> -		if (!p)
> -			goto einval;
> -		*p++ = '\0';
> -		if (!e->magic[0] || strchr(e->magic, '/'))
> -			goto einval;
> -		pr_debug("register: extension: {%s}\n", e->magic);
> -
> -		/* Skip the 'mask' field. */
> -		p = strchr(p, del);
> -		if (!p)
> -			goto einval;
> -		*p++ = '\0';
> -	}
> +	if (test_bit(MISC_FMT_MAGIC_BIT, &e->flags))
> +		p = parse_magic_fields(e, p, del);
> +	else
> +		p = parse_extension_fields(e, p, del);
> +	if (!p)
> +		return ERR_PTR(-EINVAL);
>  
>  	/* Parse the 'interpreter' field. */
>  	e->interpreter = p;
>  	p = strchr(p, del);
>  	if (!p)
> -		goto einval;
> +		return ERR_PTR(-EINVAL);
>  	*p++ = '\0';
>  	if (!e->interpreter[0])
> -		goto einval;
> +		return ERR_PTR(-EINVAL);
>  	pr_debug("register: interpreter: {%s}\n", e->interpreter);
>  
>  	/* Parse the 'flags' field. */
> @@ -520,19 +521,9 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  	if (*p == '\n')
>  		p++;
>  	if (p != buf + count)
> -		goto einval;
> -
> -	return e;
> -
> -out:
> -	return ERR_PTR(err);
> +		return ERR_PTR(-EINVAL);
>  
> -efault:
> -	kfree(e);
> -	return ERR_PTR(-EFAULT);
> -einval:
> -	kfree(e);
> -	return ERR_PTR(-EINVAL);
> +	return no_free_ptr(e);
>  }
>  
>  /* Commands accepted by the /status and /<entry> files. */
> 
> -- 
> 2.53.0
> 
