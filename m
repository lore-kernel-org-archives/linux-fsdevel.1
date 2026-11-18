Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795002784;
	b=oJmriGG+M6Gml76O9P1Zr3z0pu0iwMtcBr660WNFbEjK7inImuHL5WzuX4uIMr/s3xES
	 SJNJGDoyyJTLS4S9Nd3ivRlwVXp4qggCuzMv2dCxpZ4MSdUC1m9rz+wpRFY7Xm79fG77C
	 DEyWrFPBzzB2tNYOS0BnWyhKqdwLXkg+v09+gWX02ZqNksN8fis23NU6ibWUmBhgKUGI9
	 0Ro/CWhhXtdXloO4DQn7sWs2tijta/qBMh6JUmRlSZfKOun97bh8ojgDRGnvg0qh4wtT+
	 HY9wLOWCXg/UjOCaW/ofn6flcvlJp6qPUQufn88WDTLxsKcJXRmmuowHV1ERp9SbV3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YOemy4vy8MWHVR40UGX19+QReF1uG2SByZYvNpsd4oA=;
	b=Z6WkRBRyrASPlcaU7h8PavOtvzYBKWjZx8o6kQ/PYUCWXxRTPhJ/Ne43yBOGeH4QbuvF
	 vJHgQvmU55SA3xAbeTqIeKFzd6QH+ttTY3k2Sd4mMTd2mOmG2ZDs0GuBlVpCd2WZm9GAn
	 RAVGxwnA5cKHnEvYJkpgvv69P3FAu6yx7gFAMU6TqekSJJ9esbf2wjTlsJyV58xJExaLt
	 NaWAEz0Alm9d3eAfslw7/XZMrJUbUsClUCRx4liXlkg3VQk7SeyUwsI6vs/GIwDAfKmlo
	 10VhDMwluhgMf9ZNbZ0nZ1aD3cVM3tqWUwFJekEal6KJE292ahr2IEy+07o6rRx8BHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=WQuSux+g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1A6606A32A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 11:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F1A6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=WQuSux+g
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55ade1de0b4so8814451cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 03:53:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795002782; cv=none;
        d=google.com; s=arc-20260327;
        b=YaWRsf88tmsXvdPZizUirr1Rcc3gn4Sg5SGirfVtB0348x6mDTgK7lJWKVOv1lCkPP
         d4r0ewjZSd6RZmSkD+Qupw/XtzjFXiRv59lIkbs3+4/8inCblVL2O/5RvsN3WPbPiGQt
         sbROHaT44c4gT2ckp55sgHlfDQIsbnxwhiYWq9yYNQXHIRkxeQQChiSff6/G1U1dOjD8
         0PoVhp2y61xbbkhdoicUNtnmdE54Dc99t5EVE9q/wihviKZj0l3K+yYZdS7SChWFgNOv
         FVha5T8rYN0a5I8ixW0etdAfmoW2rDJWSXHY7PxTtsEbMkhmdF1ZbkOTEfPr9SkukTwr
         0nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YOemy4vy8MWHVR40UGX19+QReF1uG2SByZYvNpsd4oA=;
        fh=M5Mih3EH60RFx5hUp1F5un6i6HmfuLHRDkkbBpbHNGg=;
        b=TMHjeDBM+XLbuyznCD981XlIDtVK7nWmq4ioG3n8rOyvi3Y6DO0C0jB+oTvEF/ML4O
         7tO4sSOunBj3IM+HmTthPXBwlT/Z2MyocCTCp+Kg8TaKrDqPyv100iAOERuWNqEN4aM4
         kjYqVtu5OBpviiGEC4uClEteE8XtC6gtUv8kc7S6nVboS70CmM9oEBvl16nHKgw0Rlco
         dmygII4iGs8i6XSYzyK6lTkjwcf6hdK9KVFqiLa7iF/ffr2Ho7hu01Q0I/2TJpmBXK67
         SpwR/KJ5PjuiTsZE32VIpe5o65jEX+Wv/CQgfiNYcBZk8Eq4Rk2FJO5nEvXTmhJGg8Wz
         aTXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1795002782; x=1795607582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YOemy4vy8MWHVR40UGX19+QReF1uG2SByZYvNpsd4oA=;
        b=WQuSux+geT4BihdtfnZi6446nTgtD5+9/isM5YP/X7fHClnPhiELyMYopCdszDNrhC
         7DBSN+dE6I3Y/8FsMUI9jWhoYTSzo0ufLcPJvvLOA8f5NdRthvfmtSXFhmu+5pyle2om
         7XRHXksLJr7ad1Ufey0e7N20tYHCH8oXQVhLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795002782; x=1795607582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YOemy4vy8MWHVR40UGX19+QReF1uG2SByZYvNpsd4oA=;
        b=QdkFn0gutjA8huCzoxmzXsCyOVcWNE4Wu/HYuDfhgoZ0U+/IwUo3aNrGRAVD6z9BiL
         1nZnq0++9VST87x1ggiO2ggYBJHxqKUIeAgxHhstbK+XP7s+Tx1Lkmf1hAvjNPK01vzL
         xVnerlbvPX0SPn+QctwNgJJagwabLMt8lYIyWSPv/4atqEuD3KuYddrq9vyvjuYZChmG
         82AUGBtjVxSV7CEv7nLjYV2fbvEumvr0V7/8dB4U5iYlSt3GZ06+zLPyVm+erZ52bcKv
         F4PgsTQ7Lg9+DUhxNzU3+m279CwvoE329ndtsuHfP+rqaHofIqCJ+FQiDxBKdYU6I+j5
         SCIw==
