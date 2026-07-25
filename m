Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D961F942
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784996095; cv=none; b=jZ5GEsUE6EhkVipaJO6glwUVKIuxeEvEDBA+BP6qP6jJjsmMXVI2E6F2ZtDpnqsPaM+0A1VuK7JzkIVV/Zx5cb/SLNJ/nB9JRUm90Zg97TTyZwGFokVFJiPBPfU94oPjrUmj6QOlY7RoUQ+ZD5NnPi4h56N1TgpEpwtXyKhVdRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784996095; c=relaxed/simple;
	bh=mGCM6bTyaBVforz8e4UYVbAHNJk071m2ivRQ12Tvkag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLNZYz96Z0mUAMdEUlfTKOU55OU1oFqEctiwNhBM2ylWq55aePtI39aw4q+soT26I5dSSSlVox/TEmU4L6S89d9n1VBb4D+Ur9HKqbRejKtoFR0OFKvoRyb1dAuYI8bOdDzJjMTl7NtIVz9JqdGKV5IFIQ2EdfvIZ3poHpRxwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=b4FfEhmK; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="b4FfEhmK"
X-KPN-MessageId: f6882f08-8843-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f6882f08-8843-11f1-b2a8-005056abbe64;
	Sat, 25 Jul 2026 18:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=tHPJsB50xQmYK+ehVil/6FrHa+/zw3dN6HSI8VBDdlw=;
	b=b4FfEhmKXiIWNhve1ZZ8oM/2Z5iP3puVFwu8+zlVmqA/6eGMfwFqDJmQ9tfbCV8R9gSWaWl2gy3dI
	 4ST91thz3oG/7vbq5+30pggB63VRBN9W1FAEeZiVrrgScL5xVdu3daxdTWVHTU3e7LNCILGkxDbcsy
	 ZY470K7DmJI/3pWgFNas7y9M7qV2upYj/OTYGom+FMNzFyf9qASQ4smngrEdpxRiW1V4haYEzlHZ7w
	 JzCAqMagwoLWLv+YoJUzt6hQxtY9oKT/ZOWC47zzAenLa+gOpS3S89ZVYUWhEZHLY9XjTVJXJF9wak
	 wnPlZZpEtoElG6STGL7RrnzUH4lKK/A==
X-KPN-MID: 33|aZQz5wymlE1uLEnDHEJOnBG5lJJr2DnWat8jZk+/ibToRq9QDJOCtkIo3tWYSuT
 8AFflJn+IRBy1ho9dunTh0Yoo5i+idW1zCmDUIN/unTs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|cseRJcjgKnl0i3Nynao5hE0x7To2akzhbTunPGtN5kDjFKLLf7ezQPeYz31ELDW
 RRb6CRb5fttajPyern3h1tw==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f655308f-8843-11f1-9226-005056ab1411;
	Sat, 25 Jul 2026 18:14:50 +0200 (CEST)
Date: Sat, 25 Jul 2026 18:14:38 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 07/24] binfmt_misc: turn the entry bit numbers into a
 proper enum
Message-ID: <amTelCErRS0gVXvR@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-7-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-7-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:08AM +0200, Christian Brauner wrote:
> Enabled and Magic are bit numbers in the flags word of an entry but
> are declared as bare, unprefixed enumerators with implicit values in
> a style that predates the git history. Give the enum a name, explicit
> bit numbers and namespaced names and use BIT() instead of open-coding
> the shifts when building the initial flags word in create_entry().
> 
> No functional change.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 0b9758da1f88..90962044d19e 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -42,7 +42,11 @@ enum {
>  	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
>  };
>  
> -enum {Enabled, Magic};
> +/* Entry status and match type bit numbers. */
> +enum binfmt_misc_entry_bits {
> +	MISC_FMT_ENABLED_BIT	= 0,
> +	MISC_FMT_MAGIC_BIT	= 1,
> +};
>  #define MISC_FMT_PRESERVE_ARGV0 (1UL << 31)
>  #define MISC_FMT_OPEN_BINARY (1UL << 30)
>  #define MISC_FMT_CREDENTIALS (1UL << 29)
> @@ -104,11 +108,11 @@ static Node *search_binfmt_handler(struct binfmt_misc *misc,
>  		int j;
>  
>  		/* Make sure this one is currently enabled. */
> -		if (!test_bit(Enabled, &e->flags))
> +		if (!test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
>  			continue;
>  
>  		/* Do matching based on extension if applicable. */
> -		if (!test_bit(Magic, &e->flags)) {
> +		if (!test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
>  			if (p && !strcmp(e->magic, p + 1))
>  				return e;
>  			continue;
> @@ -417,11 +421,11 @@ static Node *create_entry(const char __user *buffer, size_t count)
>  	switch (*p++) {
>  	case 'E':
>  		pr_debug("register: type: E (extension)\n");
> -		e->flags = 1 << Enabled;
> +		e->flags = BIT(MISC_FMT_ENABLED_BIT);
>  		break;
>  	case 'M':
>  		pr_debug("register: type: M (magic)\n");
> -		e->flags = (1 << Enabled) | (1 << Magic);
> +		e->flags = BIT(MISC_FMT_ENABLED_BIT) | BIT(MISC_FMT_MAGIC_BIT);
>  		break;
>  	default:
>  		goto einval;
> @@ -429,7 +433,7 @@ static Node *create_entry(const char __user *buffer, size_t count)
>  	if (*p++ != del)
>  		goto einval;
>  
> -	if (test_bit(Magic, &e->flags)) {
> +	if (test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
>  		/* Handle the 'M' (magic) format. */
>  		char *s;
>  
> @@ -599,7 +603,7 @@ static void entry_status(Node *e, char *page)
>  	char *dp = page;
>  	const char *status = "disabled";
>  
> -	if (test_bit(Enabled, &e->flags))
> +	if (test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
>  		status = "enabled";
>  
>  	if (!VERBOSE_STATUS) {
> @@ -621,7 +625,7 @@ static void entry_status(Node *e, char *page)
>  		*dp++ = 'F';
>  	*dp++ = '\n';
>  
> -	if (!test_bit(Magic, &e->flags)) {
> +	if (!test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
>  		sprintf(dp, "extension .%s\n", e->magic);
>  	} else {
>  		dp += sprintf(dp, "offset %i\nmagic ", e->offset);
> @@ -745,11 +749,11 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  	switch (res) {
>  	case 1:
>  		/* Disable this handler. */
> -		clear_bit(Enabled, &e->flags);
> +		clear_bit(MISC_FMT_ENABLED_BIT, &e->flags);
>  		break;
>  	case 2:
>  		/* Enable this handler. */
> -		set_bit(Enabled, &e->flags);
> +		set_bit(MISC_FMT_ENABLED_BIT, &e->flags);
>  		break;
>  	case 3:
>  		/* Delete this handler. */
> 
> -- 
> 2.53.0
> 

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
