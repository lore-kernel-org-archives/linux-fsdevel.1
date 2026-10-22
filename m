Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792637632;
	b=IXBluSKTdPKg/Kbw9utn/4eQwUigedT/mC89+oi6iJMkkrpJ2+Kgkx6laU3hGy17+y3B
	 Fo1ir8N3w8iktxaflBKRsZMWE9yIeT1zZLckfaWoQfNZEdLwjiP1wvGCBsbXEbrmdsIh7
	 3Vdu+V9TdM/ZlpY6Kv9jSbF81fG3/ZzvVmcZjonZM//+jp7v0WuSkc3uHIaLs+xaKQ/GH
	 SVYv3zG4C41zvZXd0YGPEaBIo4210GeeWEvle0fTrqhJyO2h/aqVceQ+5jgFF57WVkCQe
	 GuL9MulifxllVANq5ZLWjt+Cwtlavg6Bzi4vcK+RhG4OwOami6C+Nbk8G/uG+W88FGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
	b=4buB36odqndcR7oLF+t1S7kSG0vVTi32FfBGS6PbuTRNJYKlq6O0p6/mwvVfkET6W5nl
	 UFJaeRlatBoh8mD9KaU7OUKImNh5hu1YhRaFJHc3rWJIHZJPZwzuLGJZ2A4fje+H5STWJ
	 fE43R3uV+rv7xmdVCUZFbmtJnK1ajvGZaDYkfURZGSnawWwdB5shxKdY6lrP2/w+jeHDx
	 n4kz64bRX3eH256rh7HFTrJXmcCqY02cZ/i5mzx9G+/Vggb80ls9njmbM/HGcIRnzIOvg
	 Q8cZXzyExID1Otv/5eLbaZd4OJ5nJJwn4JLGYsxWdInA/z9IDOu48yu0gSk7xpNiQbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="DTOI/Pek";
	arc=fail smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6C606A323
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 02:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79A6C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DTOI/Pek
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so195494566b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 19:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792637631; cv=none;
        d=google.com; s=arc-20260327;
        b=i0rZsrjCz71Mas9UvnGecrt+HvyYqWV+1zgzL4GQk0sNuMOQ0UMh4uczUyqCCVAGTX
         knJ3gxTXWls6L/j1zojABv0QNO1wsjH8T8KNwS9nZyoT0KHWSqru8N3h+aGKN5XbRvLw
         FRldsyKP1DEv+5SNv+JXGzZAICzbnihVhgwtiaNu/wAS1vJyaeg3klCgVJZ+JuhRS/QO
         iDaHDB70L0xrz53pAqys3EsEQRwhHtjgLluxffQX3r00AP4rCGgVtLUqFqJFRq9JbIed
         pYz/w/kyRNEzsxgaU0jFYfYgPW998p3SWjKbmvm2MZj4WsonypZTQEi5p0r7dWCKnmwu
         4fGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        fh=3kao5HY/7fso6zvetfwXqH3ubQ6K7823uZraBEo+QKY=;
        b=p6nu8Kbvh28IXR6kL7IGDrurH++sXvRhxnW8jypcJrJnOIkIc+e4kb5oK6WUC8HJac
         CAU0T8bK3sN/mMobktT811iaFvlE0+Ca6N0lv2Xh9h3vViTl4SPUUkZJ5zwJBoF20GY6
         cpCGqOLAto1EmylS4YDtioaM5RgEWCyBPAkk6KSGC8lj5bJJoi/DAhuwTEAiq6LQgb6b
         HCOTpCbsrPcNK5VGMXshQhNCQTB04DXc9qbb4eh0qUbfTXdlp4ro5jM+u3MobQaVVyh6
         7UzNnl2/m5olVMPndzb+l7J4qRThnTQNvaEkXBCbmcOOTYNjM797N8o7m2c6S/96LU1T
         0GTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637631; x=1793242431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        b=DTOI/PekpHCFwbCxS6btLnjWQNCiYVc9jJXCEYwAmPekEK8t/PxBNEKZNgCm5yMo5O
         ZHRqWqq6Sa4prnp5961iu97eKvO2fCe1P/oDhQUuXQyhe3en4gFePLH+ndAycKrOkdLY
         ZBtVPzCtW837QZIUsvIlXqXaajHAOKuqlnaym36x90uyaZGBsQGk0lDoH47TKDdTDSv/
         +bNghojo2jLNQuKI4CGPrg7pLnnWdQfj43K8C91aQyr5qb1zEo8L/J/KSRypGRSRs42E
         gu3hUif099K3NIyvd05k0+GuTWcbFOAPWaSRNh9N1gfC8G9MuampVJBqQHApn7d+PZp0
         CiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637631; x=1793242431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        b=zoguvCM1HwV4Y0cBk85ryoYNPCBKqS1961YqYxg0OwmNQWV5gqABHbpIzDrYzsgEKm
         7XqAnPgyk6BQWDPJBlyGd4sVDjhQn9FtBevMYjpp+7plwFUvSXel7dfjV7M3bKrygj5U
         wLx57eulWtpzvAs9L88eQeYNsKvessYiFMr/eshCWZ73tMyoXYtDszCs21A6NAyt0CY2
         1HDfZXm+hkN1Orgv4xUDCnCWSJtvSXn/Qk7nKzKIT2n1+7uofEUkgbnAFUS9Mj7hXrO3
         1LTevDzJK6TQhPoZfwziaoCAgXSc+VaPaLCBpBJMgIGYYb3rYeX+YbEp7nxUzLXQx8Ax
         2LxA==
