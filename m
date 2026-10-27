Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.37.111.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118889;
	b=UIkk8Wx6oX3cmHxz6hF3u88SOXwwJLlUKiIbWrQXL35zZ88uoLejBG1vlbFcyTWrcXEU
	 pn5tqZ9jfuypENHQLsJM3jXzPisvoKu2a2dBJsK8W6/01ssT7us2w4NB7ZS/Lx8rSaKuB
	 SntDUFoEiDbT0h0q5IGzEDOFwPg96sStA6dvh543gukJ6CrCSvA2LlIH+6V6STn7r53Di
	 MRGsD3/aGGetBsAwtUTLNS/LeMfOZzdYt4UgHL5XF/YROo2Yqg7okF0dMPh7JzgVY+Kih
	 /2uXt5xEG+dApAltpUBCewvHLf++mE+d8Htk5rDgoaLFbfqE0AHjXTKFBaawdjJGLGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118889;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=lJTFG6KAtjLyj44w/zDj8zueuqa2oCfz8t6xfr7X1Ug=;
	b=twy21On1J8aaZuE4QDvXtLfseC8MHs4OJBtpFyCXS1Naaw5K9bit0htX2Dd3GxlirsHT
	 2Q1xtSVoTFmfXxEtvmkMO1yW8mnE0Z8xpkjT7V0cm/XaBWL2yqcGMVhcOh8VfP5vqJZPA
	 pnYjPCGABl0a3q2HcaVkdjFRaBh6kZ7FC4pjnmgcHx4hTJPTBPByct7x/wCFnYhFy4GNO
	 8XfGqZEEDLrJkyHhObTLp9xzz+QDL/W7cQiCogfYX7CteR2yVEyXVOwPj+1t7nfdkYhrA
	 HBOToInTRyqnprGp6o2y23wxJ9KPdBsTVGnrlrE8u3D2EKayWF+KVvff9C4dZxcdFjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=HansenPartnership.com;
	spf=pass smtp.mailfrom=HansenPartnership.com;
	dkim=pass header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=UGfSzLjW;
	arc=none smtp.remote-ip=198.37.111.173
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299FD606A31A;
	Tue, 27 Oct 2026 16:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 299FD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=UGfSzLjW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1793118886;
	bh=OpNyYRNyJU6gg+kG86JdyNEhWCyrOAzRSyOypkHvpC4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UGfSzLjWypAeRbcEIjwFnanplbmb+1G6c8fPH0X+DMGyC77CoR/7T8zGDij6SYCdn
	 0DC9aJ3rMnpAMI58DZ3FdAu0RLTorZQh50KB8ZV/8VWDCaJJ9EoYlfGepUgTewIN3t
	 rd4Y9l/sOiyVC6U4/XtrjizAbtTv996do2eJRhP4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:d341::8309])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id A1DC11C0227;
	Tue, 27 Oct 2026 12:34:46 -0400 (EDT)
Message-ID: <d7d219895917cb1ad48db41bed19b5d11f3fc26f.camel@HansenPartnership.com>
Subject: Re: [GIT PULL for v7.4] vfs keyring
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2026 12:34:46 -0400
In-Reply-To: <20261026-semester-gabel-hallimasch-34a1d883b295@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
	 <20261024-vfs-7.4-rc1.keyring-db88a8f3b5b1@brauner>
	 <61898b2b9de5e6be98c7b8e462ba29595cae3e26.camel@HansenPartnership.com>
	 <20261026-semester-gabel-hallimasch-34a1d883b295@brauner>
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

On Mon, 2026-10-26 at 21:35 +0100, Christian Brauner wrote:
> On Mon, Oct 26, 2026 at 10:10:54AM -0400, James Bottomley wrote:
[...]
> > It would actually have been nice to copy the keyrings list and
> > maintainers on this.=C2=A0 I don't think there's an objection but not
> > cc'ing the list and maintainers makes it look like some type of end
> > run.
>=20
> Uhm, they were?...
>=20
> =C2=A0=C2=A0=C2=A0 From: Andrew Halaney <andrew@amutable.com>
> =C2=A0=C2=A0=C2=A0 To: Alexei Starovoitov <ast@kernel.org>,=C2=A0 Daniel =
Borkmann
> <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,=C2=A0
> Alasdair Kergon <agk@redhat.com>, Mike
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Snitze=
r <snitzer@kernel.org>,=C2=A0 Mikulas Patocka
> <mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>,=C2=A0
> David Howells <dhowells@redhat.com>,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Jarkko=
 Sakkinen <jarkko@kernel.org>,=C2=A0 Paul Moore
> <paul@paul-moore.com>, James Morris <jmorris@namei.org>,=C2=A0 "Serge E.
> Hallyn" <serge@hallyn.com>, Eric
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bigger=
s <ebiggers@kernel.org>,=C2=A0 "Theodore Y. Ts'o"
> <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,=C2=A0 Shuah Khan
> <skhan@linuxfoundation.org>, Randy
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Dunlap=
 <rdunlap@infradead.org>
> =C2=A0=C2=A0=C2=A0 Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel=
.org,=C2=A0
> keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
> bpf@vger.kernel.org,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> ^^^^^^^^^^^^^^^^^^^^^^^^

By *this* I meant this pull request, not the original patches.  I can't
really tell if David's comment on the patches was simply something that
might be done later or something he'd like to be done now, but cc'ing
him on the pull request might sharpen the need to clarify.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsveri=
ty@lists.linux.dev, linux-doc@vger.kernel.org,
> Andrew Halaney <andrew@amutable.com>,=C2=A0 "Christian Brauner (Amutable)=
"
> <brauner@kernel.org>
> =C2=A0=C2=A0=C2=A0 Subject: [PATCH bpf-next v2 0/3] keys: Add well known =
IDs for fs-
> verity/dm-verity keys
> =C2=A0=C2=A0=C2=A0 Message-Id:
> <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutabl
> e.com>
>=20
> > > Christian Brauner (2):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Merge bpf keyring work from of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Merge patch series "keys: Add well kno=
wn IDs for fs-
> > > verity/dm-
> > > verity keys"
> >=20
> > This is a bit nasty because the keyring specs get renumbered inside
> > the merges ... it would have been much clearer to people looking at
> > the history if the patches were rebased instead.
>=20
> Nothing got renumbered. Both merges are clean.
> The only commits that touch the ids are Daniel's bpf one adding -9 in
> bpf-next and Andrew's two adding -10 and -11. The branch is the three
> patches on top of the bits shared with bpf-next with an explanation
> why this was needed.

OK, so the second merge commit is because it was based on a version of
bpf-next that was pulled into 7.2-rc2 (even though the top of bpf-next
at that point was already merged into 7.2-rc2).  I understand now.

> A rebase would given the same commit but would've meant invalidating
> things that were already in -next.

-next is a rebasing tree.  But you mean things in your tree others had
already relied on?  Yes, I get there's a balance here.

Regards,

James
