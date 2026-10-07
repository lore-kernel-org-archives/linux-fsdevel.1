Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EE03BB669
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791349569; cv=none; b=evddCObnd1jHd6jjZNNeXK4SMUNgU9Z6g0gez2W0MDPnDTKRnRVyw2CxS3QgzWTcNJV5QNatnF843zsbA8Ej4lFLig9oQafAQSWbqlp8kKK6plqAl5CBG2M1NBw7XaP8YukjntCfZ02oLmBGxMfd1loH4b+aLnp5g0m62/JmuBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791349569; c=relaxed/simple;
	bh=G8LeofBqypYy5FArHs7+TGUt5emJ5T71K3mdEpcH0mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7GYJ8FYDyOyjFEF+0XC48V8uIzGRKxgC358jIF8pbWaKSm0xKV84N0RIX0EM6xEqonLwwd82jLQwq6KhKyL6H9DAQSxvThyH34fUBDjgCSratRj5mPjGEn7/QXCdg3o9QhDsQJ3bMMrWYwG7Pgn1bn4Ag2m/d06WBgxOwksHYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMPnPkvP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMPnPkvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6961F0089C
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 05:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791349568;
	bh=45/WO5wbYO1299RifHRzyH5pqqomm6asEV6GHMsupFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QMPnPkvPDumZGSADnQW/lRp0YzJAV0PM36Y59HEkiy42AQvw8jfYGVxyZ5pSdymC8
	 8Vr9k4wDNZyJ/CSQtBak45HkT+Igw+HDYOoSudhilUI28dstVO4vRNF7I+BRO5VZmZ
	 ecyv8quHsZZF+ok/OUtTuVML3pa8FdwZCOzDGWO6qP7RzJD9hQ7I69QMa6UbQPSPKW
	 zJMISagUaFFkFndIRXgm9/jkKDIYfe0YZvRWxd+KxvGHISK1jt2dA1m3m0hcgvxuaI
	 18X6dC4sxxrv9bazayH4t3hf1yYvVEn829vYrDWG7BgpPGzkJ1SaIt730oedBgQ6BZ
	 a6ss82Vlq6HRg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2e3846d1caso189482266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 22:06:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzvyfTrbT4mlQvqbio0GztcBpDMDbhTtXW19Ir8Y/TvuY7vpxuaXYphE3AsYyqh6543rnw4VtMgNiEm+yDi@vger.kernel.org
X-Gm-Message-State: AFq9FYI3OFvldmWM9DEkthJbLH9ELh1b4H2qUwopCvXgHc91Vx5z1reI
	USQhKISqtT9jkw4AORnQ7Al8rRGSZV4r2WDcf/96h07Tc/4mDD8V7aFX6/MiB6gqe6CBNrlnuAT
	WIEaJeKxsGNIiuJSYcvJ5wcl/sJTs+HI=
X-Received: by 2002:a17:907:2da5:b0:c2e:893:7010 with SMTP id
 a640c23a62f3a-c317c09faccmr84659966b.37.1791349567049; Tue, 06 Oct 2026
 22:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006224024.14535-1-linkinjeon@kernel.org> <20261006224024.14535-3-linkinjeon@kernel.org>
 <CAMrLSE73h6xvZXfQRDF7W9QrnAAjCJr8qyQ9P2MxCQno+5Uokw@mail.gmail.com>
In-Reply-To: <CAMrLSE73h6xvZXfQRDF7W9QrnAAjCJr8qyQ9P2MxCQno+5Uokw@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 7 Oct 2026 14:05:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-N6Dpuci9k1D6Vs-+z1OatWfmgquJ_c+jObF_19S2NVA@mail.gmail.com>
X-Gm-Features: AclHuK-eIxIpfIbjzINsR2biKL5WYnfGS7JXW_eW1Y6Fwkxxjey1Qfwtn4VqMf4
Message-ID: <CAKYAXd-N6Dpuci9k1D6Vs-+z1OatWfmgquJ_c+jObF_19S2NVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ntfs: add pathname access for named streams
To: CharSyam <charsyam@gmail.com>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sebastian.n.feld@gmail.com, 
	cedric.blancher@gmail.com, Lionelcons1972@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 12:38=E2=80=AFPM CharSyam <charsyam@gmail.com> wrote=
:
>
> Hi Namjae,
>
> I built the patches and tested the pathname interface on an NTFS image
> in QEMU. I found two issues:
>
> 1. **A named stream can be deleted from a read-only base file.**
>
>    I created a file and a named stream, then changed the file to mode
> 0444. The NTFS `READONLY` attribute was present on disk. As an
> unprivileged user, opening the base file for writing failed with
> `EACCES`, but `unlink("base:secret")` succeeded and the stream
> disappeared.
>
>    The new `ntfs_unlink_named_stream()` path calls
> `ntfs_remove_named_stream()` directly. Unlike the ioctl path, it does
> not require a writable base-file descriptor. The shared removal helper
> checks append-only and immutable flags but does not check the NTFS
> `READONLY` attribute. I suggest rejecting removal of a stream from a
> `READONLY` base file in the shared helper, and defining the
> authorization rule for pathname stream deletion explicitly. This is a
> deletion-semantics issue; the test does not establish a privilege
> escalation, since the parent directory was writable. The MS-FSA
> `FileDispositionInformation` rules also reject deletion when the file
> has `FILE_ATTRIBUTE_READONLY`.
> 2. **Repeated reads update the base file's atime under `relatime`.**
>
>    I read the same named stream twice, two seconds apart. Both reads
> changed the base file's atime. A regular file used as a control
> changed atime only on the first read; with `noatime`, neither stream
> read changed it.
>
>    VFS checks the stream inode's atime before calling `->update_time`.
> In `ntfs_stream_update_time_common()`, validation copies the _old_
> base atime to the stream inode, then `generic_update_time(base_vi,
> ...)` updates only the base inode. The stream inode remains stale, so
> the next read triggers another update. I suggest refreshing the stream
> inode after a successful base update:
>
>    ```
>    err =3D ntfs_stream_inode_validate(inode);
>    if (!err) {
>            err =3D generic_update_time(base_vi, type, flags);
>            if (!err)
>                    ntfs_stream_inode_refresh(inode);
>    }
>    ```
>
>    I built and tested this change in QEMU. After the first read, the
> second read no longer changed atime. This avoids unnecessary metadata
> updates; the test does not imply that every read caused a physical
> disk write.
Okay, I will fix it in v3.
Thanks for the review!
