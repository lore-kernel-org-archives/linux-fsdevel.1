Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4273B40629F
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047318; cv=none; b=OAsmwF0Q+OMYRf8GFp5esYcT/k3izDgliafTmYo915Go5y5kuOBLidcZjkTKSx95m/htZ760nV5Wh318ymVlUAnpGUTulL649o4QkF0Cx47C5lkFEkt32oQiAeUL7cvk1Kh3lVVp+kdYTrh0tA5CqZdfrcSQ3WjyNsbxWcQlcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047318; c=relaxed/simple;
	bh=MpR6umjLXlsx1l4+rTIMsZp9WQomlXim0atjNxaIbsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl3cwBJ6n5GEiZBnpcyav0rLCTjRRiFfYnILhjRqqqUwknYw5UvfrpgZirH3+FuwxJdOr6xE1nR+vitPkspzp9NRE13oK6wFNwFFMcDke0zXe5iqtHFY63MW+Hy11UGG6PS55UvZDO0ua1/FdOWVajSMUpRktnvejLVgfmIzUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K9sXkrqL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K9sXkrqL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so63180195e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775047315; x=1775652115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnp1PqeJnbYqpsndWX81th/SOoJTeEAmLev2qjXfUek=;
        b=K9sXkrqLlabpj1N+hURGYcdtjl5EMbmqGCJrEIslGxm54t6mg3DfJDYhaQrpBcdtee
         RPRDwX+vW3TamUjMyKu+PBF/fF21ZslppMA+y58xqlcnWj3PRMCWx6OXcGHlfNmCDjS2
         zi7+iXyBqIFf4vbDlkA4h0yu0rSnaC7eG0zZ2CPcuaCaYPzh4vaAvQs22G6SWBUvZakx
         FgYVfiBNvekw8d90Ge28xn2zDlgxvcN8tu4MGp8mSugrYnSxzdEiF8adIAlA7DBmV58d
         LMGOLMDHZRBuGNUPWZ5vkARgIXTy89Xj1R9DxpyhMJk0ucku7aJOa/7xvciHgrMUYkW0
         577w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775047315; x=1775652115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnp1PqeJnbYqpsndWX81th/SOoJTeEAmLev2qjXfUek=;
        b=LyIHYHs/HIdoDTFVTqN3b8tsnYWeSm5BxcZ3DtVhgbWPN3iFRWNjBtxx9wTsgPTzGk
         wRsMrcJFq/nRaJ/xyosMZ3M7lYyap06glE7BxLoQXzHuxtK7P+D55rM1Ovzu7tWggtHJ
         6OWPHfTy2yt6QEhDIr9jhtLISSlb8yrzdEfYBMdzbatlza12k12OS4u9cHLdHRqiJK7D
         +fIjObiKp6Y5+/JM/1M3sQsOnQjRprWE/ySVCtY4hgLbwb1sCx+s+iKUCGz+sOcmhEvx
         VmpzVPB3mGEfF/zCfJmfXecZ3nzSbe6dKd1SpnFxECtkPopHkD+m+nMA5XHByuZXdLiR
         ZHbA==
X-Forwarded-Encrypted: i=1; AJvYcCWKL+t1/sd2peF/sLzbtvBuQwupMmWCspgHGmjzyaOKWkFt8MpOoXWa4mOYDHDPhJ8vK2hEaYHLj/Sr3G0L@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ69Bns2plA6sE7AE+Qp16PnCDz0QhcmQzudu/VZHc+AYx8mbM
	pxVizI7EUMTteeyh1+M0BTM4pDORdtT0JVF2iZDYfm3h03XkeZIcKgSluMIaAJKWJbY=
X-Gm-Gg: ATEYQzzfHhLtTqSq5g6F0yCpa5IYJ89lSqsd5u1+v6qdiRG1X5etBUrbHAm5ZsH4rzq
	kJaPiX9ZYcwyFMzYNVTUbHx1NuZgYBPlMvHyaJb7DrA7scdKGv0PpXlZgMX22Nxzwtqm94de0wG
	rB7mA6po05tvAgiZRellFxa7q4jfOcSRAxd8s1sEpUxJhqllXGhBANUo8hSVyifW5xeZ+gas0R3
	zxcXGVJUCkBzxKZIydMEIbn2ylby/lvWZTUuKbhYU0+z8ODYdXAX58PiNRc9Xui2dCekWJHUqgE
	seShDWjEZRU33DD+GHlSfJ0sB1pUPCxFMAmo8N3+lh74h774WwnguAzBMPgUDGtlgJWUk5OqdOu
	jpj67xKmX5WpLaU8ZWxP5iklnTYMmLzXUY2RmDdV6gUpS6Q1YTM23lLzmvaoldZ4rjE9TikZ5SR
	/P2s+q9+FMyZEef0VxULY64y1J6Q==
X-Received: by 2002:a05:600c:1f11:b0:486:fd3a:fd22 with SMTP id 5b1f17b1804b1-48883568b21mr50693235e9.4.1775047315442;
        Wed, 01 Apr 2026 05:41:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8f546csm40799305e9.34.2026.04.01.05.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:41:54 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:41:52 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Disseldorp <ddiss@suse.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 4/6] initramfs: Refactor to use hex2bin() instead of
 custom approach
Message-ID: <ac0SkJFu-cAUfAGk@pathway.suse.cz>
References: <20260329105307.2876-1-ddiss@suse.de>
 <20260329105307.2876-5-ddiss@suse.de>
 <acpHYPiOy-S3PUNT@ashevche-desk.local>
 <acpIhBT22b2H4rfr@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acpIhBT22b2H4rfr@ashevche-desk.local>

On Mon 2026-03-30 12:55:16, Andy Shevchenko wrote:
> On Mon, Mar 30, 2026 at 12:50:30PM +0300, Andy Shevchenko wrote:
> > On Sun, Mar 29, 2026 at 09:30:26PM +1100, David Disseldorp wrote:
> 
> ...
> 
> > >  /*
> > >   * bogus newc header with "0x" prefixes on the uid, gid and namesize values.
> > > - * parse_header()/simple_str[n]toul() accept this.
> > > + * parse_header()/simple_str[n]toul() accepted this, contrary to the initramfs
> > > + * specification. hex2bin() now fails.
> > >   */
> > >  #define CPIO_HDR_OX_INJECT \
> > >  	"%s%08x%08x0x%06x0X%06x%08x%08x%08x%08x%08x%08x%08x0x%06x%08x%s"
> > 
> > I think this change should be in patch 1.
> 
> Hmm... Re-reading it, seems the both needs to be updated.
> 
> For the patch 1:
> 
>  * Bogus newc header with "0x" prefixes on the uid, gid, and namesize values.
>  * parse_header()/simple_str[n]toul() accept this, contrary to the initramfs
>  * specification.
> 
> For the patch 4:
> 
>  * Bogus newc header with "0x" prefixes on the uid, gid, and namesize values.
>  * parse_header()/simple_str[n]toul() accepted this, contrary to the initramfs
>  * specification. hex2bin() now fails.

This looks better to me.

The rest of the patchset looks good to me as well.

Best Regards,
Petr
