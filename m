Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793524219;
	b=VgR+HlN/0iE2BwFBjgM+XP1AV2QSNMExH6tpX6aq1oYin3au1fgDxXzCFxk553jNBF6O
	 R5bhMH5sbaDAuuGk1Ag0f/dUum139dd6LYjn4gI6rDJYd/WRBJ+fgVgNSTBQpK6XALlVT
	 LWmYtODhYYq450FVzeOIP3a5V0nJFdZ3EUErxHkWbDBa4YSkzsVrmt58xw9KJELbKfWQf
	 DIbHzEN0CLW4Zhc3URptnOV9n8O5bsxGrjINDCvZ6cjZYboyZtvpyHgYB7JAOen8PCPDK
	 uFWn/eQkzkXpzXBrVUfMqkuyUo3GU02fzOSbO3XG58J8KQe+DBphztb04arTaBgpseA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793524219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gTTKto2VYMGcWkyKED75nk6cPku1k/MvJQT0NXCO8iY=;
	b=tasJQJU2pSq1Bvaj9C25Wjvnprh9gzpNbBJ1hhHH6AF7lbtT/OsHjzEj1+1twCbx2qrB
	 TXmi59NIbaAZpW+qCQd0w+bW8YJjMDgZEp5TUwfvj8PDa5bdjE1pk52T6ln6mNtqWzVMw
	 xe7LGnD7aAXg9XiAW8iMEJM57l9QB2vFzqmUQKdFBmt+AfMuVvOn1jWucT25PFwxqfgra
	 Lwq9nP/TMmrCp+GbNxoI6PyU7bq1idUZZB4K82cN8WV0dQPr9BQthgbC2qOFrjbpmhtlC
	 3D+9Fmy+3jB3rpwKaBoJX5Zsu75kmwYTuAJmbhsELv10LZ4dzX/iBeVOjWGsIgRD/XQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W1xE5kE1;
	arc=fail smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EECD606A324
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 09:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EECD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W1xE5kE1
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so3150615a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 01:10:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793524218; cv=none;
        d=google.com; s=arc-20260327;
        b=oqSlbWnvUIJ24s8TmmRa9gx9qutUJmZ/r60gYM4HlqUv3rDNGlFENv07EY8wJIDSfX
         4l90IH4uw6mAB01g5EMrVPBmzr+Tz3adFmaoPNJcqHKx8jja1owbtRUGIPzbxps9D7Hw
         6/zatTJWG5bXujlVD3RgA+TsmHT9lAFX+Vw0yyx+2+r5xnfQk16j69wmys5Nt1CkgRIZ
         GjYe7fGKuG40o6zdyN3wIRIMfEsu8vwWQrdxKDluwMcOauD2cuTkRzqnIX1ymT91HAK0
         hqNzsb9+Lf7ujo2x3TDFX++7a28/Yn4fjvZdfraSP+/Bbl32rXfbJELNl53lGAPSgWuc
         DWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gTTKto2VYMGcWkyKED75nk6cPku1k/MvJQT0NXCO8iY=;
        fh=/FTXUMC0N6l6aOA9hcfvnkm50Z3fw1B60Ekhch4OrU8=;
        b=dN/B8Rb4jh3424dG8MPkuvfRKQBC3a7Qkyah9SdFsq4QyJj5Sapr4dguJIdUQGdI8L
         2HiD858WmT3rcM4hN9oe7Xw+efiNZtA0rQKB0cyHnoEUjQmnIupfBN9b4CGuNMhlVrlL
         YcFc6NiTT2ouZzJKa4B/j68McU8p652NYfYn3Od0740bIzOA0nj/OYoXQkUdVgET3v2r
         YplUcLyBh7KA/g7J9FfPbM7QaTLxqztJjIUp6V9tuD3A0nUiMKqdi7xgtATSxvSyZyhD
         26Fzi/pZwwSHP2vWvLx8OtdCUfrnC5UAd4psglo0T0mTaFeaHbq/uCW80IG5H+V0r4Xk
         /2dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793524218; x=1794129018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gTTKto2VYMGcWkyKED75nk6cPku1k/MvJQT0NXCO8iY=;
        b=W1xE5kE1yvTxtrGtxbF284NwqGriHRpG6uq/6xGfMIbok8mvKGWzLK2cTyK/Gyl46O
         LRGHg0mYqn8Q8NAyCebF5ZsEZHcytP2q2oawhhHnlW/FmDhFfilqSCHyV9TO8QjdJFTY
         HgdA412d1v13iCBQEzjbwXMl+jUGf3yTYrFQWqh9raOGrQEXJ8Td8JxPdeMMfdC9KPha
         MEXw+0UuWm8X3lSUUsqZpO8gYTuoUSA6MRkocH4PsmB4QApJZNl6hUgAMmvHGPKrv943
         e5gWNcY398BSvwYLFhBzsmnK6oxUyj0+H7mA3fu130aPPTvn7HsvtQH7vB/NInh4wkry
         IPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793524218; x=1794129018;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTTKto2VYMGcWkyKED75nk6cPku1k/MvJQT0NXCO8iY=;
        b=c+/D9RZDCnm2A9bX/JQVbIbRoC8bbvtZJH6gf38luCZgkC0Zs+GMvoXlUy7T2QFujs
         e4/mLBnxWspeuLsYNJ+VCh/yQEaQ8+QiGMs3yzlie/AmwJSry04urAsl59CLfYnLC1/a
         oUbJTtc9v4zsCXUt2vrsjds8mBjfpgPb7G4OSe+mqNPgwM+YGH2ZC/mD0UXXWwuSYbO7
         LKDQrOvCROzLU5iJQOEgEyrHPoIo4d4zO8uKnEPIhiXQ4vWte/RPDEQBFgWcMkt58Kgj
         lc2/MXbrV5S3WjAT2z4FhbhHDn+pxEBg5lKosYJO8DKzoLYmp4UmSzLEA0qSyHJ/gRsG
         F9pQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjxY+4wnEs9G5dRMVLK2pK7Z+iiYt+cGPgztVZR/hr7kTwm3fRevKbgu+Ir+wWdh6i5uqQgHw5zyVbowI8@vger.kernel.org
