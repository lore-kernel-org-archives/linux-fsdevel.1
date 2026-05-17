Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD6635F5E5
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779021624; cv=none; b=MxbMzzUdhse9C9sS2iwlI0WP45ETTEf16lvuMrWh8pUZUfBG2R761JU3lXedn4Ks7/0pXyN/fLYlYyzbDaDZZr8Ay+S4/Pwp2aM5duVT1lHADk5Sh8U/XVBVEY7PVCNMDTmVtHpZKZzqvXdIgFodn++J1qB7XcLUaBxjD1cCXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779021624; c=relaxed/simple;
	bh=SqdcfXhNySjfZ8jeGKU6fVRD6BYJ+PAXJFdsSakJb5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVh7uKBDDZHKKBdsQnbmQmIMkKUz2qfpTN+RCL6JXop0a/Zqvsk/Q0Xp+f+L9pejrLH8TwnVLjYrqpi70xKJ+OnWUfkYqP9YOnKFC5UadvfW7PaNOf86d65i0PzYWg2l55GWVlk3hPC+DtL3LaN2+2fWyOf0fvRIv9ygzvTJp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZevd1rb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZevd1rb"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so13005655e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779021621; x=1779626421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRYhLpPlO2XIGLy8e2lMtFFSB/FdoHcKXbU93W0aFKw=;
        b=AZevd1rbqeQr0/JN4JFmLruJCmntaJsNGFNDHF0cdMzcc8YLbJeRXBrool+xSM6NE7
         V05h1WMZxz6oEfrGZqrIoOY7ajjBS+s3G/ufl8geyg+mL4KqRsWnALvVf/04y76V0617
         AmRoMRQ/xH/0KkTJwsD+X6l6OFP/hD14mcNNKq0hyx20w0sIMFJPEdQ14e87WgkdpVwv
         ehK4GGFWrb17/BVW37PQ7W7umigop3o+wj1jIs+SVqnD2pgID+BUIyFpGmETecghVtxf
         fHPt0QwZ602vfNH5b2d35IcGVm9sbY4UFsVQZyjSv6G1Uia/++7Sb0hNKl2ZOkTGtlWm
         StHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779021621; x=1779626421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRYhLpPlO2XIGLy8e2lMtFFSB/FdoHcKXbU93W0aFKw=;
        b=c1KmVY08QDAlyg+MNYcPye/b86m83CQp/7SVH5hHmhP9QIgMUS7Gjw0uthuVLFOeQr
         cqa91ysIxhhvIhKzoBK5zapX+2x8ZAEOgc56i1rdBgTiItT2MvTttyDr8nCQW9zjcvUS
         /c2QjI1AbVJX7zerlU9Swdnai0JGBm9C0Y9Xvqgm7aZn67Xl8jZnc67FnJUIWOBqfK7U
         aMowu4s6IwbC/d8q7bjc0MtPF9fckBxNbD4B/Qvi4c6IVTnK+TusD4XaSw3rT1q1gPHW
         KY95A4Cf1X3+3ukOGZ+DCOYCF4GoJBKfCDnFb1K7UVSQ23PHrwUG5ZBL5i4jdf+TAK1t
         YGig==
X-Forwarded-Encrypted: i=1; AFNElJ/PfJkB6afBGmD5DzUMX/u5X1bkSb+42iAY4yIwMcX9RdQLFjX2999Cf1nLOIhbO/yBiQmah+BS/VA1Mu4o@vger.kernel.org
X-Gm-Message-State: AOJu0YyQYJ+Sms6tRaiSChcID7PWez4sPjGNie/AVq4VN9ZZvFaEbfI3
	o+azmarC0YMEDj3AnP8SIXnv0pvSoHN5rI1CGihKEWhg7Wmig3qUvh5U
