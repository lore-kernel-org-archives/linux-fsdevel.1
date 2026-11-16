Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872518;
	b=Prbt85EcF6RoIfGlxGCpAMgfRPx1Rq3gY+RhRn3JjNZZr7JnIYubLoM15ezZvumEi8Lc
	 PxgHC+QmApLrNjlPb4JCYwxJ5IwZd4dsgwb1wxuwTJmqvH5Wpu5DXXVKey9bUflG2wIU0
	 CfGm+bnAkBfDshLHS0oYSmsiqvngoxnplMmwpXLyVL2fQEzjmo7h2XgZj4Jp/7Las8hfe
	 WTNy2TqOndQF4uKMdCrM7fKUVF0+GZhMY83w/7oZ12zMmW0ns7Dm5GfpZUH+aiUSlwTuC
	 xra1dA7zO480cc2MW+J5Q0g94OdpWtJn2G+rwS+tBLw061pvkMIEwGMJ/YhoA0bGcSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LfK0P8wpQhjKU73faMZJ7aS0+N+WOnHsL569QrZcsKU=;
	b=it/74FM4zt0rSIPz11Y9GNBo9LiAACFOJMvmDeykMrVRFoDwH2+nyIe7FwLm4Tdb90CR
	 eqirdbl8N4l0wMrUoklq19SXSfe1gPe5l9wwy/JIn3VX/WMRn4vLAsrFh9OKw7B95/96v
	 DiCglXyk0rm1OQKMAb479XDwvkWNVfT3SBtm8Hu67nBrFxon3Ycr6zaMIXR1TQeFTCAVv
	 bUId3TlKZCj4IHtu62W9a9K2JJQ1MMqn2zakw2pqPPk3XsaCU8lfZamkW43baBJ/hJJDz
	 auvLI6wHoZJ1rkry1usRLTt40gYrW90W0V1vA6PsnC5+SpZYDtKPS3RN416uuE9IxbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JdtTDxg2;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AA606A329
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 23:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA9AA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JdtTDxg2
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c50dd1e2f11so229091566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794872516; x=1795477316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfK0P8wpQhjKU73faMZJ7aS0+N+WOnHsL569QrZcsKU=;
        b=JdtTDxg2OshVl5HbGUg/g/K8tqtpzSXsRw+dWKvLKKXmTrDoJenmWSadRI/ljuJccf
         7wk0mZn38OFN2LDLLbyGrlHWWq6f5pwNt2qbKdRXPXUQMeSDZjij66Y9MaJPPfn34Nrm
         n2hV7TprcOLQ34PZpxKvGrWxA2Qjg+J+mm+F7BysHJoYt0ZpHVZ0VRkSH1EH3JJ42tde
         7P2cLOnRkwBjiOlI28fM/z9y1dUJVzdkS5+UnzrzIryL6R8xGgDH4deKFO+FPqqo5759
         MfozIS3U46rx+lkCDA8uTpidJQmKhl3cp2CAliW7D+h+kNkntoC6DR728pbgrgLn+jDF
         4WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794872516; x=1795477316;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LfK0P8wpQhjKU73faMZJ7aS0+N+WOnHsL569QrZcsKU=;
        b=OvMTtsPOLyfL2BsgcigUTRH0fAMPsrCG8kMemluyiYlzZh/uDUzeoh9JjVXGTDMj5r
         OVuuda27ze9NZwlWUG5ZakxTWJdNs7c56yOXn0IdtqY3HbA0g/hwwDXPi8g9nLup13Gc
         1P0Qf8VnMspTTrfQ7EZBgMqbxxtU1Ea/Evca3/4nHKlxOgQKZu5N5FbMrH+fTmg7Bhe8
         dU/Q2jsJ0uxBEov88XkjJpTsL1A/rqUjFkChzfaMxhH4SgI6Uk1WmYko1tCgLd6BsZ1f
         LIcjcEWMeDQqQ/gyEMjYw7YNvtg9TzBp5ECC1fwrWjJ3jayZ5hn3NKHVS7FU7zi5xwUv
         YWRA==
X-Forwarded-Encrypted: i=1; AL+hErEZ+NN94jqNz87LY+jtzoqwxe0jejFhp44NMAxkYgTg5h7UqQ4Vx+VMKKXjRsyiVJgwF7RvpT6AS1T22zmn@vger.kernel.org
X-Gm-Message-State: APuU4Z+lpMn+fAAVIhRHzy2YSJAxk5bulT7bv52m54up5yzahSCKfW4V
	pnlhOqoWNdVtObo5yGV8f6nDhvF99S+uSKQfuKXlOryeTnOhxNjnE5qLBJ7e3MrCLHw=
X-Gm-Gg: AYBFou339VfnhttL3+SWPtEQa5SudFrM+rRfbStIxAddmDQMa+JRwobVVWInA970Men
	2LVUXQLNeBXQUUAoSK/5DYQ2+aXif9LOouXcW42qaTMeiUBJMgNuSVWXXM8qoBqQU17B8/R0lw2
	9LNnJahGUElq2rvncE3WnOjBWo2yXdtMp2pPewyUNUWOH2khR0l+ch3hKU5SK/mmblSyOy8KR/M
	qBu3Zeu6+Mvms+8WBY5jwy6zr7xFPkU79bghhr/q8gNBu3NR+ZvQPSGpkE/4a4Co0ZQKzsq5/UW
	W/tIA2WJpDVNy32IAqm4UQ8WGVGmMJvg2e52G7OBx4mB/nQu87S1R91lFHHBwZrRk4vMwG7ugqd
	k5hW03SkLvrY3aurZeQhkPOVitQ69J9dStP+rvfkWbsUnpEfucyb8tgiw6PkWoX5EUPXyGxaduG
	ndcb3OKAYurZrA0nBjoXIE9yjLUkLrr7ZsdBZkszPlIA52GuKY3uE9+G1JDwibyKYyCtVnx3wMD
	wKLK1bC7OX8r88Lli9gKczvgHyUsssDhlSeurAB1GmWWXK+kUW6WGxky1RptOJzfK+YNnqX2QR4
	+1mC6Rl/vPruK3eMa3PTiFEFl712gJ6qgJxIRVsFAx1R
