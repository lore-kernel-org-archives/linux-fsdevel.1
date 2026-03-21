Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBF221F1C;
	Sat, 21 Mar 2026 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774094738; cv=none; b=K8uWCHvDLCWP4xIHxIxRPbZQGaUvSM7aZVON2dcCkU01vCsK1ZhNeE8fcN9XcGwzKe1oK14TazPUJK0rnpooT1N0ZGg/EuMTQaGUC2JQkx+Ld1Rxg5GlasbrtaPrPh6k/yL16JGa0YHc5I5NdGpH4c1l/dlWVoEiF/n3eXqGo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774094738; c=relaxed/simple;
	bh=Zglp90n2erVtkbV17f9tvdupj4Gd3QWVnH+m6w13xq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fm6HGWdOSu69YV5Bb3lBXo5G8EMb705LqrTCepkaxG7hEQQPJA16a1lmeVUNQzmDNg5/1t+/k7xE0ZD2JEKUuCLbESevijRLfCAPiWejNT27FQCr0lGVHFUmADa0x02cqm0GJ7KjZMFlJs81AadAfKuoNvo3jw+z1wgll3617P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=teK+vHHV; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="teK+vHHV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1774094728; x=1774699528; i=ps.report@gmx.net;
	bh=AwsiU0kYXN8suQ8+f3bFR6yI1J3l0YMsdZcvDXZJa5s=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=teK+vHHVthf4oW7waTLBSelWaFM/NlYpFAd3mNFcLKCz0PPC61x4tqBdrJfyA1yq
	 Ci5WLlxGhi/Lq5TqiZahXDm2lgXryCGQy6JSElJLiTrIXeVaa8YDKfaguj5ESbrfU
	 DHSMk9PFlWSeai7gjb4edvjYRwtD9p6ZiDTUbDu4GEGAseH9CR/PbP07qRvXoVwSr
	 XxLAsTjUDLvuHnhm4aJs9gqJv09kz2Iap9DzSdqq5ih1Ko7rnkB9wYDWDKsf8mgi2
	 5Dw09iov5R6YC2jmOoWzIElVh7Cl01VVFPRvJW8DWdGCO6iSZcjGllPCbgaC4w7pg
	 oN2/4n2uRQnBBH7Ucw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD2Y-1vPeaQ1jBy-00ie3O; Sat, 21
 Mar 2026 13:05:28 +0100
Date: Sat, 21 Mar 2026 13:05:26 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Kees Cook <kees@kernel.org>
Cc: Marc Buerg <buermarc@googlemail.com>, Joel Granados
 <joel.granados@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Octavian Purdila <opurdila@ixiacom.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Elias Oezcan <elias.rw2@gmail.com>
Subject: Re: [PATCH v3] sysctl: fix check against uninitialized variable in
 proc_do_large_bitmap
