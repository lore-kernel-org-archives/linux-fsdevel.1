Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDF5374A18
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732664; cv=pass; b=ndjPQxJXaQsx6CxGcYHcO+wlDFVmy7uW04AF9mL43KC9k+ACHtF/FiCu3ToZNM7HVKGWJLV32LfIgg1i+McHp9IGlrSgjxFHuu07axcRYdORL10E9lDnCHe9usci+Mvh0TsscUWQ550E0OKI4gQTHVsCgdL9dxAw4paAv5sacd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732664; c=relaxed/simple;
	bh=68E1+Hu7GsiRG81tCRAtESSmzA+mk5JU9ufxGSVZsv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIrSu9A5TanWrWa8dMWWajQ01Qh+78IIfWECOM3GlfA8osw0Z5b4JC1m6A4j27zNpZ3boD6hkj4Z6YMDbvF40jDpHM/EEVTQhQ2sL1i1eW12Gb/RSoOv13ileWtp/sQhch2Qo9irgCh7xTF1bntU7yOg56+blD9OI+TE+b7j4Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhDef3Sm; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhDef3Sm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4956869750eso13182285e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 08:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784732661; cv=none;
        d=google.com; s=arc-20260327;
        b=c9adzW6530ZhGRjw7JS0erphlijzaWlUD4pCe6YZ22OQFwdUPkspFk0jIxbLZ+Uw9T
         3VO+6t7YC6GacQr3g6GPqWNGUOzalj/dyrf/9r/r4ByP9wL6LWwFGT59JstCNcuR4cvX
         VU7b9RpNY7cRjrw+CI7SMfZLt6oQBnOuWEMHH7xJcKAVJouAlGHZUeQvaxguKKXvwjNM
         W/iADD2zgsyfvB/FN9Vm+hAfWq7ci+I2GG5zYf4M6725eFM4KHXqn8iK2Om5nQfrZLtu
         Zlk1srSC9+YmnMLoj0eMgAQ0AT96AxaHHTlrtI72gtmZ8NrjHA+R/z03Cy+BdHh8ye66
         dqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VrBHII0Gv9QqV99nwXioXZ16k1/6ve2MOry2HOxaZzY=;
        fh=zZD3s1dRZNSR6EN6UHZGx9pnUvJhXDN1vTdlBB09gFs=;
        b=Xrg41/yjBXsF116pndArpGQpc5vxScmCI3iUpkKLW2csJ5O1lGg2dTvAnatskrqI1D
         jKGX8Br0B1G/CAwiU8Gt43JaoXu4//vWhHTNVsVm9CyMk6L4yfYbtFYLkKdg6DtcayJE
         5ImFnbJvFFQRdDxZfPenTggNHNPBQxUeDuP3w2Bxjt188amrewDZctSfx+zM7BMcUISU
         y4/QKS9Kxit2dxXbSDmCovkoNmxz3pib92ZmRZAEU8mfEZcxiG+tyArOmSAn1Rwf5/hR
         9OSBJBEj31LOrgk1gwI+t2fLete/edPu9k3/7iZCSQE+3cg+xMu2eH+gfPyImF+DP1wI
         9hKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784732661; x=1785337461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VrBHII0Gv9QqV99nwXioXZ16k1/6ve2MOry2HOxaZzY=;
        b=ZhDef3SmMQfZQDCnmV6T80OFFgpGaKWrGdvHKUPgjmaMaFpNdUWwjirEHW6E1AVWXW
         I+8hZk/A6IzvQBSgsbtYYGQ0Zm/N9PnwLbkGN6mVeYkp1Vu9Lp97AbBo0eD8lOvUrwv+
         4sFsScpcDrHqO3ItgEHxWb23vubEFhQg7Ue4YtkEOAjeKEQ/dsDTGaFc3GYh1NjCswWO
         +OJpGkuIBoTwpkmW1ucivzn2/6HKcAlUfchcoHs73sLmOEuB1y4WoI+nzuVSbL5hR9S9
         r5LfmM+ZjFb0jqarIi+Ph9sZU2reb6SCZfRKW/zxgqG5E6SvLx44RzJIjvtYRIQDdR55
         oVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784732661; x=1785337461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrBHII0Gv9QqV99nwXioXZ16k1/6ve2MOry2HOxaZzY=;
        b=OicCqoRgFdhNM8kCxjHhLy+WrYwEb4tHnygHyucr3AC+xvPHBdnJnEj8uj8qQHxSX5
         MRVqnxycJt/yCKaopbNh7aYdtx9f6DHsW9moS1OTr3UF/E741a918jtq9w6CNOHnfeaw
         faFAaOIKgLh6VOATco0v6LVCa6B3xE1kr/h9czKalKfPDGMhu5Je/dMBwwrdjDufk9tQ
         BnNNNGHNDxB3xwoF+/7nSLsay6McWQt7fNbG8Lc2sR6T5X/WCMflXwrY8+J/Nik4GWkN
         uYcoxtjo3c+nRHVvLy/dzqCHcSRZ+LI7QSTOhoy3/LHqbH0jV7Pv65X8QpkDggxkgJD1
         NrpA==
