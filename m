Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.37.111.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023857;
	b=rOOKO+4cYrEb6fA9u8R/1TR7cNxK4Y9as/SlvOLIs5ma+RCWKt2EBIh+INYejZoO4sSa
	 nYJUDzi1XNjPUNsaSKEvr8vYaCcVuNvgPzaEXg0bJ/coA+RWU+YEQ7pu2LhwdFURvAZC1
	 yvyGidt4CG2UrDiuSvbafZZsp4Z/Q8uOiUxkoqaYtIHPEZIyeSsTAXUUeUgPHIRkzS2oB
	 KKSLpbhhSSM3GP75Wneg5yg+WzxWT9foR3asraqb3hPHiLoraaMvnRPqvMGvK03UxEixZ
	 OkFxoXVXSnogzFeA9bb5wKDcIrNDso0kepomFYy8wKwH95NNYTN6dNdSvQ0TSHp00lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023857;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Wc1vvSITyRmBVDWJNtMVNmojd2zmObDNoGGzgUutCoE=;
	b=YL1RKKc5LN98u5pEpQQQlpsaIB1DZO+fWHEl82OqcfVr9chL2jFUKLEDNj+YiF19iLqj
	 xT+KS3DjABxa3mKkEnXRYA6BEsx6LxBsjzTus8/cBwr90xy7y8QHYYlCcywoufGqIKBNC
	 2brPxE7mlrL9UqPkp7t+Qu4c+/TjP2IcQfcbp9MMSoq01LJiljQ5TD+TLpVcb+XMYH+9t
	 d1v6zllkUfNvghmmCnMvWwe7QH+xZZR6iR+EmBm9dQGQ8wPapkbAk1PkcG/PjtNIHSP0R
	 uSrlI8et61WNVC2HWJYm1rLLXmz9SXZEah9dOi/NcOr/NWUIix0ZiQSYapy3UWvGRqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=HansenPartnership.com;
	spf=pass smtp.mailfrom=HansenPartnership.com;
	dkim=pass header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=v6ZVs5wO;
	arc=none smtp.remote-ip=198.37.111.173
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F362606A31D;
	Mon, 26 Oct 2026 14:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F362606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=v6ZVs5wO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1793023855;
	bh=t3q8uZmNgJ1aWmxQPvuZ3WfcYboWfTwK3xK6qwIhgc0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=v6ZVs5wOkWat3KND4j3nkRrxFEBdp95fqoql9Ct93JRAGnzQhyotICeBY/3zyCJC4
	 7YKXeQqbLIGbwK0jYvn0sCG8hSAnA/0vkSgVeMDxN4PvtxMxGmblks1E3dwCS3QQFh
	 NhIgEi3muy++JLs1BStQzizH2t9Fbf9aEwqKKndo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:d341::8309])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 0120C1C0130;
	Mon, 26 Oct 2026 10:10:54 -0400 (EDT)
