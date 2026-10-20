Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792516573;
	b=N7/z7vpxfNRMrOetkahr4TzIZK+Ex1zIi7dL+nV2HyQhxiOnoC7g7W+pQ7XoQZcwjUsZ
	 q+x/QmdYD2q5JzxnY6EBPoxeqMJgxghdbty/5jxcXN1T1aFAXPIsvqxyz5I7RWzKFRstT
	 6Bm5F2igE2en40QIElyouBv1OjXvjIR8A6rApq/KGAx57yaeHB8xdAqbTkSkatbA8QUrp
	 CAZ6Sp6XYWk+ALDJrjeIEKo3cl7txdl3d/x9III5EgfzdAdXVS7bhLMPv1lFL8miFbPuD
	 /g15gH8uJwBGKkxeP1Cc9kx6UBZduGa2yAXXKbRMS9hqd/xjmeKRY+yT7fuL0zpCUqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516573;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dqa81DbmEVosVhZIeXDqyDww6DzKrf466i3qKtWkyUc=;
	b=iXDJ5ZGtQFshov+lVZlOw9pLwTi7x3XwKb65CNShFEd1Uq7odUC5yvl/eQMe7afCZJDq
	 UBYeJb+3tjfgEe8DyYlN5lUkFD4abzx3430Xd6EalvRVTr4BlCi6CHhn9wsbYMXEuMZdq
	 U7jwEPGkk95sf/gE3OwXE8KWbYHr+LZlXU1V2Pvb+FUMTBOB2/6L4G9mg64W9ASMtTAhN
	 WCrKAv1INSZL4EufgCkqY9TWaUPgWuWrwIFxjnMjQA4gX5G/UOzDBGZ27ItZuVy41Mfcg
	 5uk8CXAdF+NNDEr70zn6z3os6PbdTqJEoWq45NwEjFUqp/9puwYrVdxxbIQswTTR9sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MBY0gtpX;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RTR1tuVd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814F606B52D
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 17:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D814F606B52D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MBY0gtpX;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RTR1tuVd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792516570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dqa81DbmEVosVhZIeXDqyDww6DzKrf466i3qKtWkyUc=;
	b=MBY0gtpX5imWRG66RW2rcZ445GSWpvIu60jkZK+s+Qo36ftFdLEP84K1fpVRRuMCSn2QvL
	RhePCQBn10Fr5wl1th4ja2OnATL0KHYmx46U1mE8Iuin1wApPzTUtxmeAIZuOhL1rh6nur
	ItXACyTJSF70OzzTSEz9kFj/LFjLnfg=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-jRrxvACeOV28YXoiO_GaDA-1; Tue, 20 Oct 2026 13:16:08 -0400
X-MC-Unique: jRrxvACeOV28YXoiO_GaDA-1
X-Mimecast-MFC-AGG-ID: jRrxvACeOV28YXoiO_GaDA_1792516568
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9907539aff7so2897785241.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 10:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792516568; cv=none;
        d=google.com; s=arc-20260327;
        b=mx+yEqXOK6zTXreTRVhS3LbFLs/6sxg0rpXlLaBHrXf2Tfbdwux98GT/8VhrHk6zhC
         CaY1O5RHSiVVipofqWtJIrg0bIbDkxu10P/FiHmkojMx4wWLAHIbl2mUi/uEXi/F8UOS
         lrfQCgH8Ig8Mi+q7Tc+fsMJPa3uk0bRwA9y2JRzCFVGw4+7Rv1ub8XpeD4eK521hfGHr
         LRnoPGj3DC/l1lRCFkGkKp9nQYZWzWKlPDxgINFfRaowHwqwZdKavSi9V9l8pVN8KaMl
         0neE6FWg9meKSpCYMYbTEhI9Gf6CXx04iTyoNfSnBquSCSAkOp/j2vprFCDVqi4Oha2X
         rqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dqa81DbmEVosVhZIeXDqyDww6DzKrf466i3qKtWkyUc=;
        fh=b4S1wTSn+I+f6rV7Ogp7sIVWjx+bv9DE1bB+tDdjAAw=;
        b=IFiAxK6nUI0ceCYnLmQ8YHXjcxIBhWi5XDwgVzTME/kr17D0d3Yr+B4Qevqa5U4KY+
         EF20w2osPtIfKyslL7OxXAQp5drgVB8kYQWvuuFvM3ETSJH5apgckYD1Exz6hEZtmmGM
         8GSrXSekurTi6jRMo383FyisBEVwztAs+eOiQVUO7y7ubCX9t00Inb5hP7IKYKljl9MY
         2OCEk6c0wWOY8Uw/SLlZqOUBeAnStIETcjXDKTg0y/+jm6Z4RM7Id3VAgIOI7vgqJTfA
         vYnkpDaTr6u5x6CCzKbYETqJznL5bWu5WAMgZewm0PpWoBn6POrr4A/GfsWOa1jm0Xnz
         /4aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792516568; x=1793121368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dqa81DbmEVosVhZIeXDqyDww6DzKrf466i3qKtWkyUc=;
        b=RTR1tuVdDUHEn2ze9H0ohlkt3ebd/D9SNxeKWODVXZQhpsFgpYk6JwWTN7hONZN1By
         ilI4c70pSxdaJAD8xOn2Tij9xfPC3yZf264U8QH18P2oaXTYQV1Df0UnpJbAwBQj3scN
         KsNZ9qxMAD5WISFxDRN9lhW4g7WcpnSt24ilP5OOpGpr9tIwm6LI4G3rY4E8L4m8Ywam
         +miLtYZNvR7evgHh4FH3sgCgNx0tjkEGtoYSabCtdfYQg5FwSFyXWtijwKwVGB9mYLSx
         UbBoGu4Y3qufmKbf+VOdR0+k255Uq2ab8Dnj2JkqEi3w1LF1E8zW8y2/Tb7qyEsG3iOh
         aqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516568; x=1793121368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dqa81DbmEVosVhZIeXDqyDww6DzKrf466i3qKtWkyUc=;
        b=GGCei+U3E6l5U2/138b0Fs2CG6rB1aawpWMuzmDfaDya27o4OG3wVKJAW7or9Hqe9e
         H/oup2CXPbnQvLxDz+bDdQIkK/F2LJZAIRN8AjzIrgowLjIvwcOpW1U7z0Gx8ckqTToI
         wyM0v6XFLRQZY/iWGZERPh6ftsavwL5jPJxADg0MilxFNR+kWJTbTqdDrTsV1ivzo7XL
         S8SGo8rOJbRMiT/5LWr245xDIekzWoAC9fJNTG0b5lUWR5XBDAnwfTBp4rXlDViX+6DJ
         u6n+vRVNLXWCrlG6C8rvzX6cM7gwbFvWSSr1+t28FWiLkAcsFnZ+NDsl02CbGi+pZ2Lo
         G2PQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRNlTfxUMo4Rot8sDnipPTbbHUlOviI2cZAnwTfi46nzkpPoQNy/FWUs4NNylOoys72i9G30OGYO5DKNSq@vger.kernel.org
