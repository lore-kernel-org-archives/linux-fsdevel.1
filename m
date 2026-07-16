Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939293FCB10
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196795; cv=pass; b=exP2CwuTEPtrB9oBfl5ojdioSKe7itggpCnvZQ5T8EqdpRbk9zNsiXvQY5vBV5ohzDY9rQAYvZrohH0o0K5XI/j05Jd1vkVsWg6suyVmLrua+YODTRU9qFsLDmeUXuyAQ7oWZFNg4o5XMkw2uxrVV2vlZW9ObCxHr6YqCLB8CH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196795; c=relaxed/simple;
	bh=/9vGo0nmavtDHHxTO/UOxlUFCFS9hnJACPQkba+EWgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9dgD8Sa5dnK9sc79wegPMucBexNT2/76BHDLUszTQA0HRXCrcWcv+cqDK7QZ7AvsowjY0PaSQvTqfMWE5qJvYJVcQ42ixFgwousOavFgrrC8nSX4WSjnMIeDlsepgNvSvkCa8Pl+ZnWH2GOul0OvZlcxHOGJDdKBrtXx0T/tg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaRcq2FL; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaRcq2FL"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4758bd3731bso351264f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 03:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784196790; cv=none;
        d=google.com; s=arc-20260327;
        b=sLqTOdZek37H5I89id0N04heOQRjmflElm3Y2mwHYBV7tZh2DO2E/JFz3BXd1Gm99n
         vOQ2iCET6aFEdqvRqbX8+ui1Zcd28pElkO8EnMfoJuvOtWsBGFzzjhdHGsTqjJSLxUtw
         0ECXK2yyl6swOdiPtX4FUsqBJXbmxVHptpQsLB/rCsHHlrZU2n9wyWjQtlIaNDrXJpHJ
         EKsGCmOi2elqIunpVFwk+wPR+6dR4lJOFWZENt9MJ3debuPGAzK7h4qitQEbsYomj2hJ
         LObtbjBj24A4QvMLaPKuyw9DsQWWPpt2LDHmuFmdTzA7ONBuJ2x+En4G8qphNeEwIS0K
         UZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0gYTRKSMZ6a4wFC/UrH2Lbf5sG7BiHCm8zMFzcg/FqU=;
        fh=8/qoRYLEIMnZapzQNFUJlteJfthEjGvtnXNFOr2GVVA=;
        b=e+NcxgnSPLLhYqfYV1yKdb15Kr4xHCKo6KmvE4zLMi2TLW+njXgfwhkSKzpDk0UHsw
         dTxwCvWz546FStqC/KrpiwcXITtiJmeOIcFI8NKB6Y0g2jN/x/lrv1TVNTMxMc890s0W
         AJjW5VhyWLAwjiWo0lK4AGCCmLLE9+/yuZrEGIKFAl3gN3jce6+begFaxp6lQ0C114bH
         8jd36CaZBbt7GkJ9LGg06YyikasJ02UjwhXUZ6vrvUK2QG8oYJh1mZSRC/FQcfyrVhoh
         ahqaQXMbLL1V0mLW82aOFy3OigM6zH16xPg03bMOq/AdMeNhasTBIgmqB/Rt+fU9uC34
         dcAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784196790; x=1784801590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0gYTRKSMZ6a4wFC/UrH2Lbf5sG7BiHCm8zMFzcg/FqU=;
        b=HaRcq2FLs8rsz5c+jgCQVp+R4oyE4MvfmmfahHoDJMjVpxK4DsQB9USKteROxTKprf
         ih0NVYQ8Rt1SBPvLOoWu2G6nB/8M9qcfzbTKROhWmtJopZzNuqSegJD0IX8Nk5znmWby
         vZ9rfUYoXQMvJ9C4V3/o38aL9JiIj0w4fSkZ2I4XCtbH3qNleoMLwm+r88ZbhgA68Ofe
         f5+2WTTiY3wzkZ4Z0Kc7zTUQJt3wQk98bUMufDeX2tmZ6KBNKOQEv6pFcVK0mxgUuGDZ
         6W2yvxBT3Q+5mIbJ9fO6HYVlC8FlGL6qtXRHw8HERk61eq1sueymTmJ+JST/9uMHH8cX
         lLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196790; x=1784801590;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0gYTRKSMZ6a4wFC/UrH2Lbf5sG7BiHCm8zMFzcg/FqU=;
        b=QC6gKKcQLUXD7MsU1f5469CZHaE0T4slVLmTONDUOyTZ4gq45OutOy2XvAo6JFSQI/
         oBhHoU9e7qL9JpY0E9KGgnHVyDUdJPPGM3HusWo95U7nc28rgvb3KBQnZ/zYY5MJJu2A
         id5hK1Whc7Wlhdyh0YzrLjzKmK3ZNMGD9ST5oKa6Ex6B/a34BC1mX5VuftZNjYnvL4+H
         DuvQhtSmTkYt4UZ5GNb9LwjXbq1+BKWpx0aHbbyjuT3Pqe3vnoNPvHeuS7oaMyl+eKG/
         vBWUnwF4ocTjhAS5qTmHgsEjwdvhywnzoWxsl3nWOE0ZW5pWQD2npnTbQRV81wwJKu1O
         0A9g==
