Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273738;
	b=g9TpPgpeKIkHT1X9II6/2w/S8EmioZ22bJrXWwe5K7gRUhrFRaCnVCUcFQuAMUtdzQ/z
	 zrvaP9d10kwf6ksLNh2Tsoac4/GpK1yXIU2Ec44T3UT75UXgm4vpXOjcKxHlFmH6WVpRt
	 PKPnECcIPRQR+xTBSrAIjR/5fSIVVhz0hL5rXPo4e+z1v7wS29mJ6+YJyl4OjJj4xIDx3
	 JYAdif7jtfhZSOPzpqSS//BcntKNr5xq72uVrcDJ+XnNFLYYHVklbDFHN1wfPf/AGugn1
	 D5DZjW9e1jtZyngl5X5mDZQbgrzL87RnSoQCBxPC4UWBXZv44zqTip0RIH+E6+R8dUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
	b=cj1PdwD5rABYpr+SP9HaCSDtJbTCcMZCRU886/PFgzqXDzodfajLg0YXfVtmj629gOR6
	 4tRMDr+ZqTuHoZqFLnFjFvS4+FgkWI2SAV7a7kYaLWKXWgCNECkr6bbVX0Kcaaz6ltfkD
	 ZZ8rBsaotjtfdCubX5zt4D2/vTo5IgAd/ZaG+ArdIZoTrIioMZbRTYMOqn2iH5aZyjpkG
	 C+dX0qjRG7t43jCa0SDRxjMw/yMpPH7KkDuKFOJbmACdf0T25HvbtApY2NY52wdNPrgqp
	 x8/rba1sKPC6gUse3D4qrYRfUNhVgzfqrBviBsa/hTrh00PuouRsLky8J5gmCb4aIPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=dNJoiYAL;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E6606A32E
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 01:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E64E6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=dNJoiYAL
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b577addee9so2038150a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 17:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273736; x=1794878536; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=dNJoiYALS5SsKN8KbMHxwA9DZYkzcdsAu07cbdxisVtvwMJ1/qgxm+wALuYDMw1/Py
         OH1YdDS23gryvsESVOm3lsTBMTBsigaTY5fxtXE7wiXACng9MrQaaLn57ciLKUVPlgh1
         APbCgfgKE8hipIXszPX0bh8bGWiYweEi0s2Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273736; x=1794878536;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=zy5D1ZVFxd5thZWbh2IpVlqg9lbXT/ZV3iJUC4CY39uxu8L5JHhmEcpw1RtuBQVPuk
         EpLeWGJEJAMzIJ8Vf6K0I5PiON2ja4G1mI5tPmbsw1xXX4b/xwrZb0jR89rSwbPCjcys
         AJAftIXkoJZo9ji1ZZ0MQk2XaxZn6rII8xqGgUVZO5BtAIY11zsUzI/14Je0x2miuX0z
         NW7wms5nG9Cvu52X8fYU02e+XKiz6AzLLjlOT0zvjKqmFEjdLHBSA0l0lnPrR5YFKxvI
         t4wWd1xs0Nhs1aLf7KJW7fn02j8tsXae2LLdo91ofQsNJOCzU75EuYFVyl2CABiIyggw
         lJRw==
X-Forwarded-Encrypted: i=1; AL+hErEpazOf1VJkJ6mdhXpMXivDgFZKfZMpDR5CGUG9V6iq+KuiBMiDTaKXU2lXo3mnF4qIipPe6Smt7LN9LwRH@vger.kernel.org
X-Gm-Message-State: APuU4Z+GjScYBc62gsgQThHG/VQvFdh5cL3fR7BOfO9OwbLwMEnYtEYz
	/Y1SwnyIeynUNORJ1TyqP/h6wcXB2L76se8iQFaL3neh4e9IslccB3lQwwtv+8z4qfh3j+n0DCF
	24vSdarJCxw==
X-Gm-Gg: AYBFou1RrSg4QAZy+mVXRTzb5r0tzDd2RIaakptVGEbaku+toZgZIumbChw8ZRtZHKP
	eJIy50chillcy/AJVZrwymJ4h6ZCAHrx2xtSC0fVXDaXzQt1OlFhtDPFYYVxla/YHpycJle6UqS
	ZSJEh4ePxtaFaP7iI2zpfUOKeF5NWU15TR3mqY8chRS6URVBDxRvAebP8XbknxIbOQnw7F0tyf2
	sa8c8rdGnCjf5LxmqEYOjlMGbygmq6VU5y1ugnK6eSN9YLiRG0j8ErAHv+aADeLkImm1IEJ32QK
	/kuevYRJ/8SF7MXlSuS6gFYw6ubUxeArxVF7WUvHcYYdDKiVEyzYLx6p17YMSC0lTZVHH4+JAYA
	id59x36ZkuuDw3eoL+jeX5f/zjuosJYm/WAt5IYeFhquQzaeQreiJ9MpZ9SAUTEv/5M//h/1tsz
	gbL34/QiM1fSW6kq5XyxytlazLLnQH4CzXz0aCJF6nS5gtBeLhzaDaGzrGebpHwaSo/p6yeDdKn
	kvCpNO92FIwb9PBZ5ciSl1kTNqwwcc9kU9cYO9hijNZACnYkT6ySty+5p+cKHncnzWd0wlqCbxb
	6PZKi3GYIBbPs+KxzJm3dbKv+GWkZlxU6DyL1Q5xCwWEaAK/2stgjmExZ+1wN0r2wtLID5aNky1
	16xK/lAsYNBWp2eMyqkz871M=
X-Received: by 2002:a17:906:f58d:b0:c25:4f7c:8ec5 with SMTP id a640c23a62f3a-c504965537dmr77347366b.23.1794273736285;
        Mon, 09 Nov 2026 17:22:16 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56f377sm42049666b.18.2026.11.09.17.22.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:22:16 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4cdc606b47so217314566b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 17:22:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHykjDVJtiEm6V4hPrVHgQXsZXgVRcyFK8LrGDeuSuDYKWc3X1bGP9/7I8LnMc5HJvYlcXmW5v4pYyAHR7m@vger.kernel.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus
