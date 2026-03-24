Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178933F59E;
	Tue, 24 Mar 2026 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338260; cv=none; b=rLqyBsKA1j4tKI8d0RUrezUWE8rrtWKXqF7MqE5AR2peM9pL1K7XT4+kl1Jl9LR+1imK3hGRepL2RCYWdIQWHo/C0BIuAAtXvNE/BV4EvaFiLGmLnwgw0peSMYRcx9jsRFWrzTfjIE/UyHWEMRkmTCq6kFRBLCEIS+a1pds1vz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338260; c=relaxed/simple;
	bh=vqgzI0n6hcjJ/7XiY6QBauC9jB04OyJwKmo7LsmFAq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGkMMiVxC8wSFKzD7TkpnAy0T/qVnCxEjhjg63epaTjM92pjXnluMqcwd29Hu2XQcEYOKrlikA4uCsXFPkbSCr0n0bMfwp9+gAG86+GooFyUpbLeCxORlxUifGL8K/ZmT+1xGMWSLonkEK4k7lM9vzh7fAFXKjx2Dhza+4hMk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDuXwpji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDuXwpji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317D6C2BC9E;
	Tue, 24 Mar 2026 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774338259;
	bh=vqgzI0n6hcjJ/7XiY6QBauC9jB04OyJwKmo7LsmFAq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDuXwpjiN3gVIbAjiDKegr8JdwUympJTQv6p30bIPL6uTua/YksnBqgde62tqWy0h
	 5Y78kpAQuMQwRRK9zndERMnWupU2799EHaRppQ029xt+23FyFSJXgidT4KVvumjZly
	 jllA45AhC3WMYnyq4M+EMAZA/ozqnSnP7wkjI44eTEWW32kHxd6eZOBKFtZRlOU/rr
	 7vNNQ/ZwTbnsUrbgDByMsMc3Fx+KoLKrSv0CJ7G0gtmlagdcSM6n/0dr0iLJdSnX3x
	 zENvEgCFPNZfNdtdzH2Va7McB4SvmNlgtZZa6dwCYpiI9g2ijwHvxLYI3EB9H5eTZU
	 Y5+zzF81001Hw==
Date: Tue, 24 Mar 2026 08:44:13 +0100
From: Joel Granados <joel.granados@kernel.org>
To: buermarc <buermarc@googlemail.com>
Cc: davem@davemloft.net, elias.rw2@gmail.com, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, opurdila@ixiacom.com, 
	ps.report@gmx.net
Subject: Re: [PATCH v3] sysctl: fix check against uninitialized variable in
 proc_do_large_bitmap
Message-ID: <msjawemtxqykmbis625wctfjry7ycn77nxjjbibbck3m3atvsm@rfwow2ytmgtg>
References: <wcqe7kk2jdca7otlp6iwbp27ud6d3ynzopr7gs66gqn4xeskbr@cdyrjkouqmem>
 <20260323234623.689612-1-buermarc@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uo43v7tmq4eiffyx"
Content-Disposition: inline
In-Reply-To: <20260323234623.689612-1-buermarc@googlemail.com>


--uo43v7tmq4eiffyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 12:46:23AM +0100, buermarc wrote:
> Hi Joel,
>=20
> Thanks for the question.
>=20
> On Mon, 23 Mar 2026 14:53:51 +0100, Joel Granados wrote:
>=20
> > Here I have a question:
> >=20
> > How is it possible that the buffer in proc_do_large_bitmap is not
> > terminated with a '\0' when writing?
> >=20
> > The proc_do_large_bitmap gets called from proc_sys_call_handler and
> > before running the table->proc_handler call, the end of the buffer gets
> > set with '\0'.
>=20
> This is correct, the buffer will be terminated with a '\0'.
>=20
> > trailing char is '\0'. Which, in turn, means that 'c' will always get a
> > value.
>=20
> I think this does not hold true. If the buffers is parsed till the end
> len can be of the same value as size in proc_get_long(), which means we
This is not the case:

1. len is calculated by doing len =3D p - tmp
2. tmp is the beginning of the buffer
3. p is the first character that is not a digit.

There will always be at least one ('\0') character that is not a digit.
So len will be less than size at least by one (could be more if the
string contains non digit chars). When it is parsed to the end,
len will be less than size by one.

All this holds unless the trailing '\0' is modified in some way in that
BPF call.

> do not set tr.
>=20
> I will go through my current understanding for a
> write(3</proc/sys/net/ipv4/ip_local_reserved_ports>, "123", 3) =3D 3
> syscall. Hopefully that will make things a bit clearer, or show where I
> am mistaken.

TL;DR

>=20
> In proc_sys_call_handler() we call the function (in our case
> proc_do_large_bitmap()) with the count based on the result of
> iov_iter_count(), while ensuring that the buffer contains a trailing
> '\0' char. So the buffer will contain '123\0', that is correct. The
> passed count will does not change it will still be 3. I used bpftrace to
> check my assumption as I don't know the iov_iter struct all that good
=2E..
>     # On x86_64, local chars could be at the end of the stack frame?
>     sudo bpftrace -e 'kprobe:proc_do_large_bitmap {
>         $c_val =3D *(u8 *)(reg("bp") - 1);
>         printf("PID %d: c starts as 0x%02x (%c)\n", pid, $c_val, $c_val);
>     }'
>=20
> But I must admit this was just a shot into the blue. Yet, on the
> affected host the -EINVAL results disappeared as long as the probe was
> attached. My assumption was that the eBPF trace changed which value c
> pointed to on the stack.
>=20
> Best Regards,
> Marc

Best

--=20

Joel Granados

--uo43v7tmq4eiffyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmnCQMUACgkQupfNUreW
QU92qwv9GA/mkvQP+2+Y3tnCybMPjVPYqM+uSSiddddJChMn+/dNCjndHFtTjXC0
VCWAyz9cES9SWEgWDlg8f4yusrlqdKXHoMZYJWpQcLzCOcpYauqA3iWtsVMO3Y0H
1x33PydgnJsXeSBfpTM6QvLZpJb/9iAfRR5Td/RDVSDUSTqO+1Js2LQp/1u1hns3
aPOo6A9tUb6HiU5I1FV5BoFPtAj2bdU4mzXu4XWGCKKz2VqkTgwptrbFeCsEHr/E
MpwFuK9NB5sQ/DKh9KW0NTMudJ/M/q1hCQmDI2xnMQwsQE2ReqfVX65KOgujaZnQ
hW+goy6qdpiRfNUBygqb8YoTjaWX13tBZ6o/8hgepKUaBKPaBU9i4LXI0UANs8lT
kuOwrk8dNVRea/ONdkpbvke8QtP5zO9maDTXx/fKUP2ui/bf3A4nkDZMaZcLLZz1
oWM5v6ymUDHxCFn3e0r8nj4BpClVXj2P2BtwXeHzQt32aYQIO6z+Aeq0Vx7IbMtI
QI8h1KX/
=+7RZ
-----END PGP SIGNATURE-----

--uo43v7tmq4eiffyx--
