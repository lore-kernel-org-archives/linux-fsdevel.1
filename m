Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388405650E3
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905067; cv=pass; b=cxjus2BMhYXU6ums/fh/yHIhAPb5HnMFxuRjkzIYO3Et+Cg7+ThFqE3Qp+JSq0TvcrQ9l4QAecEAR5hY/+FhkmRK5LMmd3LHbpVabHPIFzCDExT0rUGr4PUDOXCW7lom5kfXTklwJptA3aB9hkW6f/9813LS8prYw7iusblCJX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905067; c=relaxed/simple;
	bh=kFs2/Y5KiTV72hw46XVjq1+BiwJ435803ate9yBUPeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7YEATb7EFhoioM4bGpPJfyyNc0chZYUwBBH5KYo6ncAal510UusOSK/ktyyaz3i8RLcnMEIinwZ7OsPhsc22ln3XVIvLyV8vUtEUFTyF8m6C6FsLW1UCV+qRZtyrvaAtSv8tuRWOWboAcMOf6YMlR9SkUR7KMwn8Lw25Zv5TE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=byGtWLH9; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="byGtWLH9"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-859e0bc7dd9so399772b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 15:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788905065; cv=none;
        d=google.com; s=arc-20260327;
        b=Fbh6aEN3SsewubYrFvK/is42RkwTeDvd22V4JsetI+A6MGPjMMH+6bG41XkMbLvwMK
         /sHMNRLd2W/lqRyF2u4A/5BYMy3zjTleOpTLEPzru+J9HkJB6NOMl1yGUzq9KO8ZEAyR
         RRvEaprnhklU2Qidrn6gioEoKts8cIww4CwOolPE8sWC7U6HUfcmmCNjjQcBSpAeBsBS
         4DjS7ad4rA9MrtKR1xDLp+ZU29zsJugUxNqdqZmTeK67CD5KN4QWnc3z4ktJXsDJNWP3
         iYwtrJWHlWFfUezXy2H8V1n3qOShFPm0eR+1JamoE8Jm5akwIiCjr52GDcj/oz6X6dy/
         MpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YWfrU9KFZA0btF/+MeYl25HDjvWja/4fX79GCEtM140=;
        fh=wK2kSgtIUhP5effIbkBs/IYXyT7YQXTneI5eNPbnRZU=;
        b=DSc5EENPurjjJvhMNV5J1vbrosybhl0A+hXfR3w4/TDradjWVC9JBz0t0Tv7j5VlSO
         FAWvfTJ36IViqRDnv3MxlzfTRjLRZAhP2bpGYEX18KZoVYTvYvKv364Ly5mE8FFS3wSQ
         iwi+BdhXk5NKnIZ2jwbGl8Bsozfve2OLn+NBFxEQ+sATOY5CChZjSiaCUyIB57Kbj8y8
         gqzzhsH3j2QdqVXQJq5aEh9BwD6scKOcDYIiu3UeI8aL2J3UjmeqgClELBdB79n1JeUJ
         ESVlCnYNF8Lhw1IqDdJ+udNbUANiev2FPRRPh9psERcMUNhyNGbk/ukm4FmpazylxBJk
         HrgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788905065; x=1789509865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YWfrU9KFZA0btF/+MeYl25HDjvWja/4fX79GCEtM140=;
        b=byGtWLH96x6sw3h9XGMxxuPYSC951TzNPI+BCrqb+S36so5xweMUtxaq+IhYdl78cO
         l4K3ie4BoXiLGo5f1w2xx4fm/S+8X+lQMv171L7v6tU59b+KrRF82z5wKjAZ2H+P/+5O
         xtmXKTzL+uob3DpVranPTuGeOOwVh7q0nUpftp8VN1KzTMKong8gRs8yK48VJMZvuc6W
         0otQwxvj8ogNuOWZm+CVwDcQ87CWDrOHMgkOUJR+ItwtrfKxDdpzKtjRysfMFi9YE3ZL
         5PX9XAlHnebv8jwuud1d/EJMoQs/D8OjES/ydwa6btLWWg4BgMUf8uIIAXsTUUdh7Z+S
         Y97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788905065; x=1789509865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWfrU9KFZA0btF/+MeYl25HDjvWja/4fX79GCEtM140=;
        b=VNorISFO1Bn0wBc5vgAJwPZzqBAqa3ceZ0pgZUdbUTR6IFU1akdVRoV4ekmQHqlHVS
         aE/N2TjbeK+Oe3yZKTa9E2tgM0d0s0kCDtk07ouv5rdkUqYD1sNFs4vvVXzv5vlhhcvw
         VDqmMGT0O4mburgivS7b81gtTL79OUErk8SVd7KxTcbQ3QGUmU7krJoYAa18mVwMUtHL
         zDT3G+6xSQcTUvSIIEk6VMI5q3IJ3UQQ2/Xy4OYdnNE9u/VlV1ddHa+HPHGfMMY1VVfP
         wRMGu50dolyBS1V9Wm6FyIQov1LQmdX+zte899Hkcah03ZwqGyQcrMqVkQAtnpqXL1hs
         ZhAg==
