Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF94A92C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150320; cv=pass; b=oB3Xlr5TaivTozS1TgvCqPoJr+Eed24FBpjM+MgmqRid4HyOR2V8IL8+6ecbn2kTEjDOSxx/OHSliYqGjcQIDYMpKfj4sIPd0SL7Fr7XaBNfxeWthT0w/M0grDalWsFTzoFO1seDTgmj/YnZeEKX7OzGoJDSF284qvJkPeizXgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150320; c=relaxed/simple;
	bh=yndXVIPPZUhTwpg5+kIO5TF5aq571rxXnLn21AJXcnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDXucm06EDUb6IJJBP5Ksb1vckXUDjBBpdDRH/vOFiWFgimpLTPUcUyqHKrspjTwXmGdxdWjqrbwT08GkWgK8ZvoYRbP7Iv6+bY6jnHLNPSWKAva2qk1ZKu+hP36g5pRDH6lEUdAixy2C26HrjiRSg80wkIv1ydsDoCnf6OBsQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TwMI0pCI; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TwMI0pCI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2db710396ffso21126435ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 11:11:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150312; cv=none;
        d=google.com; s=arc-20260327;
        b=W2AV6x4WRtMFr9yIebE7uWv5GE305GdYuAYiUFkdDBEE1YwWB0Q33DuvC76ML8jEar
         RN/sScpGL9u3gRgY0DQ3ZxDXfjJ9P5K2WOHkg5ofwE/o0JTFw+/9rBcGb+RvdTOC2rYY
         5RIFy1XHMhUfpwYZY8PyHZ/8OXKJsRJi8MFfnTTYT67P0gwEfDQY3H464luHF8Em3eiI
         xnp9BM0NxveQ11PObUWprMx806giF079tEHnzk0tEhxcgREdQapnH0K0zVq8/HQK4zZU
         gLI8pHdjZhVEZHqCms4HuAIxDuH07cu6W24/gBUAuZ/BFdJsCy0gyASh1BCu1gt/rIbH
         6JsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yndXVIPPZUhTwpg5+kIO5TF5aq571rxXnLn21AJXcnM=;
        fh=+3+ZjxKw0qTtkDo9ohm+mmT/tvznMbu+aCMWvM8mx0w=;
        b=rRnsVPd7vfPbWu9gSUfYEn+4BGgckGEzecUTdvJRmWUUagOIVNu9LjkNlm0znBdy96
         cDhp9xagnyPrnN7IJ/aEo5m/IK4EhlUhimgPKFxx82oitasBlhdv7F1elmWqBggno6MO
         VOvqceUzJTys4kFxI5EpUwDt2HpvBJMSUgmk7o53GjjudOfABQ5kTmmr7q7y8zVopevr
         0T+rM0VqK8iPItsh5SOwsGUwBbjNLnhtXY/szPyjHYDk7aBp8YEKD0ChPksVoAwaT9cf
         vRhu+wjkRKYDMVNCF7coyRg/WynmAXVmEM5GiW3WwMw7pXtVU/o9DMvbbuds96bZfo9S
         3Dzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789150312; x=1789755112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yndXVIPPZUhTwpg5+kIO5TF5aq571rxXnLn21AJXcnM=;
        b=TwMI0pCIqmAHyh8l6si1gWdvZtSsDrvLh9KjqPdRsQ6VYijnBeje4y4YCUp2R4s5fm
         SQ/whomkDjD8E06XZJNCUFaKr8G6Haa4rgUc68wqww72w9B2Kz4vnRx3tQKEnAvxrGYI
         QiBIkw2mg0V2qBuLgddJuyaAm/jPjhWnOgU89wcxf4mXuXQzE0XIpZaTwx8lL/i9KogS
         kgZFk2tyA1FCI22L1uCXyCqM0xHNFQcCuiZ15cEKwSeN5Vy0b/sqiQiTCmDk2JwLy3v3
         0++KOZUvh5l9y9G/AvCvpg3yj5pT45oaPpNpxsgb5oeNfCtQ0sQLbQBh+ao2QIRx0jbz
         /Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150312; x=1789755112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yndXVIPPZUhTwpg5+kIO5TF5aq571rxXnLn21AJXcnM=;
        b=p2Y1Fh3Z5uA56/ihmEV8UAhTj8yMRsglBW1UxTS2OuO2bRC37U61XuUX8vYnPOb0UG
         vBwMjBEqv6cJEXADuuTfra26lob6X7vqnslPnwiPnwztx9nCF0Xa/eY8DXIhSG8/8i34
         EIWIHaXQgPNMbloJo84zzgwqoPCRngaHV93AY07gr9OcOHQtf11++vdHXgAi4nFd6+SM
         w2AqOrxsPExOi/O5gtwfB4dit6VLqgh01ZqJBY0Qz3Rsso63HO1gwwQ8bIv3QRVKgW+C
         qItOotId3NbZKNLmOYbI/BCRfc2G9qfKbFlM4wcgLO9mGNggLChd/Wl1jjsrLESn1Pnl
         2F3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxbs6S5Pjcb86Ucq6tiOHxf0gEoqUbY40FalbXp4dgIIT7Q7GgdtudjYN44U6bZR9tDYRPZOEWmegL14jnI@vger.kernel.org