X-Gm-Gg: Acq92OGwcmDV1/EW87DkMb1ZqqjE6JrXZisusREIswYILnVdh4p/61tcte/0QTcWRrO
	Bej+A5nRQ50JFHCNLRQBtBH3YjCc/M00/8tH662SxwE1OXU4jokLXtodgLG03O8d1OMNV9j/kDB
	0uO52nqqqm0FkTLOLf0neM/CS0+N44SzUN2mguAsC7ackXfckYQGEUXl24Gt/wrdnKFQeJeFVSX
	48+7wTzswV+O07AUbis1jXkjBeIxQtCTnXUb/7FdHfguAnZXItfXsD6Tnwi4Q7DALtZkcT2MGES
	bpPBvOIoevagATWscxXTqtOcVcxodlVHbwZOY0a6WSU+Yxyk6O2q9aHJPquT2idx4ibBLryUF8l
	fG68cw9Dc+ixMok4IroZy5WIP1T3zvNBUIEDIdt6UYgsNHnRNB8Y1tcRVUaSd4Fz0gKRYlkO1F3
	pJ71SdF+jifrDOVYUQoixQxY4fsdPmTXEY7NjimxqK7XlbqFV1z35YaThRiGJ6pWEe
X-Received: by 2002:a05:600c:3493:b0:48f:d2fc:d042 with SMTP id 5b1f17b1804b1-48fe61f1a27mr173743315e9.13.1779021621084;
        Sun, 17 May 2026 05:40:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53ab773sm201337395e9.3.2026.05.17.05.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 05:40:20 -0700 (PDT)
Date: Sun, 17 May 2026 13:40:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro
 <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>,
 Nirmoy Das <nirmoyd@nvidia.com>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] err_ptr.h: introduce ERR_PTR_SAFE()
Message-ID: <20260517134018.62901443@pumpkin>
In-Reply-To: <56380C61-04E4-403E-B721-F9B62DEA5D56@dilger.ca>
References: <20260514200129.94862-1-amir73il@gmail.com>
	<20260515193010.056ef472@pumpkin>
	<CAOQ4uxjDeF3uDe=OTVZ3fK65dF148FRUvPx5fOqZpoFuGUsmJQ@mail.gmail.com>
	<20260516094242.77d20c92@pumpkin>
	<56380C61-04E4-403E-B721-F9B62DEA5D56@dilger.ca>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 03:13:00 -0600
Andreas Dilger <adilger@dilger.ca> wrote:

> On Thu, 14 May 2026 22:01:29 +0200 Amir Goldstein <amir73il@gmail.com> wrote:
> > 
> > The check for constants may be fairly pointless.
> > One of the static checkers may already detect the obvious fubar ERR_PTR(EINVAL).    
> 
> 
> Actually, I just ran across an issue that checkpatch.pl does *not* detect
> this "obvious" case.  It complains about "return EINVAL", but does not say
> anything for cases like "return ERR_PTR(EINVAL)" or "rc = EINVAL; return rc;".
> 
> The following patch fixes checkpatch.pl to report many more such cases, and
> has very few false positives for checking common error return assignments.

Looks like there are a few too many false positives in the network stack.
Mostly because sk_err holds a positive errno.
They do all seem to be 'err = Exxx' though.

Does look more useful that some of the other things that checkpatch checks.

-- David

> 
> diff --git a/contrib/scripts/checkpatch.pl b/contrib/scripts/checkpatch.pl
> index 70c78a3..e3fdedf 100755
> --- a/contrib/scripts/checkpatch.pl
> +++ b/contrib/scripts/checkpatch.pl
> @@ -5795,11 +5795,12 @@
>   		}
>  
>  # Return of what appears to be an errno should normally be negative
> -		if ($sline =~ /\breturn(?:\s*\(+\s*|\s+)(E[A-Z]+)(?:\s*\)+\s*|\s*)[;:,]/) {
> -			my $name = $1;
> +		if (!is_userspace($realfile) &&
> +		    $sline =~ /\b(?i)(return|err =|rc =|ret =|retval =|ERR_PTR)(?-i)(?:\s*\(+\s*|\s+)(E[A-Z]+)(?:\s*\)+\s*|\s*)[;:,]/) {
> +			my $name = $2;
>  			if ($name ne 'EOF' && $name ne 'ERROR' && $name !~ /^EPOLL/) {
>  				WARN("USE_NEGATIVE_ERRNO",
> -				     "return of an errno should typically be negative (ie: return -$1)\n" . $herecurr);
> +				     "return of an errno should typically be negative (ie: $1 -$2)\n" . $herecurr);
>  	}
>  }
>  
> 
> Cheers, Andreas
> 
> 
> 
> 
> 

