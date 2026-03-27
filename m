Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD1E2DB787
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582082; cv=none; b=AaibPLTajzDV8alOLoOhkcl+8gIzTyIOwp6ayuTkdqVqpFA82+FNGjkt8kwTGn+7HqAp/eEc32P9faX6CKbAtXkai45RLzOmTeztUbA3W4Kr3MG2ayiXK+9+dGGlLHa4mpvDb4TJGPRDXP58WIwFLjN+cITAQEMierRd4TaoDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582082; c=relaxed/simple;
	bh=Nftrrljfq31hgoSdrbDmWha/2QoWtScyeDtSwayr+OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg3oBQNLzqBSMXhC/Q2pLIAmg/C8ChUmPb6xmaTHi/DVgDdtW7kXPCAa4919fhpduKvSTYPX0mYXCTmQ4FaSjmVZPpRJEy9c85lQo0FaT5rFNv8n92XgBPf0j5BjvbZYkNiaMRq6bfMXEAj5i4dC0huYvj4Rk7pSjgR9wUezIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQQ2dI9l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQQ2dI9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5738BC116C6;
	Fri, 27 Mar 2026 03:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774582082;
	bh=Nftrrljfq31hgoSdrbDmWha/2QoWtScyeDtSwayr+OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQQ2dI9l0fhsC44U8vOWxkifB6AJAd/1B9oytllZT6MBO3NTzYMDnpLh6Wbu60pNC
	 qLOb1wzUsMiLIRuhP2htGEAAwnHQE8XgaoDH1MnaB81d2RkxdYk9gF5XevC2DebfC6
	 LnKensUNJkZ2SkevIHkhYHI6m+KGKL1ADgxL6H721FpVZwJbSjQ5n/tVBM3Fq0k+Yw
	 NxdI89wJNirenCwgQPFWnod38T42yIaHCB4ahuNtw8otbj/CfxylFaHnQAF8zHKuR/
	 tjXycGoRUSqY7uJoBKrsdmNWgmF6VGBjqmJaSpjKW0feM1RrV0L64vVu9PyFjJsJcW
	 CTzFNHJ4HOOsw==
Date: Thu, 26 Mar 2026 20:28:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 10/25] lib/mount.c: Remove some BSD ifdefs
Message-ID: <20260327032801.GM6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-10-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-10-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:43PM +0100, Bernd Schubert wrote:
> BSD has its own mount_bsd.c, mount.c should be linux only.
> 
> Also remove MS_DIRSYNC defintion, which was introduced a long
> time ago - all use cases of recent libfuse should have picked
> it up.

Yeah, kernel 2.5.19 and glibc 2.12 were quite a while ago...

> Some ifdefs stay, as they will be moved in the next patch.
> 
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  lib/mount.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/lib/mount.c b/lib/mount.c
> index 68f9219d2b8beee51346b198ce826138b9528e73..899cd2d0a13a9332a564b10d1c22836fb2cd1710 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -43,27 +43,20 @@
>  #define MS_SYNCHRONOUS	MNT_SYNCHRONOUS
>  #define MS_NOATIME	MNT_NOATIME
>  #define MS_NOSYMFOLLOW	MNT_NOSYMFOLLOW
> -
> -#define umount2(mnt, flags) unmount(mnt, (flags == 2) ? MNT_FORCE : 0)
>  #endif
>  
>  #define FUSERMOUNT_PROG		"fusermount3"
>  #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
>  #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
>  
> -#ifndef MS_DIRSYNC
> -#define MS_DIRSYNC 128
> -#endif
> -
> -enum {
> -	KEY_KERN_FLAG,
> -	KEY_KERN_OPT,
> -	KEY_FUSERMOUNT_OPT,
> -	KEY_SUBTYPE_OPT,
> -	KEY_MTAB_OPT,
> -	KEY_ALLOW_OTHER,
> -	KEY_RO,
> -};
> +	enum { KEY_KERN_FLAG,
> +	       KEY_KERN_OPT,
> +	       KEY_FUSERMOUNT_OPT,
> +	       KEY_SUBTYPE_OPT,
> +	       KEY_MTAB_OPT,
> +	       KEY_ALLOW_OTHER,
> +	       KEY_RO,
> +	};
>  
>  #define FUSE_MOUNT_OPT(t, p) { t, offsetof(struct mount_opts, p), 1 }
>  
> @@ -177,9 +170,7 @@ static const struct mount_flags mount_flags[] = {
>  	{"nostrictatime",   MS_STRICTATIME,	0},
>  	{"symfollow",	    MS_NOSYMFOLLOW,	0},
>  	{"nosymfollow",	    MS_NOSYMFOLLOW,	1},
> -#ifndef __NetBSD__
> -	{"dirsync", MS_DIRSYNC,	    1},
> -#endif
> +	{"dirsync",	    MS_DIRSYNC,	    1},
>  	{NULL,	    0,		    0}
>  };
>  
> @@ -264,8 +255,6 @@ static int receive_fd(int fd)
>  	msg.msg_namelen = 0;
>  	msg.msg_iov = &iov;
>  	msg.msg_iovlen = 1;
> -	/* old BSD implementations should use msg_accrights instead of
> -	 * msg_control; the interface is different. */
>  	msg.msg_control = ccmsg;
>  	msg.msg_controllen = sizeof(ccmsg);
>  
> 
> -- 
> 2.43.0
> 
> 