Message-ID: <20260321130526.207666c0@pc-1>
In-Reply-To: <202603201128.E07B1E0332@keescook>
References: <20260319-fix-uninitialized-variable-in-proc_do_large_bitmap-v3-1-9cfc3ff60c09@googlemail.com>
	<202603201128.E07B1E0332@keescook>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4NQBd3K0S0TqNsclJdiMtJ59567mc95dIhWYoDQCB3EKVczdgVh
 MEqHGFqHmpGKEw1H2ZVzk1m6B1mz7m7X0otVG/bFRNhCbwkgTJ5kHz8pYeqdWm8lddk7nih
 EHPo8j4SdbZDNvB4OUOqqqs7Z/GgTSmsGdgqrq8xCktxY1wYU3a5+EoFk6uVdRMFP7Btxwz
 Y4oJBr0YmN/MR+VP6vsdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GKofsasVibE=;7tTPUpAnsk+osFkseBHO4O66WDU
 H5hN5AYSIx5hL0m21oNR7E0UbCItbUw80ygCjgt0wuvXr8LQO0KNFpp4400QDM6VeZjwCLQvb
 zY1gpfM9i1md5d/AxhsDHb1byCOqxSbMj8stvg33Bsopj0tVlp70Ic8QNXq4st9diV0htLo6P
 2aEcA3X4s7MApdVkNWCk6B1/LxvTTeM6r8t0lgtyb2Pakn9NVhODRuxBD9nv+iZjms5zPSItW
 g6vmKBUXrrajJ2I1w+HIRmOGkIK0ZKl6Cabz1affu4WZpxvwCOBcF35fQaIMnzJokm5LSS7lR
 1VohmAobJJy7xNDrKG+htEDuDxuY4nXhC749K2HwH698bkYei2Pg2aKgg/k21XMiZxbf+oUq4
 3jlYL8M1REnkPJV2dCPli2R6eungIpcvNK/ThjgE/NCOGEnPJgrmitNssgyvtuO5tUI23J1DG
 u3lKBJ5oHLwSdcnPho4hTmpGj4yjZos73Htuf+lJ6n+4cphxtRfUowilhchJOSUqftRACf3au
 FmfSPWwDqJmQQKs1n+W244xBcqwClmd+DSbHtAy254HGa3wNsvbBuqolzXXv2VYk5cfHjQFGn
 v6K+LvyygRsAT3OuxWSB30kuNMelrl+iVrxKoC0IDktxdgLsR2YiiT3pJQhBCBq2PHrFhtlNt
 8hOP7IUjicLQE2KtyuM79XXK0ajUee4qZcF6TSaFpS8Z/jBNtjWJcz9bb2g+t41itl7bPSEWA
 p7RldiHaec8XCokBKMkdeMr26+rKXiV2u26u8ukKdxsUj+50KWmBtxEs5sNDZsU3s3z1XWgke
 GOtRtV+g/RCMAHJ72CzzKPK99xfdPYsCPpXLnzQFc2sX8bHiE1SSE7zWQgfBf57WGmjW/lX4Y
 xFTaGHdwruNYsmepZHUUJRSYZc66gmzHUIjXpiI1SQzOCBEnQMXNh5svqlHmQWnZeWkstEOuL
 q4uJHIdXkQt4uhd1/AxGPlrYYe0SPNM3nQ3Brup4OI9Qk71NLfctg11SzW9xtUnuj/2lVj7ru
 mhhxu56upZ/z8CW846aBL63ZNGYESJE+XDoJcaBvkJKnIAG6eW7Ll/sxkEmlw/vzxKwGBGA7C
 TTEVVdeqFFZjEShX6W5fmHUJ3+it7qXPTUr4cAqtIOHm47g0dbyqqx55kzozkUItrVPVcCzzf
 B4y2BNvOKA6qHgXELRxifjTzGvennuaTJ2/ewVEjD4sHjxQ+z5tvHkEqJC0UFtknpFmBEtUV5
 pw/OsKMMIyCxbYzxFuuEyabCBGTzFeIQsRxleDJUmjGJsf6NFlZGBJ059U7JVlu0/imr0cLsU
 zCyj2wlzs4ZdVmbItItvX0r0zXA+8YVS6PAvskbyA+NCDRf1RZf/UKbSJX6gQmIIbtfvb+nAg
 Zf5x0BdojaSaU43d7OS9cWWUPgMKez18AXEr/PBsMrVGhlDRf+yvT8bEhLnoKOcnQuI1j+sqa
 RC+LFDuhuZbq9vCfeviF6RUDuVe007/Rohf4IlNeK6MLRwX0kiBYL3lXdaAMLCd4OoWachbcX
 QlLy3NIG6jEm5Uz3GGNEJJMLuIYBhclkuugLTyxlUE9Wc3swAqC9NmKWhW1guESMUNJM141vN
 pXVdbz91egaBtYfoAfCUb5hN+S2Feu+UzfRym0Qvv1VuVKnRfBbMOyNTfTe+tPZT0uFSrO7Im
 XV/CqFjCzLkkHT5Am7pVlxsn4ZHYpXkcqGCYZq2di4eU4OBV+QopoE/r3RZVLr2GhqCwJKhsg
 /DQRwpPD9+3vk64gDFSpp0R5nKLBgBr2hC0VRv7EM2mZ4h98pF/QRCJiL5yks3jlXuYIeIwxa
 rFImK9GJGGp6udErgIICcXixopaHw/ZTgqBQ8ixh664uix6i7rr5Qgn3vMRbQ9BN9vvE64fJq
 tHFXpL77p2KrhU4s5WNV+smwAmsFdb/lOt0T0SjCofN8RDFqjoxe6/aQsMvf1VDMmzF2ySIrv
 hEBgdVtfT7amp9++VV8/XE2Xm+JSr5tssqD1wlwefkAo9oG5ulukG3T2Jd1Ywkp/yXvQPRak6
 66BoVh6+40iFBwOAIY8n5F6wyog6dnZF7Qz2exx5pxUMkq+gY8rQ7TwC+C2SMnrNAfGg8hymy
 nb6XSWv/D71dHwyz7us1SYFBiRBxW7pDn83RWxn5RNayrRbTjRAvp6sK0HaUkkLAaCSmtghuw
 d3hwZ1gXGAyiZvGMZhn+xNH751VIeEf0QLHEjtj5w+IkNW89urwLi+BVzpdW4z1vYEA2mDwiT
 0uEsFU2f0e/dBghFCD4uXiRMQfzwcDHmHUCvbVQFMh9infdb9IK/YdQBEMrwrr/sAVquzfZbH
 m/mTaoWRDQRmSO374Zf01gLQvG8hsF2tNdXOBunyd0s/Doi/OpUz42xEjOPKjPVSVawnh8vRo
 O5qevbAobuz3+BWe9VROTjiPvfDtl7GOLDtRKWBLh5W8k3zqVYI8OjYxL1OHMM0PeLhduWrBc
 1TGeIN5shj/er7klC2XxgZyocSa+WaPqg6jCzMuTRSI3J/VpHNcKx26bPxS2kjHHjR/penOEt
 9IPtfKpK8BAeHLlh1MVcVpkRW/ySJYqPfwg1xuKRxgtJSBKu+D8kVzXhw5EGbwAezEIHzKGBU
 90E17gnB/mwvPCnmXEeZe7DSyjUQEbRAk+gqR0d7c2KFnSlXWZt965ftPV3A+3auW/Typ4J9j
 NgnA7nkw9PZSpRhyPnaC0HMZ/4GF7CJBDZRLy+AGq8SYw01L8Ly4+EHwP4CiiT0jNQ9DGjq/Q
 ePaFYYetFCh7Abs30YNzEUYLH5JiWbF4LKcUnYFdyBaApnA3uV4qshUCtINQ/mcr8lqR6mibd
 hK48JmYzP8g4MhZBu81eT2a21af+9Ffpp8rFp2+Wqm7SHW5XwpRN95fNjG0cLDpbTwtrRxTGm
 bkdsuX3aqVM4nKJ2c0D0W+7jR+ck1UYU0hqOsZgLkZ4GgiBifJoLtIRS+KOIC3+ALa7QTHBy1
 VryI3C78PUCYJVQJW/puJUAaFqdaaAInQBZANcfqZu5u8tVYwIPn0rbr+R4larrfZ6Fm+ew3x
 O+cH39gSDXf/TYXMNmuQzG9Nug56YtCsvqGXxHfiXVrP8tgrGUUfaql2yrdp+Ub8dbmYrs9Nk
 25rpYjgeA3YK6/hXhHmktBfwAwzevqHDRmToiR2siJ+uwbGlyXiAol7mIEZjGoE4b/hc7DbaN
 SjHvdIIcD0fwnec8uSG/dbZnvFiXsxOu5sBPB2l6OTMgzAE/KRLxSE0Yn7dZ+KTRxu4LxO/yr
 68pJQApNf084GGN0+DHuaP3IqjCG3XRyjJ+8bFd4AEQyUH0sf4IczvHn0VL9109PPy/eHqTNs
 gThmi5RdB9InrHn8zcpZVUge0gx9g0z5U74/C33y0OH10BWhUYkUd4NqeDYCQWyLGCWIhlRs2
 V1Pa/X/WtDIouhXF4ZDszTJ8XZE8SGLjc2LiW/qcDsbJDxcDwMUNXo27gn3MK7uAEeUTv2c3+
 dRoRH5lIfHCvRIweTm952O+1pTzv412S1poCXg9O/JW77fB4KMZkKCGD/mvU4109QH6GuDSB0
 V6JRuDCpdRes00NNOtI/R0cNAyBhnd6+SfhdLMo/7j+a8hXqKSdrdaalxyp76lXP3hJ8poGEg
 Ynvkz3MTeJjdwszheN+Bg8XfsGKTPUfA3IJzCqw0mIeoybFS46I4WcaM3dz0SPD0fPd5kzatY
 OnRfmxmqzPGi2wHmz6POInEpmPSvGFvaanroTr0bfQhItjH0LsQvM/vofsoOyi76ouLEvrVEq
 5bO+edv9iO+IUfIAgfAg+UlPa6CskmWM0jLEssijXFxHs63q+ie+4UxrB9rVui/xrtGqHptm/
 XEz32ISWvYtOpzyU20xaDUK2dmfJPs1tHMTvtxnUI3yfn1dQLJlIVedTVHkU99ZdZtMObzger
 Zz35bBnrGeuP4y2OUHgX2cqTyHMuvrLG2Hs5QBdz+bQ+Tzt+VT39qXsPp32BNL8Z+i2hzjYNI
 rgYcUSWs0SkduzrwnQKF01RFZ1sP+jZek+y/7GH/nV1zgGGwnCtX5InV7BWqqkmByMk5OCgdW
 ns3q6Ff0S7wIjhAj8gN6lNOugAFAbjQS1YRy7jeEa7uhPry5r+kGMH5BBqWx1q2vkFLP1oELj
 C8tOzlgaYJSAw7sN2FuuD7tV5Mxtv47598cpi8SwgT9zuzKp2tHVJXlpgbvrO1Hv7Qjmuh/ec
 z8/tyE5bHihrOReDYDKVub2Fp+/pH9SmU0borBRzNZBaDB26du7jCY6tuyYx35apSB7tFqyaM
 /nUGoi4gDgjkWsY/HGwHH+g0Nn4QOmNeEjGciqgpZrNFONJtDmKELb5AiW1Zdb1bm2oZVhGE9
 2NtD9biNPNBGRynxZDhYW5imZgtp6F+20aBcRJTF2zFTtybQqV6RRQs9f1T6RCf400/3LwXtr
 3IV+Ni78MTcWhhZYr4iOlZYBKdak2r0QqMeR9Zd/LFdFibIeJUiNYKG84K4rBARNvyz9gIITe
 YxwY0VkUUYTr4+8z7cZdQqEQWb51+EDpCG75ECt1PVAAVVXjQdfG9ZHs3QTi3fIHnUmIR5HRX
 xoLFOPoX5Bm/xT62/acHPwOd+8pXcCFjGHVNQKJXyaWVHsT0gLnB547zgHg2Tv7+fNNAXiHfW
 e8+AUW99Xf0nMK53SCGL9OHioKK96FcdwriR6W3N6beVPrcK1x25GwVQ3ETXBbtQuONdXenXK
 z35IdqOcRiNxpZTWIriAmc1jCDMrkgXks7oIgzDTpjQ6U8ciSAdsBBlvDEYHnjBIQ/87ZrZfg
 8mIslo/jr4AKDmLZzVZARD0CMUC9VObSoB22LgIGDo/boqbE2TrgsRz6LtBDnUCC6wyWZi833
 06X5CYa+jNUJxSWjAFUB5FjBORoqh6f6/z7Pyfnx8wC5gzHx6DzCMs8ad7ilI+Dxsi7fYeR49
 I1t8DgneWP1YgQXoASei1WmAOkzWogdJyMUUf3UuupiraUoKC9jY1o7IRLnFvp1H3YsIP5lJd
 zRWodm5fjck6W5IDn0FvMNfofA3XwaIzRGp4wOxalTTz1RzKF5QqtPvtkCuc2/W7wwUIqxkB2
 rZ8wlmgOD8k6SupXvzjdRhnXsCIRkx8r/TFpo99ENieEZbdfaUkl4n8OsnPLiVW+rObvCCp60
 YblvRlfIRry4NYk6WJUBFVFfebnvtm5HWslf5U82M2k83z4cS/W1XADTl5yNkEH88Wrh3riia
 QzPPcGY0LOjrY4jwcc6I2AEf/WsCPiuMBSFtCitf5JzsqIWSRRgMn1Wi6/iddofmk4OT+RtP9
 pb1BqNrdD4sipdSfJGAakoRiQw0uIpgigNVnbmzhmbFkdZDnbdlTon4fNoNStQ3cidwYlkJlo
 H66EEj6oCJetoRFQsBtxDDai7XsaXlsIPsv+k0V9Yab8FeY9FiHhX+jHlO4rj1LKke6UOmHyT
 uakQ2Qg51YXfm71GqLXbNOCLzu/G67TzfzMAq1zjCD/Jk=

