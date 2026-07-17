Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793D3BE14D
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301473; cv=none; b=Tstah/RbnpM0l59tpxPwGyi2JejB4GhugOd1pFimEzc4ZCcxu2W6KOV5PT9+yS1OJTUgdySy7zj5q4j0pjrvQA7Llt4pM9J6i3RyVnE0ezYFOAceAWOi740qtm0jlHlBUs9aGkahQVyI5lqKtOtHmDyqlW39PrELZ7421UA2O74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301473; c=relaxed/simple;
	bh=E4f3UkFE35zPMvfWTOJBgYW3vHvp4OhTX1Ip1xfWiqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNlPccZ9WhV5pKCD8kSTykILq7uhaSCNgW18Yjzs8j8YF7aQXtyaNnpKMIw+YjdxqAiJ2zgjq6vdqR+ybOvMdEaG2OmJ5HPMhKkrtk+cXHo4+0m9Opznyq1fmQDXvywO2q+gza73+KOBUx0TJNOwMVkCJA+VoqNHfXeabO+cqEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=R3LVmMLk; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="R3LVmMLk"
X-KPN-MessageId: a6dd896f-81f2-11f1-83b3-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a6dd896f-81f2-11f1-83b3-005056ab378f;
	Fri, 17 Jul 2026 17:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=a8HLQHxPCpbLm2MKNPLqrY3+EQ9+E1jrzcFBgC6A4ls=;
	b=R3LVmMLk+I61ZwygW8mhNvtj02kJzxjqrIrjtmsWnsIa3wuFhDGculuYRMMOHGVaRP/SmeYswD/YO
	 tJ4I5tp5Lb4F6RKXaZe8m4gwNILOodXDayAfLipFqMon+EG5/58PFAoLoK6ATnC4bEtvP0aF2HWQvI
	 dNixdoWnJTa6AJVgnetikhFMBdSajnkCgrZFM/Iafv+BoddAWDvgJZAL3e6wdn342hAIwJOZTB7+l8
	 4/i1rCUWEYuum6WHHlewgF1mVbIe3nYazora5M6A8uvmhLOOGojjZjRgmzDlbso/YQnMMxa6+Tm51h
	 U5uaAw2x8QsZ+mObfAdeQaug5ZYqyZA==
X-KPN-MID: 33|BJ5gks8oQ8GvvVXN+LDYfxHKPIO3j4bE2nWZPbpnvpGV2TQGKcwYFW8ru918+L3
 uIkRLJux9vj2y6nnf2+B4mI6WSKXjvxNzRwrKVitsZeA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|xO4ZtJFzH3SbHMvW4gTF0FS+AJ9qi4XIFY7Lk3s4cEGi3T/UQ3LpSvulZ7PLoZJ
 o2gJcdVaW2goBAMHeD3slNg==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id a6be1a71-81f2-11f1-920a-005056ab1411;
	Fri, 17 Jul 2026 17:17:40 +0200 (CEST)
Date: Fri, 17 Jul 2026 17:17:34 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 18/24] binfmt_misc: simplify check_special_flags()
Message-ID: <alpCdI9_5j83xly6@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
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
