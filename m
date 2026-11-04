Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792253;
	b=Ovtf8Al8We8Ii6MkqhGC1P0gqSOJZWTkHZqixDnlU0WD3HvbS7IDKgmf0I2CFF/LM3gw
	 TcI2/4WpleXNJbKRUaRLrvSNyh+c4zHDpzaLevFpp/mm0hW6u3X0OEqMlVGSiM35A7kkV
	 530UNCeQllhpM5frV9JSsDE6HsRhxlGToVPhpTczcg1lQ7ngpEFhXgKOWatk76l5ig8KE
	 O1K/qgewLv56a8fsZeE8gYPfSqyvteEaeDIRTTBoPqmGjLE/oTtSmsHmdJ8z7UAvVfbVy
	 boS/M+R/6CA/sfN2dZUO2iL7whzpM/VOeoLCZ6sSKrgtbEsZ1wYbs3I9paHQza2xPhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=m1N2CPL6JIQI1DoRI2I/9sbG/YpOMPe6UrD3Lt2CabI=;
	b=2WmNLH8k8pD4IyX3VRGxMPhID778hsqJWdh4hJ1p8tPToH29QPAewgq/ZsgxnQCEowjC
	 cAiAR3HMHcvBNT3CIVKH0S5bBchI3/Jq7JXgeUXemB2vgcVY1gLcBxwDTjaaiwcJn224T
	 nn4FHEYwDi8Ef+iNeaaAkb20GlGNgsCJlrOyzEiul+q7yoRyUHdx211tlhUna/rcbRw35
	 DogFLFFaCbIdny4bLw+wBRH2c+BqsOS28LLTMN2gW5KcuiO1zQ+JrENLPzBuvV6XcBMT+
	 KArZJJ/93xhTz/XVU/flxx1Vt71uLIcBuGTtH/tnYzeHCcl5wB0ROiAXjGcEHZnPTLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xcw7KGuS;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E91606A33A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 11:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5E91606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xcw7KGuS
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48b060ec084so384521f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 03:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793792251; x=1794397051; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m1N2CPL6JIQI1DoRI2I/9sbG/YpOMPe6UrD3Lt2CabI=;
        b=Xcw7KGuSrQbG5Tb3P8/nfqRZmZgLRlBjOTNH+WvaQdBXji6cpW64IgeIjQL9XkRN5N
         KIuqrnkvCeZ/qHlLc9gcjGNmjJyZFj7y4yqbJkzF3XkSSuAj0jXe94VXz/qZvwK7oUKa
         SYVwGk0HKx36TB63oIZd927U/3+x4Ww9XmLRShldoZiZULsqohiqmuKn7MoV4IRu0a72
         cXrldU1rib80Nj3/ZpkMBtTjxKEI9xNlWpE48PJM3KnZNXH0FfUPDfckSru6SJJHB4MZ
         JcvNeQe+fGJrI+83S+u+Qjs/4b7EUSxjQKwmrmPqph1h3xota5ZdJKD87XMz/meO5L8K
         pdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793792251; x=1794397051;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m1N2CPL6JIQI1DoRI2I/9sbG/YpOMPe6UrD3Lt2CabI=;
        b=q4MCVuSpLdHT3iVahsODqHpKyFUzLKqyUoQNKuh2o/+DMjuLRt+tkCLUfliWaaZI5W
         nv3dXvXE6dBIY4QEpcQaeSxwTA6gTfXpwUKEua7xCXSwVm0Ky7qh5ffoDzFkz1xd3E1E
         cMjAjt1wlY3x7ZMuuQYPh/EHFVko6am5MUUcoo7INgaDr5oBxOCzSUS6e+ICJRzfRTZ+
         eS/HF4tdS1xNPwv2478grOFUZd2xqcswz1Uc1qJiC5zU9znQr2pT+pKh4uHdI1M7tILu
         CUefPQUDe1eTF0iB2krPlePOSwT7D+IrJMBKAteABF23YBjOxGi9zIF4xsbzHUS+1nvG
         N52g==
X-Forwarded-Encrypted: i=1; AKwUvBxHc/6CbmNzUAF7BJ3QPV/sxT/wruq37KY452lKK6S3PZOwc++z1hchYFguRjVq716ds2KR28E3ZYeCdGZ9@vger.kernel.org
X-Gm-Message-State: APuU4Z+yIYIz9J/aXl336Xm4yWpirMOBqdhwGL76PS6lligWld8L/Q/8
	pgu0i6OggLyaobyf7ZDxOj5SyT8XH1k2qph1EJ5cgEYn3YruG3G2PElf
X-Gm-Gg: AYBFou2SzdAaBglqA4pnQdkDdPmHnr/tGP16ijtrR4ZClCKagKbfwsS2DiFWRBMcaDE
	dFFoYivkRqDZGXr5uNG9iq7EBfrNcU0bdj+550UfBVexsNOHWm/LUHU9GTSZOX1muI056Eg6uRi
	jq/dYR6vPebl/C8QSbFkxhNeRs2oaKVIq88o/kU96Aqv7AxMN93QOa2su56ErAzDtXDLU4QacOe
	a0Zl0OfvQSX+AadxJAltQwueIKifqIJ8aY7JpNnZGZ7xhSeBGM7Nif19rU2EYmSmTue4wqi76fc
	YmjcEafuP2m+VpQngGWzAo6OCnGPVtLqb1ICcod9k2jLyuB80Ylq9eNQ+Sy66YguyxCYom+AVep
	kltqlOmNoaKlcYeYmGovLcaOJzYfGsrxhpjNsglY9HH+98XKygwywek8lHVrTaAYtZqRl2vplUI
	mYo2D/wP8ePKTg2u1IExTYnsMEmLrBAGlm0L4PjJDbI1/odxR0k9YRIWX8Kf9XocoZWUm8qs+w1
	2XJ15g95IuglHms+FtKke0++fOqf7u7yoGjWZwFQ6m04EA/z29Zgp4wDkRtHkoFQkVBZNCLKUUU
	U1NieVV0iaGmRzR8VJJYvs866NR8EgGctAug5GBgbNGTwuPHKo2jlzl5vZFa
