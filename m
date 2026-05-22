Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BCF3CA4BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444233; cv=pass; b=X4Hriyr1EGg3yeqPn6tEF/jSZEUNHOm8fq4r2hgN3XeK+HHKaAQxzIOABbmyzCILeBbGA1xBmQzFhZXZ9hPJFSj2JP+57tAJGuObhWKAYOfGxUvyrDakVXLfmNJ/NcaYkTzkpk9Y5P3tPzMkoOodj/9K1T+LB1LKBfY4BhXlXyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444233; c=relaxed/simple;
	bh=gdxsRuXHNkwnRZYBMEBbND2aGhOV+KTpwOY1IDe0yIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erYuon8Zk+ie9FpxsCj7Exg89wOdb5ocuTLSuxjCd0p+wFFf8GrrYueU0QyVnLmbLUnXn87goQhfrV3KDFA8AYSGM8KM4eVIngdpltQ1PwEdq3d9JeECYKadgwErUjTqZjJoSgl2jpfFONT1//ArMTzhwnaTG/xRrDKefxSK+tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HA24hNf3; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA24hNf3"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so11503049a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 03:03:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779444231; cv=none;
        d=google.com; s=arc-20240605;
        b=TEMdAvzjWI5iewQJQW7+KIpB8Qe3E8BANOIW3DqWYazdoEF7khOatfmc9ZisudaupL
         MVM4XFPxQ92FG67OTXoL+bRv+YFNRuMIv/8mgD6BfwDFrF/dNuo2KfwGyjHWdNoI946r
         zayw+0sYnUIsI6rk5hDkFdLccNyYcgzMcWfGfGOrXl1H38QRAdAxZx7Oxdv1+5NSThmf
         M9/469tAaVxzAQIyg2O+AL3D8dIL3qLL4OPE4ZOh9Wb2S02u+dnRwOoz6hlDlcQBv6gF
         3IWOsMEQbhnwcLDy2/4dxSWdhwyt+ruy8nTCC7EanjokxJtvhzCMeaFK28Sdj187lrpA
         TIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7VTTzNgP8kZ4WZqo/Pt6YUFHI+mQOpC46U4p4u8GdkY=;
        fh=HYkCL8EoW14K8G9IMHSOi61/nciku5w1sBLMzGBBKPE=;
        b=HNdflzNiHqIUWGAU2h81f2pmLwbqRfWG8bFdiqNI9ct9CvnIchbfnQVB1TK6rmr2ZR
         UjxMjlGKZiS7iz2q1GgMPyopSqJtqmFQFKgVOnHQhkldGHe6l5M37XtXvEb1TX21s0NE
         InUxZ4+UZHgLYwWE/6B+P6cR8laeQglQLv6nA/D4/tn949p0ACO0b0wRihkqS/ugAb4V
         14/KZ60FldfntuTSxQdA/smt1aFkddnkUYkkcMqmfcjKmxT2ZmRByOtUoWYJaAqw7u4g
         D2iI8aMZ1Ks3kUf3LjJ5w/jwKQroKFA6tMEtndivCJmC2m4tCncZE+aSp/Ct+XxoC3B8
         P8KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779444231; x=1780049031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VTTzNgP8kZ4WZqo/Pt6YUFHI+mQOpC46U4p4u8GdkY=;
        b=HA24hNf3VqHQXZCjZFHxkBMH9Gyazri/fiphkf5+hVrQZAe3PsqgIeGIndlQq2Ik74
         EY+gTzREp3fAOgAwChd6hU+fqEGmOZSpAvFFMnQdeToN/dv/iIUp3C2SIm47cR543tR8
         0OJS/HeY/WzjU1JIM3LO97BrjKJYmp1xYEhsMZlujiopRuqsecvcvym5uaUZoZ8bBMND
         v9gpF+C1Tua2iKRIlJsYzmkAVVZqoHe6UT56+okWQvcU9PwovznD3T7dNDG3ZV4tP9CM
         fxj8JUNsWzHJXRgFn4y8IxMB/diSDlFVki2exdv6htpcCF1TwouukLHFzS1ZqU7oxFeE
         1zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444231; x=1780049031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7VTTzNgP8kZ4WZqo/Pt6YUFHI+mQOpC46U4p4u8GdkY=;
        b=JwG4vWCtPYeYON6no8vy93f56I7j5JFB3yVgiaA+LkNpmPCXAXB5lkJ5fYlqeHdypO
         lCaVwl6MXKvuK0qdytfYAf/4wtP1ZVnlAmKtMPpWMQRu1h+NTV8VcBk9alyoMgIyY12e
         CPAiU8sCOuihWTUFdYJuAzkx0c9UVe1N7rki/2//nx/mGj07CBuxTPZn/dJ91HeRR1Np
         QHa0TRtOguFPdQoetNSpDCOsKNXPn2wVQIooual7lO3oZzMbnDyDGqdGvH1vbB78uTt/
         qt9Bj6V0/uVhcRsHD/4WzCVHi/y9EUlcu+OjyYKjRA/uV73ybrS9mJbHp6ChG8jxV4Fg
         jN2A==
