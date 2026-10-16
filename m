Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4B39794A
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133886; cv=pass; b=qUbbHeLJqN9WMkE2dcFgqoJUMioi3sL4K8V4A8FKlYx43hS/sL2tDVp8DKenbeX2QmH1xT1Uo8XJgM6I5P26O3UKpMrikhKlOPHgdZdalqGvEtLJEEJwsQ5Lcr4e3DXC5faVG3sYif4f+Ib6xOi5VZGhWQfNsd/f2+x3/+4jRn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133886; c=relaxed/simple;
	bh=U76ebMoSyTQsuVPgYGLotffYpp8DopeIDr7nhIKrbho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fREgAsIskz8V/KwJJ8PYxhommmUEGKUND0ItYliOC3h3XbMT45aI7Ks46iwgqDVVLIuRb8kcRIDT7JmOj+0r2nc0EH3HpbavHVFnBivWpmC0FjszSJSzdR79t/tPM6y3cRVwRixB7mW6lB/7ZPpiMT68WNmCU1xLgLhzZRsSzQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BugadP+j; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BugadP+j"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso3564436a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 23:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792133883; cv=none;
        d=google.com; s=arc-20260327;
        b=bnTAMJQXfx4s0M+U1GT01M6SI/GTH5wbnRQm6+vDFzzMQg1YHBnMHBC+ivH1ZLd6uP
         dPk1H2pepQgFjnws4KU9Wy3q/Wj4yy0grT3weJTkLXN9xVD5A5UM+kmGR0Y7gXBJJroN
         f6qY2fXZ2VRF09vX8QhDnXnVZx2yjKkmVJzA8z6H2gO+aXbS6A95JcDeNJV25DY2y17N
         h5NI5CSF0GPKHgOiZt6mK2jgmsfCpRc5025pw1F4dhO45nOgO+jm0fRbz1E4GXH9L6+v
         AfD4TPA7O+j8tM4XiE14MszPcd1DsbgcW8P07POZjJhwOLdorDo+zM/gTE4tFiX50cVm
         cFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SLmKggqak5/Dj+cuhyZUgxKGUgEOUrXFwflmJJiDsks=;
        fh=bBsgM7hWG2FuEBPuQnDa1uw7bWrTlDyT/Qvodr8SIUA=;
        b=E4rIWo/5He0HrX/OEhaTMsfqu+CiApDaLmXzIwKUEV9BnS1hCaESz9BAdV99orJj5y
         QmD6osgtQQiOFNrVLP8avgJEnuCfU/0OH4HAYD9+3olgMmSmkP4TGEseanYDFrByIYdU
         oIFrK/QatlR87vVWcCun3u4DPt2S4tjzxVclrdzyRtytEko2LgcHbO1bBQMS1e/83hrD
         DtJ3Jstbyj+dTVz9QwOszBcyhttFLjrAkcyV/nTZPz2qgUaL7vYZ4gsf9qWThT0wmAIx
         yt17kXRU835sy56N3icfskQsscan+XcNvePtSBNunTrdqjxMDfoXkqu1Cgb1yxWhmtM8
         IntA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792133883; x=1792738683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SLmKggqak5/Dj+cuhyZUgxKGUgEOUrXFwflmJJiDsks=;
        b=BugadP+jf8T/v67A/JZWzdLRyW4AdJANwF79NplWKBXhKgdrT0gT+DKp9Nc96q0g4i
         7SsTwmyUVBckHll0pINvBD6Kk9lE3rYk41B1Rc8/pVVxuxfXEP7T3Hgqd6K35uebzOeU
         ftYZo+a8UHNm5Dmj/4/QMnDbLDbaybFVxQxqNjUy9h47XJ1LW8b8HtDpiHCcQsRasznw
         cvlaB6v2dNUcYfOotwIvATL72CllhzEMLPQh2wbFjQ9Hf6uILynFO2XQxabhETwzE2+Q
         I8BTsP/VqZk500g3spKzLYEheOgoVX1iywgT4m3F91Nshu00qpYPudpoDlGrwKNA/55H
         JXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133883; x=1792738683;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SLmKggqak5/Dj+cuhyZUgxKGUgEOUrXFwflmJJiDsks=;
        b=SdJPsSse78WTBw0GjeRi0985XPKxL7D1zxuh635d84oItUiroQDkjuQw68hpTI6Azp
         20P4prxvTzn4Gc4OyLBlOaSV2ttS+tNHF0PET/4wTIDNpg7tq/KtqUdxGOsGUCEv8Y0g
         qFpqCczipV0v3Wz7V4/1f5wfN0GVQg5A2N+XzUDuzG2nRspnf1zGERpv8GORA8UJ8Rwv
         MUL6VprOFm2bRvQyooDY9177gJkKuxz47MMFV5BunLseS/OL1TuC2Rjebpn4ItNKZg3l
         5XuqQ9kWn14JXOQZLDEJ5RRzuVzljiwEoWEU3lHKLLsz0pFEbdoxNwUA9Evko+B1N+m5
         l/2A==
