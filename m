Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009201C84B8
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873338; cv=none; b=KWNqsinU1UE9Zwya2FsyvWmqJrD7ZzvqCEP8BjM5iqtnfiS0iMb0J+JMgGwANwkSPFWQAXGYMaknwu5nLqbNoWbIKHgJcXZ4uPoVyi48gWHNpBNXQTaSkyjZCWdoxjYwlakbAqOJPF3GkIc8FT9WuhCAlIAUAsu3Gf0LMunO488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873338; c=relaxed/simple;
	bh=MU3aqZnseiZ1EpQUZp1uWHxSRDqBZCy+pNLrys/AvBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfKWLcJ+LXqW5W9hjpoUB2FPR+3VqTswKIlfi5CZHG34JrL92Mp+FV/XiRsl65Dzflz2WjuHqVS7srs8b4bPhdHe3emkhlsXGqZpRY14LhpHJX2lnWCeNmJZQqQrvOoLZ2+4y50+hUB19bMf9USRYsfyEcchodAbVTaQONt3/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQqOLJtA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQqOLJtA"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b9b190easo234841f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873335; x=1774478135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR/WzDyhHN49Oz88JgChFgqBUvp+C0TbE/XQgiBQK5U=;
        b=IQqOLJtA9ajCuBp0iypn3G0FX/MfsbnLp+T4jdeRaVrHBKPxGTs/jCNXbZnpF8vgUl
         MbBtbH3GFBnNd/9TqcULA71s6ESjPaJueP56FWN6tcDfBFQqpLMAIuNq9z7nbuTQ4LLC
         5lVLlw5tB+zaocn3ei6C8cvSo3xg043sT6XOWGRgOd2o/gnngjCCIdbEVT+GdE6FgZTs
         FpCkfAxx3s5huLkj0YlHVoWn90UhiWia6kExlsbLyMu2rgfej7vmcIPfkM0ckhnbrjIe
         ao2xjFPhzMSKGCelAr3TU45C7Gj2qOT/fyLiMphbi9DFEQvAP3i41kRWvx7rnGcG+Ls4
         h3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873335; x=1774478135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bR/WzDyhHN49Oz88JgChFgqBUvp+C0TbE/XQgiBQK5U=;
        b=FcKfQnIsmQWzXw9wzCgV0lurRL2Ldqwk9SebehSMTeFuMiF7yPQAaW+LcnkdgvNU9H
         J+8Df2RxtB2/e3wvA3iqq4aw5P8lNhm89SMnYcNC8Fkph5fNLAj1ZU6vfh20m0Sv+8yO
         015i/LmrA0SBpMFIUldgk9Bx+l4XKstghBh1PkKTaeyK3W1uGWD8BzucyX10tVtNlpWM
         I0Cjc2dvr9VXHyARqb2LfTURLaWHrpOxFC5z3agdXRe3N4RcalaWttCum8bKRk3NLb0M
         PvCLaI3Vd8MPRkuXelKJcy6ZIcWZ8rkETc4xtOboJSMCzSjgM/Ocbf3SsnB0QyWnWrdd
         XEQA==
X-Forwarded-Encrypted: i=1; AJvYcCUo7h/PNJm2p0cZjHDi0G0LHCa/9sqnFfpL9KHCqiwv75OIuqIo5AtYnxQocd017G/SE20IlK9H3AvPAjAC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9sCqcPje0i0op87dYvXYolHcr0/AnnJGC9rPnYX9lmUshqok
	ox55BWzERamoEJcxFTntulo+aTR48SBpeszd8iOYpp446EMlfjffcFH4
X-Gm-Gg: ATEYQzxeEDKQ2NwgXyMPZQW71UEn9+9scpuXuX/cuNfoPa8kO5T/0j2q4EojJEPmwHm
	DRn26QlYAPUF3BHuUGC3jX0wHIq9wt8/sLiKgoyzXDlRQ9bqFWwOwBo1/Thb3XQHD31CKbr7Cxi
	hn1UO+BTWOA286Z4XyAXWFSapv5hMOV85vguH6F9y2zUcgRAb3wdiDaJIzb5EYkjzlAOEcY7vB4
	UgqYOj+5V31NO2kcjYT+o4haUH2W9KUb4gs6IweBg+KQvtAdpMJO/1QEXuPG8ge/xS83WkHfG9u
	XFewbfhl/DOrOq+cdHwEaoun/KABSgeL5f2YK3kqYU+JVjkVT3WplYlxrXAz/ebm65wDsAzPPN7
	TiYCmnUy7SV+Hhi+gnJRH3wZkT2diNtxhJgZJfDnRU5mOuuUtudHyEeHxtS7A45NVMjJ5vuki5C
	jaDHKTuYcSOF9TUYFBKdb7ZtPnduS3hj2CesgKpY2USvl2xoCc2FAwL5UzaNQvRDbL
X-Received: by 2002:a05:6000:40de:b0:439:b539:787 with SMTP id ffacd0b85a97d-43b527cb618mr8645022f8f.53.1773873335122;
        Wed, 18 Mar 2026 15:35:35 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518a3dedsm10534334f8f.36.2026.03.18.15.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:35:34 -0700 (PDT)
Date: Wed, 18 Mar 2026 22:35:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: Replace user_access_{begin/end} by scoped user
 access
Message-ID: <20260318223532.1abcf12b@pumpkin>
In-Reply-To: <CAHk-=widw8GwXNuq5ALr+NgDDUN+=pc77U=EczqUiVZeD2Dz+Q@mail.gmail.com>
References: <23f19c88e763beb852a4891b2a908890bdd01b66.1773651096.git.chleroy@kernel.org>
	<CAHk-=whFS7D1M4=cMi9cR06Uoxr1QeM8HUtRB6V3cQth=QNoXg@mail.gmail.com>
	<e19d7d3f-d2f3-4bb0-be4d-af2679673f68@kernel.org>
	<CAHk-=wiJVSCmiQAQYYjdQqo9Z1k7WQcep2qW+DiqHyP7Y1_SnQ@mail.gmail.com>
	<CAHk-=widw8GwXNuq5ALr+NgDDUN+=pc77U=EczqUiVZeD2Dz+Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 08:53:52 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 18 Mar 2026 at 08:49, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >     #define dirent_size(dirent, len) offsetof(typeof(dirent), d_name[len])  
> 
> That 'typeof(dirent)' needs to be 'typeof(*(dirent))' to be convenient.
> 
> It was correct in the patch I attached, but I'll just point it out anyway.
> 
> And we actually have a helper macro for that: struct_offset(). Which
> wasn't what I used in that attached patch, but *should* have been.
> 
> IOW, the macro should look something like
> 
>     #define dirent_size(dirent, len) struct_offset(dirent, d_name[len])
> 
> instead. That looks fairly clean, no?

And unnecessary - the struct_offset() isn't that much longer.
Actually, from a readability point of view even struct_offset() almost
makes things worse.
If you are being paranoid it is another definition to find and check.

There isn't that much difference in the lengths:
	dirent_size(dirent, len)
	struct_offset(dirent, d_name[len])
	offsetof(typeof(*dirent), d_name[len])
and the last one really does tell you what it being calculated.

I do remember one compiler (and I thought it was gcc, but it might only
have been msvc) that required that offsetof() always generate a constant.
ISTR the C language requires that - which makes all the above invalid. 

> 
>                 Linus

