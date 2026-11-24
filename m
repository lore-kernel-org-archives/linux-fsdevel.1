Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539878;
	b=C1g7VNvUfXuzph8g+jjajbHUSNPQ8eTgBvyAf4Oxv3WWTCN1tReE4dzEn8uDa0jmrSbd
	 LEVL3K4GUcK4cC8TkQfdiDg60H1eGN30PX56loS7eHhff1NVJ/weWwJo2GVqK0XQzS6zz
	 /mDN32ziI9c81RZYJSLG6pRzrRVy01B4O1EGKrl9uDk0SGwyLNORfw9z6YBcincpiDHzc
	 I7KkMdDh7q2xLye9kdkC2e9+h04MKYPpIybOjA9L04eM2d5VAaKRJBwQuNJnYmEoeOdNl
	 SIC97vpJYSOyGw74x1CSS92Iz8VTuhkxEzupB26PuBQhRGBDoD60XRAebrnKbE4Aarw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539878;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=amr7RgsA5dUsK8sbnMNPwEulyxVHPRB3I1arTSwM8mc=;
	b=1PHOVBfe54PRSs0AGmg7YylAcQVQzd1zRmg56wylU0BTltyVL17lNYxvZQ0YM1sF8ef7
	 IqiHmZOVCblysq33vogVFo+pkSe4nlBO8ZMbcz8VVrxbjsf7phyUqbyyRodt6v4CiJH9h
	 NMVrjyTymdftsLw2fIUQLiTqGyrbwj6UZP/uVxMBbjAzKbykAy/1TOqmdXOUINGmy1O39
	 LFlDFQjl9pRZ6BNRNxA8RZDLDwlUgZgwU8ZuGLP4J3J2xorfiGgC9sDlMsysXUP66aC+w
	 0ogN34ggxShW03bEAlg+FCsbpeY3cJz53ZSIhXKVMSIo2YgIYdfrPffYA9dAlKRQjrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ANr3jPol;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15620606A31E;
	Tue, 24 Nov 2026 17:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15620606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ANr3jPol
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	From:Reply-To; bh=amr7RgsA5dUsK8sbnMNPwEulyxVHPRB3I1arTSwM8mc=; t=1795539876;
	x=2110899876; b=ANr3jPolpYo0UStQ6O6HE9hmvt+ODMTtNylbPyXJX3dyozUO8TQP67jyaMM39
	xT9z5tombfPKGPodM9WLTb+7yyGUCPSFXPWnxvxDrKfnzgbc/1or26WlvKRO3VrN6p15BR6/mjOIh
	NhnEBMPqdJ+tgA11BzQhCicvc5XEJX7AX+wNihoXRQRvfQNJfAC6UlwfbKd0QvRbL2naDLG65sNYN
	v06eUxIFcW9IqKYIKK6ORu6g3B3/pICJ3XkGbOp8oE/MC5HTot3EhcxzRuqtAf/TKGC4UjljAY0i+
	O6Qv3hdDYgwMOzTcYCap3nnOW76MoRvHsLBwcuZsPSUts3crfg==;
Received: from bl17-56-70.dsl.telepac.pt ([188.82.56.70] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xVtwT-00000003ZOX-0Ggl;
	Tue, 24 Nov 2026 18:04:29 +0100
From: Luis Henriques <luis@igalia.com>
To: "koraynilay" <koray.fra@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,  "Christian Brauner"
 <brauner@kernel.org>,  "Jan Kara" <jack@suse.cz>,  "Edward Adam Davis"
 <eadavis@qq.com>,  "Amir Goldstein" <amir73il@gmail.com>,  "Miklos
 Szeredi" <miklos@szeredi.hu>,  <linux-kernel@vger.kernel.org>,
  <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] vfs: fix file_getattr hint to request xflags
In-Reply-To: <DN3L6DY60QKG.184FB9CISL5SL@gmail.com>
References: <20261124150108.189282-1-koray.fra@gmail.com>
	<87se0qb42p.fsf@igalia.com> <DN3L6DY60QKG.184FB9CISL5SL@gmail.com>
Date: Tue, 24 Nov 2026 17:04:30 +0000
Message-ID: <87h5h6b1pd.fsf@igalia.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24 2026, koraynilay wrote:

