Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53F3655CD
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jul 2026 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470378; cv=pass; b=kfDQrtjcfLayGb1TCxcmd8jYQAWiKF3FxYl6feQWwm3lrRZtNWxidSdLogQNxN2v5VZSDEQ9WSWoU+L4PqW8N8BbInLArP9sjHSoqeYEyopdW0ehVyAUYD0paj1GsE91Czv37LE8ePBbZt+GHkSJUzp4EWBh5N4ItrrGn1xcnj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470378; c=relaxed/simple;
	bh=Gf39QtDs1NJUG97yBMAnk9ZJwy/ZHg7aeBsaEUjF3/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QH9nIWSifTVJrUe0pDAWXy8UstfPxzoycrxPIwsMxR3YWDBJ3VL52UN0/ohBcHRYx1f8xDN9tosGS4kuFfhVwkbQvwBhWE9xAqK6V9ZzuNXIMvpkbNe2t6aZp/KDHibAW8hkOoJNDh7zqKkcE8mEhN8rUHzcBae7C9MVBtorWPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=d9wy5ZKV; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="d9wy5ZKV"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b01146b205so6898016e87.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jul 2026 07:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784470375; cv=none;
        d=google.com; s=arc-20260327;
        b=Zp0VYoqRcxL4xVG7yUTyQ0TQXVpvyEifO0m7JBxRJwC2V4b9A8VP6ttvmWACSnBIbg
         Z7Ou7oXE6xDScABUI3DsDJJ1i6JtRRtPso3o+Pspt/gz3bhNnWV0PsLVehvjlDOIHnhX
         AVN+s6Wxb5pgUtS/teE4oXehLygFlsWbY8nwkaTWz9FbXJEJhKuqOjO9TnZ80B8JVIZp
         uYjfstayA53fhcNAUUNeBkikJFlAhPhRDeRFyjlKkgVKPysIhfdWF1Fdbh38wqZQ/h4r
         Lda5Bs7Dha49dHFuDPttGfWmtRWBCnnTZXvshNyLKJn4MyH2QZE6ebKcKGC5yF/HBa02
         XLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8fnfVrhkwP422PxO/5FsFZHAUY1r3GNO+87kR51xMWc=;
        fh=5crp7xFHrfFyk67C1tHZdxx37/cNrXRJD4iBQmc2at4=;
        b=j632vQFoS6DCoF0kivpWMRD3qsdT85m16XkmaIwKtEB0BhEK+pp5Z0tJh9z/ocGRXY
         yxjmHY/PmZm3dX6IFl52xgGhbQ8Lx+BBnBafJ/45Yqjfq7b6euJB+6M9kZjD2uD5CNIC
         JyscoTjwJ127wWLsPeASvx2z6kmMDZsRbMMqFM1vgmS8i4YAjFcIwXPVLxRvVYO3jqD+
         Z4yAv5UUAgU0F4gnuspqqfI02AtiMxH9BcZ99MpH+EMRzRCc+FKtnPOb+QlwY3bLSreE
         GS7Lc6fSPYwoJYTQnQBJFHs3D0eYIehVdvHHN0LyiUij3zh6nldNMagrWoUjWMqgszeh
         M8cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1784470375; x=1785075175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8fnfVrhkwP422PxO/5FsFZHAUY1r3GNO+87kR51xMWc=;
        b=d9wy5ZKVfznR4qbSmLHM5wLxuSjQRPGy4i0VLYQtK5dLLnwGkRiddDA/VLgetiMi05
         Y+I5UVuKvV9E3SM3HWug7hMlD4PFdtZXvAOxx5/lQIh2bzY+pz1wpzt6Bzg0w3hILDMW
         e3GsK76nCbgIptHRnYDLRt9rCOZy8ameABUXCEZA8dK9EblMfR74xzbuPGYobV75OCGT
         5dmKGa4DA83unOer5/p/6wDrCqXELBQgzfxOhfojRcG7ht8/0nlpdK50hruoJQPTrjAj
         m2PabkRjHvH6MgKwQzHgdBgP8HHyIdR7r2EMuqKn+CkNA0aIbcifu3rVZlrjzFttBdzl
         Ph6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784470375; x=1785075175;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fnfVrhkwP422PxO/5FsFZHAUY1r3GNO+87kR51xMWc=;
        b=sUTz212qHEDMX3Ks4KLkuguZWnsrV8xWPFUvwavWSeWlFs5wZdKO+NduqVO9XZ/7C9
         pj9mVKpNcRV0vt5HBxRcQnq0eensjxeTbE1OTKuu9AxS7a7sKZI4cqhNQwGyktZywiuv
         1auiYvUSa8yQsOR6I+4ppqcQkbN/M4iTbmkXvCrcGZ8wksJN2RMfH1hPOumqIJxOOOIX
         RlfjDllbWJptvLofoRQcxi2IK5mcxAP8hADJxMwIaxTJ+U/HcuVr2fKjMTCB9wSDnpV/
         UIjwUNoHpslKNnyZpc/Mm1WFdOkVw7iSfX8V+da/21qths7kM/oM0PF5IHs0bPhtp9qR
         SgkA==
