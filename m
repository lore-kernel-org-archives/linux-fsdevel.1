Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0264C4A13B0
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522744; cv=none; b=HMcUTVygqQaKlnPbO3Hude9h60kDJQavoaoi5y3iNZzA1xPJifTBhjxatb6RaNa7guqcEnZC0NX1eJIawYfN1aoDwCAZZMBo+cLiwWUV35umWmr9Ez6msXCpnRJgd4kH9EZt8vhWsi03XIz+zUWQ3lUDHiCMFILJKEsyeOWUUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522744; c=relaxed/simple;
	bh=KZSmPn6xQM1bVRhAbp7rTJ/2+QAJ2min3ynRo3L1ax4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRzTBNLeNq3B3QO5WBs7pm5jfs2TbYnWWQEV3R9ioKI79PFLGf9YFUw80g3ZZObuWZBR1xwwCTZNCvCAZSbL8P+8buk0roRCC1vyjICXH8rU1OSJomwGfvnujusqbp2FDloTpLcBTdyG/lWtg9/GdxUCCNBMGqUVSb7BTF2FmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aNtRKDwf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aNtRKDwf"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c35980fdso208435ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780522741; x=1781127541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O8X5hcAFVZJZKmCogabE4dJnuZ1g/E7cQIrqG9l17rg=;
        b=aNtRKDwfadMCvp8fJF7OgqI5pxo+lm4T39QX+CCErOJLQsOb16pxpA15WdzYq6VSS4
         FygZArf83tiWKj+pRJdEZdYjjymLtZNlxB88HY81elQk/RZO4S/jBXSdo8O7Iw+4mPhh
         yi8QJTGkW1b4oqU49z8RkNBwVfFBUBD98IFOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780522741; x=1781127541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8X5hcAFVZJZKmCogabE4dJnuZ1g/E7cQIrqG9l17rg=;
        b=UN7+NV2d4js8QXofbQNQ24uWWhfbn/SlTA0lamkEyOI/7uoluB1pvCY99oEe9u1hia
         9rSujOKFvztfLa59rggipnZEYc5bnHcwC9Dt27idvWQ+SpNSPbqD3bDAk/ltYPhKoNYr
         kXhCJN4oQg1iTQjwsPKAOztShAzu9ZuyATlgOa6B/tA3wSe46D2gEFbpI2FJ11idQYJe
         eKSqqkRmy4TlGHvoUdd/WvD7IIr/S0NGEMzZJhHZJG4fjORY7Cv5mGLl3b7ieN3XKCyo
         dv9njRZkOPCrrHkRGzfvEg1g2fQF4Gns0G+dfkVcX7USk2IbTNfzmxSF/VNK+ojiF1Gs
         Ucag==
X-Forwarded-Encrypted: i=1; AFNElJ8Dgc6MtgSxhytlDTzJpz/KmGc0uhmNy6JTb5HJOvCnhZOQrMm3Bh+utjQOKD/C3BksfF5cTEPCpEtQ/2fX@vger.kernel.org
X-Gm-Message-State: AOJu0YwEku0SUfbBbcDA74pT1RqJqlpP6SF5js3GGvYWkoraVUaCMOom
	UgCAVe4ITnwLH8DGc2xCjtGc65XDctCAR+fmmZugNYizpubIek03iX8c/LydzwblCwtMg86spW6
	TKn4E8FxNQA==
X-Gm-Gg: Acq92OEdZJX7Ba6fpzeR1KBX46mUaQKaHLjLXbdH9vj8e7Zb9ntJrHMILFFvLkO6wb1
	Pbtu/vkyH2NX0f4jN5nKV10KTbQxxZH0KSoTFPVFjF9pRFeAAEGKr63N5x2/XlcIxdJezMakAuX
	LrO/P1QsJubFKEGs6TK3OqQYQ7ktehaqj9DCaR8EyY17U7VJ2TYmrnYmJLzxW9B5h7gUsYxQYpK
	V6UkC1MVpUdP6H31iuvIS7lo86ICA03L2mHsklUfAJpXsOdnpt/hj0m3C0BFo6qBVa+CtMhkwLb
	niltDX5v+LnlBNlzIBTjUXs5kXpKb2HVylV4wLg8X+N0MtakQv+V5VfIlhZjMWQ+BszxRPDcpms
	w3geIVTW75tXSFdtjMWcsqP8WUEqjAfdrNtu6LZJGzgGhrl39B7HgIZ7w3hOre0g6ZeD0bsV9vd
	sWZDflrvrk83RLIuyPtlBelQY5levbSDfbbhS+Lrv6hzKnDQlxad16OVNevbSLu8p3c/ZHOf2Qe
	MOlKuiwwns=
X-Received: by 2002:a17:903:2410:b0:2ba:924b:3948 with SMTP id d9443c01a7336-2c163a359d6mr57700615ad.15.1780522741067;
        Wed, 03 Jun 2026 14:39:01 -0700 (PDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629cfe2sm37948355ad.62.2026.06.03.14.38.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 14:38:58 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36d8b644473so4344359a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 14:38:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ85igPkPGndpWD+xw9HTn7PU8qAc4AdBueKUUSlNZCPk4P2n9IUdJYtLaD0CDXq754ur42R8oLyRlt1jUoM@vger.kernel.org
X-Received: by 2002:a17:90a:d647:b0:368:af5c:5925 with SMTP id
 98e67ed59e1d1-36e31102a48mr5572800a91.23.1780522737998; Wed, 03 Jun 2026
 14:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
 <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com> <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
In-Reply-To: <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 14:38:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wha=LtAq8y-B4j9ps1g_qv3CK0LrHdHEVxP_52p-m=NZA@mail.gmail.com>
X-Gm-Features: AVHnY4IpVbwzilxzEo0kIzmtKsGcV63XCgmSpKmBQvjcdm3Lbflf84U-wY6VXLY
Message-ID: <CAHk-=wha=LtAq8y-B4j9ps1g_qv3CK0LrHdHEVxP_52p-m=NZA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 14:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It was just the filesystem side that basically now instead of exposing
> the page cache directly (with filemap_splice_read) now only exposed a
> *copy* of the page cache (with copy_splice_read).

... and let me note that UNTESTED part again.

The patch looked "ObviouslyCorrect(tm)" to me, and I did actually
compile-test it too.

So it probably wasn't _complete_ crap.

But I never even booted it, and if I had, I wouldn't have had any
loads that uses splice (or sendfile) anyway.

So caveat emptor.

              Linus
