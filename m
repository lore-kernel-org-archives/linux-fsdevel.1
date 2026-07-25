Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1E38AC8B
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995005; cv=none; b=PLrQHsQWK0fx5xunYt1EvPNFd1w9HjC+TRWDjlh7qJqbfJhb31gwoxLUgqG3nNnqxwJrWuMXqIzGM2uUI2iHIfKyiMzFoOi0RcdU1LLhyXvVoy7D93pJqpvll3Jw//hkj9XTRr5XgHysugauXVW6Qk5EkENn6A1EuXWUmDn1ZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995005; c=relaxed/simple;
	bh=6E/JeQcmJrHZS82w8KSCAscj8JzkgrBvcEcexMMUtNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oguxPP+kcKZZ6AtsCfGncHvVDwGBEjc1Lv7CtmmN56Om5q9zVpCOb6t9qWUgjWGmIqA8T3V7zMkP4tSFzh3GWFNkGrjjU8iUngQH0Raj3pSKOaFf4eqeqX0DkPEHsdCC2MWlS3Ne24YQjDPmbaoTP1mAz5RF3svlr5stT5uwhwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=R8TUIcXK; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="R8TUIcXK"
X-KPN-MessageId: 6bfc4e3a-8841-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6bfc4e3a-8841-11f1-a055-005056abad63;
	Sat, 25 Jul 2026 17:56:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=b8lliPLK0GDS8x8PyMcUI12+gAGgg8IMSmccabc8c1I=;
	b=R8TUIcXKO9XNZFGDPs3wAOw5ktWrA40SLcZsbsRW8mQPXfnu2TNxOQJ4ZEJ0DrUp2bnxWtG4ydYqT
	 peRhLPLp05vZ3p9MVH0Nj73JRqGAnm/3vUAKT9CwQserd7MA6yZmrwsk0hnAnpfELM9cqnJQXoCbI1
	 Y2BXmrXGQBqVDldrz69/eU909+DHPeYVyJ8YPQ7+XlKZ9BVWe/CzhkTuQ7KriYoOO/rER0WitGmJ7g
	 XU7+WHAboMpfoDE724R9lKSb34rBe71VIz7koGwSPLLne7WG3YutYCVlWgTmKUgtKVfU73Wh22lHvu
	 HLUI4zwoCqkzP/3mknGtriy0of/a53A==
X-KPN-MID: 33|mUi57wCuWvvG0LGVyxwb3o16GVAnNDnFpnvC5k29CIELTbHl5G/tJntfHmJNO+r
 c2262xMLDWXjAFTjkRUXPhg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|bIStoMYjiI8YkzJXRDUA9BuGLqllNgXfiKqZl/2NLxUx2TlVpFEynW3PgapxHlN
 7JNeC3IBFGlfLO1MJDdWFLw==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 6bc66b1c-8841-11f1-a998-005056abf0db;
	Sat, 25 Jul 2026 17:56:39 +0200 (CEST)
Date: Sat, 25 Jul 2026 17:56:38 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 18/24] binfmt_misc: simplify check_special_flags()
Message-ID: <amTcjW7tgdqfwogc@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-18-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-18-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:19AM +0200, Christian Brauner wrote:
> Replace the cont flag and the pointer increment repeated in every
> case with a for loop that returns from the default case, and shrink
> the multi-line 'C implies O' remark to one line.
> 
> No functional change.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index d6bc2abc4a7f..d9dc9546d199 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -309,43 +309,31 @@ static char *scanarg(char *s, char del)
>  	return s;
>  }
>  
> -static char *check_special_flags(char *sfs, struct binfmt_misc_entry *e)
> +static char *check_special_flags(char *p, struct binfmt_misc_entry *e)
>  {
> -	char *p = sfs;
> -	int cont = 1;
> -
> -	/* special flags */
> -	while (cont) {
> +	for (;; p++) {
>  		switch (*p) {
>  		case 'P':
>  			pr_debug("register: flag: P (preserve argv0)\n");
> -			p++;
>  			e->flags |= MISC_FMT_PRESERVE_ARGV0;
>  			break;
>  		case 'O':
>  			pr_debug("register: flag: O (open binary)\n");
> -			p++;
>  			e->flags |= MISC_FMT_OPEN_BINARY;
>  			break;
>  		case 'C':
>  			pr_debug("register: flag: C (preserve creds)\n");
> -			p++;
> -			/* this flags also implies the
> -			   open-binary flag */
> -			e->flags |= (MISC_FMT_CREDENTIALS |
> -					MISC_FMT_OPEN_BINARY);
> +			/* C implies O */
> +			e->flags |= MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_BINARY;
>  			break;
>  		case 'F':
>  			pr_debug("register: flag: F: open interpreter file now\n");
> -			p++;
>  			e->flags |= MISC_FMT_OPEN_FILE;
>  			break;
>  		default:
> -			cont = 0;
> +			return p;
>  		}
>  	}
> -
> -	return p;
>  }
>  
>  /*
> 
> -- 
> 2.53.0
> 


I really wish there would be a construction like

  static const unsigned int bm_special_flags[256] = {
        ['P'] = MISC_FMT_PRESERVE_ARGV0,
        ['O'] = MISC_FMT_OPEN_BINARY,
        ['C'] = MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_BINARY, /* C implies O */
        ['F'] = MISC_FMT_OPEN_FILE,
  };

  static char *check_special_flags(char *p, Node *e)
  {
        for (; bm_special_flags[(unsigned char)*p]; p++) {
                pr_debug("register: flag: %c\n", *p);
                e->flags |= bm_special_flags[(unsigned char)*p];
        }
        return p;
  }

that would not waste as much .rodata. Actually, you could offset the
table and the memory argument would go away, but that is a bit
ridiculous for non-hot-path code...

Anyway:

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
