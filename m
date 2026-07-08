Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CF638837B;
	Wed,  8 Jul 2026 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509358; cv=none; b=fekwy0wYB10QnFS13IowpluB1ue0kSOP2gTmDy99nGM1SbDqdMV1+SDWZbp2OyJWruGd0KANiemWCiC7IJzInWxWDeISXdaJoP1fwcofCWhVOvUP9/jiEQKUad6C2VoRDUZ9/owmmQbmBVAbNRWO55czFaEibIWmUha3AEIrJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509358; c=relaxed/simple;
	bh=wM7XB9I3Qi69y+GncOvyk1kZ7fyHBUWteP2W6l8MfAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cQLcsCFgw/dt9f4Xtl54ZJSpoZ9H0B/nkTNP+jMu0+UyV1V8naVaF7ZIcxM+764MENdrTAkW7zkeb9QzQyaK0a/yM1EpUMDmXIJA4sXRyBhd+2EvEjvWjdw91zKQzdcTkfkczR30TZSgchcIzlbkFJCoGcm6mzUO7y5cXrHDkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxrpSd07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxrpSd07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394D01F000E9;
	Wed,  8 Jul 2026 11:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783509356;
	bh=vlbeyqSbZXl0WKwCQPAtV0QLo4URkUFXPOS3zKZ17LE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lxrpSd07r2T3I/A4bLljmB/z0jvAluRexRilPsQKuX0nLE3EVOb6xAHuxxFJ9ZEE7
	 ms13bWj3/3tJFSmyMd9mS2twEMGGWxIY5Zfg3JmDq3/VCfx+IYD27ragAVYlr9SLWM
	 v2VYTgYeIGEDjbKxxme7dNVYeXNQR9R5Ya4kHmZQXbV3tJgJxwkBuuCytMUzfre9ci
	 pM1gPi8Jq2mBF5YadD1MxLGPerCcvHhO9YAKGjPtLNviKodzmgkUuoxMsnOYfXv37u
	 0bKPrljJ+ieJPc6osKOdlrzF4a0tEKhPQoq1Z9QRCKGqaDCUnGpjqpRJHvDG1bS+PP
	 f0LcsMGtgDTNw==
Message-ID: <67fb179754d4d69a9342ca86ce89d659c7704895.camel@kernel.org>
Subject: Re: [PATCH] fs: annotate inode timestamp accessors
From: Jeff Layton <jlayton@kernel.org>
To: Yu Peng <pengyu@kylinos.cn>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner
	 <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+8b3bd9f8a06658479d4a@syzkaller.appspotmail.com
