Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F1036897C
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994472; cv=none; b=RtuMFifH6/rqvAHWreg4lFhTCrxPZl4igbqYtpQfeH0DIhe+ExYD0kUJUIYOR3IIKtkJBNRmcFQPu/nj+c/fL1Lu4TOKGjHJM3Mjp4Dh+jjDeP13jlC/XFzkBkMsHagSjfEnaKDjlxPM1mzntGLatCi6/HIJ7Kw4xOwRDszbN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994472; c=relaxed/simple;
	bh=NwVlMGGG/PnEpIUx5J4HFsUGVWrCrTeHnOyZwzBV1/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b91OCWLGihBnj62nyCgGmrG5SiVEg6snOYO7F1s+U+/3PF1A5IVMtaHclM+vNOMLTUL8cDh1egGoB+HdngL37vqiDm6LFK0JTXdcooKuxzGXK3exZ8D8bdIAPbSm4VLuq5xWNuzUuK9Ew+4VAnHJhFH/lXUJ2EVJVarYqoSKF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=mJpQKmFZ; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="mJpQKmFZ"
X-KPN-MessageId: 26a289c7-8840-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 26a289c7-8840-11f1-bfba-00505699b430;
	Sat, 25 Jul 2026 17:47:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=i4ydykD6V+3+U4iaRPvJmsbyjlTfOIKGt9umZ72t3cQ=;
	b=mJpQKmFZAMRKbLAqTfaDawchrajSvnu6WshknpPbJx3u9g8W6pUWc5ZCMIXtgsynH5lgv+thT4YlM
	 01b5FO1itECWvqQDuT3BxZKd1NxZMeruy/vI7bHXERWqzM9dtykNH8BCf2TTenanKMm9gl/qppkqZb
	 n40aE4hyAaPERWFfl1j3BbhXPiLC5/Ei0tolhlzQyUKry70C06A2MziTkZTf/L+fi+VOJP6FwhrQ7S
	 oqYqCoEFMbNokqN0f/lU7eywNHhbp0Z8l1sYmyF4K3NUGjFs4ldUYE/R5ZL9YezDo1YbTLwhzlQWy+
	 /ApopiHYmO5T5w8fp2sght1epDhu0tA==
X-KPN-MID: 33|tCBIjNA60F/5wc+E0+19sYESqAheNmiYOAAIOBuKehyf/z+1W+snzwYjalhfEyq
 LjGhY4A72LU2yK49ee7z4MDMzbYUxkmot2cQXU1BhZtE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3H7GIxBg0dGGV3/VDwgCdP5MA4WVS/TjBwGOALBiyI3OiBf4Q+PGPe5bNJ0EEMI
 rLOfo8lFQCDII1ogOFEgvFg==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 26687a12-8840-11f1-8dd2-00505699d6e5;
	Sat, 25 Jul 2026 17:47:33 +0200 (CEST)
Date: Sat, 25 Jul 2026 17:47:31 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 13/24] binfmt_misc: factor out the entry matching
Message-ID: <amTZesOS4C5kwrIe@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-13-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-13-a162f7cb58d6@kernel.org>

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

Replace with 

	} else if (entry_matches_extension(e, ext)) {

> -			for (j = 0; j < e->size; j++)
> -				if ((*s++ ^ e->magic[j]))
> -					break;
> +			if (entry_matches_extension(e, ext))



> +				return e;
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
