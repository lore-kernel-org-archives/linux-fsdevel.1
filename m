Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837356;
	b=tUbksDI5Znr1obRFfs09ljb962IvdJv9P+h4XytW9pVmupWuRw+RfAQwBmCQdvBgbQOE
	 JOICBGuTcDLsG0iP3+YjkM3ndo3e8kGJ9F3W+14L33e0JAaqnTPV8THgucd1cAbl64evJ
	 14Uny8Tr3W8LwYCOCO/arjrHxhh1ub408lGQn5tiouwCUYZkgZy6PcRsZbrma4RS4Dt05
	 D+IzzQZz2Nlw8X/D2eyJOZAL+VFPj2MchvErA3Vo3LLr1z4DwbHxJy09c3HHd+Nl8l1lo
	 xFeUhPsV/LFeBq1FUSpXqnt6X1BzJ344YY4jyhM4Um/d9DWuNQCFMlnsitfbb3OahDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HB+BFMHFfjLmudpcNjOWqHhQxCGm0P7UzEzu0uzUFsw=;
	b=gPOClwDR2suaBPV3vBHCw2mcCkRi5cdYXqUe/7Lb1O3QhdqgekGg38Z+V79JwnwmIpoC
	 jYtweOmnruiiM0pAfTUaHP3E3w6SwsPjK68doGFgr0JXP7IPnnmkIzMQBX0r6LhL0EhD9
	 NYEl+dfEnzTK3IP+DepcBTe09D3xYvgccOnedgQXAWDJplDI6gsJtrqIlIflSBacT9vvt
	 VyqwFSJpGwVR8i7nyiMw/dtYgoqjiALzX/m6uL425weiPpoa4MlmD5ZpEh9OG8s2ZQMNp
	 oB6rGvgUn2vJ2jUBNWH5pqCfsmttY7vDfOpHhVKLzicUXLDKXUgfATJaA9dOeVA9cRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QXaIFH6n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE6B606A334
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 00:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE6B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QXaIFH6n
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9f6a16afcso13315ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 16:09:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793837355; cv=none;
        d=google.com; s=arc-20260327;
        b=akkCRclrvQEHyPnau5ie3QksEyfqU6tKYrfoIbqgB9VGmRlZQT6EoLFF6iR/kgLj9k
         SOwR3EKe9+ZCqvkk1nuYu60xePqjNh6LqiPCWQ7X9Lm7YkdW2HDSQxV33T7GveVspkSB
         pqsAOP6f2HubHH6xGakwQg+nnY1MgxFmjIGdm01eTlY/P2ce6whTJS9cdFqFpmtWU5Nz
         P4D+efK2BUZw3OhHwnI0OIUirIU4lmvRaFNKazCcgsWVXjmt4hSDvkekSh60cg4OuAUQ
         DkaGLjq9eefOShZumCtBuDvErcG4OnNaCeidiV3KVbYxrY8/Wz61uYls5TgybEMhlCzz
         vygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HB+BFMHFfjLmudpcNjOWqHhQxCGm0P7UzEzu0uzUFsw=;
        fh=ObuZLgTLwKXsKSVQnxX8FC0NT3OQQ/1Dc2OIVa9sBlM=;
        b=mFPRwXviX8hWYfYcsTazNTTTKAGYNKWnROMp43+h4/k6XGuCcdNYfS2YhiiGqLAj4E
         U7E5bx3IuWw8N80JLe5RI9cr4Bg2ETrkopI72mMzHi0luxx9MGKYpyrNTCavyzpMmix5
         +btoBZD4W5JPWlK9PzIMYx6EeSjpADLYrQjaPjrNW8Grbbb1FUCL4OXJBY3txzdOvF0E
         5w9nlbrNf52uaHZmun/r22j4T4m1TycmXDcXGLI3QGHP4Yks78T3W7d6YuobP/rwPMDx
         k9SqcSTUIUR/u0o/SoVVWnYXS6CyMmKpCwLazlfO57tE/1b/wznsTQ6rbWzReaf5JjG5
         0N7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793837355; x=1794442155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HB+BFMHFfjLmudpcNjOWqHhQxCGm0P7UzEzu0uzUFsw=;
        b=QXaIFH6nvmIEpsYVHjgTv9wsJb6tDyNMc4WjxLp++EaO8Y4wKyte5afOw7KHG+4lIv
         l4znz9VzF81N7EuyqY+s4/BgMvgHQSZmi1yC34kb1lS4W5yZGnXVX1wmRO0XBLSYx2gy
         /acNcmtqotpkuHAf6vYOSQxro3wRjNZgKijJ5GAygdiELdsFI6DTL20MdwtaVDmdxAmP
         mu/uXk2dGQSy7280xtnyFGNAMlmy5Td+epcvzlusPsFo916i03FGi/u7nmHRzR804sa0
         YwoUSS2qnNUoZxeMpJIEcMk4r4/2pBYQNuiO02rAH6qluGOfa0eZ5OMItTP7TDMo07kb
         YkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837355; x=1794442155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HB+BFMHFfjLmudpcNjOWqHhQxCGm0P7UzEzu0uzUFsw=;
        b=G2VHZFio2jvNz1Lv/pIfou/mOXssu3uwAdHpX113szDJZXFmYmzjxBVEadqKN+7s0d
         masZkKnMhrAddz3eyf+TWIbA03rybyzzP9v+K4Rcu0H1+eM48+7B2ygh+f4jHr3e8vyG
         OzhgVAKfue1rofiSFpF8BBeCvYvH61BZOsWH+X8t7Fcj4IJOukt+yB1fb0Q3K5ZhfLSx
         lQ1EOpOJQwJn9m0Df/KpndP4svulQBAA3AV6NhSYskwR9MzwVDk3mdK5zWrBm81XYyfj
         ihpXe4i7DqWmcgoTYji56XkVxq8eH6FVjzUrCDeYIPpfbJzmepfQ1SSEGVIaT7Fylt42
         zeNg==
