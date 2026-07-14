Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C241B8F3
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069567; cv=pass; b=YOca+5c9ZRvE0dWtYGZXjbQT831HJeFE8Gv28iq5EEnOSPPPKC4MnsjLJyGTl9FHhM7Pzb0ELbRxfrJSaC5eBa6UDKd38aZgGrs4OVPa5J65LCeO2HF1aO2XYUbSSq4xKcL7khRsIulC8ninIVcEZCOev92Yx84Wsbh885OZugE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069567; c=relaxed/simple;
	bh=nYoADaUwDh0+BQd+/OoXhra0JAA3KEwkTgxpAdiz6Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmHL+MrDdvvTsdtuNmXwDgwd8hH9rpKQ2onabEklj5ZvKq1OG1cttENudbS2Vb5EW67TwwrPUMdF0BAq3xZG+zjWivIejpJrdm7MAbVpzngdvh4UWydniyHlAaxMI+WirOVJmcXKZKktmrzhnUynobheIW7ilwDUXwsUXxwttis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7RsKZt/; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7RsKZt/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dcbade417so3220525a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 15:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784069565; cv=none;
        d=google.com; s=arc-20260327;
        b=k1CDit17Z2LVGPYuZDjBmiKSd5D3vsdcSgzbFStMqkt/qJ94v/XLgEs1eEZakNE9+V
         mfwTG3ST9kdLU3ugreoJFuODQv/Jo0LntQn5OExkd3NkJbiGsOd6cW20VJu0wOqwfkpD
         TKOWKezjDZlp2PmwDLbdzgXrNX78SYPzRbcQwqA1gXN3UjgX01H3eNwWD8YbL9dVOnQs
         O653+HEvvaGVLAQRf7HteX92F95ttUCJI0CTup5bJOPVGj7jNsGBOAJlqjJWf6hlNjFo
         DammtkLSF7mNMq597bOvA0lnW11a/XK/k42w/jrM5hYIazkDX1heX1v0DNGP1wOuFY1S
         UqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kgM5gfHSJ4YqkHTjYUXiFkb4Lm3TeivgtFXOYo4rTPc=;
        fh=o7WmFkDjANv75LTOhTnl0CJK0cogpz9UYIg6Wqx9y6Y=;
        b=ph6wiQd0gkCw48kTFN8dWXhWdzLqWtMBBlj5iuBR1b45zW7HYcrGLzP4+VIRPK+cJm
         7wDwgedWtLuYH+pmfLSdHelH840bizybed6X5ZdhqvPFKLalcKCLvM7AL1YRH8buvoqs
         vNA2oRzHv6L+pxctUPBx0ShjDHNFb3VthPhxoGjzTwFgPsLok4pMF+qmQgZdHw2elJ+O
         A3BFzYFMRZE3EHaXlNqJofz57klS76j5PLx3ZrqK6sG+tZji1rUiMOT7PfVmSpgwU4Cw
         CK7aXfB1JRYGPnezV6C1fEMjBaQ4E/vfyd7fPk/BBAm8N56tf4fI6OLpbvyq0qHt7kU/
         SqpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784069565; x=1784674365; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kgM5gfHSJ4YqkHTjYUXiFkb4Lm3TeivgtFXOYo4rTPc=;
        b=G7RsKZt/Mq4MBNXSXBuK5nWZR5Ek4eVb/Cad+C5bN5r+80izeovHIDtrZFI5ehV7WJ
         2eGY5NF5A0AU/paKypS7i6cXW5+14WOreLjjf9flY2537hcNP9t1lbCJFAzGCxQyUwkh
         GeuRNRBn2x9GACvWs8LSqQBSs4GSnrn/JJvQTbzmZg0kFQuGQEUX3AG5MPl07hfXshaw
         VPJ/5sRpV3y6J1d0I6shK8W7zSes9ZDKypugu2uGW+KdS3ZAvmnVTzutHiunJKNOWeoi
         K1chE73FJDJvzTDF4rQQOavmKacz7eI9ceQIbdAZBryq3HS+XnMs5qwD0SNt7qb7g1Ef
         vbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069565; x=1784674365;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kgM5gfHSJ4YqkHTjYUXiFkb4Lm3TeivgtFXOYo4rTPc=;
        b=aCi+d2vq6Jxjj+/5FTAiN9hv3L71Fqpcm1V8WTGXLlJYw9CVBxOAYG73da/5XABLsA
         /+xbDPMeFnIjjwFRGZeHGKMfA1GPS7c/SRkU4oGR66D/LfjI4Ae0KbX854wbDP9qRJdx
         ZwoiLs20QNVnaBe5U7EqzkjOCHbJVGIY/k6ayb0Lhr9J/Ctfgw7UvPVw3Rp9PnVapobH
         mlm4993CYhT9ZlxmRweQwk2PyhN37xH3QHn4pIaRPMv1rUFWS3yRIXugLp7RJetPjsOO
         q88xy7MuPlT0RdrXj6cppS/wIU9X1N3PxrySUmCVw6waL5GXdYkoIDLKoQA49fBQKghJ
         918w==