Hello Marc, Kees,

On Fri, 20 Mar 2026 11:30:29 -0700, Kees Cook <kees@kernel.org> wrote:

> On Thu, Mar 19, 2026 at 11:50:50PM +0100, Marc Buerg wrote:
> > proc_do_large_bitmap() does not initialize variable c, which is expect=
ed
> > to be set to a trailing character by proc_get_long().
> >=20
> > However, proc_get_long() only sets c when the input buffer contains a
> > trailing character after the parsed value.
> >=20
> > If c is not initialized it may happen to contain a '-'. If this is the
> > case proc_do_large_bitmap() expects to be able to parse a second part =
of
> > the input buffer. If there is no second part an unjustified -EINVAL wi=
ll
> > be returned.
> >=20
> > Add check that left is non-zero before checking c, as proc_get_long()
> > ensures that the passed left is non-zero, if a trailing character
> > exists.
> >=20
> > --- =20
>=20
> Please don't include "---" as a separator here: we want to keep your
> entire commit log (including the SoB and other tags).

+1 for this one...

>=20
> Also, I think the explicit zero-init of 'c' would be nice to keep just
> for robustness: the compiler can elide it if it decides it's a duplicate
> store. There's only upside to including it.

Sorry, disagree on this one, not a fan of this 'add unneeded code just in =
case...'
pattern hiding the real fix and/or logic of the code, but just the
opinion of a sporadic contributor ;-)

