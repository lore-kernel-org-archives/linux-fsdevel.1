Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D542E424F
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713502; cv=none; b=mxmFVoKC02OH8TAeVJ+hizPl8O6lne9WFdlRMUOPcgOhmCUxiE009MBB9biBcGRsa3aoLI7drWpvpmZh9lZMa0DXuYneGG0VE4SX81Ubtgp1rVmyCfxYa/mUCWEKQ3WwCfJ+YZV7n5PzyiJpjpB2wRFGMVA+VSbmgK26Rvb7JgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713502; c=relaxed/simple;
	bh=dVWjT8lXSlHpZbgobFE0J0uVpfDEeFE3TGrURuS5Fr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aalG357HtyoX90Uk/zMGmuf/5ZNRDTSfnvejBKw9TH0rVHMT6FUuYPIUsYhICDiYPb5DI/+5NW5sw7cTQA9i1ecoCMkJVxT9QJWOu1HFhQvnUFW+ubafdaasIKhYUmCexKpP2UrOF0cJuYrlaa23K3DvLvoMUT20I8H1IbojbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhEeV23g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhEeV23g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C4D1F00A3C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779713501;
	bh=dVWjT8lXSlHpZbgobFE0J0uVpfDEeFE3TGrURuS5Fr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IhEeV23gufY9bFO4CanzNGRS2CW8TRSqMljMbagXp+lHijNQfwBz1c+dJ1bRJMD37
	 hocxBWVtqBSGAYA+CP2SUXFb0l/xj9+es63QnbiUyL1uU6Us0waPfuzx5NCdDsp+QP
	 dX9McVCCNunVJzj853c3bncgRh+1cJmCgIKP2J+EtfS2CzAmwndYmJ4UHonoOXlnUe
	 8QuGmtlfQP5+gVNLSN1CuODIAGSj+LrpKXGxa38anx3EFZdGkPU0gqHbI3jqfaS6Zr
	 /G1p6ZXjNh2zkZRySQIlZ4rKDwev//UTr43PAmG0m+L7ou/xbULXExmSSKYRNVpF97
	 nFjF7JOrhR63w==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd3d7c29b4dso1371026266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 05:51:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Waq4mLRTaVvzOR5hulQqCe/3B4SYVLdSVF+lS+U9jpAAv3Jnf62R9UY1ebPmX7315R5aqnCdYrhn/6PW2@vger.kernel.org
X-Gm-Message-State: AOJu0YxCyoxew3pXF7sVslEqB4F66KbnrBiXvZQ/3A3x0YBKhA9EPjXo
	CzhChuzVRY4kPxAppjBxWulUKF9g3QSDt2QWnbAYNCbfoocftPsdhU3vxlogtwbw37vJTmreNTk
	RnIcrrGjJdbAeA7IqiKlCmOOAgSTZ2Lo=
X-Received: by 2002:a17:907:9729:b0:bda:56f5:a27e with SMTP id
 a640c23a62f3a-bdd229447damr796993766b.6.1779713500060; Mon, 25 May 2026
 05:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524054238.3129288-1-charsyam@gmail.com> <20260524054238.3129288-2-charsyam@gmail.com>
In-Reply-To: <20260524054238.3129288-2-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 25 May 2026 21:51:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9L4=OXHqPkroga==P-EX5xM9uJJ=MPY3NW6pEsJf6ouw@mail.gmail.com>
X-Gm-Features: AVHnY4IzvZG3hsdqQt88oqpPZgFuWVyD_ZL-5Q_dCMBBmFn_VDYjak7GXHRCEJY
Message-ID: <CAKYAXd9L4=OXHqPkroga==P-EX5xM9uJJ=MPY3NW6pEsJf6ouw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ntfs: free link name from ntfs_name_cache
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 2:42=E2=80=AFPM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> ntfs_link() converts the new link name with ntfs_nlstoucs() using
> NTFS_MAX_NAME_LEN. In this case ntfs_nlstoucs() allocates the result
> from ntfs_name_cache, and its contract requires callers to release the
> buffer with kmem_cache_free(ntfs_name_cache, ...).
>
> All other ntfs_nlstoucs() callers in namei.c do that, but ntfs_link()
> uses kfree(), which mismatches the allocator for successfully converted
> names.
>
> The conversion failure path reaches the common out label with uname =3D=
=3D
> NULL. That was harmless for kfree(), but kmem_cache_free() does not
> provide the same NULL contract. Return directly on conversion failure
> and free successful conversions with ntfs_name_cache.
>
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ntfs-next.
Thanks!
