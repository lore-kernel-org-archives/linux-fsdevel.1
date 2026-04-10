Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC63BB9F4
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775822176; cv=none; b=YGYQIKioKFAAJdviJm43R31xLHFwtJg/WckYNnpAWf+SnWi614kQQqcOZbHEtd50OBsErMftewvctWSQch6TEwkj84GcGYXCKIru77YSheJ+oRJIkpMdOL+U+vONZPfXkQjVK4TimzsrQ+Ux7YDUgBTUTpfgaMU87PyZTJb26yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775822176; c=relaxed/simple;
	bh=ZY8X2O/Wr2RHOJVZLLE+0oSeU68/RQ/yiJWe/aKivtk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fGvi/KcsPDMRzOP5As0nsTKYlo3GOf8TMdswoebsZyy2ygpCwbKXjUP3X4NUgXrBSO5vL73lMMvHpbOYqRl63O9bnxFc8jj4JMmhKoQvCp+h7N4r2knyqEr2QKTyk57+pv4hNaqPVOw089xmJdroYikgWfbayV+DDZoWj8ZXONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBG4ftiv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBG4ftiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4AEC19421;
	Fri, 10 Apr 2026 11:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775822175;
	bh=ZY8X2O/Wr2RHOJVZLLE+0oSeU68/RQ/yiJWe/aKivtk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KBG4ftivenzbInfv8ACormHdBnWhiILMl25Lk+uiXloT4SJgR5KydCC9bIfpTDu3b
	 uV3dJbWMQsR94JynM39pIir9LbACVpxh9TOauM1yLKvzo1zARU+ed6ECk68zRwTiDi
	 pHsYdKvv7TsuA3GCqMTMkutcnradVOibkoctF0oxNuf+xmJhnI4zq7cxWdhpSDEMHM
	 RcQRTgbXR17Hd22kow0OulTS8QLTgmF+ZlGO/RJUqWX9tnqC9bjWwqvUkWSSUpY2W8
	 +91PIJA+tEzfyZIuUF+YyR05LUG7rXymECW0m2MOvfIjEflrYA22bXJfKvT4CkPtrm
	 6ybkkuF2mIAYQ==
Message-ID: <ecd898202614340dced57f96a22542d4d6dbbf72.camel@kernel.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan
 Kara	 <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, Max
 Kellermann	 <max.kellermann@ionos.com>, Eric Sandeen <sandeen@redhat.com>,
 Paulo Alcantara	 <pc@manguebit.org>
Date: Fri, 10 Apr 2026 07:56:12 -0400
In-Reply-To: <ff5771a38b1977dc419c92cd466df03581e9bd69.camel@kernel.org>
References: <20260122202025.GG3183987@ZenIV>
		 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
		 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
		 <20260409190213.GQ3836593@ZenIV>
		 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
		 <20260409215733.GS3836593@ZenIV> <20260410084839.GA1310153@ZenIV>
	 <ff5771a38b1977dc419c92cd466df03581e9bd69.camel@kernel.org>
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
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-10 at 07:18 -0400, Jeff Layton wrote:
> On Fri, 2026-04-10 at 09:48 +0100, Al Viro wrote:
> > [this may or may not be the source of UAFs caught by Jeff and by Helge]
> >=20
> > lock_for_kill() losing a race to eviction by another thread will end up
> > returning false (correctly - the caller should *not* evict dentry in
> > that case), with ->d_lock held and rcu read-critical area still unbroke=
n,
> > so the caller can safely drop the locks, provided that it's done in the
> > right order - ->d_lock should be dropped before rcu_read_unlock().
> >=20
> > Unfortunately, 3 of 4 callers did it the other way round and for two of=
 them
> > (finish_dput() and shrink_kill()) that ended up with a possibility of U=
AF.
> > The third (shrink_dentry_list()) had been safe for other reasons (dentr=
y being
> > on the shrink list =3D> the other thread wouldn't even schedule its fre=
eing
> > until observing dentry off the shrink list while holding ->d_lock), but=
 it's
