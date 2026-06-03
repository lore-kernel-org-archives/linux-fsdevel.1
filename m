Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F14338F942
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522637; cv=none; b=WKtQE667ZrQ+DDIN2Wt4/cW9fMdQ/xZMzKwRGCea7QGDTc2XZXpPiXb3jPqiHk8iHV/ojf/fzRkSjQCgCu9YEcskzJ+7cUku+BD8YOvP8vmGlSDCI/JefTbm09Uwz4vR5n63972lbaqsOx6ke+A6ncg9AmsSNTx9u7xASuLCFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522637; c=relaxed/simple;
	bh=G8aqlWT5bLZQV/uLuybjUVkjg96V4exbndaKeusMIxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpN1sfJEgiVuKvg/Oq/5atnnr7xi/tYRAhMkh/cNmyXs1/iQ22wAAIMlIHxSmGtXuj91R2rB/e21FO2+kiuScqyziTdyUqolsGGlAXPp/MAw4IS3N7fkANiCrbdOQ1XnhLdrKXx4fLHgs36t1At9A6b33lsEsuZH13a/ZMkbVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X1yvySnm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X1yvySnm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c3315c5dso215685ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780522636; x=1781127436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jlzwef06CJIrE3LIQnd2Z4dg96b07Ks4mMmqsV33wA0=;
        b=X1yvySnmSrP8qBWKuaTJVC5aT2XNZ+ZeLmuecnonr9glwZRbdUzW5iQ5m0Sk1efVyT
         KR99hT00iXTqzImgV9KCl0vtpTL8qsSf4NIGlkhoXOtO7PWsFDP2WUvEuVu7OmTLKvPZ
         TQbpaU7YXSj8OOOhBjvu7xnRGnk44PUI+yFoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780522636; x=1781127436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jlzwef06CJIrE3LIQnd2Z4dg96b07Ks4mMmqsV33wA0=;
        b=rTuBk86fZ9I/xW8QWQ4TjT5KrRNesOj5SH9xVu9sai8aKFNKHWHRDeDOnPgDV+vRmY
         tHUe4Ry4oq/PBcvXvYMEy8Ok0g1zzJily8VDT1hvijIDsJsbMB1Vxx39zc6pnJa2uslz
         6tNBIcPvCMzEpugj42TK6N56Qvu4Cc0ZeYjZ0sc1IGn5m4UFEex/NLBKtFhdzGWUQnlM
         p1kHupaMChxS/Y2vTUeAj42KaebYZNhSfSgk7Cdn6kTKdR9aZ3BknYyzRCOYXvcH28Y2
         BWRu/qv5rbjTCi+yYMDewULGBley4jKKjiRY0hafxKYrN2LCs2zDfZCE0kuoAacnn7mm
         Xe2A==
X-Forwarded-Encrypted: i=1; AFNElJ98I5TuKWgZn71/ts+0uowBzo0Hew1y2uEmk2PpzcPYlbjU7z4Ogf1EvGvdkCAmNs5ZklY/Uqq87BKg0pqH@vger.kernel.org
X-Gm-Message-State: AOJu0YxXmFyOTqpfN8JiclrgUZL9v+iAJ3TOhknzCtS+rEyUnQDygDy8
	dxo9LzxPa1RSGj30HlCIVH2WJ6TVPlYpQHz3+5pjQpK8lVOXaTEQl7rAX4d1Nw97Yv9M0TxgegB
	aVlAnb75PTA==
X-Gm-Gg: Acq92OHApvoBv2QfSCD2czeTQp6vHL9Dg7I8iMNjV1dUBIx+wagkfCSFF5sCADqlKuH
	lRWuX9LKyReRslugaFTMyvnwK2IJ6438wLp42M2eyVGQTU74Ya7VC104ckfP51I8D/ajOe68ZYH
	jUoqPwlu0ERI14qjHOsJKe82b22pfnM5vYlyH1ZUC6UicavX+xk8fvtwHEhm9ipO95Qyf/YBbex
	d/6lgKGNDjQeminxKi9ZKyl2oYBye2bpM6NTMNAwJJdoEr0cJUW3lodsunyILw3C1A+JE9rV1I8
	0d9dk37Fj+tySc9ZPlXfoRPxTLdB0vbHZ+ymZqDDcRrMdKT5jyk95w/ivCdIjU5A5dFC6se25aR
	G51zpvHUyY8Zgb9bsCSwY/IzShoNxJjOPeq9Qh+IXmG6QfiC/ipfKHeohv2/H6ISY0GvykWGkli
	q/Lhdo0bueWGF+/8XRTw+9+pTNEQWy8M/mCZFQVtSxjT1YYcUN2u/QeUVYlKM6eIs0uRoFZm/Sa
	8qpQSYq9+gR3Z4=
X-Received: by 2002:a17:903:2b0d:b0:2c0:cf44:3b3b with SMTP id d9443c01a7336-2c163fa3a7fmr60425315ad.24.1780522635905;
        Wed, 03 Jun 2026 14:37:15 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649c302sm34539235ad.73.2026.06.03.14.37.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 14:37:13 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so22690a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 14:37:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8MTGt+SnWgbnKeY2kk40gC3dCNlZEmGxri2/ISpMGFn1j0JNsBn8ac42ofDyFkTIIjYWOsq7bq1Wrcny6Y@vger.kernel.org
X-Received: by 2002:a05:6a20:e196:b0:398:90e5:a9b9 with SMTP id
 adf61e73a8af0-3b4978a0b2amr4845639637.27.1780522633187; Wed, 03 Jun 2026
 14:37:13 -0700 (PDT)
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
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com> <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
In-Reply-To: <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 14:36:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
X-Gm-Features: AVHnY4JdHVy7zfm3YSY570fWNlTEBH8JxW4P9TvGYREa7sUrzYx92vQNA-k2Zxc
Message-ID: <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 14:31, Andy Lutomirski <luto@amacapital.net> wrote:
>
> I think I buried the lede too much and you're arguing against what I
> was trying not to say.
>
> Maybe we should keep an API that does an optimized copy, from one fd
> to another, that can send from a file to the network with at most ONE
> cpu-side copy.  Not aiming for zero like sendfile / splice.  Aiming
> for one.

Oh, absolutely - that's what my completely untested test patch  basically did.

The user space interface was still there.

And the networking side still continued to use the ->splice_write()
thing for writing to the socket.

It was just the filesystem side that basically now instead of exposing
the page cache directly (with filemap_splice_read) now only exposed a
*copy* of the page cache (with copy_splice_read).

                  Linus
