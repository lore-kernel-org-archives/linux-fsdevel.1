Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D0480DFD
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534412; cv=none; b=NveLBkBSVGqrOweNNI4CfG/OI/qO9SPMvaZTcFCE/ysK4juouiUMpiyMG/GKd3j8Qldy/9EiYGz3lHlj2uSD5h5wmbV5HRajHUhXYKCU0pNzntnkSDr5t//GAW9ukYqnpGpqoOoFVhxFEd0foQsYm/9KVhtq6V9DQrQJAn3/mOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534412; c=relaxed/simple;
	bh=mKB64eFzBwevlbfHP4GHbGCdzZzNbk41FGpjUYsfux4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeZJyqz0x3BiZZT9jZatTIWbmyTJuEMtCrSuHHXo5JVJuin34eoYg12Plb+oS/L/VFWNExCZQHut9PkYbmWmdyAWb0eXnUggdLl4BRElrQRTxRqblEGnTJjMKfSwHFeG32Bv3oA/QeO2lw8p/9S2K8TJ3s2KakvJfXmFNjW7I3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NXY/JxGv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NXY/JxGv"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47de008b020so73314f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783534407; x=1784139207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
        b=NXY/JxGvymDRFrsijRMZ9tHdf1vok229JiWLzBHZwp/af9/Y7FHShzV1p28lfGDO0P
         Zjbde5zb79XSg/jwyzfbIjMg0JbSsUD456xvuSBgfX9elPAfqtA7LRQ4E5uq5/7exmey
         EqK3Ef4oiDQgW7SogTWxwIn9DFaDCNwAlfxgMTUAGHE1yhxkzaZ+/aNgxXqr5PJhJTbk
         YJ3U/xgt0mK8BckXQ4KsDSdGzsNpqaB1DoJXAjYrfk/nUDVL5XmP9eQo6rp9dUT4uRxU
         WqEtlylEfFx/GQK85wL6RWzG+tt8Cl+7EtXP6XzSYBHRNjkC+HgLsWCbnvW7fF2s9gZo
         WeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534407; x=1784139207;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
        b=jrV5/QoQBGDafineTg7gISicfb7HqCEiHO2J/6M1TwjtuwXilfnoJKyiz2uZ1tb4N7
         t7gJCQEwMCEMFNX83EFA/rJXyYrZKy9TAh7bY8PIuznX+g36cXFYrks9Igw0HGLafhe5
         Hvuqbkkf7OD/ktmPwRk/xCsP6BBn82ONnkXels1unUsi7ROYqJIBkSMdiowJ6tDghVdg
         DGe3wv9SrQLq7k/q7jy6dWMKjo+GyZ7dDcevzsHHPcBYHX5PDGViHiA1nZX5oMJd2qEl
         y8QvA79VhJrpsbLhkG4yRxDYCsu2kApFFOvlM+imPzu6ASvGGTIF8YZyf16R9QGngaDM
         acUw==
X-Forwarded-Encrypted: i=1; AHgh+RoAksKHffX6tnXFjvyQaB5me1DI8lIqhv0kYmQyzUf7wLk9mUfcZUydKFYMD/KXZ+fglC/MP6ZpwnPCwk2W@vger.kernel.org
X-Gm-Message-State: AOJu0YyTT+/dMjPS/Vq6Oo3bfBquY55OgO+5ymiGjz4Tq4eXVWbpJM+w
	urYwW1218BvgnuZ3AjjH7Of0/TeXxEEyDc5MNNO0LCsD8FmvXA1js5r6lHXhRyGzUmI=
X-Gm-Gg: AfdE7ckMWYbuXE4LHCl+zAy49j0V5FyKL3+R45LmAoLYqCno1O5YgPqh8UZDcy/GPWE
	0Cdel3Nju/KXx8Qsi6Ys0rLqMtyCezaKgSS7fT+irRrQOHN68S/wDk6/OIJ+zFnf1Vfz7swwQq+
	2/vWs6nrc6pE2DUDWT7zmE13LJIqg2jn2xNsohLia/u4ySvj3t5ABWaET2dcrBVLKCXRwNOdohR
	w3lehNgDHtlxLpyzSL/qSokl5apWvZv0FrgLEscqhUacI5aFRlozhXhQQy/cUW62cup2PHwdlmI
	WyBHJE7eKSdzuaC+KtC2QgNnPhn03inI5gbfxnk/7Vvd/7lZbs02vv5yy1f0e9/h1Dz/IY0N2Q3
	DFg6Aemp2udiQWsaxyj09rztZd+kr8aarPRf1h+DnxS4hTNgafeN8j4Kl2VKEusLzKB3fWL6v39
	AVdvFpunNJKa/W53vwj/nj3/AKQNvud2S//6TI4A==
X-Received: by 2002:a05:6000:460c:b0:473:c608:eeb5 with SMTP id ffacd0b85a97d-47de9a4f159mr9196162f8f.29.1783534406837;
        Wed, 08 Jul 2026 11:13:26 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm43325516f8f.6.2026.07.08.11.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:13:26 -0700 (PDT)
Date: Wed, 8 Jul 2026 20:13:23 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>, 
	Alex Elder <elder@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Michal Januszewski <spock@gentoo.org>, 
	Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
	drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, greybus-dev@lists.linaro.org, 
	linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, cgroups@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
Message-ID: <ak6STbqZd-Q-c56v@localhost.localdomain>
References: <20260708154510.6794-1-petr.pavlu@suse.com>
 <20260708154510.6794-2-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kijzkd5xnaepafl2"
Content-Disposition: inline
In-Reply-To: <20260708154510.6794-2-petr.pavlu@suse.com>


--kijzkd5xnaepafl2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
MIME-Version: 1.0

Hi Petr.

On Wed, Jul 08, 2026 at 05:44:29PM +0200, Petr Pavlu <petr.pavlu@suse.com> =
wrote:
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index a4337c9b5287..60eb994c32ae 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -16,6 +16,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/cgroupstats.h>
>  #include <linux/fs_parser.h>
> +#include <linux/umh.h>
> =20
>  #include <trace/events/cgroup.h>

There is kmod.h in here too but it's unnecessary, no module lazy loading
in this code.

Thanks,
Michal

--kijzkd5xnaepafl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCak6TOhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgY2gEAgOkCGIEUNQ8/AFfxYtdb
0XG1ZQXkD0d1Rm0cAq1+u8cBANw3nWI/wHkp5zcHmZWevxdnweU507gsyVTXzMGQ
ZwsB
=k+w6
-----END PGP SIGNATURE-----

--kijzkd5xnaepafl2--