X-Gm-Message-State: AOJu0YzwdF/X2TUHBKUQxJcmaitUg7/2R2RpBilZu+etvI2UcL1A4kLJ
	ifGoFLZ1e2eSteskd/LV1hAwfLP0XZaUJ+dUUse7BSEKl8HwXtXF44sI6jCyBcqS+oSjbaWzGrW
	EbDo9fs2BQ91vwvBSdGRSwBtC14VYNhhp7CQ26QI=
X-Gm-Gg: AfdE7cl6XE2mtyFLzCDHhpNUuQqfHgnIQ8QzFxHTIt+2nYw0iG6bRjpciek+NTWSeFW
	aGjJFCkZj5kxNCLfIzKLb/ysbwLA0Id4muV/SfuLKuBsaauUs8dBTe7zVDc/e19CivDmOeCVqkw
	Ri7Nq6CIm6r1/9X9tu4pG3GCvMIPh4lPbjSu8sNsnbD1Na0mFgz0PZz1kAkDp9QlPpVY8KzZrA8
	nMSAdlFTSShA8/LMIFWHSxs09Lk2He5PY5SAhtcwtz9xn72/pkj5aP6DgqB7fw=
X-Received: by 2002:a05:6000:1acc:b0:472:3090:d88c with SMTP id
 ffacd0b85a97d-47f5a557550mr2382202f8f.24.1784196790209; Thu, 16 Jul 2026
 03:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713220932.413004-1-amir73il@gmail.com> <20260713220932.413004-3-amir73il@gmail.com>
In-Reply-To: <20260713220932.413004-3-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 16 Jul 2026 12:12:58 +0200
X-Gm-Features: AUfX_mzXKKyPECDpxtr7aH47OhobPNkCrTgnnp8wyafWqJnPsgum1B0ttIWoL90
Message-ID: <CAOQ4uxhO-eJ=QU_okX0y8TgjZcn1-UnB-myNawmXLk2ACjOieg@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/fuse: add ACL_DONT_CACHE regression test
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 12:09=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> Add a test that reproduces the stale ACL bug fixed by:
>   "fs: preserve ACL_DONT_CACHE state in forget_cached_acl()"
>
> A FUSE mount that does not negotiate FUSE_POSIX_ACL initialises inodes
> with i_acl =3D ACL_DONT_CACHE.  Before the fix, calling
> forget_all_cached_acls() (e.g. from fuse_update_get_attr() on a
> statx(AT_STATX_FORCE_SYNC)) would silently replace ACL_DONT_CACHE with
> ACL_NOT_CACHED, enabling the kernel ACL cache.  A subsequent getxattr
> would populate the cache, and because fuse_set_acl() skips
> forget_all_cached_acls() for !fc->posix_acl, later ACL changes were
> not visible to callers =E2=80=94 getxattr returned stale data.
>
> The test mounts a minimal libfuse3 lowlevel filesystem (no
> FUSE_POSIX_ACL negotiated) and:
>   1. Issues two getxattrs =E2=80=94 both must reach the daemon, proving
>      ACL_DONT_CACHE suppresses caching before any trigger.
>   2. Calls statx(AT_STATX_FORCE_SYNC) to trigger forget_all_cached_acls()=
.
>   3. Issues another getxattr (populates the cache on a buggy kernel).
>   4. Switches the daemon to a different-sized ACL (ACL_B).
>   5. Issues a final getxattr =E2=80=94 expects ACL_B (44 bytes) and daemo=
n
>      call count 4; a buggy kernel returns stale ACL_A (28 bytes).
>
> fuse_acl_cache_test is only built when libfuse3 is detected via
> pkg-config.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

> +static int do_force_statx(const char *path)
> +{
> +       struct statx stx;
> +
> +       return syscall(SYS_statx, AT_FDCWD, path,
> +                      AT_STATX_FORCE_SYNC, STATX_BASIC_STATS, &stx);
> +}
> +

Christian,

If no other comments require me sending v2, please change this to plain
statx() on commit.

Thanks Luis for pointing this out.
Amir.