X-Forwarded-Encrypted: i=1; AHgh+RpEncJrYABovoDD9uOo1ESbvAaDGbDf1oDiyOLNP4g7VDR74ig43502aBx8VC3o9SRpb+Wa/PZui+pp8Emb@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+Y/SEN7CQoskWmWSBI0t1T1K0TAwQy4yAKEbKBxmYYbswQtK
	dcaug2L3noaGlfmvCjtFhkdys2TBu3iEE5Hxe2DSkwAtGApC6tOMSOEuDBwqF3/GKW0KL0Ho7Wh
	D+DvLqR2VKA4eNg/B+O64YV8q5+TBYM+KGQrGDa6j
X-Gm-Gg: AfdE7ckNeGskFjhdtmiutmW5hmZ0AgjQW4kp7zAyft9f9NyY1G6S+vZ+UULw7YPP9eH
	t/Vm7D0VZQ4j0sXqr+LBkxWh2toc6FAGH9iM87ROjWk85htTSV4yKJMRz7f35Y+XZha6o2V8o3p
	xOHEqKa4pTTUuUi0btMjirhzC0B7+uVPiEKulpe54pA59Ku2v2Jm4Iz8rN40FHB41ORdA53I+/D
	BefKjVFIlZ3Qk3vFSlFhdNMw/f35PfLhZiBpPUn7VkkoI8AbtGun7bwLPY=
X-Received: by 2002:a05:6512:3d8f:b0:5b0:1879:1ba9 with SMTP id
 2adb3069b0e04-5b28f9a5720mr2256451e87.33.1784470374426; Sun, 19 Jul 2026
 07:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715101107.973997-1-mszeredi@redhat.com>
In-Reply-To: <20260715101107.973997-1-mszeredi@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 19 Jul 2026 07:12:42 -0700
X-Gm-Features: AUfX_mx-VrWAtPNuDviKfVjbn51tqQht-nWAXr-HfoWBbjn3eDOh3hiCtUPefpg
Message-ID: <CALCETrXYHX+OSwm6vhzQqvdk9Fkbxzh_dGuVm2tjvPJG_x1XdA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: allow opening overlayfs/erofs layers through O_ALT
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 3:17=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> This is a prototype patch. Needs to be split up!
>
> 1) O_ALT / OPEN_TREE_ALT
>
>   These open an alternative namespace rooted at dfd - instead of resolvin=
g
>   the path in the real filesystem, it resolves it in a virtual tree that
>   exposes metadata about that file.
>
>   This is intended to provide an alternative to adding new ioctls:
>
>    - provides structured namespace
>    - allows accessing data through fs ops
>
>   Could call this O_META, but O_ALT seems more generic and there could be
>   uses beyond metadata (e.g. seekable, in-place decompression).

This gives me the willies a bit.  It's very cool, but it has some
potential security issues that I think we need to watch out for.  As
sort-of prior art, NTFS supports alternate streams and Reiser4, ahem,
supported files-as-directories.

Some questions that we would need to consider:

1. Can you open an fd referring to a "directory" within an O_ALT tree?
 What happens when an unsuspecting process gets such an fd?  Can you
fchdir to it?  chroot to it?  clone its tree and possibly bind-mount
it somewhere?

2. Can you bind-mount *onto* something inside O_ALT?

3. Whose creds are used for which operations?

4. Can you mmap the things in O_ALT?  Is this determined per object or
generically?

5. Would we ever allow FUSE to expose custom things inside O_ALT?
What contents of O_ALT can a program trust come from the kernel and
have the expected semantics?

--Andy

--=20
Andy Lutomirski
AMA Capital Management, LLC