X-Received: by 2002:a17:907:3e13:b0:c2e:3ed7:7db4 with SMTP id a640c23a62f3a-c5096340feamr1038815166b.23.1794872516213;
        Mon, 16 Nov 2026 15:41:56 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac2550e1sm1103294a91.3.2026.11.16.15.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:41:53 -0800 (PST)
Message-ID: <fc1f9f58-71ad-410e-bf03-8b27e607ab76@suse.com>
Date: Tue, 17 Nov 2026 10:11:46 +1030
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] btrfs: assemble a multi-device root filesystem
 without an initrd
To: Ismael Luceno <ismael@iodev.co.uk>, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261116224316.11237-10-ismael@iodev.co.uk>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ujyBQkUpLw5AAoJEMI9kfOh
 Jf6o8OIH/0mqW+TQM4m2x3hCsnK+oB4yJH1qnGvIhFF/Lhs48wI02sGh6/4aA0hkCDfd9LHQ
 +ci4FUepZ9y4VS01+oIExbg/8ytzGYTzLtb44jK2GBOBVSJkMiha6jp22XFt7WUkT/tvbreu
 WWdGsaJIRQaZChy7xsMI8lqQ2WdmluZJ4LT0wD3l/l6QU1ZseMGySebdY9sVOQEOJNV7Qj92
 /KOAFNmeZshV/qDI8Iw1RTs6TvLqCcqmlZLCmJkYSVhT1RonWRren8xIRcFEgMe004IDnt7V
 qdQhk/nhTS9x9MBAhMRl0TTE1VKDLvVALsud3iZLrmmtYvwPApzGJk052f0m28vOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ukKBQkUzDspAAoJEMI9kfOhJf6o
 SNsH/1ysUWOKmzY0rGS3ZdS61QgqMGhSWD/EJ4UiPw+xO4l4+GtX0fOAqxqsmBKqje3vyhBa
 Z5o/1Y+gNiN+E6RBcSz4b1TAd78sQ2bvT5DWOvBjeeVxHdiuQMIn4S8xk5ZpySBw5ifjoiuL
 0M33UVtJOzM8yfAeL+d/Rp4leJw72SutjkLyZTG/gJIp4pJGD/kFHn24OLL0IxEcO0gOekNZ
 os5e1R6jAJ2ILk7+MDnvU8wXHcCiVzuDhJLI1tih1uUIE50muHQJWbYuVBbdJeu8WlIDDssx
 UOCxLylNG3gDXV5MhLubPTOpp9OiFc/XC37nvkgEcrlmlOFBv4/NJCbECpo=
In-Reply-To: <20261116224316.11237-10-ismael@iodev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/11/17 09:13, Ismael Luceno 写道:
> A multi-device btrfs root filesystem is normally assembled by the device
> scanner that an initrd runs before mounting the root.

What is the problem here?

Is generating an initramfs really that complex?

Multi-device filesystems/storage solution requires initramfs to do the 
scan, no matter if it's btrfs or device-mapper, it's already the common 
knowledge.

I just see no strong reasons to do this at all.

And Sashiko is already reporting over 10 high level problems, which is 
not a good sign either.
>  Without an initrd
> nothing runs that scanner, so the root mount names a single device and
> the rest of the array is left out.
> 
> This series lets btrfs assemble such a root filesystem in the kernel:
> 
>    * mount devtmpfs on the initial root before the root filesystem, so
>      device nodes exist to open the other devices by name (init);
>    * let a filesystem tell whether it is mounting the root device and read
>      rootwait, and resolve root=UUID=/root=LABEL= values that name the
>      filesystem rather than a partition (init/VFS);
>    * scan all block devices for the remaining members of a btrfs root
>      filesystem, and wait for all of them to appear before mounting.
> 
> The scan and wait are gated on CONFIG_BTRFS_ROOT_SCAN (default y) and
> only act on the root mount when the user asked for it with rootwait, so
> non-root mounts and systems without the option are unchanged.
> 
> 
> Ismael Luceno (8):
>    btrfs: add config options for the root device scan
>    init: mount devtmpfs before the root filesystem
>    init: let filesystems ask whether they are mounting the root device
>    btrfs: add a helper to scan all block devices
>    btrfs: wait for the root filesystem to have all its devices
>    Documentation: btrfs: document waiting for the root filesystem devices
>    init: let a filesystem resolve a root device by UUID or label
>    btrfs: resolve root=UUID= and root=LABEL=
> 
>   Documentation/filesystems/btrfs.rst |  31 +++++
>   fs/btrfs/Kconfig                    |  25 ++++
>   fs/btrfs/super.c                    | 165 +++++++++++++++++++++++
>   fs/btrfs/volumes.c                  | 196 ++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h                  |  25 ++++
>   fs/filesystems.c                    |  37 ++++++
>   include/linux/fs.h                  |  10 ++
>   include/linux/root_dev.h            |  14 ++
>   init/do_mounts.c                    |  51 +++++++-
>   9 files changed, 553 insertions(+), 1 deletion(-)

