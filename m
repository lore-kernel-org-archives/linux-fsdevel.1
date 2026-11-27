Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795796335;
	b=wa9EhYJEcq8mULbj2Z51n0T7bNNgbHV+C4MKU2KXCDUX8j75DEUihftjngOBVHkkLmTp
	 VVOtfqBNax6eQUkyU9qmeepoc5Vanz9/llOHOzzpH2lpgLhRkU9hRLjyRbZ4CP2TOSobR
	 rKfRyt6eJoikWGcz3Jctkvnv3ay9ZADaWgMURwKrOMmADf8FE36qNS2eo7pwVOcm8wj7g
	 V6pvAw2HOzSW7Jg+XXvLgAo+MrSlvrEX73/nzu+eEXQMNGe+1Y1UXh33RhZGLFXggv2xq
	 3YXGN6VEOgL3zYep2k+bLqoaeSAh1GdEA969QBWRgpao+7ZLjPAfSExwq2T4QHwithg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WcqK/TokdPrpJ1SyssRoGlfCD57QN3XIIcFf/99tphc=;
	b=mQ9Z02kn1pngZ5JGsoYFYLHjdh+YShyX6WlKFK8+SOklpLG1anKTzc0gKchO5hXjbq4f
	 aLRaAZJ3GYT4R/5ArCfT20H+i6HILuwDT2na+aX1GBUsqb7hyDcgC7aI0XOdWRRDB9QlR
	 JUf8/XKJ6dzxkjsDyKkSMf9v31n4X/j6RAAE/gZV5fblqgkxh97LETR1JQq/02rXiIHmK
	 G+z/XJI4ZN45dhcIWxsXfHmr4BRa0tczZDGd5cl7roBXhc296CDjs5pq2SR6XGp42UczG
	 12AB9wQHqt/tfPil/AscKA59N6lj0jeOvn8ja6iRW3wlfPwxQcUtswQWNS31m8sBwyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="naloy12/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B29D606A327
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 16:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B29D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=naloy12/
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b8a52db5f9so10101805a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 08:18:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795796333; cv=none;
        d=google.com; s=arc-20260327;
        b=Ul/Su8eIW2T2Wl98An6NlymQjc6a2BOiLQmGHDlzSq6L9uWER7qhNsL7UUaAkASdje
         yR5WqOjNnRxW0KgybmfaoBPhIEF6WeJMnHGM5/dmF8uuIEd7zNdjA/q0j2edkPeE8uSL
         ur2MThUf9RLQdudL2jd7MMH2hIGH/50565Kp6sw9H9V9xQgC3ZgQMqNdjF0OB7ATQMq4
         KpGz1+9CByOWj2puG9+VwJyj043uaAv7LUPI+UF3HxZeLUrh+vYmXpzxBymdDfghbl4N
         rI1H//A1JzgW0Zvixdk1DnR2t+BJ253er0asUtT7bnEjNUF+z+YTE7IxSuzfFrNhY09y
         x6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WcqK/TokdPrpJ1SyssRoGlfCD57QN3XIIcFf/99tphc=;
        fh=0c8RqHsmp7HeBQK8nsIr/KCsotrTrBszpTXjKqcXVv8=;
        b=pn9zVSINEc+RZM4cK3heYYD/UyaCqAMVFo4f2bny7EOMkkYq41Xy7zO313MUMyBnNh
         zIUKMyct0qZk5l3WON/UltLRzBzVB3wMwAhGQxc+YRITl5O9eIygqGnRY35JrRpZ4yK+
         yuEdJ4s69UAgmOewwT0LFAnh2KdrX7FaKqJ9tocC6vuERjn4Ws85J1kWPnZJYLgzJ4al
         aMrwF7rXQfu/UZEQshwgl2bfpmFkWlcAjgaRwHivBwprX1OuF5L15tLTAVpBeN6u4FeD
         JukJzshfEBUpg5+SCE6Gczz8DiWXTsEPsbgWQg2lgrRzoQmKL9xaT7ShgORUyMDXvcT5
         v5Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795796333; x=1796401133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WcqK/TokdPrpJ1SyssRoGlfCD57QN3XIIcFf/99tphc=;
        b=naloy12//Z/JEicfOBVG7/emu8n6hsVyuTwhG/APX5YJILPJ+Ejhpn8jBE4NDP7/lK
         g0UksYAE6Bdao6mTsS9kfqJqJTBy4iSLcQUfz2p6ydY9idCCIBNNnumqk9ahTewMQrhJ
         T08f33nweDrOyw3pKSkr1Qkrkked0vr7ZHwRDHta+TN6WG0oGzqsuhDrEOx72fBh5WU0
         oYgUXVXd1tU/mzTeQ0mzsTJviZuAX74N/jPwzeSjBiwxnyK0h0TealYMchARBmDUZIOX
         ViMp+AC7Q+jtL9fE4jDvp/Jor7sArB0DX5YSBPvQ3+fL8nmRlQu5cAOGwV0tlnPOhQ6L
         rUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795796333; x=1796401133;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WcqK/TokdPrpJ1SyssRoGlfCD57QN3XIIcFf/99tphc=;
        b=YmV7Fih00voUAmglIQiP9NqRWuL9S2KF3wHr+OXsHcWos9ywf4unbgwHFaRAxBpk0f
         TdOkArTyJ5fiwS+2nQybE5YuzqLaaCKHK2uBjBUkXHrUKuItu+8jZWQlh5WS6gXSp1e0
         swjF7wxEgrtT27Cwz7FEty7OymU/eSacLCjcjptR9E5WEoRDqjn4IiLfMT68Sf1iFTOe
         1g4VW7a+v/M/KvWSwL5hwUxeDqK8+gds/LswQLGE9sexoms7YhScIbJfwcOB9m/VUig9
         vvRklV/qRINtQeU0rVgmDQS8ypy2nl5PfaI89hnDT7OLhIT1Dq26a1h1SM6WrfY7TZoV
         eTGA==