X-Gm-Message-State: AFq9FYKbNlN94G7c3LK09lGB8drvyy61EusLdSN4iZW1MQeSYHb3cw//
	I+9Puc0rX3kelfD3fY3i2FADbVyAGYjp/RL6DMFXGZXStM2kWOe8+nU0aNNS1x7At1pBm1SBEl5
	k8xSGPtLFgIquJ54Xh1Ilkyl//W8ZukB3Y3gi//KBR59U1iH/v4u6ZLLjKvej/XJpx8DO+AtVAP
	0CW0DFpwO4X6zpWrod5x6/tgk0glIPcDzEvEzlV/bG+Q==
X-Gm-Gg: AYBFou0smGsX7IMctoFq4eHbzymvudoGNJlk+6CpY7/bIrZ2GROSjcxtoAVN0Yecu5u
	7BI4jaqrvOPQBklaviyE6DRYqENmqYCKLoVgReQXacjEHtQ5gk6698LyIW0ULfT/LW33CARrHO4
	QKcbLvYKWaY9NgwFT6va5eW2MMDypJwJ7p4/ijD4F43rH43WWAHrsOzmVgY60zAcB29L42Tzr9K
	WErFI4FpkLy7vh4rF4MWoKPN1z0ZsHuOQO+3aRabMyLLZyDql5jgccdTthn4u8qVvqU2HFOfARS
	oFbqXKYMS9ZESoo+iq7HtrD3MA==
X-Received: by 2002:a05:6102:358d:b0:7c3:b15:a981 with SMTP id ada2fe7eead31-7cc3695de87mr3672345137.15.1792516567822;
        Tue, 20 Oct 2026 10:16:07 -0700 (PDT)
X-Received: by 2002:a05:6102:358d:b0:7c3:b15:a981 with SMTP id
 ada2fe7eead31-7cc3695de87mr3672333137.15.1792516567403; Tue, 20 Oct 2026
 10:16:07 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792498351.git.amarkuze@redhat.com> <20261020160537.GD699485@google.com>
In-Reply-To: <20261020160537.GD699485@google.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Tue, 20 Oct 2026 20:15:56 +0300
X-Gm-Features: AclHuK8IZ3rN_Kb2MqxIXzdba8gBbiLwQmfRP__gRggxXmiCnqZNpSqi1Sf_34w
Message-ID: <CAO8a2SjWStsoCQ7eeoBb5oY3nSUQVFVMT9Rvj1ZcFGNBctuEvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] ceph: support subvolume quarantine
To: Eric Biggers <ebiggers@kernel.org>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, xiubo.li@clyso.com, 
	slava@dubeyko.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, tytso@mit.edu, 
	jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My bad, resending.

On Tue, Oct 20, 2026 at 7:05=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Tue, Oct 20, 2026 at 12:52:32PM +0000, Alex Markuze wrote:
> > CephFS subvolume quarantine isolates a subvolume while allowing recover=
y
> > clients with q/Q MDS auth caps to access it. Advertise support only aft=
er
> > cached data and metadata access paths can enforce quarantine.
>
> No base-commit given, and this fails to apply to current mainline,
> current linux-next, and also to the current default branch of
> https://github.com/ceph/ceph-client.git which MAINTAINERS lists for
> fs/ceph/.  So it isn't possible to review this.
>
> Note that Sashiko was unable to apply it too, so no reviews from Sashiko
> are available either.
>
> It's getting to the point where I should just immediately delete all
> patches that don't have a base-commit.  It's a waste of time to even
> bother trying to look at them.
>
> - Eric
>

