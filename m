Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4CD47D935
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943892; cv=pass; b=LFmXBXkK0sWCcV4Ban4GzZypsX/NM2WmhYxMdZqc+72SDKKrwlhCDy7/0kJTI7SQmDdInoO//AwQ+V76dn3fUHhHu8FkSWkyTBwifo3dwpZT/hQIrc7Fr2i0rXkKIuxnMVjMY1KEieRG3zadtmPpNooEwx7Jxvb61a4aWUABG5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943892; c=relaxed/simple;
	bh=dJPCdypeOQacbOHsNXmqZAmTMKMgt8YOMGaXHcDNHkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGFJ1g8bQepH28glRR8lbgSaqn1GI2hVw7Vay0kKnOPBbkZPOCHBLtUff5FCFayizqRhaioqspjSIlL386pLu+fMxtjMrchqI4Fm1qW4MPVD8oy+0CroEKsKtpuh40z1xQ93DIPVCPhxhg4u6WrdxR5K/Ec4kYPkpX5jiAJOd1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDHleAUJ; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDHleAUJ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-448cf99c133so2700931fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 08:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785943887; cv=none;
        d=google.com; s=arc-20260327;
        b=e6aSTGqyfZiIMqQV7s+w4mgKRDOXcXdCRl0NFdUPnVmF/p3Lih6JqxxguJaHH/Eqlw
         eBIreRiC6mkOcx37M/Va1hFI/7v4oyQidcrzuuPXjyxJd/V4mXvCq8uSMmCDKC853UhS
         peyADt63viEDjdtb2ReEK2m5w/4mE0TNU6n/UsXDFBToO1YTlclOCqzlriDW4t0Jf5qE
         d8yyFyiCxDwnTu/FCQe6VhKhjDPULZVux3QLwzJAVr/pfivM+0aMuxW1BQZ+CW5iwThv
         9Gfh4Pa8nipX3CvTOfyZTXUKE8hk3bniin8Av4hUMawhGqX/jn7zr489DWdxIS38hoSs
         NUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WopFs36fjBNe4p827wx+9JX7Lwtk8JPVIwqGHdzA5zc=;
        fh=thD4YFX1GkLd+9JXu0JZ0ZTjkeKJROBZoUCtijBZCSI=;
        b=LbfLCpcsdwxnnVOpPAq7NfiWoCBhQeyg0COtSiubxSNq2IIYqNiZsGR+Krkf0GStMp
         W5usDgaoIFlLTdtGJSG7osx5YDiKwnrVqssYQiOFHf98akqcZuD3GRSB9nOe8mpIW+Q6
         YLGoT/ow4ZvDNnq0mLYpEgoNj9/jmf1c0MkRKU2b4eDFqF5ePFhxu0J98FQjcMq/g1+H
         /RRNPhULOS/GoiwuOfUh2B6xlYXobPrZNmnXjlMd5gIEKj+e/DnGW1VDgqBmYZ6hkf+d
         qAr0tzB/PF07gfhoy3/jMdvzydZSl4ABmCgKPy0BNsPC71sNicOrXeM1GtVvU2x/Z0/l
         rpZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785943887; x=1786548687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WopFs36fjBNe4p827wx+9JX7Lwtk8JPVIwqGHdzA5zc=;
        b=qDHleAUJxgsCUfR4HPO0zhUwzygyenvCoRBqDd+OmmfbyVu5gxD8Op/C7KblzFHtFA
         K9YMj0V5RfemHBeGZLLV7U2pNIs2r9WNsWoCLzjXxI5dxgJxEDvY7YLdDBouEpJSP9xx
         4v5OSNazeMQn5tX94yQareFcugZ7TsnIHNfvFtwuKMScCdtaJD6vP4deuDJVKfxbfoun
         l3OYOSdWbgMASS2e53DO38uim+uz0m8/wrYDExO+dmCIEIRkwNjyF/H99L/5qpV1HeCk
         4nJPcy5x/FvFxrjowSQAbmdj/DWIYwkBif9y+ZI1omcjaU2XPPox/wpu3TIHAXmtMrKq
         0Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785943887; x=1786548687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WopFs36fjBNe4p827wx+9JX7Lwtk8JPVIwqGHdzA5zc=;
        b=Z3KAgw6kbsY/+688+rfpmBSmlKKRh7btbPJuEYaCAOCBmnQ2IX938P8LxhYAZ5MvaX
         6BSDacwAe8/mWDd9eqQgLinzLqQftSN8c0vgZn/M/hKVYuBYWuNo5kB+GNdJxNdBOJtH
         O0xq8N3cf3gztXhkXlH5dTSWPuTzJdL+roaNRfdyq6Hd1pxvaI18Y7obc3+bzNdcx1Mu
         opOWIDl23KQExg7BI07izdJSb7tPJD+GA9dtn+FXRvyUQvger9vA4oOBJkGd2eJyEW7E
         X3dFH+Cz8685RrRW0xGna9zkfWU/uk0aViUzw5L6NfRhB9UPEtlxXiuy9OWjIi84Iz1P
         jCcQ==
