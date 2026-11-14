Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794660617;
	b=vwYDT5XAFYyFP5BcCNNyEmkqyrf9Qlx36hdQ5MpUSCTIyl6xRjB1kd/y4aM0Iowky604
	 X8MfYr6SfTSqkkGu0WD53rGxffrX+Y2aJOsv7RlId7/6gm2jyDrpkpI2eEX7PaWDFJXxd
	 GJEwGwVwUdFhng0Vww8o2AdoxK6paWP3Czb+F9UH9t/Nha1nuYSnR7zrTop/7yQKrnx4j
	 jSK8M3cLrJQ5mC2njRuDeZxTD5UnDALXWrrn7h29CGuXxsqsmowZzsAT3JWfMd2gVSPB1
	 mF+O3yhvjI1U1zqibEb5Pn5WzoC6tLVsj61t6Prz0qynvIvB8E+Swhxasd3l256AgNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6dkKz5yvSausCV1c/fbXQnDgv4ggD/tyHpRglM3aXlU=;
	b=dgnxgYVtHAWD2YdJ/weKZeM5Qi73mf71QZpHnksz/vX1uk3el1oUbQV4LyU/A5H/+GBF
	 6/FPefojRK9JtM11kllihaMpZ+Anx8r2OiX4oN1+pyR/NK3duQsb+gTHj7vXd0FLm957+
	 KKMoWhiheDMx35o7Pa+rL14aQUT0aGgOLT1z4X6zUySExdFXMcqoBos3/wWFF4+eVpQdR
	 7WvGYsIGeRvhv6+ajm13DoYr4t+szhh7ZAxEdGvj2oeHUWwL90kjKpVoRxKNSFxHrH0s+
	 mDEhO1T5gG2pmRFaIuB5VuTI32YqFhECjYU7PeHTGj9iKUGD+UX9Y8bl0tamtV9vlIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rHLxnGAb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B8606A32D
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 12:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C4B8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rHLxnGAb
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37600b0db49so2602694eec.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 04:50:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794660616; cv=none;
        d=google.com; s=arc-20260327;
        b=C4d2fH1jOH63u8zpgykoQAhtkW20SIwFteW6Suyjnvj/2MMlWZYeL1kUMR9FolEw1K
         IXoFm75qZ8jLx0/HULWqf0Z5KzkH4+cIBbI8sevlP3EJRgX2H8KkgipYgNnUGbf/BOuH
         Ig1ArtCgGXvfcqj2D7bYYmSUqFFNBjhk4msARxxrhCIZCvSquMUyI3fzbCPZg3FZc7B0
         NIKmd33cw5+8mT7l7MuiRSE+R72Odnr3YxO+Twp53mQ3mas+dIUv+SH9Z3KrkuKcTqvq
         mvZseiAE/hPlS4FMkMuc0ugQ5vF5bsP7heydatJNYyyt2VOW9cxyX6W6hOrkDQV477a2
         cL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6dkKz5yvSausCV1c/fbXQnDgv4ggD/tyHpRglM3aXlU=;
        fh=vj5uxjBbxQTTOSpwaSiHoH2BHO3A4XbOtnsFAzGyTa4=;
        b=NRi1PTkss4uuCk9bSFUY50GUJEZf/UFfR/AzAMLl91VWvPreZAtHsFQ8WaDdxEk3tQ
         z6WP6XI/Z6e+9RqphvFR6RfP4qlf7ODxvm5b+H0rYf+zSRhf+NIFY1e4gH9WRvrRlNiD
         Wkm0EvsyJz/pk+kMYSQWDYCo1rIUIiIXVnjlaaZMtkvHu3SWfyVE5fJxIlgz2HxQ4lpI
         4c6Kb8S5FzlTQqL0V36T0iycO4dHEpM/FAqHdmybYAz9QQBZMWpR5jUBbsJTRJg1Ywkj
         PW39Q1SeS/WVFB+uvFT0jkTtifYVWDLjTepzYEkrhgOZZmhSie82Ai/8lJdC7t/cyVY6
         Ek/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794660616; x=1795265416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6dkKz5yvSausCV1c/fbXQnDgv4ggD/tyHpRglM3aXlU=;
        b=rHLxnGAbFSmDpAxmVZJvNpdCvaeisiLzrYpTLQmYx9KMwRsWnPOlyDTMEwJXU2oc+R
         +rFSTlhBLkqQm5lE7fcQ2ATaGfunF5QpMjsozfS2ZPwnSj9xiBJP8hp9hWVWEm/rgQs/
         TE7rhoeiNtWYohZKRkPourE1IjEC3vPsiYcZ7x2k6V8qkMhJ05rQyAUXr7UtH5S1L+qB
         ZPDfHtuCTnmymz9uQHhfcRnwn+LQbb4qT6P3L/9cRHn8fR2irpm5Y2oqa+pY2XqmEloD
         HOFOavPKC86gWRu1zg9rQzhXx+arrrREhY/Zibc7nIQVVgxp2Z51cfXBIgKPFUmdpfBy
         BSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660616; x=1795265416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dkKz5yvSausCV1c/fbXQnDgv4ggD/tyHpRglM3aXlU=;
        b=stNTqCsZh0NRH1nbpj6v+3+ou9kueNY/y5j34MLslV9tT3uNUrgWV02SqzGx4fhjK3
         yOm79wHfhpahZNMpqXjM3aejd3laRPBRODHUA+hGr6gVxsYN4usB+X9ddmY6iU+tEP0Z
         hafBQmK5WDKNOXcr7a9BX9+u89b1WX1uHDmfvIFfFCCz+H2E/lEj2LH6oCwD49WNdZ1t
         Uid1coAdrlRX567BWwwmpCd5BiVlllkQJ5tiKtgURCFQ9ywziufxciY8XAfDZhBTsjl5
         V8zo/miS4T8EpsoG9RuOpj2aZzCr8xxCewgX16xFlfGx6BRwuaBJlh5wAHjweR2IgvKt
         iIWA==