X-Forwarded-Encrypted: i=1; AKwUvBznbHSgkx6iqcotIjkVOY5NdqlPB1tyc1eN9kZFfpDNiD4qJ1oJAJfoUsipzw14cyayQM2KV/jTgwXFEVCY@vger.kernel.org
X-Gm-Message-State: APuU4Z+94MjzSbaU3qRqLA1NolQ/p8jDghe1lhiA24nJR2cxanw6Rqbc
	yaH52kwo4vsSD1UAjHekugS4Y+ECW2tfcDdKFNxc6bh6Hv2SRw8RxB/tALzeOxAi2GwbzVFOIxc
	ZyQ0I63XpfKANXeQLSqAs0SVhY5+M4Jprp7+B7gK9
X-Gm-Gg: AYBFou3insLTU7jaRPhTwtCMN83/2EFDT2+VdhSPkXdhwkUx1yQm7RHailyxjL9TPYq
	l8140jR46+uPpW4yH9dhlKjbd2+IzCAlevpCla1fSussf6MYdOXKVzkou7IpZYKY4ok8+1hbg9j
	N5/ickBjTzIT6CaSPVg1W6a6FWSbxvFr1d0n7F0gk2peyM7OpukAM3ri+rJdST7DCP2/Fj5V5D5
	ih5aLzPoAlPOVMOkCWwkRs/23AE4uZ7VhCVLqxTZ4w3qQbC5b7sqx55CuJdXMTZ9tr1gGvQYryc
	eneD5KI4dv9dOBAc1Z7qi8vwD2/2z1UZNxocV9Ysdz/esav377jfjD07Kn45qYGsmEeioqP8HHD
	4u1HuVC6Tq7WYMCdfgUy0KvJpBHsAm0fNGiKglgw5mHxJyos9qw0z+yV6srtKJogIHGR0YmkGqa
	Q3yzqeL2v8Uk1rxPNrtf1Sag==
X-Received: by 2002:a17:902:da4d:b0:2df:96ca:d7c7 with SMTP id
 d9443c01a7336-2ed27dd6f44mr1503915ad.10.1793837354522; Wed, 04 Nov 2026
 16:09:14 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-44-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-44-021c84d852e0@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 5 Nov 2026 01:08:36 +0100
X-Gm-Features: AclHuK9OZgoxGPef6pQV_HsS-hU8I1LV2S0BG0Ux9234a4e7Z7um8wA7D7hSN74
Message-ID: <CAG48ez3=6q6hqMcN-=q6qNrghHjbpXr+i-Su_s0siw25reBkWA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 44/51] proc: sysctl: resume readdir after the
 last name it returned
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 8:27=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> proc_sys_readdir() counts the entries of a directory and resumes a
> listing at the number getdents64() stopped at. The entries are sorted
> by name, so one that is registered or unregistered in between shifts
> everything behind it by one. Listing /proc/sys/net/ipv4/conf with a
> buffer that holds ".", ".." and "all" and registering a device whose
> name sorts before "all" makes the next call return "all" a second time.
> Unregistering one that sorted before the position makes it skip an
> entry instead. So a listing that takes more than one call shows a name
> twice, or not at all. Even the 64k buffer of ls needs a second call to
> find the end of the directory, so a device that comes up right then
> repeats the last entry.
>
> So remember the name of the last entry a call emitted in the file and
> resume at the first usable entry after it, like kernfs resumes after
> the node it stopped at. The entry itself can't be pinned across calls,
> unregistering waits for that. If the position was moved by a seek in
> between the listing counts from the start like before, seeking to an
> arbitrary position has never been better than that.
>
> That also takes one walk down the tree to resume instead of a walk over
> every entry in front of the position with a round trip through
> sysctl_lock for each of them.
>
> Fixes: 77b14db502cb ("[PATCH] sysctl: reimplement the sysctl proc support=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
[...]
> @@ -756,8 +834,11 @@ static int scan(struct ctl_table_header *head, const=
 struct ctl_table *table,
>         else
>                 res =3D proc_sys_fill_cache(file, ctx, head, table);
>
> -       if (res)
> +       if (res) {
>                 ctx->pos =3D *pos;
> +               sysctl_cursor_set(file, table->procname, strlen(table->pr=
ocname),
> +                                 ctx->pos);

sysctl_cursor_set() is called here, when the output buffer is too
small; but not if the proc_sys_readdir() loop ends because the end of
the table was reached and "h" is NULL?

Doesn't that mean that another getdents() after reaching end of the
file would observe the last entries again?
