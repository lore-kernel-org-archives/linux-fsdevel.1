Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872356;
	b=sQwkNh735xhmwGfYEBE7ZtvikmSO06l4c2YS93u4wd2DOJ6Mo18Eu1Ck0o80tVWLgcfC
	 JHOoFyhBm3e1J+FxD1Nbwnh5GTailJT9h1Ya/K9sUbmA1cD66OroWLTmXHiFV/AwyJGy+
	 0hm78NZV/ePVKPAOVNiOtc6i36l2P7o/O8Ue2LIICbngPd4XgUXkeozveEATS9j3cB6Nq
	 Yyf9HxJc8UN1XkRo2rjtZW8zeReasY1XruTYY6/adLzIdFHT8JDAGZWJCF5bcoV3mD0IS
	 45XiD2COywvVTl2zURRAl9pM5p6BiAFvTAJmT/dzC4nrPTAPwlEjwQ4+8b4DNyLYLlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872356;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
	b=nG59O8mDZGbAkrKxOfPQlh0ZM6yZUfZHekliWNzTsfk2NcSCrORYnoMc9DXS43511pm+
	 gz5zjZ45j8PsfMRCFTegCIFHXM0jQbN4Wm4A4g+BV8ye1jPG1R6VgyBYwBw3OWoO7eVwB
	 /p/Ez3xqoYFd7K/SfNFxE9cYpW1rnjxb6O/VtPlnBpvgk/E/PG1I6y7MZClHWjxf+Im3i
	 S5aH9Au6MJ+Eaek+hVgyynIZ0ucFidOWycrV7VQlS0l1ll82EBd5mkNTTXHcFKt8e/d+s
	 FZOqvetkM5RRzJZya0U8zpIJE7SWv5BdF7Z9tKtifvKlEFTfs52jiejdZIcGRJHwxbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D25606CC70
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 09:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1D25606CC70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93cc1ab5f6cso197423085a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 01:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872355; x=1794477155;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=yeB5YDrXhXWFB43F9NNui4BoNjZjm6yxHnakDM4dPmimZDZduuRMPWWxkIyynZCD6m
         2nXVllVe3pXeFfnBEV45fLYndXyJ3j3Cx4k3RrLXBeJwtMQxjlZNzmpaCHRi/ROYjkDy
         p1QVpYohpWZgmU50ZoVhHY4kqiEW03pa/ZmIVwE36AZ08hFyFSsQFe+oIxBrUTG/BHX6
         FjXCT9powsstPFy0N6lMnkaYn9rwvl07otoWgmQDLL8UswOcHibMI5Ik+icIClb60uFn
         NrMD0EWr8XZCFOF72eDPOEV0dVBQsAmLoEGDZUDTCSgccZcdddNARF2QleENMoA6/se3
         LeCA==
X-Gm-Message-State: APuU4Z/vsta9Pwxdrqq78dgV8USIlD7XfkzGXNo1KLDNpBIsfrWdfzFn
	p8DCKnpMcs6sAfud3aCpdsgsKh1jymy4kpZ7M0xUtdDetBdZ/N9XZ8y8W0nkjk7WD7E=
X-Gm-Gg: AYBFou0OmTfPUbpcXK8R2fboh72LVWD7YlgyABKuv6ZEbrgCtChB/vl+zctli78MHj1
	Ff9gW4Kjhx4+0I5ZeAycVVVtCuVx4p74mGw3AOihXfPs3s9PWtRXv/0I4ooa33WmgvXy3ZNz1ty
	jMrR42w19RYGvi/stSnX19eJVVHuMYQrvYzoGw4bNIrI6/w2e2JQ09s4FA8AfGYCVSAfx2Ho5QG
	b1VuJ51mhoxWEERkB//LePho12dZSLB20P8rE8PsAJO+wC3mNQ8jwrZXpOJsSQi8xHYrE6upvnk
	Bg67urJ9BFeb/53UXnubJoQ8cZEWIaRlr/ufFVGqTvhHd+9C2aC19C+xW2aIfJp0am9gaMyyNuE
	OqQXC56pfgB3tyXKU+5oYHw4BR0LyeSHA+03wsHNIg12LVR5dFeYK4jhszpcnCCHosnjx7kafDE
	WA23tx/gZWaNYJzbM8hM2NRwjouB5S72dx9pIeKnmZrrn6G/hTDoiioqX2kf200jgCljZLEqWBf
	1A8XwPveVp4gG84UGAlIOpoYMOxfL6mCPQDeRkHL26YoxhEikgSNTXm0SKx2qIZtVcXEMK3UDRJ
	GK3xQLJgNTagHaZJDbJWH4pZLo/sc0JMnYd2fZDqdIeGvUqpZKwCwWoasatTwUqZDv2XdA==
X-Received: by 2002:a05:620a:4612:b0:944:14f9:8ef5 with SMTP id af79cd13be357-944216f1f37mr3331432685a.59.1793872354848;
        Thu, 05 Nov 2026 01:52:34 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488e442sm422205585a.40.2026.11.05.01.52.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:52:34 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f269e335eso195869885a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 01:52:34 -0800 (PST)
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