X-Forwarded-Encrypted: i=1; AL+hErEaodZ4mzAKfdAzVqkJYa6nIxjyW9KHHdM5cZtzEctDa6dxjI5qFi+2AJM5FRCAD9l/JJcyKHQNIekTtO25@vger.kernel.org
X-Gm-Message-State: APuU4Z9fXDyKzMYWcC8tgot7z/7tYFmzqy365itLqOAWO8W01t99Ry5J
	Mhi6hQMFW/6KmHQs2FchBw8C+xPdvK2TqCuVNrHffA2gamFBw8HqzuBk/Xw2DFHn5BhM178CPFe
	xt5pNsrol6KsOr9tTqSA1MD4Wfm7aGSv+nj+Nk+OMZQ==
X-Gm-Gg: AYBFou1IJYJt/+Il7PGsWBA8flTG50h5qg2/K5MfcXBgw9U6UdgbJLlMeWn5+pTQ90+
	hpaeZToAgfkudBfZBfIBDUsNBKhAu5G0/7Fkh8flv4SLj5AKXwMe30ECeO+xkkCOjwU2VxVaab0
	yJgbV1ancGEyqsp+70q8JJ3XHVCy8AnCWAEmSAXVC89He4L/D1j+EIdEsQsKfmOhd6HlFBl8lGb
	/kAoyQ165lzUxgv1Yf9xAkmm8MdOZwRCFVKMkxA2pA4sQuDsvlpkIIdrGIBcdJF6gXZf0DWzb7K
	aTexnXmOyqL8wloyDJk3Rfl4dRwCk6e0FU0hDTcOKGWPeIK1fV61j+ZbYxKrl6r9OwEqFgw1Wf1
	3meqit9x8hUha/2N5h1gscdgojfe/U0or0uPAhy9qhUti4zzWrqfHPrODJ8VZ4TcdX+YCZNgLr1
	qTp32l25Qs67Q=
X-Received: by 2002:a05:622a:1b9e:b0:55d:2d44:9ae5 with SMTP id
 d75a77b69052e-55d5a5543e6mr34027371cf.18.1795002781647; Wed, 18 Nov 2026
 03:53:01 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260903132636.1113789-1-cui.tao@linux.dev> <CAOQ4uxg6_0wnzBmA+-rZeADBTKwLsWFdEM5ZVGa6YvWX6mAGXA@mail.gmail.com>
In-Reply-To: <CAOQ4uxg6_0wnzBmA+-rZeADBTKwLsWFdEM5ZVGa6YvWX6mAGXA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 Nov 2026 12:52:49 +0100
X-Gm-Features: AclHuK-v802KVD0LHoWjY5iM0tjQ6zHZvpD7dHxxWrixnWgNNbm10gK44m_ypRE
Message-ID: <CAJfpegsfjfEamq5=+0Pu0+E2EFRzf5Yk7iSp9-z4kved9jNjLQ@mail.gmail.com>
Subject: Re: [PATCH v2] overlayfs.rst: clarify the scope of file locks taken
 through the overlay
To: Amir Goldstein <amir73il@gmail.com>
Cc: Tao Cui <cui.tao@linux.dev>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jlayton@kernel.org, Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Sept 2026 at 15:51, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Sep 3, 2026 at 3:26=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wrote:

> > +Note that file locks and leases taken on files through the overlay
> > +mount only provide mutual exclusion between tasks that access the
> > +files through the same overlay mount, and a lease taken through the
> > +overlay is broken by opens through that overlay.  They do not
> > +conflict with locks taken on the same files by anything that changes
> > +the underlying filesystems directly, so file locking cannot be relied
> > +on for mutual exclusion between overlay users and such direct
> > +changes.

Locks: completely agree.

Leases: independence on overlay and backing is not guaranteed, as open
and read/write/etc. may trigger an open on the real file, which checks
for conflicting leases.

Thanks,
Miklos