Message-ID: <61898b2b9de5e6be98c7b8e462ba29595cae3e26.camel@HansenPartnership.com>
Subject: Re: [GIT PULL for v7.4] vfs keyring
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christian Brauner <brauner@kernel.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 10:10:54 -0400
In-Reply-To: <20261024-vfs-7.4-rc1.keyring-db88a8f3b5b1@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
	 <20261024-vfs-7.4-rc1.keyring-db88a8f3b5b1@brauner>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 keydata=mQENBE58FlABCADPM714lRLxGmba4JFjkocqpj1/6/Cx+IXezcS22azZetzCXDpm2MfNE
 lecY3qkFjfnoffQiw5rrOO0/oRSATOh8+2fmJ6el7naRbDuh+i8lVESfdlkoqX57H5R8h/UTIp6gn
 1mpNlxjQv6QSZbl551zQ1nmkSVRbA5TbEp4br5GZeJ58esmYDCBwxuFTsSsdzbOBNthLcudWpJZHU
 RfMc0ew24By1nldL9F37AktNcCipKpC2U0NtGlJjYPNSVXrCd1izxKmO7te7BLP+7B4DNj1VRnaf8
 X9+VIApCi/l4Kdx+ZR3aLTqSuNsIMmXUJ3T8JRl+ag7kby/KBp+0OpotABEBAAG0N0phbWVzIEJvd
 HRvbWxleSA8SmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT6JAVgEEwEIAEICGw
 MGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAml2ZBI
 FCS3GUMIACgkQgUrkfCFIVNZKjQf/deRzlXZClKxTC/Ee2yEPqqS7mm/INUA49KdQQ5oIhSxkUBy0
 9J4qjMIo5F8ZFkFTqikBqeL35LKu7O7rn8WETfX8Bxvos3HUsl3jHo34DES4MUFIpoQPgtiLRGwLb
 K0cVCAArR2u2qj4ABmTRrs1I1kvdjEw6gatOuXtEe/j5O2fvfzTq9GBr0Q3n2IAsFXi4hLlx6VPE8
 tyWUZ8BWJKtih3JAeUiXFvASL3McV0rV9RnU0VbjEQEhSE7PMYhWpnDC9AyBb0lXJllQRvC3NSkUB
 8KVQgNNxRPss0WE/nBoZ4dFA42jTyzTz8lNylxZoAWV7WJb3QxVg4oCodRVrxxrQhSmFtZXMgQm90
 dG9tbGV5IDxqZWpiQGtlcm5lbC5vcmc+iQFVBBMBCAA/AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeA
 QIXgBYhBNVgbnPItGJxvq2a34FK5HwhSFTWBQJgS5mYBQkbNYS9AAoJEIFK5HwhSFTWBpwIAL5Bk3
 5FB34U6iHmDzzgdCbxLTs43T/YQyJpcGIvopBvnI/fDY8oSG6Df64/O6B+1R+A8TDp6ZG5ysUWnCC
 6GuIaEHemBYkitMPglR6+sGCMQY7O0mlsPvdssvKK1KI9Bno4VU6ogaF2qVzefSqg1Djmf/DcsxWP
 rI/jdJ8FB5AYR2rjIdDFc+zRdAJuavo1/anyY2wgpFh/3R8IOYAEfWV9nGgYkf9+tA4EIn1sxE0I3
 L5oW2N3mbyRrkzuBwO8ztMCwqEPk7moWzhokcZqMXiAIahaZdkashJC+s2X2RZSGCy+g+pvY5NN4B
 BVG5XwLgVBqbHMTcxE0fbmPqz+q6O0LEphbWVzIEJvdHRvbWxleSA8amVqYkBoYW5zZW5wYXJ0bmV
 yc2hpcC5jb20+iQFXBBMBCABBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAmODZ5ACGwMFCRs1hL0F
 CwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQgUrkfCFIVNZu0Af/TzvL2/NdgAcw9uN3x60H8
 jc4QUq14VpxcFEFEMpcj1morkX/G93V+56HBBaXZj+yK8PhxIA/SIz+sU7C/0YvKuvzakP8ZX/7WJ
 e32SOUtjfr/VTaqjIBzNj6OxLvZpmNbBw7s6DwhhNpHOWqJ/1ml+PtDRDV71IB58yVqQjp1xlNKVl
 ZppcJ5908EJzsFnRIVjiQiDSKoppqB2BCibBbrWcln7CiWMyOC/cco6SIn6twH+f7+aivJ3xGcOE2
 a9gBKF5rNi9TBoX9oyPmshv/TDmnohsVrH7AYXlGYfZTk15SWEiROh1QX8/uD9wl/gcIv5EDUpT/F
 L2jzOsA5663bw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, 2026-10-24 at 12:44 +0200, Christian Brauner wrote:
> Hey Linus,
>=20
> This is a delayed pull request which was waiting for the bpf merge.
> This used a shared branch.
>=20
> /* Summary */
> This adds well-known key ids for the .dm-verity and .fs-verity
> keyrings.
>=20
> Neither keyring is linked into any other keyring so request_key() and
> KEYCTL_SEARCH can't find them. Userspace has to scrape the serial out
> of /proc/keys before it can add a key to either of them. That's not
> great as any user can add a key with a newline in its description and
> make /proc/keys show a fake .dm-verity keyring line with whatever
> serial they like.
>=20
> /* Testing */
>=20
> No build failures or warnings were observed.
>=20
> /* Conflicts */
>=20
> Merge conflicts with mainline
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>=20
> No known conflicts.
>=20
> Merge conflicts with other trees
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> No known conflicts.
>=20
> The following changes since commit
> 1b7415bf70be95b9a1e7e87d544867881065613f:
>=20
> =C2=A0 Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.3-rc=
2
> (2026-09-06 16:17:40 -0700)
>=20
> are available in the Git repository at:
>=20
> =C2=A0 git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-
> 7.4-rc1.keyring
>=20
> for you to fetch changes up to
> 503b65da9a7e5447d91222f62399522f2f62a0fa:
>=20
> =C2=A0 Merge patch series "keys: Add well known IDs for fs-verity/dm-
> verity keys" (2026-10-12 23:37:42 +0200)
>=20
> ----------------------------------------------------------------
> vfs-7.4-rc1.keyring
>=20
> Please consider pulling these changes from the signed vfs-7.4-
> rc1.keyring tag.
>=20
> Thanks!
> Christian
>=20
> ----------------------------------------------------------------
> Andrew Halaney (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 keys: add KEY_SPEC_DM_VERITY_KEYRING
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 keys: add KEY_SPEC_FS_VERITY_KEYRING
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Documentation: keys: document IDs added si=
nce
> KEY_SPEC_REQKEY_AUTH_KEY

It would actually have been nice to copy the keyrings list and
maintainers on this.  I don't think there's an objection but not cc'ing
the list and maintainers makes it look like some type of end run.

> Christian Brauner (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Merge bpf keyring work from of
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Merge patch series "keys: Add well known I=
Ds for fs-verity/dm-
> verity keys"

This is a bit nasty because the keyring specs get renumbered inside the
merges ... it would have been much clearer to people looking at the
history if the patches were rebased instead.

Regards,

James