> On Tue Nov 24, 2026 at 5:13 PM CET, Luis Henriques wrote:
>> On Tue, Nov 24 2026, koraynilay wrote:
>>
>>> When using a FUSE mount over an underlying filesystem that supports
>>> xflags, querying them from userspace with file_getattr() strips them
>>> because file_getattr sets flags_valid =3D true so FUSE uses
>>> FS_IOC_GETFLAGS instead of FS_IOC_FSGETXATTR.
>>>
>>> Fix it by setting fsx_valid =3D true instead.
>>>
>>> Output when using a simple FUSE mount that simply forwards the ioctls to
>>> the underlying fs:
>>>
>>> before the fix:
>>>
>>>   /xfs/file: FS_IOC_FSGETXATTR: ret=3D0, projid=3D69
>>>   /xfs/file: file_getattr:      ret=3D0, projid=3D0
>>>   /ext4/file: FS_IOC_FSGETXATTR: ret=3D0, projid=3D42
>>>   /ext4/file: file_getattr:      ret=3D0, projid=3D0
>>>
>>> after the fix:
>>>
>>>   /xfs/file: FS_IOC_FSGETXATTR: ret=3D0, projid=3D69
>>>   /xfs/file: file_getattr:      ret=3D0, projid=3D69
>>>   /ext4/file: FS_IOC_FSGETXATTR: ret=3D0, projid=3D42
>>>   /ext4/file: file_getattr:      ret=3D0, projid=3D42
>>>
>>> Fixes: cb184dd19154 ("fs: init flags_valid before calling vfs_fileattr_=
get")
>>> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.11
>>> Signed-off-by: koraynilay <koray.fra@gmail.com>
>>> ---
>>> Hi, I found this issue while working on the v2 of [1], here is the
>>> reproducer, not in the commit message because of the size.
> [...]
>>>
>>> [1]: https://lore.kernel.org/all/DN2YMTH77KWE.3IPE9OG8377X0@gmail.com/T=
/#t
>>>
>>>  fs/file_attr.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/file_attr.c b/fs/file_attr.c
>>> index 833e03810b24..3b249a0a6b36 100644
>>> --- a/fs/file_attr.c
>>> +++ b/fs/file_attr.c
>>> @@ -383,7 +383,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char =
__user *, filename,
>>>  	struct path filepath __free(path_put) =3D {};
>>>  	unsigned int lookup_flags =3D 0;
>>>  	struct file_attr fattr;
>>> -	struct file_kattr fa =3D { .flags_valid =3D true }; /* hint only */
>>> +	struct file_kattr fa =3D { .fsx_valid =3D true }; /* hint only */
>>
>> Isn't this reintroducing the bug that was fixed by commit
>>
>> cb184dd19154 ("fs: init flags_valid before calling vfs_fileattr_get") ?
>
> Hmm, it shouldn't, since that was just an uninitialized bug for the
> whole struct, while now it's initialized (unless you meant something
> else?).

/me facepalms

Sorry for the noise, I totally misread that fix :-(

Cheers,
=2D-=20
Lu=C3=ADs

>> Maybe fuse_fileattr_get() shouldn't be handling FS_IOC_FSGETXATTR at all,
>> and FS_IOC_FSGETXATTR handling should be moved into fuse_do_ioctl()
>> instead?  (Or, more likely, I'm missing something!)
>
> The bug being fixed is when using file_getattr tho, which in the vfs is
> directly sent to inode->i_op->fileattr_get(dentry, fa), which for FUSE
> is fuse_fileattr_get().
>
> What should probably be done though (well, not in this patch) is switch
> fuse_fileattr_get() from FS_IOC_FSGETXATTR to vfs_fileattr_get(), for
> fsx_valid.
> This is because while right now FS_IOC_FSGETXATTR is equivalent to
> file_getattr VER0, in the [1] above it will be bumped to VER1, making
> file_getattr VER1 a superset of file_getattr VER0.
>
> Thanks,
> koraynilay
>
>> Cheers,
>
>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEELYu6gLmcXpLzRUX2XiCt4cRUsX0FAmsFw54QHGx1aXNAaWdh
bGlhLmNvbQAKCRBeIK3hxFSxfXSAEADhQgfQXM0nY8JVX3itRJTY6e6vvZj/ISK/
w21jTeJS1N2UHRZu0an1rHCnmhYq4FK8Lv/0MhRT4DI+YMcY5riLAb7SQlBjE4Px
/kR+aRQ2qcyHb7FKxcDtWyNUAFruTwKSQgWkGzkGNMrnX0BRw240NoMtQSKj1xoZ
MTxfcgsRhhcmuna8XM9rClIgBXTaRVJsyZqoMKp8jAMxykGoVRPfizpDs4fd9vDs
R1DKfvvKMLsxoj/7z53aoSAkqB6bPYp94B4Fv2P+jVfXDj1//L7bGn0Wafp0QI+S
Z0BXAAnpgTQEXSFhWAbBK9l6A428kVEbSbILtZ3epRKZ4yfqhmCj80xdEhGpAA+V
Y4WvLeYxXBowhLb2nP9Ip8cwFQ52aGxjstNbJVaKsLP8q++Jpkz3qQMyVDYePRi7
wT1BejaGARS9RgyiLeKFPGPYLfs8g9JoIKJOr0Vtf7z+MEbsOxj63MznFNWR/z0p
6wn70vCk6Kf4pIwf6d/kfZK3Db32FCh1aftIlkZeXyd0H9PBnaD097jwLVZ50cxt
uEysfu3dREUVkXFnjxAO5rVhgpHpHZiqCwfejo8zZUoFdDw5DbCKxO0I7GoU9/uK
IKRgxE+BaFATaEahnKvrbmYeX46XrvHoNTmOlERZsNk5BIyeqIv+hiHn+7v9hvyA
j6+s1zK0Zw==
=lDaX
-----END PGP SIGNATURE-----
--=-=-=--