X-Forwarded-Encrypted: i=1; AKwUvBziPUTtCJVH2A9mANq3Sahduzg8cVz4jJGBbhuwupV311r6uKY2gn5xbnlAyCMi2hTP4oLLw8C4G67oqfzb@vger.kernel.org
X-Gm-Message-State: AFuF++mSe1/+vi8MQoFnT5pBnZNJy1L5QVIKXFY7qmRiAivdxuqPX9o2
	2xa5Tglz8AI8mKugyOtht64PcZK0BSjgbH/7veW+Mz3sIb1EUR7IB3U2KpsvL64ZqaYletCe2ib
	a1eug6gZl5o2nHcM20h+oKE1psQ7yaQKWDlond2g7
X-Gm-Gg: AYBFou1In6BP5fbN5biCSZE5v0p6RNrvwYrwdSx5P3QEunHQgGo2r90kNb1Q0QhzK6F
	vLTpqIwbeYmgLN5++0bEPBCH9eejc2Q/Mw0Fxzqf9fzX43OmpgAMA9xcWU6vYrmhecwjzM24rUZ
	09kPnI2zjT1v+B7FVCA+3lm8IqkrcxEcahkfz+J1ocZKRJs3nyG7pw7hFXdlN9+GwKxpWkzyi6/
	dW3ngerkA3GwV0OQGe8el1uJIaXu0gDo3G9nnDOrlZotChH2W/mRtUJ/genw39X1iIheLKayOqn
	eTZZNRhTwvZvqD+TFCpNMLqxS2clDld6CdldUanpANpF8Vl6PXuLg/cqFuAZBKICKH0BZ8ifC1f
	z
X-Received: by 2002:a05:6a00:4103:b0:857:72ba:ff0c with SMTP id
 d2e1a72fcca58-86843380d24mr2506973b3a.20.1788905065338; Tue, 08 Sep 2026
 15:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
In-Reply-To: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 8 Sep 2026 18:04:13 -0400
X-Gm-Features: AcwNN1WG-GhgrrNi3fsiuaGk2OK8M8zXACNxnVPqz0qu4sJFuS02JXSPQW7uSlo
Message-ID: <CAHC9VhQwHFdfWkTmZtMC+FgPDd32nW-e_FPbUhE70Y8a6viEBw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] lsm: expose mount idmaps to inode hooks
To: daan@amutable.com
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 10:48=E2=80=AFAM Daan De Meyer via B4 Relay
<devnull+daan.amutable.com@kernel.org> wrote:
>
> OverlayFS performs upper-layer operations through inode-based security
> hooks. Those hooks receive the upper inode and dentry, but not the mount
> idmap used by the VFS operation.
>
> The security layer cannot distinguish an identity-mapped upper from an
> idmapped one or make the same ownership decision as the VFS. The VFS
> layer already passes the idmap down into all relevant inode operations
> so this just brings the security hooks to parity.
>
> So pass the mount idmap through the create, link, symlink, mkdir, mknod,
> and permission hooks. Update the in-tree security implementations and
> non-VFS callers accordingly.

The above three paragraphs should replace the commit description for
patch 1/2.  The current commit description for patch 1/2 only
describes what you did, not why.  In this case, it's pretty easy to
see what you did by looking at the code in patch 1/2, but the motive
behind the change isn't quite as obvious.

As long as you are okay with me updating the patch with the change
above (and explicit on-list email would be good), I can swap in the
paragraphs when I merge the patch so you don't need to do another
respin.  However, if you would prefer to do a respin, that's fine too.

> systemd has been shipping systemd-nsresourced for quite a while now. It
> relies on inode and path hooks to perform ownership checks using a bpf ls=
m.
> To make this actually secure we need to be able to calculate the on-disk
> ownership from the idmap.
>
> ---
> Changes in v3:
> - Restore the two-patch split from v1.
> - Add the missing Signed-off-by trailers to both patches.
> - Link to v2: https://patch.msgid.link/20260901-lsm-mount-idmaps-v2-1-330=
9b9d1eda2@amutable.com
>
> Changes in v2:
> - Squash the implementation and selftest into a single patch.
> - Add the missing Signed-off-by trailer.
> - Link to v1: https://patch.msgid.link/20260824-lsm-mount-idmaps-v1-0-041=
4a9641c85@amutable.com
>
> ---
> Daan De Meyer (2):
>       lsm: expose mount idmaps to inode hooks
>       selftests/bpf: verify mount idmaps reach inode hooks
>
>  fs/cachefiles/security.c                          |   4 +-
>  fs/namei.c                                        |  18 +-
>  include/linux/lsm_hook_defs.h                     |  23 +--
>  include/linux/security.h                          |  58 +++---
>  security/security.c                               |  40 ++--
>  security/selinux/hooks.c                          |  19 +-
>  security/smack/smack_lsm.c                        |   9 +-
>  tools/testing/selftests/bpf/prog_tests/test_lsm.c | 231 ++++++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/lsm.c           |  79 ++++++++
>  9 files changed, 410 insertions(+), 71 deletions(-)
> ---
> base-commit: 786262be6048deab760f68c8acc2c85607165894
> change-id: 20260824-lsm-mount-idmaps-9d9b994fe1a1
>
> Best regards,
> --
> Daan De Meyer <daan@amutable.com>

--=20
paul-moore.com