X-Forwarded-Encrypted: i=1; AHgh+RoeuSmJyx1w8HY9g555JD0aTgpFdPZwVmhzHbeuHPr409CJHYD8QzDG6dYbTqSpLt4JlB52chPvJDApC/u5@vger.kernel.org
X-Gm-Message-State: AOJu0YxSOcTLuU+RVUCoga/3mUHpV5SDqk0lNwyaXKhj4cF5ykvDJGB1
	RsmPQQTTvsWvYciVxgzereVtXSHpvik/QKNlf5TMUrr80CqySkcfWkixC93UN/qJjF41VG4671U
	egnS2y0v8plcaReipO+oEViI8IrfFPHx5kCqnGEsn
X-Gm-Gg: AfdE7cnZ1jwS5tcYPMGeI9wQ56HkquPMSYx47RRMeJsFoWvJkXciPxPnw4vPXaqGE7V
	XrBqeeIpW8eEpOyOGeYusQtB3pElVuLOMQmVoTVsYv55/v1PVBcbM0zSEPR0z/6kju6TO4ytUfi
	aLC9Ikt0fw1Qvn3p+BsH0YFmNg0CeFxTK0azFBCHlRd0p3c9by6Stmo71ebdmhZ70ZIiButs3Mh
	cZPNU4RZiohHf9elI4t2plcURnm67oJYo5tDdyYkGCX22UBe8WS0w2YuAF/ZRW2BDa3Nwbx
X-Received: by 2002:a05:6a20:6a0f:b0:3bf:99fb:db96 with SMTP id
 adf61e73a8af0-3c34d719d38mr6086909637.49.1784069564657; Tue, 14 Jul 2026
 15:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712165610.366474-1-timday@thelustrecollective.com>
 <20260712165610.366474-2-timday@thelustrecollective.com> <alT2yHlfzhTZ9n4T@mit.edu>
 <20260713164417.350710-1-timday@thelustrecollective.com> <CANpmjNMfQT6Z9ke4x49sp6z8+pt_5ZLUoSh0da-99bwos5-8Lw@mail.gmail.com>
 <CANpmjNM5CmQc_YG_5=zhdLCr7gGL3QYPcd4R4=m2NzwNY03d3Q@mail.gmail.com>
 <20260714211246.1046948-1-timday@thelustrecollective.com> <CANpmjNNU_GiRW6y24hvbUsXze+jf+9ptx8_Acq1Y=mvPSr=wFg@mail.gmail.com>
In-Reply-To: <CANpmjNNU_GiRW6y24hvbUsXze+jf+9ptx8_Acq1Y=mvPSr=wFg@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 15 Jul 2026 00:52:07 +0200
X-Gm-Features: AUfX_mzv4cLX37cRkCFKYs5gHQK6PnrtFafZdRhGytloUdSp1JvIS9VXJ-Tsfl4
Message-ID: <CANpmjNMgH3sX-RoOjo4Vo2Dqx7=3rov1Mz02u+vKt4WkNuSg3g@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] ext2: fix ext2_xattr_delete_inode() context
 analysis warning
To: Timothy Day <timday@thelustrecollective.com>
Cc: Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jul 2026 at 00:08, Marco Elver <elver@google.com> wrote:
>
> On Tue, 14 Jul 2026 at 23:14, Timothy Day
> <timday@thelustrecollective.com> wrote:
> >
> > On Tue, 14 Jul 2026 00:56:56 +0200, Marco Elver wrote:
> > > Relatively certain statement expressions were once again the problem -
> > > this should fix it: https://github.com/llvm/llvm-project/pull/209330
> > >
> > > I haven't had time to test the Clang fix on  fs/ext2/xattr.c with
> > > context analysis enabled  (please do so if you already build Clang
> > > yourself, otherwise I might get to it in ~week).
> >
> > The fix wasn't enough. The commit message on patch 1/9 omitted another
> > warning. On vanilla Clang 23, I see:
> >
> > linux/fs/ext2/xattr.c:829:6: error: rw_semaphore 'EXT2_I().xattr_sem' is \
> >   not held on every path through here [-Werror,-Wthread-safety-analysis]
> >   829 |         if (WARN_ON_ONCE(!down_write_trylock(&EXT2_I(inode)->xattr_sem)))
> >       |             ^
> >
> > and:
> >
> > linux/fs/ext2/xattr.c:860:2: error: releasing rw_semaphore \
> >   'EXT2_I().xattr_sem' that was not held [-Werror,-Wthread-safety-analysis]
> >   860 |         up_write(&EXT2_I(inode)->xattr_sem);
> >       |         ^
> >
> > If I apply your patch, it resolves the second warning but not the first.
> > I tried to generate a fix [1]. That branch has both your patch and my
> > fix applied. Those two changes combined fix both warnings. My fix
> > tries to add some special casing for tracking contexts acquired by
> > trylocks. It works, but I'm not very confident on the correctness.
>
> Nice, thanks. I'll have a look, but it appears right. Need to get my
> PR merged first (need approval), then please feel free to send yours
> with me as reviewer/approver.

My Clang PR was merged. Can you rebase and send your Clang fix and add
me as a reviewer? Please add a more elaborate commit description,
because it's a little more intrusive and the problem and your solution
is less obvious.

Thanks,
-- Marco
