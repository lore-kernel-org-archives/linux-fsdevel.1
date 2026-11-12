Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478959;
	b=5ewTl2oj/uHVSVhm5GdijW2wNgcRpLT6C1r2fAX2EBvITN8UBwOqEKDSVGa4HF7orsmQ
	 oY7r66G3RpmZZdk+j+4eaWcdBIgTggQiGf6hrStRBOhPkE/X4PZj8TTPu1jrGb4UiDs9i
	 Vu0z4pCIopQajPCzz1nySvIzcbsH+K8UqEUFPBzPmxeDG/9txkUpCqJ/UF+X74hPrsWYa
	 Pe9HcVvKdWkLB/HTzHuuB5LmOoBRen3gLa6wRQYymGswZwt06s56EoECp+UTDEDt/GYeo
	 J87YnmjBB8XLyCF4H9AVH1rNvclQmGxP+78KTXYx9IGldNf39nRqrRmuSkxxuhmckmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478959;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eszEeUmzyGQ9L5uzbk8VgNcgdcYzrPgBruu7pdfNjtg=;
	b=n+wiIbNA7yWRdEXussjtY8VsHculo+ewgOGoCwUTcQ7KyIG55Gb5wf7SOiUfsS9HTzWd
	 SUvuwzWYY8yfTdPciEhqniGCfg0y6uUc+28ArjaRn1+iq/HZUvTbg09ql/i71MG5nEORp
	 XHjS5AHh54ljBt28jvReUT0jEbSeRAEG8+w8qpQEUfAiy8iCXdOMCNLZ/ASd2UiwBeGnK
	 fo18y8v+Rj+tpSB3bG4UKq3U8joPyaoJ3nV0B1utY2Zh/wIxv7IhAeGqpAC9Qfxu+96N7
	 ixTmtt1Q6ib1uChc6vcKkq43iniWSVOHjcv/A2UyC0/WUEvRX1xihpm3y6OF0mVReEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUz2sOBj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9385D606A33A;
	Thu, 12 Nov 2026 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUz2sOBj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C361F00A05;
	Thu, 12 Nov 2026 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478959;
	bh=eszEeUmzyGQ9L5uzbk8VgNcgdcYzrPgBruu7pdfNjtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gUz2sOBjSDTwchLsNEYBkp4I5dyt9I+nuMCr0Q7eCujVvfcWdwn/8SNoBRoZmrgIZ
	 cWBSnisEgNB6IRiGLisImDhvdYBOImpNx2AHZ2vAvMtr3641S2E98KZymjyRwLORnK
	 FbKUgwML5qrMds4g8/ujJJEdhtzlxMwoqpkY5bh7Ey6wZyRdT+dYSjBiZfdCakSF2E
	 kQjmhQ6mHRjtDeihWwVJveCb7GdWlm+8vqYM6MMowkncNJZSjSDgdhnsBiZT1rhSo8
	 ctGvRoY59IYgvFfqxAp9Zg0iJxmHwL16oDUUuUzgCKHNlSmkmnPf/pdrMttUiYQPBQ
	 vhjIIIPMG8CMg==
Date: Thu, 12 Nov 2026 11:22:33 +0100
From: Joel Granados <joel.granados@kernel.org>
To: wen.yang@linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
Message-ID: <avWTAV9Xt-x2iNvR@hobbes>
References: <cover.1793204511.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kbkfmlx46zbzof22"
Content-Disposition: inline
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>


--kbkfmlx46zbzof22
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
MIME-Version: 1.0

On Thu, Oct 29, 2026 at 12:34:39AM +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> struct ctl_table describes an entry with data, maxlen and, until this
> series, two untyped misc pointers in extra1 and extra2. Those two pointers
> have accumulated at least seven unrelated jobs: a fixed bound, a bound re=
ad
> through a pointer on every call, an object or namespace pointer, a small
> integer cookie encoded into the pointer, a lock signal, NULL standing for
> "no bound", and a value the core itself casts to unsigned int while
> validating a u8 range. Nothing in the entry says which job applies, so
> readers infer it from the handler, and the core gets it wrong where it
> treats extra1 as an unsigned int.
>=20
> The numeric half of this change is the direction Eric Biederman asked for:
<... snip ...>
>=20
>  net/ipv6/ndisc.c                              |    3 +-
>  net/ipv6/netfilter/nf_conntrack_reasm.c       |   30 +-
>  net/ipv6/reassembly.c                         |   30 +-
>  net/ipv6/route.c                              |   11 +-
>  net/ipv6/sysctl_net_ipv6.c                    |   53 +-
>  net/mpls/af_mpls.c                            |   58 +-
>  net/mptcp/ctrl.c                              |   29 +-
>  net/netfilter/ipvs/ip_vs_ctl.c                |  157 +-
>  net/netfilter/nf_conntrack_standalone.c       |   45 +-
>  net/netfilter/nf_hooks_lwtunnel.c             |    4 +-
>  net/netfilter/nf_log.c                        |   67 +-
>  net/phonet/sysctl.c                           |    6 +-
>  net/rds/ib_sysctl.c                           |   23 +-
>  net/rds/sysctl.c                              |   32 +-
>  net/rds/tcp.c                                 |   11 +-
>  net/rxrpc/sysctl.c                            |   51 +-
>  net/sctp/sysctl.c                             |  148 +-
>  net/smc/smc_sysctl.c                          |   42 +-
>  net/sunrpc/xprtrdma/svc_rdma.c                |   39 +-
>  net/sunrpc/xprtrdma/transport.c               |   27 +-
>  net/sunrpc/xprtsock.c                         |   26 +-
>  net/tipc/sysctl.c                             |   18 +-
>  net/vmw_vsock/af_vsock.c                      |    4 +-
>  net/x25/sysctl_net_x25.c                      |   23 +-
>  security/keys/sysctl.c                        |   25 +-
>  security/loadpin/loadpin.c                    |    4 +-
>  security/yama/yama_lsm.c                      |   10 +-
>  134 files changed, 3075 insertions(+), 1525 deletions(-)
>=20
> --=20
> 2.25.1
>=20

Hey Wen

What is the base of this series?

And please add a base for your future series.

Best

--kbkfmlx46zbzof22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmr1k2IACgkQupfNUreW
QU+h+gv9G5IMKAyI9ruQg9M16SDqprbhEzJYUItQ53Ig0T8Bi1y06QYCHMRaDMeI
BkCc+Hl/p8Kdm5BKgDFoNV5KOyhowEVPbcmwZY6MSOe45vw+2YPprDmELsIoeTZI
o4nv76iqK/TN8sjxkA2CwSzNoqZAT+aI6j2CeZkFZRnPqjYeytHFkeYEUT1OWOJj
Hyn7/f8xrV2kySxhlb/WLYpMFDJ+d3aoCkcFgCOJYaOYcgWy5v2hOsjhYxFhrv1a
mOHqf5o0cAi7LPu2hAisBwb977x3TDqtP7J92akgPatS1l/kATm/hA1YUuO5JOOs
S/XOHSCdmfCbKdX+F9Z0pISx2y4AOxQKSiHh887aPCcskNDLvY3LRlWOltDRjDn8
Ul5gXQhSIchZbJ4iW2BpYJcYdY2VWvYkK/kFdn3ibtlYNUYr8fGvXvt1em69rzJ6
IlWZNgmVDaA54RGryCMqet8PIrs5bWU92GjMcCFlhwd/cGd5j3EFStxjd3mXwP5G
6QpbkY2P
=2Cuw
-----END PGP SIGNATURE-----

--kbkfmlx46zbzof22--