> > simpler to make it a general rule - in case of lock_for_kill() failure
> > ->d_lock must be dropped before rcu_read_unlock().
> >=20
> > UAF scenario was basically this:
> > 	dput() drops the last reference to foo/bar and evicts it.
> > 	The reference it held to foo happens to be the last one.
> > 	When trylock on ->i_lock of parent's inode fails, we
> > 	(under rcu_read_lock()) drop ->d_lock and take the locks in
> > 	the right order; while we'd been spinning on ->i_lock somebody
> > 	else comes and evicts the parent.
> > 	Noticing non-zero (negative) refcount we decide there's nothing
> > 	left to do.  And had we only dropped parent's ->d_lock before
> > 	rcu_read_unlock(), everything would be fine.  Unfortunately,
> > 	doing that the other way round allows rcu-scheduled freeing of
> > 	parent to proceed before we drop its ->d_lock.
> > The same applies if instead of final dput() of foo/bar it gets evicted
> > by shrink_dcache_parent() or memory pressure, again taking out the last
> > reference to that used to pin its parent.
> >=20
> > Fixes: 339e9e13530b ("don't try to cut corners in shrink_lock_dentry()"=
)
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index 0c8faeee02e2..b1c163f20db6 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -751,6 +751,8 @@ static struct dentry *__dentry_kill(struct dentry *=
dentry)
> >   *
> >   * Return false if dentry is busy.  Otherwise, return true and have
> >   * that dentry's inode locked.
> > + *
> > + * On failure the caller must drop ->d_lock *before* rcu_read_unlock()
> >   */
> > =20
> >  static bool lock_for_kill(struct dentry *dentry)
> > @@ -933,8 +935,8 @@ static void finish_dput(struct dentry *dentry)
> >  		}
> >  		rcu_read_lock();
> >  	}
> > -	rcu_read_unlock();
> >  	spin_unlock(&dentry->d_lock);
> > +	rcu_read_unlock();
> >  }
> > =20
> >  /*=20
> > @@ -1193,11 +1195,12 @@ static inline void shrink_kill(struct dentry *v=
ictim)
> >  	do {
> >  		rcu_read_unlock();
> >  		victim =3D __dentry_kill(victim);
> > +		if (!victim)
> > +			return;
> >  		rcu_read_lock();
> > -	} while (victim && lock_for_kill(victim));
> > +	} while (lock_for_kill(victim));
> > +	spin_unlock(&victim->d_lock);
> >  	rcu_read_unlock();
> > -	if (victim)
> > -		spin_unlock(&victim->d_lock);
> >  }
> > =20
> >  void shrink_dentry_list(struct list_head *list)
> > @@ -1210,10 +1213,10 @@ void shrink_dentry_list(struct list_head *list)
> >  		rcu_read_lock();
> >  		if (!lock_for_kill(dentry)) {
> >  			bool can_free;
> > -			rcu_read_unlock();
> >  			d_shrink_del(dentry);
> >  			can_free =3D dentry->d_flags & DCACHE_DENTRY_KILLED;
> >  			spin_unlock(&dentry->d_lock);
> > +			rcu_read_unlock();
> >  			if (can_free)
> >  				dentry_free(dentry);
> >  			continue;
>=20
> I'm a little skeptical that this explains the UAF we've seen. It looks
> like this would mostly affect the parent dentry rather than the
> children on the shrink list, but parents can be children too, so we
> can't rule it out.
>=20
> Either way, releasing the rcu_read_lock() protecting a dentry you're
> holding a lock on seems like a bad idea.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

FWIW, here's Claude's review:

  Summary                                                                  =
                        =20
  -------                                                                  =
                        =20
                                                                           =
                        =20
  The patch fixes a use-after-free caused by incorrect lock ordering       =
                        =20
  when lock_for_kill() returns false (race lost to another thread's        =
                        =20
  eviction).  Three of four callers were dropping rcu_read_unlock()        =
                        =20
  before spin_unlock(&dentry->d_lock), which allowed RCU-scheduled         =
                        =20
  freeing of the dentry to proceed while d_lock was still held on          =
                        =20
  the freed object.                                                        =
                        =20
                                                                           =
                        =20
  Changes                                                                  =
                        =20
  -------                                                                  =
                        =20
                                                            =20
  finish_dput() (line 935-938):                  =20
                        =20
    Swaps the unlock order so d_lock is dropped before rcu_read_unlock().  =
                        =20
    This is reachable from dput() and d_make_discardable().  The UAF       =
                        =20
    scenario described in the commit message applies directly here:        =
                        =20
    dput() evicts foo/bar, the parent's refcount drops to zero,            =
                        =20
    lock_for_kill() fails on the parent (trylock on i_lock failed and      =
                        =20
    during the retry another thread evicted the parent), then              =
                        =20
    rcu_read_unlock() lets the parent be freed while d_lock is still       =
                        =20
    held on it.                                  =20

  shrink_kill() (lines 1193-1203):                                         =
                        =20
                                                           =20
    Restructured to pull the !victim early return out of the while         =
                        =20
    condition.  When __dentry_kill() returns NULL (parent's refcount
    didn't drop to zero), the function now returns immediately without     =
                        =20
    touching rcu at all -- correct, since __dentry_kill() entered          =
                        =20
    with rcu_read_unlock() already called.  When lock_for_kill() fails,    =
                        =20
    the loop exits and d_lock is dropped before rcu_read_unlock().         =
                        =20
    This is the path most likely responsible for the production crashes    =
                        =20
    in T262643929: shrink_dentry_list() calls shrink_kill(), which         =
                        =20
    walks up to parent dentries via __dentry_kill().                       =
                        =20
                                                                           =
                        =20
  shrink_dentry_list() (lines 1213-1218):                                  =
                        =20
                                                                           =
                        =20
    Swaps the unlock order in the lock_for_kill() failure path.  As        =
                        =20
    the commit message notes, this was already safe for other reasons:
    the dentry is on a shrink list (DCACHE_SHRINK_LIST set), so the        =
                        =20
    other thread's __dentry_kill() would see that flag and set             =
                        =20
    can_free =3D false, preventing dentry_free() from being called.        =
                          =20
    Changed for consistency with the general rule.                         =
                        =20
                                                                           =
                        =20
  lock_for_kill() comment:                                                 =
                        =20
                                                                           =
                        =20
    Documents the ordering requirement: on failure, callers must drop      =
                        =20
    d_lock before rcu_read_unlock().                       =20
                                                                           =
                        =20
  Production crash relevance                                               =
                        =20
  --------------------------
                                                                           =
                        =20
  The shrink_kill() fix directly addresses the UAF pattern observed        =
                        =20
  in three production vmcores (od0103.dkl2, od5175.prn6,
  twshared90354.17.frc2).  In all three, the crashed thread was in         =
                        =20
  shrink_dentry_list() -> spin_lock() on a dentry whose slab page had      =
                        =20
  been freed and reused by kmalloc-64 or kmalloc-96.                       =
                        =20
                                                                           =
                        =20
  The scenario: shrink_dentry_list() kills a dentry via shrink_kill(),     =
                        =20
  __dentry_kill() returns the parent with d_lock held and refcount         =
                        =20
  decremented to zero, lock_for_kill() fails on the parent because         =
                        =20
  another thread raced in and evicted it.  With the old code, the          =
                        =20
  rcu_read_unlock() in shrink_kill() allowed the parent's                  =
                        =20
  call_rcu-scheduled free to complete, and the subsequent                  =
                        =20
  spin_unlock(&victim->d_lock) touched freed memory.                       =
                        =20
                                                           =20
  Whether this is the full explanation for the list corruption             =
                        =20
  observed in the vmcores (LRU dentries spliced onto the dispose
  list) remains an open question.  The lock ordering fix prevents
  the immediate UAF on the parent dentry, but the mechanism by             =
                        =20
  which entire LRU chains ended up on the dispose list may involve         =
                        =20
  additional factors.    =20

--=20
Jeff Layton <jlayton@kernel.org>
