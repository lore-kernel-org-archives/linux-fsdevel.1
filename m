Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DBF3F4830
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785000518; cv=none; b=OiNCMdWUdoTc1SQeilivQYnGUizQhxBymf+/5IJH0IiROoHq4UAkLxJXCvsy0yO6kHyc8xvuGulZv950yVYBGVVgdqusAzss+KKM+3L2WrszKFXJPNmP0SeFXr6bf0DsT4/xaAXuw9MdYhB3ZTOO2dXO8FkaWSTnybn5gslbPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785000518; c=relaxed/simple;
	bh=35dn/Gk3TmrBtLSdsw78YRdBRcPfS+8NMJ2nlfuPVkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7IEjFMnCuffw7HRRzVJROkw3UiybisgejD/6fAdRh/K7IODjFDX1hYc0cilsF8mjRqaCaP311jq1imHPrASzYrrT/rwTtbhjd5SWP5JwTiE4Ti9eeAXdPYCNP7sM2jcBAFd7f7DrOQLzQzaL/rO+6W1VRGPbOdRQJrTrZHampc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=HSoLBd5w; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="HSoLBd5w"
X-KPN-MessageId: 41d56262-884e-11f1-a5a1-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 41d56262-884e-11f1-a5a1-005056994fde;
	Sat, 25 Jul 2026 19:28:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=yoMkvhdAZpLwPCCHt7VVbhOPhYfVa+HdCEjj+o5rgYk=;
	b=HSoLBd5wHvvfY17nczUCTkVsPf7ysOimW7kcD0E0JAk4QNiUXyy8t3N9+H5S/3XspEBDNHLUpcA9Q
	 e/kbNXa0eWYiZlVHMS90OONDlCvsnBZGfkTsp+obSiYrsCyltPE3O6w3THYilueCYYOpmF6wl1GlZ/
	 ng6Gpsh4r5k9ZENHwP2H3whOXXk5nSNHY5YO7m9XIiDUs3hMThFrGf7s8fwGDhoDfvc+qjxO5GHahv
	 lqvo2hFQjdhqwjBTdKukS8r5FhXRRW4mc73a3D1mTXYnIk1JO56JnoDq9EJSrxoj17BttyJaUGA3da
	 JElWQ0LApsCOREwugm2asWvZtc0befg==
X-KPN-MID: 33|t4CpmFuAn3wB14rtQJXp3FG64DY3bypVFK3Iwqb6NOyGTC6fPIB3uXq5v3sX03s
 sslBUEeQLUzSF3SVgM3xXJxAJ1/W8SkTBUUW8rZ9WWp0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|9/bzuXATuzEs4UcloPPcQr9B5NkItDr1CPUHQUZlLCVIxubJxBrTSewAId96BAJ
 YZHsrNhJTKuzpFY2VaddeyQ==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 41a1d055-884e-11f1-a789-00505699772e;
	Sat, 25 Jul 2026 19:28:31 +0200 (CEST)
Date: Sat, 25 Jul 2026 19:28:26 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 21/24] binfmt_misc: use __free(kfree) in
 bm_register_write()
Message-ID: <amTxz8293ky9ncO1@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-21-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-21-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:22AM +0200, Christian Brauner wrote:
> bm_register_write() has to free the entry it got from create_entry()
> on every failure until add_entry() has linked it into the filesystem
> and made the inode its owner. Arm the entry with __free(kfree) so the
> error branches can simply return and disarm it via
> retain_and_null_ptr() once ownership has been handed to the inode.
> The interpreter file keeps its manual error cleanup as freeing the
> entry would not close it.
> 
> No functional change.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index a9e1e0bbcc60..eb56aa6a3ca2 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -800,13 +800,12 @@ static int add_entry(struct binfmt_misc_entry *e, struct super_block *sb)
>  static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>  			       size_t count, loff_t *ppos)
>  {
> -	struct binfmt_misc_entry *e;
> +	struct binfmt_misc_entry *e __free(kfree) = NULL;

The cleanup.h guidlines say to write

	struct binfmt_misc_entry *e __free(kfree) = create_entry(buffer, count);

Either way, I am not too fuzzed.

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

>  	struct super_block *sb = file_inode(file)->i_sb;
> -	int err = 0;
>  	struct file *f = NULL;
> +	int err;
>  
>  	e = create_entry(buffer, count);
> -
>  	if (IS_ERR(e))
>  		return PTR_ERR(e);
>  
> @@ -823,7 +822,6 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>  		if (IS_ERR(f)) {
>  			pr_notice("register: failed to install interpreter file %s\n",
>  				 e->interpreter);
> -			kfree(e);
>  			return PTR_ERR(f);
>  		}
>  		e->interp_file = f;
> @@ -835,9 +833,11 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>  			exe_file_allow_write_access(f);
>  			filp_close(f, NULL);
>  		}
> -		kfree(e);
>  		return err;
>  	}
> +
> +	/* The entry is owned by its inode now. */
> +	retain_and_null_ptr(e);
>  	return count;
>  }
>  
> 
> -- 
> 2.53.0
> 
