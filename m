Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AD2FD7D3
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784997007; cv=none; b=AZAcCqvZgdWspGNf5rIeF7hQ+0HNSPl8rL2tnVYHfvQSH8CQ+Nzgi6QWBotHZDiaBiQvjmoLrFyOcSB0OyLT/SQZXrfJU1AWrSgUOrILeYP9YZrbw2berFNUhWFYZyS41MiVAiz1Hg4ZwIHVtwdoWzbV1+g45nVNEx0mCZOtA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784997007; c=relaxed/simple;
	bh=UDwWcxyK8x45WLTbyF3JgkGaSUIbCGSzQ+cb8ev+zyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aiegsr0ONhRy8dl8UR+JexofeoUHKEhuaRafbH83qut6eU9HDuOYhyM6IqU/hMt5TBqOjvzaLW7AE0+YGUYQ9lKOyUsnaI+/ROFHCq9vscpk2y3H1xbVDY9xZY+hXSVwXn1ckef0WwCZ3UU5PU3ljZoF8Dsk4CkLRXHRisky9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ldVHvzU3; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ldVHvzU3"
X-KPN-MessageId: 13459b61-8846-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 13459b61-8846-11f1-9e8e-005056999439;
	Sat, 25 Jul 2026 18:29:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=9NOBUv49T7ToX/K4H4kKJPsi+EKjIl7Ooc3WRNcdlZM=;
	b=ldVHvzU3DXavEc2TreKqR8kVf5AVNuwEojW2WOFht0LxX1+BthGysSlVCBGMe1RMEjpmqTIoM7Cmy
	 dVSRJPLufhvAdduqe704J/kglRVRWTvQHkK4FSrY1qHa8J+B7sVvGz5OSfDDlbD7GMQURU+nH3eJt/
	 jz/9yLbFNkLMhxuRzoe5eKfPxUHf90EI7u9b89o33b2gbdGZjKgbRX2FxwgIv6lRmpZK9loXFSeuDq
	 9v/kRS6xwrf5XcFfoM+PnPs2bJE2+58DPDBc+1pwONHaECblieXiA6NmR97Qdv9nWhE2306AoqnM4t
	 7H0ji1N30+bx+SgFd3X2fUvqthYMMSw==
X-KPN-MID: 33|CBRkVaaFRB9b3xzdQF5ESsZIRaX8E/Efedu2g3wzDlrEYL54Uo0IaGUfv2DQrpM
 eKzeqkkrdIiNKGO0sLm08m00wfqKoDFJ/trcK1sEdaa4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|53lsszmG0L4fuDZW6ajWlyv7INCwvFMlLH17wQmkZGInxrTobbciV6WGiwSsUAa
 lbV244g63yzd+/vWi0is3JQ==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1304f40e-8846-11f1-87f8-00505699b758;
	Sat, 25 Jul 2026 18:29:57 +0200 (CEST)
Date: Sat, 25 Jul 2026 18:29:52 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 19/24] binfmt_misc: use a flexible array member for
 the register string
Message-ID: <amTkcITPlXlFk7VK@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-19-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-19-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:20AM +0200, Christian Brauner wrote:
> create_entry() allocates the entry and the register string it parses
> into in one chunk and finds the string part again through manual
> pointer arithmetic behind a cast. Make the layout explicit with a
> flexible array member and struct_size(), and give the magic pad of
> trailing delimiters a name while at it.
> 
> No functional change.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index d9dc9546d199..4cfd3ce5e47e 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -59,6 +59,7 @@ struct binfmt_misc_entry {
>  	struct file *interp_file;
>  	refcount_t users;		/* sync removal with load_misc_binary() */
>  	struct rcu_head rcu;
> +	char buf[];			/* register string, fields point in here */
>  };
>  
>  static struct file_system_type bm_fs_type;
> @@ -78,6 +79,9 @@ static struct file_system_type bm_fs_type;
>   */
>  #define MAX_REGISTER_LENGTH 1920
>  
> +/* Trailing delimiter pad so field parsing always terminates at a delimiter. */
> +#define MISC_DELIM_PAD 8
> +
>  /* Check if @e's magic matches @bprm's buffer, applying the mask if set. */
>  static bool entry_matches_magic(const struct binfmt_misc_entry *e,
>  				const struct linux_binprm *bprm)
> @@ -345,9 +349,9 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  					      size_t count)
>  {
>  	struct binfmt_misc_entry *e;
> -	int memsize, err;
>  	char *buf, *p;
>  	char del;
> +	int err;
>  
>  	pr_debug("register: received %zu bytes\n", count);
>  
> @@ -357,12 +361,12 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  		goto out;
>  
>  	err = -ENOMEM;
> -	memsize = sizeof(*e) + count + 8;
> -	e = kmalloc(memsize, GFP_KERNEL_ACCOUNT);
> +	e = kmalloc(struct_size(e, buf, count + MISC_DELIM_PAD),
> +		    GFP_KERNEL_ACCOUNT);
>  	if (!e)
>  		goto out;
>  
> -	p = buf = (char *)e + sizeof(*e);
> +	p = buf = e->buf;
>  
>  	memset(e, 0, sizeof(*e));
>  	if (copy_from_user(buf, buffer, count))
> @@ -377,7 +381,7 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  		goto einval;
>  
>  	/* Pad the buffer with the delim to simplify parsing below. */
> -	memset(buf + count, del, 8);
> +	memset(buf + count, del, MISC_DELIM_PAD);
>  
>  	/* Parse the 'name' field. */
>  	e->name = p;
> 
> -- 
> 2.53.0
> 

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