X-Forwarded-Encrypted: i=1; AL+hErGBSe5vX7XSl6SOBALFzflqSnGUWAeN+04Vs0IsNTgaLWbmBqzytKLPgN0K2dlJdCrLBrdRIaiTm+3KVR6o@vger.kernel.org
X-Gm-Message-State: APuU4Z/T1wqM8rh641QURJGmHroH9BNclrCrjlowXmnt8rgCMgytnVUL
	zVeDwEjnoexYVADWszBay13IIHinxFY784rcYtST0nEOMcp8lek8b8vPM5SZ7w0/Y7z/3Jf1Ux7
	/iJWckdwEIsq5Rjy/Ue848mrlxrg4I+YZJ49i
X-Gm-Gg: AYBFou2z5sx4QEORYNGGxazBJLQjWIT1HLRlUbud6Zk+yT7EBxMxUAYpPKh6mt6AYDb
	xtjp8M2/RNPv7v7KUQZKlGpnF0DBqK9uHnvY4wwMQRzstHD7adXFkZ+OG6uxerdxeR5tOr8Xhag
	L5hfDeqItYCYXIVFwlms4zw0v6BscyQpZSKaM3zpxKrBnAKc0KGZLj0GfGFyUg55xAlMKTTK7jN
	9RK8urCe7+Pk1fIVaTmwbGr1Rdl5njNwvAHt700wDnmqFMX13qo4Ut3VuqB9UFvpBDyIVyyf7/F
	zi60MVWd4cM42JFYiAxuJnYAk9VjNlhI0lREvjdM0aQrWOYoSPcVWwrOLymI/ixmW6vQ4nypANq
	8Pwl23kv3N+BVW41zhtQQ+zche8bJl0mupFYd5c8BkhmBV92BxiM7A5suCA685onSYk6NM7gwRU
	91cpJKOwOwVAscEEz0eJ4ne60Y9ncoWLc7mjyys/+P
X-Received: by 2002:a05:701b:2608:b0:1ae:d447:6c84 with SMTP id
 a92af1059eb24-1b4f5f6471emr6935062c88.19.1794660614833; Sat, 14 Nov 2026
 04:50:14 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJ6F8CFSfgdZqaKMndGZtbaww32Xr_KVL3gA_2Jemgv9i9vskg@mail.gmail.com>