X-Gm-Message-State: AFuF++mxYa8sZBAk4ZZy6LY8a/Axl8/BkvW28WgkDY/5w7prADbbjGxy
	jsARHmWhUsGkyGTupQXKACIUuYup4+Z65DO8Y0CD8TDDTP/6T7ovqyOr3wSAJYJCrR0AkQaQdbY
	C1XUXSw4EWd+OIlhmDrw2iMXvbNWUX61jOSrglwkp
X-Gm-Gg: AYBFou0vOLPcDI3sEl6pSNBGnL+6wEeDYcTfVqrm1WcyZk4zJNbR3q/9sj9+dKadSla
	0Iy93934YngQryhZ/XzkdBMQkxT9ImNtBXis3Z9UrZP9unFgF5xNI7X61vkSXvg3ygDu+SGN0zE
	BULlRmZ+/PmCse4p1YFFSI8oC5lIhceUxCE3+0HxFT3JD2D972COENOLCJsWzfG+Y/8Hhaq4YLq
	FSVasXY+u24iOchAAPKs8mrW09g4ZvkEClOzMLEdm6P8abGXKfDmtWWUKrC/SYd0DRkfH0tytB6
	CqS1zQbN2wA6NiDflKgj9ezPxjITv5b69d5wz2tzr0BOnyR4P3HGSIIjPsmTYJWsMSK8cTdw3Ch
	6MjqUCKukS80=
X-Received: by 2002:a17:903:2c0e:b0:2d8:d4d2:d139 with SMTP id
 d9443c01a7336-2dd0eebbae5mr122269175ad.21.1789150312031; Fri, 11 Sep 2026
 11:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
 <20260904-lsm-mount-idmaps-v3-2-920a1963675d@amutable.com> <aqN0EGbbHk8XMqI6@lima-development>
In-Reply-To: <aqN0EGbbHk8XMqI6@lima-development>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Sep 2026 14:11:38 -0400
X-Gm-Features: AcwNN1XCr_fenCgMMDZJbz8HR994qWOko4FbMjHRvNv-mIjsWVDFAeKB1IvJ2OQ
Message-ID: <CAHC9VhQ-Ee0KftEFdSWiGDvT9EYFnUvfieNg8+uEQagDncy8Fg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: verify mount idmaps reach inode hooks
To: Matt Bobrowski <matt@bobrowski.net>
Cc: daan@amutable.com, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:25=E2=80=AFPM Matt Bobrowski <matt@bobrowski.net=
> wrote:
> On Fri, Sep 04, 2026 at 04:48:56PM +0200, Daan De Meyer via B4 Relay wrot=
e:
> > From: Daan De Meyer <daan@amutable.com>
> >
> > Extend the BPF LSM selftest to exercise create, link, symlink, mkdir,
> > mknod, and permission through both the VFS identity idmap and a real
> > idmapped tmpfs mount.
> >
> > Record the idmap observed by each hook and verify that every updated ho=
ok
> > receives the mapping used by the VFS operation. This provides regressio=
n
> > coverage for passing mount idmaps through inode security hooks.
> >
> > Signed-off-by: Daan De Meyer <daan@amutable.com>
>
> This all looks fine to me. Feel free to add:
>
> Reviewed-by: Matt Bobrowski <matt@bobrowski.net>

Thanks Matt.

--=20
paul-moore.com
