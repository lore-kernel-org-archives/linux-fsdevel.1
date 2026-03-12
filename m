Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F31D5174
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308733; cv=none; b=D98cBMZfW1h4sa+TWhbtHSQjNisHtszA7rSTxUWEWAb5PYjoqk3RicxPdNM97EZeExDHSyPScVZuSguxq9FUuov2MSkFoH9W8hrWe2nT7jpSXYUOZCg79udV3Zu6Broii4CMrRApeqBRf3i0XE6cCEj+nZ/c2hhSLR/U8xVrCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308733; c=relaxed/simple;
	bh=0ZRANUN7UlCukwYQM29Md9MnE0nYb2RsCEQmYpZxDpE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Pne+XMC/8icxoP6v4Rqi5iwHjI1DiC31PU14uHp/RAtlspJNE4yPqWCT7mpBDr2ivCRyN82+YnRIBKqgtyDdlHtz46Hejrc3rBppcIDn+rBoihGyUchia4vxHfZ13w5cZ0KnbGaNWqlzc6THt4ONsX+sody8CEGs2MYOsnfXvN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=nCpB1pfZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="nCpB1pfZ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ab232cc803so4325545ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1773308730; x=1773913530; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3x0eeu7MjizOqKGGJm4T2xmjny18E14L15w/38jmSwg=;
        b=nCpB1pfZElk8JOvn9zteby2BBnel8E9UT1BeI0QqqExRlKKRt/+MaPYSQd5DbVTm1b
         5X3XMQcxh4vts+7qvf8R2CufaVkGr4ZhiObAZEz4bwFHgefMiu8P/8qFRP9tX6SZczi6
         T5tU+xQ5MW+G+2LPl47ubqkb9dF86RiMKZGlYU0NwaXWXG3Y5PJHP4Fe7u0/s1tiOTaJ
         4Aj9U2qunFnV1SZVJpJpUQUcBtapFS0y7o2JY0CRmACdLkiwD+1tpzLR0g9zEdvONJiQ
         ucvzilDnh3Zxw/OGBGK6aDpwiNz2WSAao5+FVvK2kvHy2HrISg33fbcKPexAB1F7D3a4
         6Xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773308730; x=1773913530;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3x0eeu7MjizOqKGGJm4T2xmjny18E14L15w/38jmSwg=;
        b=e4sBwwE0uY0NyRqRoPf9vqXQSDL2in/ZftZUOrZ/FAPQYGFq7gGWuZE86DbVsts8bT
         n8iRrjAsEMaaWTtWyiCQZpyrm41ey1hrUOX+TQRSAfaq8Z09IMzP8hwo129E1OM/TqVh
         ulJ6eqAAZdPrKElsUvKHQvZR/EokvDZcvZceHLJJ14dSM5pm3dyP4m8TReYaDkw80I9L
         Am/URgiyvqVZG7g/EhFb3BSOY4Cfrf/R5twkcxHXZt6aM3XgJDx5DqCDpZgIYiwkEQP4
         Xp/TRKz0zwZMxwZzsf9ZcV8tWqofW203rXsxgAD9zgumWJMoAqaF4hm3lX15CLUVAR+s
         gnhw==
X-Forwarded-Encrypted: i=1; AJvYcCUKlKZFwbfZca19arXhHrjTgAz7lRONmwnU51Mq+Liv4oZ929pR0RrKYxXW1vx52Tck9leHr37SVXDYgbAO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3DQyWNlwjik2IbLXft1KDkylLvUb5EWcnoezqr5WEYCocT29k
	vi6xd0GE7sVNEOBJeoeVultQf96/5ae2y3jP+IVxs46g57M8v9VyesiR9LRhIgz7XOY=