X-Gm-Message-State: AOJu0YzBfikp96FJBNrea2bFdsRcuq32a3CVlIp82rhC+pGN8+s7ZNc7
	smnCy91T3s3qB8Bb0mzCHWPedR4shtA4PuMtJf8QJTJYnGWuwiD+itEFjbchzhS8tp6MXXXu3Vs
	qMixdlRtXMGC7axAd1YOrIR+RzWhgAqs=
X-Gm-Gg: AR+sD13udV3DTLS3I95ttVuwNvDWtESg4RBLUYKZ6YKHJdu71/sZokqk8t2pFltT2re
	O8FQeSoMfOI1vnBVlQ3zF7Y/yWUXLvGzx52v/Sg/JGSySujp389xUjMUo8kI4HtXVL55y1PJ9y/
	RLkMGIGrRqhsd5RVZr6SeZl+usWCsQYtNWHWnbgYyKSilRuSUHF2a6cAn3wg7C2IFOiUcp6YOHI
	iV2Oswix19m9u79BQx8FBTm9Xs7FFbw3XuJt105eyrxmRHwgK1oywyr8Js1aCUDDTSJqS6urAmK
	7/kBMIhwFJzyThcDaGstUI0IhD5/H2+PdBU6NPoWEUU=
X-Received: by 2002:a05:6820:4b04:b0:6ab:19c3:370e with SMTP id
 006d021491bc7-6aeaba25ae8mr23166eaf.1.1785943886510; Wed, 05 Aug 2026
 08:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
 <20260730-work-binfmt_misc-preopen-v1-1-4a0b0da71f16@kernel.org>
 <178571387898.1880415.17662890925792360904.b4-review@b4> <20260803-notunterkunft-wildtier-restaurant-1733e9660017@brauner>
In-Reply-To: <20260803-notunterkunft-wildtier-restaurant-1733e9660017@brauner>
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Wed, 5 Aug 2026 08:31:15 -0700
X-Gm-Features: AUfX_mzXyERgbDVMxdqUz6VFtphDyebsN972OxffP9NIbYDefxKewbjkZdrOpws
Message-ID: <CACCo2jnjvYVG82cgwq-UcEU7ZLRaMp12xG4wBLM=zNHUqqVg7g@mail.gmail.com>
Subject: Re: [PATCH 1/9] binfmt_misc: let a register string create an entry disabled
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, jannh@google.com, mail@johnericson.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:18=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sun, Aug 02, 2026 at 04:37:58PM -0700, Farid Zakaria wrote:
> > On Thu, 30 Jul 2026 15:34:03 +0200, Christian Brauner <brauner@kernel.o=
rg> wrote:
> > > diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> > > index 707f8a14f8a6..ca7840b01a2b 100644
> > > --- a/fs/binfmt_misc.c
> > > +++ b/fs/binfmt_misc.c
> > > @@ -75,6 +86,7 @@ static const struct binfmt_misc_flag misc_flags[] =
=3D {
> > >     { 'F', MISC_FMT_OPEN_FILE,      0,                      "open int=
erpreter file now"     },
> > >     { 'T', MISC_FMT_TRANSPARENT,    MISC_FMT_OPEN_BINARY,   "transpar=
ent"                   },
> > >     { 'L', MISC_FMT_LOADER,         0,                      "loader s=
ubstitution"           },
> > > +   { 'D', MISC_FMT_DISABLED,       0,                      "register=
 disabled"             },
> >
> > AI brought up an interesting point that this now changes the set of
> > valid delimiters which you might want to call out in the commit message=
.
> >
> > For instance 'DnameDMD0DmagicDDinterpD' was allowed before.
> > It might be a very obscure feature to pick a delimiter because
> > https://docs.kernel.org/admin-guide/binfmt-misc.html does not even
> > mention it beyond 'where you can choose the : upon your needs'.
>
> Yeah, I can send a separate doc addition for that. But that's kinda true
> for any new thing we give meaning. So _shrug_.

I figured but thought it was worth calling out.
Maybe you will want to reserve A-Z for non-delimiters; the
documentation seems to point readers
to #:;- all sensible options. I don't have the history about this.

Having a growing flag set and arbitrary delimiters seems odd.

I am headed to DEFCON tomorrow but I saw a few more patch series will
go through.
They are getting a little more esoteric for me though :)
