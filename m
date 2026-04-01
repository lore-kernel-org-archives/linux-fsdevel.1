Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF243F0746
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047645; cv=none; b=AnG/HbIsm8KdXAFqq6wboQ1Jhg0Ygv4JTjqFd3rQyNHXrk3wZKKrck5LoWZ0y8E0EBr7m8O2L1GQCrh3hI4W5+8twtGP94OT7J/qj3IAHaR2uxqjuPa11qMsIy+fH1p32CYFAwEoRGWleP7UjRrJcMuk985nRyB7w/PerxPX7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047645; c=relaxed/simple;
	bh=GxJNV1xPzaUW2EbQXJsL8zuVUtqru3tnwUUTmQhDhV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn2Bjgx6rWxVBLpPixLMCVG2sW94CtqCW86AgS2D2aRJk+pSnUu9B5M3Ex334YHHH3LuXZUZxIoTz1tuKNTJ+lhgVfVGB8GR1yvSQncmzRgE4wNgRrZofPgUZU2hzVe6vhkCLh3RCRwQh7LFIa7KBsPqzvmD2MDIRQdIb6k8RV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hBqG1AWf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hBqG1AWf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso24472695e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775047642; x=1775652442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmkE/mRjtY453rWaP2ZVb9e+iB/11UzwVnbiatYRX+w=;
        b=hBqG1AWfWu1ExZp5JezUn0oTRxqjMAqiO0JHSvMhE6u8imLA0RCcOel7vV2UPDaZKY
         jH3sanCK551nx9hKSkjz8TCQKfF0xnw9ps7AQNL0QqwOz5w+4qW3HAuqXvwkSW1i29bE
         l7oz19OrBOjRu+GJHLXBuZ/TYHJcI/fDRNDZuFnIKDLGMjQsThdIwKh34sb/afxb0nzw
         uGaaea8+r697v3xP2jfZGaY9Qop7eOT4JjOkTkpx+mwk3EUmMkEo+Vx1c5ciEzdEr+Wl
         y3CUbcL13VNETK/80xFt8g2rwb6Teu1vdxDFSaieDjAP56lPogA9rElKqPIezQPA/C7L
         /+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775047642; x=1775652442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmkE/mRjtY453rWaP2ZVb9e+iB/11UzwVnbiatYRX+w=;
        b=IU1ZITIEbvDC9W0kO2nAEKeYpK4iuMq6gVqnZjwovJjGoGiLnfalM1SF51Hv2BGwOR
         kasJwKwWGw5fpte35QpcINY3m/0Gl4BkTMyfl4kJTjdqgflQFERYKO6KYnSTAaa9ciQ5
         jg94uVmGLCF9br3CfL8nOGOTKoiVlKL0qhzYjbG+vtAnrTe5JV86MTFtjvJU0eKQnzEG
         0kEcn1iNUBd62m6yUHeN19BkmOpVRQLVSekgxXjbf0EvDuD/omVAXrPgfS/gJLc9r+pz
         bs6cB+alTyJI/Hmq3ahvD/kCj0eJHIAwOYWG86QYR143g7fpaVTkRJm28EANMbpibgt6
         CGWg==
X-Forwarded-Encrypted: i=1; AJvYcCXUyBiRAltKygJFn2nRCrDa3LURRitoUUKEXVfUIllaDkiyKajbnmIskTwWlwQr/Qh1GGBHNCEF5z2LgfZc@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDNBQZgmINsTuPxzma/CvJ+HhbZ1qiCQl4v7OYmLzpxKndchC
	m6pcaUv1JHSI4qv77SbgOiUIt9goz7IXBGUcXNN+zNctsrxxpU4g/nyOeYUtrsESG8I=
X-Gm-Gg: ATEYQzwjnnxLJBaNUIcNvPSMQ+Xu1aDKMk8m8dUwVOZMC/JJkwVqe+J7/TQOf9WTFeL
	Gi3lFb/1xpHmVtgZyBRgIFD4fC8y+SKOYtdD2ygpfKBfL37ePdL+HEBRrYP3aHmUcBjvE8vieBO
	16alvNNi1LzVe6S+qie4KCedRvV16yv+Ajsz5dr6mGr101Rw6XGXy7oK9XKGzXoYeLEXDo11ZE7
	RxAZ/Pp0YFbSNnxvge6PSIaoZWXm34VYgfMJXfXIFXLuOIswEYxBw5ots937zjmgYgWttV9MVzU
	wzveZy8tCqWp/zKyOcWFdQjoG7JKmg4t+ueHXMBRDYm3OhNPgEvzeWv6kbkdgyT+QCPn1udvazQ
	5QaWg+JknffylnkQlBM3lRWZjQB8Ypm6Y3fR1A3U2LtEPj+dEVAYmDYrLjK7TUn4DgJnnqI2m7d
	bjse3zC1b9z8cTTdn5UXf2muyj4A==
X-Received: by 2002:a05:600c:310d:b0:487:18c:7acf with SMTP id 5b1f17b1804b1-48883599311mr56100045e9.25.1775047642136;
        Wed, 01 Apr 2026 05:47:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8a546esm62124775e9.5.2026.04.01.05.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:47:21 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:47:19 +0200
From: Petr Mladek <pmladek@suse.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 2/6] initramfs_test: test header fields with 0x hex
 prefix
Message-ID: <ac0T18NAxOsR9gMG@pathway.suse.cz>
References: <20260331070519.5974-1-ddiss@suse.de>
 <20260331070519.5974-3-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331070519.5974-3-ddiss@suse.de>

On Tue 2026-03-31 17:57:32, David Disseldorp wrote:
> cpio header fields are 8-byte hex strings, but one "interesting"
> side-effect of our historic simple_str[n]toul() use means that a "0x"
> (or "0X") prefixed header field will be successfully processed when
> coupled alongside a 6-byte hex remainder string.
> 
> "0x" prefix support is contrary to the initramfs specification at
> Documentation/driver-api/early-userspace/buffer-format.rst which states:
> 
>   The structure of the cpio_header is as follows (all fields contain
>   hexadecimal ASCII numbers fully padded with '0' on the left to the
>   full width of the field, for example, the integer 4780 is represented
>   by the ASCII string "000012ac"):
> 
> Test for this corner case by injecting "0x" prefixes into the uid, gid
> and namesize cpio header fields. Confirm that init_stat() returns
> matching uid and gid values.
> 
> This test can be modified in future to expect unpack_to_rootfs() failure
> when header validation is changed to properly follow the specification.
> 
> Add some missing struct kstat initializations to account for possible
> init_stat() failures.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
