Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB163EAC68
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138218; cv=none; b=AKF8662iZL9FUOdMxzVuOBvx+uofmlozw1gq/QjhcMAXCIBSaI3qeiORGvnBu2KRbFvWHero86s7xGdvqnz9evYs9wD51FEE3d1MBQIY4eq1YxVeLtvsiLrSSTJm3zB125bbR/5wWPQD/pPnXEt4gE0J3pJz4FcCMQOvnvsPFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138218; c=relaxed/simple;
	bh=qat2wW/S5sFfMSSYogUhfOa5HM/fpcWvQmY3H0cHrvw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=PiL3tJ/VqDbyYopcVBNMX3VmnhEJi0R7mfCwCekW0iuYqZbxFjRcjuroCBEbLt6I9Hq8IXcxUZ1O2FL7Juj3BK942HSDuZMFcU33rfQSoVRRpQ8C4wwQ0XiW13vkcp38Kh/QMlQFzf+FwEGDWhoL0MKYUspkQvjHVhEwgGTjF8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=k4LrZ9CK; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="k4LrZ9CK"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80dc4a68e4aso25320867b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1785138215; x=1785743015; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uRtQsepgOz3Ez2KnqaflKAVM3t8o2/GIA2QttRFCrNQ=;
        b=k4LrZ9CK/RNNcTiT1HMgqlsksX6bTsKa6a7d24DQY+T2y3cGfvkrwYvmmsirSZkr6f
         uRWYAxFxo2R3XwgfWuF5YP+39oHwTVJspshvMHtDTppSRWxuSyQ7X6eyGf0PcrOE60Bo
         YMDEQ6X5w8/ibRK81p8SfaeF8dVq/lPI14jvEqZNIvi9Wh1bJc+ygOU6kbhB7TTwXiSQ
         cOTUv3tdz9St78lFpBljK7G9f7jq9Iza/Xp2WbskxsQtlK5eVq+9T1c87kFysbfw44JG
         JkM6Cu4DXdQGy509QratwAGOJ9sE3JFv2/uC97Ol2mPKXDZjELhNxVPeZ9O1g+0nMwt/
         snfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785138215; x=1785743015;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRtQsepgOz3Ez2KnqaflKAVM3t8o2/GIA2QttRFCrNQ=;
        b=Vmui0FHKK4LhDKXLc3IPIzYXDjSKellgpm9lkJupbEhoScdYDsRlH5Dk2VSojMRTLt
         llbOzPKV2FV/3+aupMeD3C6Y+zWvtBIh9Iw8/qVfRxYmrqMKHbIFuG0WIAMTZwTuaYSx
         qHrBAeavml+aZAS5sFpO37j9cjoHdDW73/8Brj1UlS04ctmEOyerWcLa4VgXpQbz0FP8
         vpiKQgtntz6Cw4s03mQwWgAF6GTiSUhV3sljq2R4RIrsVXV1riXoof0T4yqhwdmVApuP
         YByri1Ny7S7tCJ4X5yga9GopK93CQrFooVNdt5JiyWfgPVmUxX04jXFO3/9jhKnZaBDJ
         00gg==
X-Forwarded-Encrypted: i=1; AHgh+RohR4+u4P9jOkTzkjEjUfhajT96lxUY0F0yDwkwhiifLZ1mhaNtaaFE8n6RMibkl3quZHDdcn0X5TAaJLql@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdsob1+l+KBUFs6RSKn5sXOjybwncSatR22pTyjIfAFQ2EqcCu
	zUTfSOPmhQqDR+H5EQd9oOSnqjT2sLOZqnLnNz71j8nn3Cdzjcw0iRsLGk7wAsU4dQKkYRJfU3o
	RJb6X/A==