X-Forwarded-Encrypted: i=1; AL+hErFC+ks9ogftBUfvN5aa3Baejzxg/txpgOa9Q/5LSxBym6RS1fga3aca5xZXlh4kEaQydNcnhZOiPY+DWfeS@vger.kernel.org
X-Gm-Message-State: APuU4Z9rstf91ZvqLgLbdt02QwQb7ugqaTmQNaKYzf9atKoCdajLsc4V
	Rz6xhavzisx8y3WO9QbbSSrG0krXs3nG1pLg9zT+6UtHs0uSRPGAsNgKg/JMEN8+W6tT6lyJK3E
	M4C6RBIs0EM7ul4d24A2vYgMRTkFvhYI=
X-Gm-Gg: AZFdTZdV9MrZYQuB0opZrJeWUNY8J6tGTBGMz+6sAxul2E5PS2obrr5daN07cjVe6iB
	oldCTbdCCy27jefb1KUvvsdh/kfN6eCLONj3sosbEKQODBoG5Z3mCxqWTHCZx3rMYBVjBr10rQl
	UCpTFOPeD4qDaosx/IInJF1GcI3r+aCRVCnKx843zMqRJRPQEYU77EBLNnB6iTcMyoOD3iMjUQD
	JK4ESt/GRpeQNv8gP50bSyplSUmByNCzCA+SjuyKcmAGImkboYXVkl3Bn44UjeiNsMscVG55raE
	vZCcapSU497sYWnVa6cL+nVmE1psJVs5radxVfYoz3arYrFFOZ5QPGXF/1BXQhuhT+44GNXzBTg
	CSzozYQyzXmqXjRObT6Oui4elvfyJtc04mDPFW7IiOYGZOrNJlzR7EFAgCIA5Y6PzQF0BCg==
X-Received: by 2002:a05:6402:e05:b0:6af:80c4:8981 with SMTP id
 4fb4d7f45d1cf-6ba37e890fcmr19985269a12.26.1795796332918; Fri, 27 Nov 2026
 08:18:52 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <DMZ4VQ7SZ07T.29WMPQ0BQZGSS@gmail.com> <20261119153222.65195-1-lauri.gates@gmail.com>
 <20261127-disput-nestbau-wahlparty-c189ad680243@brauner>
In-Reply-To: <20261127-disput-nestbau-wahlparty-c189ad680243@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Nov 2026 17:18:39 +0100
X-Gm-Features: Aa3M54qCjcbbYjv0mzgNqjSQ7Sw_WVEr_GJN4PX5Bm9lrA0JqzVoRsl7zVlER60
Message-ID: <CAOQ4uxhE38TnXseMOyWY1OvidBWew2hAYAV+rYeTPaqRYZb45g@mail.gmail.com>
Subject: Re: Concurrent FIEMAP on reflinked files serialises on the AGF buffer lock
To: Christian Brauner <brauner@kernel.org>
Cc: Lauri Gates <lauri.gates@gmail.com>, koraynilay <koray.fra@gmail.com>, 
	Dave Chinner <dgc@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 1:44=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Nov 19, 2026 at 05:32:22PM +0200, Lauri Gates wrote:
> > One constraint for that case: the flag has to stay out of
> > FS_XFLAGS_MASK. As I read your fileattr_to_file_attr(), every bit in
> > FS_XFLAGS_MASK is reported as supported on every filesystem, so a
> > plain flag there would read as "supported, not shared" on btrfs.
>
> Right.
>
> > Christian, with this mask on the way, would you take a plain flag
> > (say FS_XFLAG_MAYSHARE, "may have extents shared with another file")
> > that filesystems advertise through fsx_xflags_mask? If so, I'll build
> > the RFC on top of koraynilay's series instead of using the inverted
> > FS_XFLAG_NOSHARED.
>
> Yes, a plain flag is fine. It's simply the stx_attributes_mask model.
> Filesystems that have support raise the flag in the mask and everyone
> else just doesn't. I see that Amir's busy discussing some details in v2
> so maybe base the RFC on that series, I guess.

FWIW, I think the v2 posted API is a solid candidate wrt the UAPI -
The AT_FILEATTR_ opt-in and the struct extension leave very little
open questions - the remaining discussion over v2 and obviously needed v3
is around implementation and the fine details of the contract, but for a si=
mple
readonly flag like FS_XFLAG_MAYSHARE, it is very clear how it behaves.

Thanks,
Amir.