@Marc: in case you go this way, please remove my Reviewed-by tag on next
patch iteration...

Regards,
Peter

>=20
> -Kees
>=20
> > When writing to /proc/sys/net/ipv4/ip_local_reserved_ports it is
> > possible to receive an -EINVAL for a valid value.
> >=20
> > This happens due to a check of a potentially uninitialized variable in
> > the proc_do_large_bitmap() function, namely char c. To trigger this
> > behavior the variable has to contain the later explicitly checked '-'
> > char by chance.
> >=20
> > In proc_do_large_bitmap() it is expected that the variable might be
> > filled by the proc_get_long() function with the trailing character of
> > the given input. But only if a trailing character exists within the
> > passed size of the buffer.
> >=20
> > If no trailing character is present we still do a c =3D=3D '-' check. =
If the
> > uninitialized variable contains this char the function continues
> > parsing. It will now set err to -EINVAL in the next proc_get_long()
> > call, as there is nothing more to parse.
> >=20
> > proc_do_large_bitmap() passes left to the proc_get_long() call. left
> > will only be non-zero, if a trailing character has been written.
> > Therefore, checking that left is non-zero before accessing c fixes thi=
s
> > problem.
> >=20
> > The problem will only arise sporadically, as the variable must contain
> > '-' by chance. On the affected system CONFIG_INIT_STACK_NONE=3Dy was
> > enabled. Further, when enabling eBPF tracing to dump contents of the
> > stack the issue disappeared.
> >=20
> > Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
> > Signed-off-by: Marc Buerg <buermarc@googlemail.com>
> > Reviewed-by: Peter Seiderer <ps.report@gmx.net>
> > ---
> > Changes in v3:
> > - Add Reviewed-by: Peter Seiderer <ps.report@gmx.net>
> > - Re-include bug context into cover letter
> > - Link to v2: https://lore.kernel.org/r/20260317-fix-uninitialized-var=
iable-in-proc_do_large_bitmap-v2-1-6dfb1aefa287@googlemail.com
> >=20
> > Changes in v2:
> > - Drop initialization of c to 0
> > - Include checking that left is non-zero before checking against c
> > - Link to v1: https://lore.kernel.org/r/20260312-fix-uninitialized-var=
iable-in-proc_do_large_bitmap-v1-1-35ad2dddaf21@googlemail.com
> > ---
> >  kernel/sysctl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 9d3a666ffde1..dd337a63da41 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -1171,7 +1171,7 @@ int proc_do_large_bitmap(const struct ctl_table =
*table, int dir,
> >  				left--;
> >  			}
> > =20
> > -			if (c =3D=3D '-') {
> > +			if (left && c =3D=3D '-') {
> >  				err =3D proc_get_long(&p, &left, &val_b,
> >  						     &neg, tr_b, sizeof(tr_b),
> >  						     &c);
> >=20
> > ---
> > base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
> > change-id: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap=
-30c6ef4ac1c5
> >=20
> > Best regards,
> > --=20
> > buermarc <buermarc@googlemail.com>
> >  =20
>=20

