Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9633DBD60;
	Fri, 27 Mar 2026 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603108; cv=none; b=IBXuYuTCzgcQ2UfWhQ+98nypi/Ug4y/k9rneirKmNrePxGgnFnmIuJ2cyqnxIdSpHFpt5VUepLhrmU7x9ZmJmrg2yvatDQ1rnpf0rfIHIq0KbzW7WxKsXWHc3LjUXoImMf59eM9weUudDUYrgdzTix77l9juyLbNVElMf5MoBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603108; c=relaxed/simple;
	bh=y1DZ5pKYv2D4FY44lFWq0Ufplwe8z0GAL/3X8pAX/XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bSApPTc56wGq33AN0TVhceYdhkQ+dKKz6TqEzBvBaqvzFfmE3MwZE6keN26POKq7fz5/+ZhPD+NFu8j8w6xJHB23mpY/0DS+O1UxSm6610SJOq6vcW1D+MQMnSl7BmDDRyzED3Ov8v72satejsp8MrRBIlmx1LtQKTTc5y6LfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAP2fYWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAP2fYWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6A4C19423;
	Fri, 27 Mar 2026 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774603107;
	bh=y1DZ5pKYv2D4FY44lFWq0Ufplwe8z0GAL/3X8pAX/XQ=;
	h=Date:From:To:Cc:Subject:From;
	b=EAP2fYWs+6PYYKeMwTXgss8XvZHXqua0Zp4FwlfysociyiGYXaAZO+bTa1mfeSugp
	 BweZQhu4uTmiKNwpl72EOjkS7Dv6G4Rr//O3IAgHaljBxBQ0hLerRDaIYui4FFFtUc
	 a5CDRMUm9RyB6DT4E1gS7KR0Jvo8g2Kv2QUVMCoM8MsIkH41LGIyXvE3aeidBs9MEP
	 cD715lIvSiP9j/9prk1AP1UOFH/jFfHVYFHa4/0f+u5j5V7ldS7gOXwd7QF9MKM/kq
	 2JMiXMdzxnz/N3+G0dpwag2GRO1dml2cI1ywDd5itaxSqObj3M6oCsFu5CAsn0wQtW
	 3sKMCabp1+9iA==
Date: Fri, 27 Mar 2026 10:18:21 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Marc Buerg <buermarc@googlemail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sysctl fixes for v7.0-rc6
Message-ID: <vrx6mlibyi56mx5ibb6mzmey26ngcgrufkhg2j5yfw6d7azc7u@wvmp6rtddd34>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yqjuweh5zjinlncs"
Content-Disposition: inline


--yqjuweh5zjinlncs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus:

Small fix for sysctl bitmaps. If it is too late in the cycle, I can also
send during the merge window for v7.2.

Best

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysc=
tl-7.00-fixes-rc6

for you to fetch changes up to f63a9df7e3f9f842945d292a19d9938924f066f9:

  sysctl: fix uninitialized variable in proc_do_large_bitmap (2026-03-26 09=
:32:19 +0100)

----------------------------------------------------------------
Summary

* Fix uninitialized variable error when writing to a sysctl bitmap

  Removed the possibility of returning an unjustified -EINVAL when writing =
to a
  sysctl bitmap

* Testing

  Quickly passed through linux-next.

----------------------------------------------------------------
Marc Buerg (1):
      sysctl: fix uninitialized variable in proc_do_large_bitmap

 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20

Joel Granados

--yqjuweh5zjinlncs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmnGS1MACgkQupfNUreW
QU84dgv/Rdi+SmHcx4MhYy1dHRtCa4ZRs/YVPyFsD9yCCbjdTMPlK9a709CTXsHk
TyyjJFo6OL8OLHY1145f5ayilI3dpfK3lgUw/+yoKVPRR7NENpNZuRH68VwgAGvs
efXwhjSC30hNbFU1yvevgO1EYB3HoYsLAOXLPBKZ4DZe6SGLSpwRcOIP7R51Vbvg
cP7nAedOdn5QZQtj38HNbiu4qZWB0h7neca5exz+m0m3fMCsX3uD3+htUoVj9Xgo
f5EuuUid6hoKcRLSqnAgf92KPTwr3BGQTYW5pcNdS/pYHEH2HbJ+t5XU+qv725Nq
FdMrSnT6y6GgLQvskfJDNOspoX+uEVJPoLe93BSIk2oaTMUqNNACbNzJuT/ctgpC
MCiLHCo8vaNAr+E+1RipTPGTC+WjhhCpiIh87n+7i/dQgfqDt109RF51rSvjEjQO
qmUe9etbtMNAXLWT9cv6psYB9WFYeTLb9BmGIt244opksqEvZ7jWQUr5Q8SrLOoo
0NPFPR4r
=5PAA
-----END PGP SIGNATURE-----

--yqjuweh5zjinlncs--
