Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA9E33D50F
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773877624; cv=pass; b=bSKJWMgXQpfumnkbQawdByDJ6TafPPC/dSo9emUm025Np/Elvcpvhbba/y/YVAFQ2lOnw9SuFKh8EAKtB4N7SSsJcUMgm7JzbBBKzvMSOB8IfI0bSVBZAzrA/vxpC488H2zVZI/5HR6xv/vIcITMmb5ZAZk+V4jLrFAuD0biRVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773877624; c=relaxed/simple;
	bh=goPdRYRb1QYfjLs/QmPDwV3Kh5LoPgcZM/xi+f3fGd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIQW1vd1JpISY0/46IXDHjFOQrnDJGQite0/srlBBR18V+nK8QoBgHMiOyjG4EuKqsTjvjAo8/Tjf/LOqQoNgD1Sh0wADKd4AK6775qrbq8OZorz1tASOCxFkrQiViQkVWeh2dwJnyLBEsYu/SB6+c5gg3i1kpIPezBpFPXMG3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AKLsHbzP; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AKLsHbzP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso1641595ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 16:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773877622; cv=none;
        d=google.com; s=arc-20240605;
        b=bmyQzvy+H0JiXmtZIj7+82W18yqSMfOFOgO1M2MMPF1fybkxvWnRL3zKtwzp1H32ka
         q1PEiceL+Ah8S1rjqeyP7CPeVS3/fmCCt7DMUVkbxZMIjgXbDGLY/cAfGPWXUW7lbyzw
         b87IXIAsbb3iimik7rqFKLmXRnoOXIHBNXo24Zl48EiuHpZjg9nnqRLpDH5ewoCA7fLe
         O8vtiaULnZW5h5U76GxrZUlr1FXzgGN0OivoejYrfFJxENzmqIV3E2G/iCBenCyVYN9F
         x7/IJ7bvaGB1eLf3VVVlrIarP4mdeUT17N03/wp8x8Uw8jwmnzh7uh9mATue+sj1Iq68
         CmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
        fh=t1zMs4wbl/4cHN0INzgLVZP4jpF9KG9GbVCjd77ltaA=;
        b=iprU2+FnriWCDBHvbnETeyyIDrLIu0pvBB+kpcZLkN36LhQAwhNSVoNMeONp5Z6dX+
         SQxsMp3vSwIrHYWkZtVpSTp1sarTBrxqTKh8HbOw6QqG4E9EOR0B/AO2Cr6hSFSmEQmQ
         3ild3wIJZGVVZVog5b4obM8j+XOuPKIGQRPSWfSNroGbifuHGZ28+88p0TgtDnVkxxLy
         hx6nikM6y43om5Kf8ZTdKOingj+cJfnyQKd86o2+ToqjJsh8vYZNOjITGq2nN7pFTB4C
         hfhCn4yY/Bl8KrHuX0E0OewptDNXMpTTdNz9Fn+3KpPilYaYiWJxCCcCAv4OF2cq5/40
         Sjfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773877622; x=1774482422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
        b=AKLsHbzPe/UFGdaly4ZmKWfwEwmrHjd1DkZL4IVkQuzIErZyEfHo63QiPdDZocQ1er
         TDQuBHxvJGfj7ByZiLM4PkfV8rNk5V/3NumordXmOjXxnaeC+X32rN8w4u++FYqMJ922
         qiHl419cOnkMprBN228Xaq+2531KkoPltl6Xoo3Vp6WW2pPtOlttG1dg8+rgq8J+7Dml
         4EjE2vHGePmPhTt2w4gTd6ctMcC6LeWCMahkdppjXGiyBMeMN+uX9UjHwZhkMaO5oXpt
         utlaZH6uQCma0rd7bqSMOrjCIguHzeb4LLkVoaJxpS4oP3XYJDepNYXITJJxfvyktN/S
         yLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773877622; x=1774482422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
        b=MUCoE1V4zXsY+kwqE1N3Y4y7ziUs+InSKoP7rbXPf7lmA5SWqG5CbewgL/J7j91QCN
         Lzs1HAr+/mzU32JuloYtSTOfTyavFH7ebYbJes4KK2h3ZfFzSxlnhBzwzggHR/LAa3eJ
         JNMd63Dx1MB2UNoU3SaTPKzavgV/h6c5ssru8WdYC+0HSOZ6Qpfgclq7C5cdrN+D8Nvq
         LaMG8OeBfvK3C38mQ5farb3oEDXGeI7PAY2WTbHwmpyiAI6vRBymKn/pXVI2znmIV/XE
         J0GHytIDnmZ6xJYhuAD32yNdicWZ/eM771rjomzHiR11x7pgvgI/4qIYSvMcXZrfRrym
         l9eg==