X-Gm-Message-State: AFq9FYJFzBwkNV/lH0QdJs9DJBP0dgP0Zyqs2g4t+e5xCCrPPndkjtVM
	JZ2i16xTwR/2e4D1NI1NwL7dEQWAqBGqpdZhDJMeBZLB6pZxkMALTV7CnNMmC2iE219KwFh63rQ
	U1zfXZKw/rrv17MgKYBsrYnIw6qU9Zn4=
X-Gm-Gg: AYBFou0gVUoNrWRkPOnRaFNL4cPkOS+oVksF4qXBdkLNMQpFrXcU2WTHb3k2Ev97Dnu
	XVe8D4+ndl2bRLtQanRPH6UBQH/r2SxPLAwiG9+jjPmcB/e1mixGkTd1j8KOwWqI1v6CKyNyoxf
	p2/+Glx0K3tic9uFb6Y43zJA0Czt2Ggufp5zozOSpspzNcCk8xEtE1xS95nyGpwuGMnlVNSctHP
	FkCamXBHSlzHdPJ0thE+mW7vwqDBULEK2hMrkFswHnJWnmawp5Ga9yzV6YQW3j82od2kaV9NzH/
	mGbInKc3Qop5VSC870rjBEkeGezJ6tabMViynFU2ZRcIVZsFDsFDai6wY/zPNbZYycY1ZtRqRcP
	vPa3PmAyKJwOT1gNJOvjfcW6N6UrRax3eJVzGWNh+0nRK5Bk32Acb9xQiZyVD+WMExNtc7g==
X-Received: by 2002:a05:6402:2159:b0:6ac:bd53:d29a with SMTP id
 4fb4d7f45d1cf-6b4d3376eb5mr3101530a12.3.1793524217756; Sun, 01 Nov 2026
 01:10:17 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030113201.2921633-1-amir73il@gmail.com> <CAGEkeHekpqv5ncd8tFP2v-OAy-ujTf9_RBbed3dgmTTAQrsPzA@mail.gmail.com>
 <CAGEkeHeBcz2Atc7zz6u-Evd40+AOBtx9Ke+REthvTppxw-vpRQ@mail.gmail.com> <CAGEkeHfrqbdHW801cjJLu0-to31SkH0Fc2K+OnnjFcsbjVDAkw@mail.gmail.com>
In-Reply-To: <CAGEkeHfrqbdHW801cjJLu0-to31SkH0Fc2K+OnnjFcsbjVDAkw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 1 Nov 2026 10:10:06 +0100
X-Gm-Features: AclHuK9aXJweUY0FXmVj7ilj_KjKaqclW9Ic0-fv7P-Z1kCumLZn6CfgziHGTKk
Message-ID: <CAOQ4uxgVAxxQwvLhw-2M_A-hPd7ZCqw76_H=2p+3b5q+xQGQTw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Overlayfs casefold fixes
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 12:14=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> > On arm64/QEMU with ext4 and tmpfs, both tests fail on ovl-fixes
> > (1d27da7de3f7) and pass with the series applied.
>
> Based on the two fstests and the fsconfig reproducer reported above:
>
> Tested-by: Hungyu Lin <dennylin0707@gmail.com>
>

Thanks!

I will send them with the next PR.

Amir.