X-Forwarded-Encrypted: i=1; AHgh+RqWtdL823oZJvApg40g4KAG/py5WlFJKMfD7lHr68Mfc5lF5ObVipF+uMuv88KNQcnzGblctmPPJV4/O7Mp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxap+uGNxFFEU6OvBcMlD3E/voBAdu1+O7n/Jvfkm5JIHDmsrdC
	j96KlqUFNaURb14qiIBvqicUxHsK9mHcRpiH6e+9DY8Hd06L/WqD9UEN8hsieHq5PrA/vZqnUH0
	nIB+IyWqPdvr3CMigcAClEHdOjauP5/w=
X-Gm-Gg: AR+sD10qJ8eP5fuyrqitu/UJ4EDZhOoTQ1lI+sQt2WDcfz3sorqZMgj3AkPmW6tyFrI
	Bfgu1fiVfKXGr6tKiezMCbZFplaVeWjFtFQFKwgw6GMC5PUteR3eE6O+BjzcdHTGpRUJN4F6g3r
	0bJ0wvcR8373RZ/nNvyaNUYMjO/6JWaERVO1GMp7/GKz80lCD3La3XLTZX4ovWBkpJrgqVBAkur
	U3xRbAjVLq4q+SjTDO260jkRaz61Tv90eZe1DfR+tEkduZeODBQFa5NI1lZ2diXNycfgVzTOGtO
	XMvrN6E9C7BFhfumicAdIwGxgvRe4p2x2i9+oT5Diw==
X-Received: by 2002:a7b:cb95:0:b0:493:eccb:8cb2 with SMTP id
 5b1f17b1804b1-4954a514021mr195433855e9.30.1784732660423; Wed, 22 Jul 2026
 08:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720210202.1163861-1-joannelkoong@gmail.com> <20260721142842.GA11935@lst.de>
In-Reply-To: <20260721142842.GA11935@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Jul 2026 08:04:05 -0700
X-Gm-Features: AUfX_mz-QRaNWTV-iWqGU1Ex3HB07wLBD_tcGohk3_JqJeeLhG4PXZXQHlEcyac
Message-ID: <CAJnrk1bwHFRqxpHAGDWhuL3A3fS_a-XDjWG5r9f+bX-XUYu33A@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] iomap: convert to in-iter iomap_next() model
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	changfengnan@bytedance.com, kbusch@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	David Sterba <dsterba@suse.com>, Dan Williams <djbw@kernel.org>, Gao Xiang <xiang@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 7:28=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> The submission seems to be missing most of the relevant mailing lists,
> e.g., xfs for iomap itself and the file system-specific lists.

I'm not sure what the general etiquette is, so I tried to avoid
spamming people's inboxes by removing the filesystem-specific lists
and only cc'ing the maintainers since everyone is cc'ed for the whole
series and not just their individual patch. If the filesystem specific
lists should also be added though, I will make sure to do that going
forward.

>
> For now I didn't have too much time to look at it, and the little I had
> I used to jump on the simple direct I/O thing, as that's the only part
> that stood out as something I didn't like.  The new "don't advance the
> iter" magic flag just didn't feel right.
>
> What I came up with is the patch below which sits ontop of your entire
> series.  I redoes the simple read path very heavily and now requires the
> file system to opt in, and provide the begin callback only, i.e. we
> require the file system to only call it if it can, which simplifies the
> logic a lot, but requires more care from the file systems, and exposing
> the old iomap_begin callback.
>
> Fengnan, can you check if this keeps your performance?  It does more
> inlining and avoid the direct call, but hopefully doesn't inline too
> much like the previous attempt.  If this works, it probably needs
> to move before the conversion.
>

Sounds good. I will fold your series in [1] into v4 after awaiting
replies on that series.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260722124931.3159664-1-hch@lst.=
de/