X-Forwarded-Encrypted: i=1; AKwUvBwSE0PtbNRMnEmgWEHVVnNNr1ENDIRc/BiB+70/drsrFqRyvcjQNOYf0FKPNvDgbEUgkIJbxsmJqUIRUbcC@vger.kernel.org
X-Gm-Message-State: AFq9FYJI5PYfkktcjFEl4+cvQWsIqNPPu1vM/ft3Hc1FJ/It1x/2Kzf4
	rZ7MpZ5UUMYHztPScCXOqVNKCq4HeANUqFKkgPK/PTNs9Py3nPjtpIFqcgyTHnbYNj4V2eo5tdK
	j/K71RekHZsxUaxACVeur0yuKZvy+lM8=
X-Gm-Gg: AYBFou1jHnv17Zm/uOX5J1YWsnjoQg3j53tCN4UIk+q3DceiGv6VVPGP7wWWh3kFygl
	K7YAELu1yIPAimwo9+TTTg3lrgp8sg81Y7cVx2QLiEwA85AHEwKFb0JTJAGcb1PuIEUpZrXlyEd
	i9UcxXbISragFs+YB89cJK++HLZcvVuQyffWX29Wjmw/+p2VcdofKCGCopABjtVcwo5sbCmLT1B
	3co+r3DOdrQksK9xOl9/++ia3zP4QDSRpG+9iepTU9bT33bT5D8NgxWA7v4g+WHvznV65n1HPV5
	FT8d5iiwWNMLJ3G1SYn/vJ10ys3bD6w0fgvoPCZP5LiEzcmBJ+XiZeQn
X-Received: by 2002:a05:6402:5006:b0:6ac:fe75:16a with SMTP id
 4fb4d7f45d1cf-6b17c21c293mr17047655a12.1.1792133883273; Thu, 15 Oct 2026
 23:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002223746.3248726-1-neilb@ownmail.net>
In-Reply-To: <20261002223746.3248726-1-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Oct 2026 08:57:50 +0200
X-Gm-Features: AclHuK9MH6B6PzJPsaSzlLYudYyT9yvA5ySybSRksoXyZI_T9lFw0oouAp4jzR8
Message-ID: <CAOQ4uxhkGPc8Wiik61_9-u_Jf=gUx0Z4EDaW1z=FMhx73oE_eQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fixes for dentry lockdep tracking on stacking filesystems
To: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, Jeff Layton <jlayton@kernel.org>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 12:41=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> The recent addition of lockdep tracking for in-lookup dentries didn't
> take into account the needs of stacking filesystems.  For this we need
> different lock keys for different filesystems in the stack.
>
> Thanks,
> NeilBrown
>
>
>  [PATCH 1/3] VFS: per-fs-type lockdep key for dentry in-lookup locking
>  [PATCH 2/3] VFS: rename lookup_map to dep_map
>  [PATCH 3/3] ovl: provide private lockdep class for dentry->dep_map

Christian,

These are fixed to the series you have staged on vfs-7.4.lookup

Best append them to this branch per PR?

I have added my RVB for the ovl patch.

Thanks,
Amir.