X-Received: by 2002:a05:600c:83c5:b0:4a2:148b:c88c with SMTP id 5b1f17b1804b1-4ac17191017mr340673885e9.8.1793792250984;
        Wed, 04 Nov 2026 03:37:30 -0800 (PST)
Received: from localhost (mob-176-246-9-149.net.vodafone.it. [176.246.9.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa481a45sm122452345e9.7.2026.11.04.03.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 03:37:30 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=48cc1ad8402764d92e1376cc3050a9a9645276db561dde693e9f605d6644;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 04 Nov 2026 12:37:22 +0100
Message-Id: <DMMEA3RCJIIR.3M3VFS656X8B7@gmail.com>
Cc: "David Sterba" <dsterba@suse.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Chris
 Mason" <mason@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, "Sean
 Smith" <defendthedisabled@gmail.com>, "Andrey Albershteyn"
 <aalbersh@kernel.org>, <linux-btrfs@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] add provenance time (ptime)
From: "koraynilay" <koray.fra@gmail.com>
To: "Jan Kara" <jack@suse.cz>, "koraynilay" <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261027220532.736352-1-koray.fra@gmail.com>
 <upe7qvhod63zd724s7uiql6kanqyrcwplodoavcvqjt35vd4ee@s3iglizxejlr>
 <DMLN8XHASPL4.1R3MI7CMA5KCD@gmail.com>
 <unzslqbr7karhkgfxrcmjwgtps3byokmsqecyouqlc7aa6cszv@pgup6q2nxwt6>
In-Reply-To: <unzslqbr7karhkgfxrcmjwgtps3byokmsqecyouqlc7aa6cszv@pgup6q2nxwt6>

--48cc1ad8402764d92e1376cc3050a9a9645276db561dde693e9f605d6644
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Nov 4, 2026 at 12:33 PM CET, Jan Kara wrote:
> On Tue 03-11-26 15:26:20, koraynilay wrote:
>> On Tue Nov 3, 2026 at 2:25 PM CET, Jan Kara wrote:
>> > On Tue 27-10-26 23:05:30, koraynilay wrote:
>> >> This is an initial implementation of a new timestamp to indicate the
>> >> time when a file/directory was initially created.
>> >>=20
>> >> This patch series takes inspiration from the one by Sean Smith
>> >> <defendthedisabled@gmail.com> [1], but using
>> >> file_setattr()/file_getattr() as suggested by Darrick J. Wong
>> >> <djwong@kernel.org> in [2].
>> >>=20
>> >> The semantics of this new timestamp should be at least these:
>> >> - it should be the same as btime on a newly created file
>> >> - it's user-settable, so it can be preserved for backups, filesystem
>> >>   conversions, archives and any similar operation
>> >> - it should be preserved every time mtime gets preserved
>> >>=20
>> >> and the correspondence with the other timestamps is as follows:
>> >>=20
>> >> ctime <-> btime
>> >> mtime <-> ptime
>> >
>> > One thing I miss in this series is an explanation what this new timest=
amp is
>> > good for. Because frankly, I don't miss such timestamp as a Linux user=
 :).
>> >
>> > 								Honza
>>=20
>> Hello, my concrete use-cases are backups and filesystem conversions.
>>=20
>> For backups, my setup is btrfs and using btrbk (so btrfs send to my nas
>> with ssh) and the only missing thing from the backup is the timestamp of
>> file creation (which I'm currently working around using xattrs).
>>=20
>> The situation that prompted me to finally start working on this RFC
>> PATCH was when I wanted to merge 2 btrfs FSs and the only way of doing
>> that (AFAIK at least) is using cp/rsync, which can't set the creation
>> time since btime is immutable. The workaround I used was the same as
>> with backups, so with xattrs, but noticed that some files (symlinks)
>> wouldn't accept xattrs, so I looked into it and found out xattrs are
>> only for regular files/dirs.
>>=20
>> (also see https://lore.kernel.org/DMGS4KQLY24Q.14MUTR6U93GIC@gmail.com/)
>
> Ah, OK, I think I finally understand why do you want this. Thanks for
> explanation!
>
> 								Honza

Nice, thank you!

Best,
koraynilay

--48cc1ad8402764d92e1376cc3050a9a9645276db561dde693e9f605d6644
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRJ2XvJtXGwULYEerQ0bnTtJTDoOAUCausY8gAKCRA0bnTtJTDo
ODftAQC9g00TbhJ4fqkc0NSdA1KvBdO2hUflWG1D9U7QPJVKNwD/e1sMPB8EEpEs
oOjAe8fi91WQcNkFmUDPnwGV8y9PRQ0=
=eltA
-----END PGP SIGNATURE-----

--48cc1ad8402764d92e1376cc3050a9a9645276db561dde693e9f605d6644--
