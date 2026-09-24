Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D0C483BCD;
	Thu, 24 Sep 2026 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256591; cv=none; b=N72/zuxt/0HHdbEJClPti3hlmupMvnd7kmOL7a1V2B9yz9vWtDQqM7aTd3r0kqDebK9QwWkLmYSFy/tMkd3gWcA+6zHvc1AFxr0xX/gDGbTnZu0DBpCeg7b37Qxe5THhMQTgGs00wD++nr2AScAE02VcWwFstsGum3rTZMyOQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256591; c=relaxed/simple;
	bh=NhF6Q1fofW0qZP7ATGzvHGaOfKnrSD5tWRjwuHcppPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgrbNSfVUY1sYzCsuvy081YA7kUjBsXbibg8ZDmCU8ikDG7NxldXTyl8hExpaMvOAQrvKqq+YVLis3ivNBCkw7xPUpboOBEI9IfcdE8lrx/nqLjPs97qzMaRujsjmxTIWwTtxYhq4lik6TQ6DzZiDaXBqTke3LjbYHJpmDnKuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZzdQo4S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZzdQo4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F871F00898;
	Thu, 24 Sep 2026 13:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256580;
	bh=irEjNTSoLjZ7mf/PTFt1/oKOLRsrl1sS/1oJwjHNpzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JZzdQo4SqDq69MOEjSFq4gNeszFF3jmr1WKOksNiiYaXuCcIGd04MDTphYBiBLLRc
	 5iAwiEcZ30N1QfEUQUchQBZtPoOSOdu+Zhb2aVMjOsVxpcAlH7GxmquSij0CSSMRCD
	 dEBwx1Bw2ZB+bCIWNCq/LJ31/QJl8UINBxAuGqeyB3uHm7kxmpnaVVRqqXAuVsCfAO
	 jEZyIIQVvKTvAbWbghmLtxrKi8pwUSnojmJ2Rt8KfZ8TY5AyK1lvpzM0St1sp0h1Us
	 leCTjUjcFZNBXHYEbY/JFRbZIaguy3AKVMOr+EMg9JJNdRuwVdrwrwUL+L5H99tvvA
	 sxqCG03ajYenw==
Date: Thu, 24 Sep 2026 15:29:35 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Serge Hallyn <serge@hallyn.com>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] sysctl: add unsigned int limit constants
Message-ID: <hc3jlqepedad5jbxz5rpskjktvbjcohorybc6kbtd7wtpajqi2@zftmndyhlw7a>
References: <cover.1789987960.git.legion@kernel.org>
 <92b31e85fbb91af953aee911a44787142cddee3f.1789987960.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dpps7hjfdgwevhtm"
Content-Disposition: inline
In-Reply-To: <92b31e85fbb91af953aee911a44787142cddee3f.1789987960.git.legion@kernel.org>


--dpps7hjfdgwevhtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 12:54:49PM +0200, Alexey Gladkov wrote:
> Some sysctl handlers use unsigned int storage for their limit arguments.
> In particular, proc_dou8vec_minmax() expects extra1 and extra2 to point
> to unsigned int values even though the controlled data is an u8.

This one reads like a fix as opposed to part of your series. Is it
strictly needed for what you are proposing here?

>=20
> Provide shared unsigned int constants so typed sysctl descriptors can
> pass correctly typed min and max pointers without casting the existing
> int constants.
>=20
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  include/linux/sysctl.h | 7 +++++++
>  kernel/sysctl.c        | 3 +++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index e5d7226ab6f5..7139a4c72736 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -59,6 +59,12 @@ extern const int sysctl_vals[];
>  #define SYSCTL_LONG_ONE		((void *)&sysctl_long_vals[1])
>  #define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[2])
> =20
> +#define SYSCTL_UINT_ZERO	((unsigned int *)&sysctl_uint_vals[0])
> +#define SYSCTL_UINT_ONE		((unsigned int *)&sysctl_uint_vals[1])
> +#define SYSCTL_UINT_TWO		((unsigned int *)&sysctl_uint_vals[2])
> +#define SYSCTL_UINT_THREE	((unsigned int *)&sysctl_uint_vals[3])
> +#define SYSCTL_UINT_FOUR	((unsigned int *)&sysctl_uint_vals[4])

I would really like to avoid that. Its one of the things that should
probably go away in the future [1], [2], [3], [4]

[1] https://lore.kernel.org/all/875xyczpzm.fsf@email.froward.int.ebiederm.o=
rg/
[2] https://lore.kernel.org/all/tencent_C5E6023F97E7CC2A046AAEA09BC9ACF4390=
7@qq.com/
[3] https://lore.kernel.org/all/cover.1739115369.git.wen.yang@linux.dev/
[4] https://lore.kernel.org/all/qnrzl4tjlgw5rzlvxavr3pt7fhkslnm4dd62q7uqzb3=
mfoa2jg@fuayx77rfcs6/


> +
>  /*
>   *
>   * "dir" originates from read_iter (dir =3D 0) or write_iter (dir =3D 1)
> @@ -73,6 +79,7 @@ extern const int sysctl_vals[];
>  #define SYSCTL_KERN_TO_USER(dir) (!dir)
> =20
>  extern const unsigned long sysctl_long_vals[];
> +extern const unsigned int sysctl_uint_vals[];
> =20
>  typedef int proc_handler(const struct ctl_table *ctl, int dir, void *buf,
>  			 size_t *lenp, loff_t *ppos);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index f7b75985d542..54edaa2fd5d5 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -29,6 +29,9 @@ EXPORT_SYMBOL(sysctl_vals);
>  const unsigned long sysctl_long_vals[] =3D { 0, 1, LONG_MAX };
>  EXPORT_SYMBOL_GPL(sysctl_long_vals);
> =20
> +const unsigned int sysctl_uint_vals[] =3D { 0, 1, 2, 3, 4 };
> +EXPORT_SYMBOL_GPL(sysctl_uint_vals);
> +
>  #if defined(CONFIG_SYSCTL)
> =20
>  /* Constants used for minimum and maximum */
> --=20
> 2.55.0
>=20

--dpps7hjfdgwevhtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq1Jb8ACgkQupfNUreW
QU/rjwv/aNkzVpS0H9NQk8jxv6F2Qpa0nFyMmge+cCd5FszLAm3e2eDXgQzf4/nF
gnsof/f5n8oxFDXItARXgcJs60sBtbImpwTlt3TYPLa0nmP9tTLLsi12Ig/+EY/8
VPLtHN8Vcr6d2RiN2OCsXQXQujGzYSLiHURfb1ZrgorgfT1FWACbTPF6ag+Kcqo0
TlU5JNZqEbi2vyeEVx8MvbyP+DVW3KEu2AQaiBAEjJPc4bxsz4HT0Z+lNdY2ViB1
4BVcE4IzPovCOJnQoIX/Eo2IbqrCBllSL/SOqvr4pX3Mgu73MF2Z5/dxvwbahbOM
o3KiwPOUznJ67Bcfrlb0fKK41O27BiV8doxNOe6bsYEUgOzqv4q4D7PB6hTBlG3k
6y89P2sLzIy8YCXgDPZnqz9DaK/n8tcr9Uzgi+pKNcR4BN5kQPzghHsH8XI7IOye
4SiMz5+OzNA6EX2wPANzdvJgGSrD38/mwzhYyW2c03PkbOSwG7Z+YTwV0VMEwWow
AahZFXXZ
=DVuM
-----END PGP SIGNATURE-----

--dpps7hjfdgwevhtm--