X-Gm-Gg: ATEYQzzVoXjC8rmjhDrT9pUmyQ3LoW5auZCO/TpohMxMC5th4MPEPBuc3ihDLp7Z8tn
	Lo/eF91+M+HnKJVOwn5dh8pjxbXnQ6OMjc4HECvCuFf1i8hsOj6Tp8hWuzXa4mPdQW45K8UwwIl
	2G5Mpc4Y9778MItdH4/RrBzb6Tz0c6EhGnidFhWCds6skAftXncyoE08Tr6uMVzIPc3Jx9BTpFh
	qMjCgklCqQivRxb6l/Msc8jJgFZ2ooH1MWi5lsc6mHgo1nRhue27TOm72eKBltZg/7P1qHLHbWm
	ypIU5TFv7pD/SyLK92LrpyiJkf7C7FkX+b44HoByF4L7uEA/apkwSel5/b/k7PoXGike+x7VFGl
	sYX2YNbIRgkY9Z0zrEppcvoZVDb7rYLg0QgtxC3YbBoG+sssN4Xmfz2UpdKSyTaVNTceT0dtroQ
	50sjH/ICupSyzq4GIhQKUX2NVEitz0VnCSEXLTKL47wVktP2FEXu3wMAhQ/Um5aCSxZtVDs1O3u
	0TWLA==
X-Received: by 2002:a17:902:f550:b0:2ae:3e4a:3cb8 with SMTP id d9443c01a7336-2aeae95301bmr56859165ad.53.1773308729647;
        Thu, 12 Mar 2026 02:45:29 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae258e26sm49293315ad.37.2026.03.12.02.45.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2026 02:45:29 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [RFC PATCH] quota: allow unprivileged users to query ID 0 default
 limits
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260312090810.1145908-1-ravising@redhat.com>
Date: Thu, 12 Mar 2026 03:45:17 -0600
Cc: linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 jack@suse.com,
 cem@kernel.org,
 dgc@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F061AB76-E500-4F78-A6E3-E71A32B04077@dilger.ca>
References: <20260312090810.1145908-1-ravising@redhat.com>
To: Ravi Singh <ravising@redhat.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Mar 12, 2026, at 03:08, Ravi Singh <ravising@redhat.com> wrote:
>=20
> Default quota limits are stored on the ID 0 dquot record and are
> applied by the kernel to all users who have no explicit limits set.
> However, check_quotactl_permission() only allows unprivileged users to
> query their own user or group quota via Q_GETQUOTA/Q_XGETQUOTA.  This
> means unprivileged users cannot discover what default limits apply to
> them.
>=20
> Allow any user to query ID 0's quota via Q_GETQUOTA/Q_XGETQUOTA.
> Note that this does expose ID 0's usage counters and timers in
> addition to the default limits. This enables userspace tools like
> xfs_quota to fetch default limits and display them to unprivileged
> users.

Showing the root user's quota usage may be confusing for the regular
user.  It seems better to filter out the quota usage in this case and
only expose the limits?

Alternately, should users without an explicit quota limit have the
default limits merged into their returned values, rather than them
needing to query id=3D0 separately for the limits?

Cheers, Andreas
>=20
> This change does not affect Q_XGETNEXTQUOTA, Q_SETQLIM, or any other
> quota command -- those still require CAP_SYS_ADMIN.
>=20
> Signed-off-by: Ravi Singh <ravising@redhat.com>
> ---
> fs/quota/quota.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 33bacd707..8b21f3c1b 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -42,6 +42,9 @@ static int check_quotactl_permission(struct =
super_block *sb, int type, int cmd,
> if ((type =3D=3D USRQUOTA && uid_eq(current_euid(), =
make_kuid(current_user_ns(), id))) ||
>    (type =3D=3D GRPQUOTA && in_egroup_p(make_kgid(current_user_ns(), =
id))))
> break;
> + /* Allow unprivileged read of ID 0 (default quota limits) */
> + if (id =3D=3D 0)
> + break;
> fallthrough;
> default:
> if (!capable(CAP_SYS_ADMIN))
> --=20
> 2.49.0
>=20
>=20