Date: Wed, 08 Jul 2026 07:15:54 -0400
In-Reply-To: <20260708080232.2564807-1-pengyu@kylinos.cn>
References: <20260708080232.2564807-1-pengyu@kylinos.cn>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BB
 MBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4
 gBLNMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI
 7Htij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/r0km
 R/arUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2B
 rQZBBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRI
 ONb7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZ
 Wf7ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQO
 lDSXZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7Rj
 iR5K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27Xi
 QQZ9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBM
 YXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwkIBwMCBhUIAgkKC
 wQWAgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWOd7SlPFzIYy2/fjvKlfB/Xs4YdNcf9q
 LqF+lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC
 3PMJj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoa
 c8UPc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3F
 LpU+CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx3bri75n1
 TkBYGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw
 87i2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2
 xjO+2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y
 +jNd54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5d
 Hxf/BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBM
 BAgAiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4h
 N9FK2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPep
 naQ6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub0T/8Kwo1qGPdu1hx2BQ
 RERYtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmBTgUWKN969HPRkxiojLQziHVyM/weR5Reu6
 FZVNuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR
 685D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8Eew
 P8RuGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0Xzh
 aKg3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyAnLqRgDgR+wTQ
 T6gMhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7h
 dMKnKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b
 24gPGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAg
 kKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjr
 uymMaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItu
 AXLYlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfD
 FOXIfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce
 6nOAON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJvwi6NmQ9P9UAuLG93S2MdNNbo
 sZ9P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVXhJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDv
 qrAaCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51a
 sjS9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qG
 IcJE574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbL
 UO7mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFyeWRh
 dGEuY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOa
 EEZVoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSU
 apy94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50
 M+LFTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5d
 dhV2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn
 0P91I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0
 jwSYLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7e
 flPsvN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/JNk8dtwmvWnqCwRqElMLVisAbJmC0
 BhZ/Ab4sph3EaiZfdXKhiQqSGdK4La3OTJOJYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7B
 AKidn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc
 8ftCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQg
 HAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD
 2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozz
 uxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9J
 DfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRD
 CHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1g
 Yy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVV
 AaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJO
 aEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhp
 f8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+m
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 16:02 +0800, Yu Peng wrote:
> syzbot reported a KCSAN race between fill_mg_cmtime() and
> inode_set_ctime_to_ts() on inode->i_ctime_{sec,nsec}.
>=20
> stat/getattr can sample inode timestamps while update paths store new
> values concurrently, so KCSAN can report benign races on these fields.
>=20
> Annotate the timestamp accessors with READ_ONCE()/WRITE_ONCE(), and use
> the ctime accessor for the remaining ctime loads.  This avoids the KCSAN
> reports without changing timestamp semantics.
>=20
> Fixes: 4e40eff0b573 ("fs: add infrastructure for multigrain timestamps")
> Reported-by: syzbot+8b3bd9f8a06658479d4a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D8b3bd9f8a06658479d4a
> Signed-off-by: Yu Peng <pengyu@kylinos.cn>
> ---
>  fs/inode.c         | 18 +++++++++---------
>  fs/stat.c          |  2 +-
>  include/linux/fs.h | 20 ++++++++++----------
>  3 files changed, 20 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index 31c5b9ee3a81..95e981b4e19c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2833,8 +2833,8 @@ struct timespec64 inode_set_ctime_to_ts(struct inod=
e *inode, struct timespec64 t
>  {
>  	trace_inode_set_ctime_to_ts(inode, &ts);
>  	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
> -	inode->i_ctime_sec =3D ts.tv_sec;
> -	inode->i_ctime_nsec =3D ts.tv_nsec;
> +	WRITE_ONCE(inode->i_ctime_sec, ts.tv_sec);
> +	WRITE_ONCE(inode->i_ctime_nsec, ts.tv_nsec);
>  	return ts;
>  }
>  EXPORT_SYMBOL(inode_set_ctime_to_ts);
> @@ -2908,7 +2908,7 @@ struct timespec64 inode_set_ctime_current(struct in=
ode *inode)
>  	 */
>  	cns =3D smp_load_acquire(&inode->i_ctime_nsec);
>  	if (cns & I_CTIME_QUERIED) {
> -		struct timespec64 ctime =3D { .tv_sec =3D inode->i_ctime_sec,
> +		struct timespec64 ctime =3D { .tv_sec =3D inode_get_ctime_sec(inode),
>  					    .tv_nsec =3D cns & ~I_CTIME_QUERIED };
> =20
>  		if (timespec64_compare(&now, &ctime) <=3D 0) {
> @@ -2920,7 +2920,7 @@ struct timespec64 inode_set_ctime_current(struct in=
ode *inode)
>  	mgtime_counter_inc(mg_ctime_updates);
> =20
>  	/* No need to cmpxchg if it's exactly the same */
> -	if (cns =3D=3D now.tv_nsec && inode->i_ctime_sec =3D=3D now.tv_sec) {
> +	if (cns =3D=3D now.tv_nsec && inode_get_ctime_sec(inode) =3D=3D now.tv_=
sec) {
>  		trace_ctime_xchg_skip(inode, &now);
>  		goto out;
>  	}
> @@ -2929,7 +2929,7 @@ struct timespec64 inode_set_ctime_current(struct in=
ode *inode)
>  	/* Try to swap the nsec value into place. */
>  	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now.tv_nsec)) {
>  		/* If swap occurred, then we're (mostly) done */
> -		inode->i_ctime_sec =3D now.tv_sec;
> +		WRITE_ONCE(inode->i_ctime_sec, now.tv_sec);
>  		trace_ctime_ns_xchg(inode, cns, now.tv_nsec, cur);
>  		mgtime_counter_inc(mg_ctime_swaps);
>  	} else {
> @@ -2944,7 +2944,7 @@ struct timespec64 inode_set_ctime_current(struct in=
ode *inode)
>  			goto retry;
>  		}
>  		/* Otherwise, keep the existing ctime */
> -		now.tv_sec =3D inode->i_ctime_sec;
> +		now.tv_sec =3D inode_get_ctime_sec(inode);
>  		now.tv_nsec =3D cur & ~I_CTIME_QUERIED;
>  	}
>  out:
> @@ -2977,7 +2977,7 @@ struct timespec64 inode_set_ctime_deleg(struct inod=
e *inode, struct timespec64 u
>  	/* pairs with try_cmpxchg below */
>  	cur =3D smp_load_acquire(&inode->i_ctime_nsec);
>  	cur_ts.tv_nsec =3D cur & ~I_CTIME_QUERIED;
> -	cur_ts.tv_sec =3D inode->i_ctime_sec;
> +	cur_ts.tv_sec =3D inode_get_ctime_sec(inode);
> =20
>  	/* If the update is older than the existing value, skip it. */
>  	if (timespec64_compare(&update, &cur_ts) <=3D 0)
> @@ -3003,7 +3003,7 @@ struct timespec64 inode_set_ctime_deleg(struct inod=
e *inode, struct timespec64 u
>  retry:
>  	old =3D cur;
>  	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, update.tv_nsec)) {
> -		inode->i_ctime_sec =3D update.tv_sec;
> +		WRITE_ONCE(inode->i_ctime_sec, update.tv_sec);
>  		mgtime_counter_inc(mg_ctime_swaps);
>  		return update;
>  	}
> @@ -3019,7 +3019,7 @@ struct timespec64 inode_set_ctime_deleg(struct inod=
e *inode, struct timespec64 u
>  		goto retry;
> =20
>  	/* Otherwise, it was a new timestamp. */
> -	cur_ts.tv_sec =3D inode->i_ctime_sec;
> +	cur_ts.tv_sec =3D inode_get_ctime_sec(inode);
>  	cur_ts.tv_nsec =3D cur & ~I_CTIME_QUERIED;
>  	return cur_ts;
>  }
> diff --git a/fs/stat.c b/fs/stat.c
> index 89909746bed1..c461c3054234 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -53,7 +53,7 @@ void fill_mg_cmtime(struct kstat *stat, u32 request_mas=
k, struct inode *inode)
>  	}
> =20
>  	stat->mtime =3D inode_get_mtime(inode);
> -	stat->ctime.tv_sec =3D inode->i_ctime_sec;
> +	stat->ctime.tv_sec =3D inode_get_ctime_sec(inode);
>  	stat->ctime.tv_nsec =3D (u32)atomic_read(pcn);
>  	if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
>  		stat->ctime.tv_nsec =3D ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn));
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d10897b3a1e3..e5b97e324db1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1598,12 +1598,12 @@ struct timespec64 inode_set_ctime_deleg(struct in=
ode *inode,
> =20
>  static inline time64_t inode_get_atime_sec(const struct inode *inode)
>  {
> -	return inode->i_atime_sec;
> +	return READ_ONCE(inode->i_atime_sec);
>  }
> =20
>  static inline long inode_get_atime_nsec(const struct inode *inode)
>  {
> -	return inode->i_atime_nsec;
> +	return READ_ONCE(inode->i_atime_nsec);
>  }
> =20
>  static inline struct timespec64 inode_get_atime(const struct inode *inod=
e)
> @@ -1617,8 +1617,8 @@ static inline struct timespec64 inode_get_atime(con=
st struct inode *inode)
>  static inline struct timespec64 inode_set_atime_to_ts(struct inode *inod=
e,
>  						      struct timespec64 ts)
>  {
> -	inode->i_atime_sec =3D ts.tv_sec;
> -	inode->i_atime_nsec =3D ts.tv_nsec;
> +	WRITE_ONCE(inode->i_atime_sec, ts.tv_sec);
> +	WRITE_ONCE(inode->i_atime_nsec, ts.tv_nsec);
>  	return ts;
>  }
> =20
> @@ -1633,12 +1633,12 @@ static inline struct timespec64 inode_set_atime(s=
truct inode *inode,
> =20
>  static inline time64_t inode_get_mtime_sec(const struct inode *inode)
>  {
> -	return inode->i_mtime_sec;
> +	return READ_ONCE(inode->i_mtime_sec);
>  }
> =20
>  static inline long inode_get_mtime_nsec(const struct inode *inode)
>  {
> -	return inode->i_mtime_nsec;
> +	return READ_ONCE(inode->i_mtime_nsec);
>  }
> =20
>  static inline struct timespec64 inode_get_mtime(const struct inode *inod=
e)
> @@ -1651,8 +1651,8 @@ static inline struct timespec64 inode_get_mtime(con=
st struct inode *inode)
>  static inline struct timespec64 inode_set_mtime_to_ts(struct inode *inod=
e,
>  						      struct timespec64 ts)
>  {
> -	inode->i_mtime_sec =3D ts.tv_sec;
> -	inode->i_mtime_nsec =3D ts.tv_nsec;
> +	WRITE_ONCE(inode->i_mtime_sec, ts.tv_sec);
> +	WRITE_ONCE(inode->i_mtime_nsec, ts.tv_nsec);
>  	return ts;
>  }
> =20
> @@ -1677,12 +1677,12 @@ static inline struct timespec64 inode_set_mtime(s=
truct inode *inode,
> =20
>  static inline time64_t inode_get_ctime_sec(const struct inode *inode)
>  {
> -	return inode->i_ctime_sec;
> +	return READ_ONCE(inode->i_ctime_sec);
>  }
> =20
>  static inline long inode_get_ctime_nsec(const struct inode *inode)
>  {
> -	return inode->i_ctime_nsec & ~I_CTIME_QUERIED;
> +	return READ_ONCE(inode->i_ctime_nsec) & ~I_CTIME_QUERIED;
>  }
> =20
>  static inline struct timespec64 inode_get_ctime(const struct inode *inod=
e)

Nice catch. We could also do this with data_race(), I suppose, which
would allow the compiler to do a bit more optimization, but I don't
think it'll make any significant difference to the generated code.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
