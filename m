Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD0C35AC10;
	Fri, 17 Apr 2026 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453271; cv=none; b=haSs2Zd4WCau93htGVNgLTqOBo2Vhr5xoRjonHMs/S1/0t0CVL6mw9wTjXpACXN/IT6HdDCxGP8Okbx2JlafGg5sOb0YgXx1WAki5qeWRJFT9GxLbD3jH24nYigKyThAdiZccPYTihoizj/nGowc91D7H88TaGGNr7yQ5Ik26lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453271; c=relaxed/simple;
	bh=RVXU/z3SSTm1OPS2Qvq/JRqPITVNN9tCE4OtxjZUz/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkRTlYFOS49CkD/oDUhvDTbCKU5WubpcDn9u5ONGvUge5DCZ0mohtKeS/DfNR6S1le9OfIOvcniNxcCK/CCcjeorYVaop0eApifJeiIPiSxPxKaRmnitOa9HQ8jZqcf8uuNwfvu1gB8EUJBhWDAiNgcIMMfrAcmWOGSY5tw6FFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=TTOG/q2i; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="TTOG/q2i"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fy4Lh3RbNz9v5b;
	Fri, 17 Apr 2026 21:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1776453260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVXU/z3SSTm1OPS2Qvq/JRqPITVNN9tCE4OtxjZUz/c=;
	b=TTOG/q2ir7z+5TtrQuxrnoLlbpJ594BRW3LsOB3LcwP0hPJS7+VDW7w2volpmVgxxz3mqH
	7bfHC7U/WbQnJH9Bgd6ijhMzQ919Lm/A/tYGkN6eCFmNMEeVHAFhKjnIj5oOwT/hJVJreV
	Tg/esa68Q3lbVVQpU6XZ9zsin/CTwbl5YkYjj3PVD87AToYHLiPgNi8jTLbrBexgoy0R2D
	HJkU7OuG/Jm2aUsh/KMYmcrWSwIbF/qaxay/hmu9f7hyxA8fZCSCzMsNJI6w2R0r7MyVrO
	uJQ1lRmBboVg/DLzTon5E0zmaurz9It+SbmOBIbFZRTG9GAaOk6ToWeWBBykjA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Sat, 18 Apr 2026 05:14:06 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: wooridge <1063373698@qq.com>, yurenwang152@gmail.com
Cc: Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, Petr Mladek <pmladek@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: add CAP_SYS_ADMIN check to panic/ctrl-alt-del
 sysctls
Message-ID: <2026-04-17-floppy-moldy-vile-squabble-JZOuCI@cyphar.com>
References: <tencent_4BACE37ED72C80152F8C6A8C585893505A05@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tfcax2sfnyv6w77s"
Content-Disposition: inline
In-Reply-To: <tencent_4BACE37ED72C80152F8C6A8C585893505A05@qq.com>
X-Rspamd-Queue-Id: 4fy4Lh3RbNz9v5b


--tfcax2sfnyv6w77s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] sysctl: add CAP_SYS_ADMIN check to panic/ctrl-alt-del
 sysctls
MIME-Version: 1.0

On 2026-04-17, wooridge <yurenwang152@gmail.com> wrote:
> Several kernel sysctls that control critical system behavior use
> proc_dointvec() as their handler with mode 0644, but proc_dointvec()
> does not perform any capability checks. In a user namespace where a
> process has uid 0, the VFS layer allows writes based on the file
> permission bits (0644), enabling unprivileged modification of critical
> kernel parameters.

"unprivileged" and "uid 0" are not really compatible terms.

More importantly, these kinds of check-permissions-at-write checks are
actually quite weak because of setuid binaries -- you can always
redirect the output of a setuid binary to a file to bypass these kinds
of checks. A very classic example is mempodipper (CVE-2012-0056) but the
recent "CrackArmor" bug (in particular CVE-2026-23268) is an even more
obvious example. For those reasons, if an attacker can get access to an
O_RDWR handle to a sysctl file, you're long since screwed.

For reference, proc_dointvec_minmax_sysadmin() was added in commit
bfdc0b497faa ("sysctl: restrict write access to dmesg_restrict") but
there are two things to consider:

 1. This code was added before mempodipper was discovered and so the
 understanding around why these kinds of access controls are not that
 useful was not as developed as it is today.

 2. The change was primarily focused on trying to avoid a loophole when
 people were running with non-userns containers and had access to
 writable /proc/sys. This is considered wildly insecure by modern
 standards and would not be considered a security hole worthy of fixing
 today. (Most container runtimes use user namespaces, which block this,
 and most container runtimes also bind-mount /proc/sys as read-only
 which also block this.)

So, in my view this logic was somewhat flawed back then but makes
absolutely no sense today and should not be propagated to other sysctls
because it just gives a false sense of security.

> Affected sysctls: kernel/panic, kernel/panic_on_oops, kernel/panic_on_war=
n, kernel/ctrl-alt-del

I also want to point out that the files you mentioned aren't even the
juiciest targets -- kernel.core_pattern gives you free root code
execution on the host if you can write to it.

--=20
Aleksa Sarai
https://www.cyphar.com/

--tfcax2sfnyv6w77s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaeKGfhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG+USQEAqiK0BHGsxEtKBOxjyYUN
unCZWRyZiPa7W2p8kuypFYsBALREPO2QQ8cqjb7I4f57rKKEGHxvsGZh5k9hrpIW
0WkC
=SdGH
-----END PGP SIGNATURE-----

--tfcax2sfnyv6w77s--