In-Reply-To: <CAJ6F8CFSfgdZqaKMndGZtbaww32Xr_KVL3gA_2Jemgv9i9vskg@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Smagghe?= <cle.smagghe@gmail.com>
Date: Sat, 14 Nov 2026 13:50:02 +0100
X-Gm-Features: AclHuK_R76m67a3L3t-pYvKsH2nE90VH0yHZRxCdMvakyYIbxZrTCTjMoJpBnWE
Message-ID: <CAJ6F8CFgkgksyk6YM3NdMkQNhSFWV4depC4c-mHvpDHpnjhM-Q@mail.gmail.com>
Subject: Re: [REGRESSION] ntfs3: existing files/dirs with ':' in their name
 became inaccessible in 7.3 (ads on by default)
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev, regressions@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hi Konstantin,
>
> Since upgrading from 7.2.11 to 7.3.4, files and directories on an
> ntfs3 volume whose name contains a colon are listed by readdir but can
> no longer be looked up: stat/open/rename/unlink all fail with ENOENT.
> Nothing changed on the volume or in my fstab; the only change is the
> kernel. This is caused by commit be310476e886 ("fs/ntfs3: Add basic
> support for alternative data streams"), merged for v7.3-rc1, which
> enables the new 'ads' mount option by default.
>
> Example (the directory was created on Linux and was perfectly usable
> with 7.2.11):
>
>   $ ls -1b "Game Soundtracks" | grep Reverse
>   Reverse:\ 1999
>   $ ls Rever*
>   ls: cannot access 'Reverse: 1999': No such file or directory
>   $ stat "Reverse: 1999"
>   stat: cannot statx 'Reverse: 1999': No such file or directory
>   $ mv "Reverse: 1999" "Reverse - 1999"
>   mv: cannot stat 'Reverse: 1999': No such file or directory
>
> With 'ads' enabled, ntfs_nls_to_utf16() splits every lookup name at
> the first ':' and treats the rest as a stream name, so "Reverse: 1999"
> is looked up as stream " 1999" of a non-existent file "Reverse". The
> real directory entry is never matched.
>
> Why I think this should be treated as a regression:
>
> 1. Userspace that worked on 7.2 breaks on 7.3 without any
>    configuration change. Names with ':' are legal on NTFS (they exist
>    on volumes written by Linux, by ntfs-3g, by macOS, by WSL, ...),
>    and they are still returned by readdir, so the directory listing
>    and the lookup now disagree with each other. Tools like ls, find,
>    rsync or backup software report errors, and the files cannot even
>    be renamed or deleted to work around it.
>
> 2. There is no obvious way out. The current mount line is:
>
>      /dev/sdb1 on /mnt/HDD_2TB_WD type ntfs3
>      (rw,noatime,uid=3D1000,gid=3D1000,dmask=3D0000,fmask=3D0000,acl,
>       iocharset=3Dutf8,prealloc,ads)
>
>    'ads' is shown although it was never requested. Following
>    Documentation/filesystems/ntfs3.rst ("You can use every mount option
>    with no option"), I tried 'noads', which is rejected, because the
>    parser only registers fsparam_flag("ads") and fsparam_bool("ads").
>    The only way to get the old behaviour back is 'ads=3D0', which I only
>    found by reading the commit message.
>
> 3. Silently enabling a new syntax that changes the meaning of an
>    existing, valid file name is also a data safety concern: with a
>    regular file "a" present, an application asking to create "a:b"
>    now writes into a hidden stream of "a" instead of creating a new
>    file.
>
> Could you please make 'ads' opt-in (default off), or at the very
> least make lookup prefer an existing directory entry whose full name
> contains ':' before interpreting the name as file:stream? It would
> also help to accept 'noads' like the other options and document
> 'ads=3D0' in ntfs3.rst.
>
> Workaround confirmed here: mounting with 'ads=3D0' makes the entries
> accessible again.
>
> Environment:
>   Linux version 7.3.4-arch1-1 (linux@archlinux) (gcc (GCC) 16.2.1
>   20260810, GNU ld (GNU Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Wed,
>   11 Nov 2026 19:02:39 +0000
>   Arch Linux, x86_64
>   Last good: 7.2.11 (Arch)   First bad: 7.3.4 (Arch)
>   The Arch kernel carries no ntfs3 patches. I have not built mainline,
>   but in v7.4-rc2 fs/ntfs3/super.c still sets opts->ads =3D 1 by default
>   and has no "noads" parameter, so the behaviour is unchanged there.
>   The kernel is tainted (OE) by out-of-tree nvidia and tuxedo laptop
>   modules, which are unrelated to the filesystem path involved.
>
> fstab entry:
>   UUID=3D717D6EE943D0AF06 /mnt/HDD_2TB_WD ntfs3 x-systemd.automount,uid=
=3D1000,gid=3D1000,fmask=3D000,dmask=3D000,noatime,exec,rw 0 0
>
> #regzbot introduced: be310476e886
> #regzbot title: ntfs3: names containing ':' inaccessible since ADS suppor=
t is enabled by default
>
> Thanks,
> Cl=C3=A9ment Smagghe