X-Forwarded-Encrypted: i=1; AKwUvBxel1UJ1uBIy6XGua1rFDOS/rJgN0SZe2jGBiKf6qV97eheBTHUthKA5NW88O3b5hIBHaQY20eP37ZQyJN/@vger.kernel.org
X-Gm-Message-State: AFq9FYLxgCxsTy1zmIGtShfmsN0NycYB+xxWd9QTvjYCpE2bqoqAUmLa
	SoO+K0BVCdEwhSdbh+JK1dX0M+Msr+e1/wDibCQ7YmlgaPdm+BgnIsZhK6YJBWJAQMw8CwFSh8i
	PuOtyGRN9J5ntr+z/Ey+Sr6NyXDNNGeg=
X-Gm-Gg: AYBFou0Onyd6zt09mJdERNpOSnIaEo9Nvy4Bc56o+jxyuuz6W+1pDfBgpmV1AbHYyGL
	cyXLslRLeIhcYiWtLY4UsArt1thuLq9Yu3eUBmiXbS2dJX4V39QVAvGFTSDbCXJdc5dUPO3VGmU
	pbbenTeYZe0ybP7A6/WhKGrP6pkAsclyWghZe3zcjbhuGSyauRx0Nn6uhqVeIpDx5AwJDd/y6Vb
	fUG3/U/vf2b+cVYJt5BawjYf3EoGFiVWyCsI96uQQIfSLC3MSIHfB+Ej8HMWLwIIuFYUo/t7XZO
	pv7FdikMdUVsDgnKWxO0Wo9ylbFAr9nvvxpUCd9TOjHnAUfmdO36oBY9hrHiLqqtFc6DzY0ev53
	lgH4WLmJjP0AGUb12KFTEHb+WU84c79jk8fzhbpQQLyrTF9YB9qtPnaszmw==
X-Received: by 2002:a17:906:ba84:b0:c41:8e21:4d60 with SMTP id
 a640c23a62f3a-c46791326c1mr341731966b.1.1792637630664; Wed, 21 Oct 2026
 19:53:50 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792552161.git.jan.koester@tuxist.de> <f444dffc8e6bf98bf44c02456adc2de40e4ecd95.1792552161.git.jan.koester@tuxist.de>
 <fd20b840-350e-469c-9fd2-008fa0ded62a@slotpi15m67>
In-Reply-To: <fd20b840-350e-469c-9fd2-008fa0ded62a@slotpi15m67>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Thu, 22 Oct 2026 04:52:00 +0200
X-Gm-Features: AclHuK8zMCY_XzKvgZWVeEW29rK2WIKSmZA1a7YbTdfyZ3EtSnPZJ1CNUxd7pQ8
Message-ID: <CALWcw=FYKcDNXeArpsabHiQOAL+cWkF=L3stL6MB0OvVaHei1g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 40/41] nfsd, nfs: carry UUID and GUID owners as
 their text form
To: Chuck Lever <cel@kernel.org>
Cc: Jan Koester <jan.koester@tuxist.de>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, netdev@vger.kernel.org, audit@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 7:44=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On 10/20/26 11:16 PM, Jan Koester wrote:
> > Encode such an id as its text form -- "xxxxxxxx-xxxx-xxxx-xxxx-
> > xxxxxxxxxxxx" for a UUID, the same in braces for a GUID -- in both
> > directions on the server and the client, and take such a string (it
> > has no '@', so it can't be a user@domain name) as that id again.
>
> A bare UUID in an owner, owner_group, or ACE 'who' string is a new
> owner-string syntax for NFSv4, one that only Linux would recognize.
> Thus it isn't interoperable with other NFSv4 stacks as proposed
> here.
>
> RFC 8881 Section 5.9 says a string without an '@' that is not a
> decimal number means no translation was available and the receiver
> "should not use that string as a basis for translation into its
> own internal format." RFC 8000 Section 6.1 forbids bare numeric
> ids in multi-domain deployments because they collide; the same
> applies to bare UUIDs, and more so to GUIDs.
>
> If you are serious about pursuing this, you'll have to start by
> raising the proposed wire format on nfsv4@ietf.org before the
> Linux kernel's NFS stack commits to it.

I recall rumors of MS wanting to stick Windows SID in text form into
the NFSv4 protocol.

THIS proposal is even worse, in every imaginable way:
Stuff an unreadable 128bit blob everywhere. I am sure people having to
debug that in the kernel will LOVE the idea (compare blob a with blob
b as human,YAY!), and admins facing the 128bit hexdump will send
marriage proposals to the author, for making their lives even more
heartless and miserable.

NAK, -1, for the whole patch series.
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