X-Forwarded-Encrypted: i=1; AFNElJ/Y2Q2ZHm7Qfbtp+fJ+jQZ/Iu6c37H2mOg/VNtXPFjVhyrnQ6YX/5DEmGcj2M6+528if5wrDZUHuQ12DvKp@vger.kernel.org
X-Gm-Message-State: AOJu0YyrF7Jtuq1b4UjfkJprYOK3NJHWqKzaKvXtaVbWBTb5VozXpOiA
	0ChkfFAKZ6IrVko3Xhbz3h2alyhoJXvz7SU1iYao+4OPkEwe4xd6GLs5VgztB3hZU63i+KibhG3
	a7XArQ00Mk2XxP/iMrLNmrncMx2KPiQY=
X-Gm-Gg: Acq92OHQfOXl4YB8I8ZCsCRSLDR4Np1T0w73Tnb3yWup2V5BXoZNyMIbh9XTFaL3ZCh
	pQjypTv0N6pN3c6EGH2bNVYJVdy0LUR5E27vr122bFthir/5NAq5gEb7DCv/ZK4yXNUJiHkuUh4
	/xQWwr+BHuWo2aGfcGSQqY6HATdLI5K2+Bw8qnzN4MqwsnZBuL5dqdYHznVI773jPyaHl3i2VxB
	i4q49r3FyHIuuFQY9S8g3GSzvDOVg+RqrBOCuG/UxYuHfuvfCNcimdw924MKeWPH+HrB7iSMzWC
	jbd1IZXr2xSaZ4bTevZJzEMHKAS2aXNi4HFr4FD6Ug==
X-Received: by 2002:a05:6402:458e:b0:687:8a9f:3142 with SMTP id
 4fb4d7f45d1cf-6889c4331b9mr1337257a12.10.1779444230564; Fri, 22 May 2026
 03:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs> <177922944844.2436629.11205124993260163523.stgit@frogsfrogsfrogs>
In-Reply-To: <177922944844.2436629.11205124993260163523.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 22 May 2026 12:03:38 +0200
X-Gm-Features: AVHnY4IK_mvuSe5-3KT9gh4fnkJ4klzAb59GOzP4QZrEfJEjjgpQOz_XglBlrvs
Message-ID: <CAOQ4uxjJ0eF0vE0hgsNoWqqD+UQ4r-1-b7493cYNPUGSUR+tcA@mail.gmail.com>
Subject: Re: [PATCH 1/4] fuse: move the passthrough-specific code back to passthrough.c
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	bernd@bsbernd.com, joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 12:29=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> In preparation for iomap, move the passthrough-specific validation code
> back to passthrough.c and create a new Kconfig item for conditional
> compilation of backing.c.  In the next patch, iomap will share the
> backing structures.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Please add

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

and please keep in it future postings even with minor changes.
I realize that fuse_backing_id_remove() was changed in this version,
so that's fine, but I only know that because recent revision still fits in
my ever shrinking context window..

We discussed the fact that no one has lots of spare time for review
and re-review is a big production killer (in general).

You must know that very well as a review and also that having
a "what has changed since last patch rev" is very useful for reviewers
and also very expensive for authors to maintain...
...unless AI agents can help to generate per patch Changes
for the post --- notes?

I assume that Agent can do that on a patch set after it was created
just by giving it two sets of patches?
For the very least, producing a "No changes since v.." should be easy
and useful.
Letting Agent go over mailbox and verifying that all RVBs have been
applied is also trivial.
I realize that patchworks and b4 review can help with these tasks
but they are more tuned for maintainers and less for authors
(I think).

Obviously, I could do that with an agent on my side, but that is not
a good use of resources and not a good model to put this burden
on all the reviewers.

Worth a try IMO.

Thanks,
Amir.