X-Forwarded-Encrypted: i=1; AJvYcCUw2lIEDSqmR7bzMpkOLqKyjAuz6hGGOImtyPBNpeaft/QPv+3jTbwPuF5cpM1uEGRQL7RqE4I9sey7ThdX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DJS5qAyU1aXpx7qtOXN0ivJXGj8/yMNLPEDVVzHOyFMsXzY7
	66qUtU2PsjiYfoNGgDDnpS+KsxX+5r4Sx/HrN+3YNjbnEO4Eus+9Zemhhc82Uh1yvzCjJOIzsF4
	PUjJxQ53vA2Ji+jw3FlTI9X8wLFIB9Di8hZ/jg/zq
X-Gm-Gg: ATEYQzzeoHXpD4iX7DKdTZb/6S6WTcCA7q/fzwg7BYrjnQMLuxWE7sCxlJHtYlkKeAm
	+GW1/e9SAtvXdR6fuoBZuhcZeiawlCLxQ/4b0HOG37YbBsn94pXIKhnHxPPP2J1GdxiuFlY/e/C
	5H8tpnzs1aSTDgKuJ24Ib4+XxMneQQcaUQMf2n+hROdNOgbRUX+16k0sPUONuSxHVpjwL8ft/o4
	BjlZLNgBuSjqj9LRRS96/lnZ297OOGoWM6A1a5YLd1fR5l0IFxbqd6YvO3O9wME+wNbLQz3MztL
	ZOfJyzs=
X-Received: by 2002:a17:902:f547:b0:2b0:7177:d5e5 with SMTP id
 d9443c01a7336-2b07177dc04mr35425715ad.43.1773877622532; Wed, 18 Mar 2026
 16:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318131258.1457101-1-amir73il@gmail.com>
In-Reply-To: <20260318131258.1457101-1-amir73il@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 19:46:51 -0400
X-Gm-Features: AaiRm50UCF1CurPQjVXbzqdFj4rL7YmqoTti-AfxH9o9diMwAaN1iIjAFrpAzkY
Message-ID: <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
Subject: Re: [PATCH v6] backing_file: store user_path_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 9:13=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Instead of storing the user_path, store an O_PATH file for the
> user_path with the original user file creds and a security context.
>
> The user_path_file is only exported as a const pointer and its refcnt
> is initialized to FILE_REF_DEAD, because it is not a refcounted object.
>
> The file_ref_init() helper was changed to accept the FILE_REF_ constant
> instead of the fake +1 integer count.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Christian,
>
> My v5 patch was sent by Paul along with his LSM/selinux pataches [1].
> Here are the changes you requested.
>
> I removed the ACKs and Tested-by because of the changes.
>
> Thanks,
> Amir.
>
> Changes since v5:
> - Restore file_ref_init() helper without refcnt -1 offset
> - Future proofing errors from backing_file_open_user_path()
>
> [1] https://lore.kernel.org/r/20260316213606.374109-6-paul@paul-moore.com=
/
>
>  fs/backing-file.c            | 26 ++++++++++--------
>  fs/erofs/ishare.c            | 13 +++++++--
>  fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
>  fs/fuse/passthrough.c        |  3 +-
>  fs/internal.h                |  5 ++--
>  fs/overlayfs/dir.c           |  3 +-
>  fs/overlayfs/file.c          |  1 +
>  include/linux/backing-file.h | 29 ++++++++++++++++++--
>  include/linux/file_ref.h     |  4 +--
>  9 files changed, 103 insertions(+), 34 deletions(-)

Still works for me.  I'm going to update lsm/stable-7.0 with this
patch so we can get some more linux-next testing.

Tested-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