X-Gm-Gg: AR+sD11ZT1S2ip48HLT2ZkDYwO2/ZA5MzFehhuGAOZzp0S4MuPCwcTKkPmCGcEdU6cM
	UWUHyXEYoYjzk1khcblCNVTsUegfuK1CezztxxAyqAwkeliggFf7IBMdquvEuUuILA1gNvdwh7t
	g9zXfzvMW9goo+QWTRmX7QmPeR3NHlsoP3pdFA/6Srfjhq9Q1W10AgF/dOxBmc/zg/28SQQa9hh
	vzjd61fkvPLI1Z3zSAGpcw6tFhDhFBEsCFMrR4HNSFGOeEwGpr5vgcfp27mkfF7nfn0JtvMYYBS
	Zr0q3kmumIex0++ppEP5IchQYaGTuvt0ApT9mfAStKdvrs9+GY1EnLBVantiA1AWPVLormz9qCt
	C2k/2gIPYpP0c4L999fawyJrZ/4JJQLvF33nmHuR10/t1CPpIo09Fy2l00Y+XcQtEWQTKr3Oo+m
	lS9UgSXsVty7CTvdwdUZzW
X-Received: by 2002:a05:690c:6704:b0:81d:5155:213b with SMTP id 00721157ae682-81f69cd5a48mr24289417b3.14.1785138215197;
        Mon, 27 Jul 2026 00:43:35 -0700 (PDT)
Received: from smtpclient.apple ([150.228.3.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657bfddcsm28229997b3.18.2026.07.27.00.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:43:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 4/7] fs: support FD_FAILFS_ROOT in fchroot()
Date: Mon, 27 Jul 2026 09:42:25 +0200
Message-Id: <ABB3CF80-5F05-4279-8E0F-73A21E6B9DDA@amacapital.net>
References: <09b4735f-c04e-40f3-a7f5-254b7918fbfd@app.fastmail.com>
Cc: Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jann Horn <jannh@google.com>, linux-api <linux-api@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
 Farid Zakaria <farid.m.zakaria@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc <linux-doc@vger.kernel.org>
In-Reply-To: <09b4735f-c04e-40f3-a7f5-254b7918fbfd@app.fastmail.com>
To: John Ericson <mail@johnericson.me>
X-Mailer: iPhone Mail (23F77)



> On Jul 27, 2026, at 5:30=E2=80=AFAM, John Ericson <mail@johnericson.me> wr=
ote:
>=20
> =EF=BB=BFVery happy to see this patch series appear; thanks Christian!
>=20
> Also happy with where this specific thread is going. I will just add
> that an additional flag in fs_struct to force RESOLVE_BENEATH in *all* pat=
h
> lookup would also be nice. The combination of:
>=20
> root =3D pwd =3D failfs;
> chroot_locked =3D false;
> always_resolve_beneath =3D true;
>=20
> goes along way to getting Capsicum's "capability mode".

One thing I dislike about this is that it=E2=80=99s (approximately) a task m=
ode. Why should an fd representing a capability represent one capability (a s=
ubtree) to one task but a different capability (dotdot) in a different task?=
  Do we need to prevent unsharing a userns if this bit is set?   Do we want t=
o have to worry about any task that could potentially SCM_RIGHTS and fd to a=
 task without that bit set? I prefer beneathness being an OFD property.

Note that the obvious giant holes in capsicum-without-a-mode (root and cwd) a=
nd their respective dotdots are fixed, quite cleanly, by this current patch s=
et.

I also think it=E2=80=99s a bit of an ancient mistake that paths like /.. wo=
rk at all instead of generating errors. Maybe a future beneath-only fd could=
 also disallow trying to dotdot past the root, even for symlinks that contai=
n dotdots.  This isn=E2=80=99t just an aesthetic thing - if I have ~/foo/bar=
 being a symlink to ../bar, I think it would be a mistake for a beneath-only=
 OFD to ~/foo to have =E2=80=9Cbar=E2=80=9D resolve successfully to the wron=
g place.

> Then we just
> need to figure out things like more capabilities for directory file
> descriptors per Andy's brainstorming thread thread (which I ought to get
> to replying to).
>=20
> John
>=20
