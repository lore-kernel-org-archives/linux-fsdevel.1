Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597336F8E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704458; cv=pass; b=eIsrhAzth1iFzuOJcCZ8YDn8JMbjzwI7tuDsozxK/ToFFk1W2LOWgKSjShHkCq63ww/kARytbi3RE9l6lzBoo2J9gMzilKQpMFBp82BkfAjI1DhI5wx94mD8QVSzIgIzjPoxvTDSoUinZHbi0fasD7vKAg8HesU451sFLDj4lSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704458; c=relaxed/simple;
	bh=QqaIYA8X3X6Tew9rng99hk3rmPCslU/eWwD53qMGzFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRJndSIKAIqmM9iyokNuOaNdCBfk4G601cIPRvguc0lG3FZGFcRZxkKq35byWZqfv+JkHzpLibnlZ+hkJImwWay0FkY+8qbVIWB4M4m1b+vog5NbIfK0zmnOwfep9UQ7XS8GdyzrfCK1aKGRGxMj3p5Cdduec//DnWCd5dudtis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AD9fcV9D; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD9fcV9D"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899d6b7b073so68957776d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 13:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778704455; cv=none;
        d=google.com; s=arc-20240605;
        b=PFhK4Z4wvORc0OmPrcdI1RvX2+Wuq/0G+C4UmTvujI5rVJvBhihoPaBoXZ4TBp9cuZ
         csJWoBwWeCuYB6w1YnB6oyD9pxYCQ1o1QeF+LDVkahXtqXOllkUkPCBXR9QfJsOIpw/l
         AnPf3at4zR+51DQxRTx6VbYEuR72/dajHcHNKIaFLcBaB5R9LiaG/9Ty5hpGBp7ByqKl
         JIuHi3fsRCjWV337XSY48pfiv4roGIJEUgwFNMjF+NGUb48RbQo3CWkJ081peBEBksfm
         a3rPQVw+Ae7LxIE67rWIc9DDmUxOIXyA3IJHLH8r42kI1vyJ7NI7ogr/U0lSouWDqsHR
         OpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YffvRc4ueiaHAv5vxRd/K/yTD1qBPNZn3LhENW3N4xg=;
        fh=As+mEBD7lQ/P165Zyx3yIZ269AwDBZRnNpVl97lC9YI=;
        b=NS/0AEFJEAusqHowN/XFlmxxbXBbdPrStffsWzgamzkj13H1bD/HkCEh/Khq/2DslV
         U9Cv5Jct3dmYbDf1/pu+iLBxjmBNGoYrbrZNye6YKnNxAgAm0+1IvWAro4Cnno16Bnvu
         xAleX1uCC/mmCNjwyNWF5ZMxxLC4ECcyhFnaF0wdsADu336aP8XMIXtdvgGlsImJRdQL
         NqBLgc0K3tXFhR5pvYgBwB/xNKkICrQjw81d8isR/5I4jO87E6Ees6J3nvK7NIpaDJ4H
         m9BiQCfbsygd6we/2VXm2HP7L8XOqdA5ZCxQdj2kZqNrVhIJcER19XqppjfiU++9cIkG
         lhNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778704455; x=1779309255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YffvRc4ueiaHAv5vxRd/K/yTD1qBPNZn3LhENW3N4xg=;
        b=AD9fcV9DHYgDCefhJ2zSXZDp5IsgxaGD+U0MOWxRyeVB9HxtlwiRupMCngACCv3gN3
         DM2QnrQXjV+sYmnB7buk4J5Dt6tGrh1OPZBWVQB8b9fCQmOKih3ywWgVh1komLd2T6S9
         Iw0vFCUrddNFBUe65lmXniDofheSzrnXitWFheF975H4HOv5OAkzK3mkvFZBQzbbEFO5
         3CBUV04Gi5ikM28vxU2ZcJDeIaaPgXBzn1SOf42ImQdPsuYoVzWX98ke8U7+4SKfTYHq
         rgiLecCrmAZpjPBD/RK6amLrzQARySCD79r299h/pV/nX/61R2SXk8dj58MY+M4wHe8N
         AnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778704455; x=1779309255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YffvRc4ueiaHAv5vxRd/K/yTD1qBPNZn3LhENW3N4xg=;
        b=Y8uPCLnHmFqoVUa1o2kNAKCo3gkggM3rrf1TuI6TKgR03J8+HqbC3TThTUvtUHfuL5
         pD9PDYB6EW2PFUKrbF4py+EiGVRQ42avjkda6s5SijUGPKJ9xi0BHUBfIYltYrHsxvym
         NXtCBQPjjPVCfDn9vHKa9vEcrOeVPoI+3+BH81PGDC9E3nH3FKKXBx+ry9fPYXFZcL2V
         EJMS8D+Bu8pZLUdeAhHb9wiBbH30a8udV780+XLtD9sSBLRasSEmZoaoc1jUgucv+IiL
         qAEQdzUqzySV0Cyb3Zz47LC9lhZhWABRKz84Uj6AYqblTamhhmZt6vREfRbREchbp3xl
         WKaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JTDo9znHYBEP6KiAvkdv8L+ZBupnInjhM9Bwvkq77NrgqDCbSeGg2FVER9D0xERImxZnehfHyJOd3vXi5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3n8aQRV9OQv5PBYUeQMrLzSV8daeKTt9v9M2WOje+8Jg9/Bz+
	b/oSgfsJv0wmUswLwqyykc3nxaOTuSMUXrhT8+YoLs5oMtVV2GlV4GGCraI5whjP6lusO2ROS1q
	fCzGzevm6B8aVAIxnoj+1W64d9H9dWDk=
X-Gm-Gg: Acq92OEeqVsiRQ4pwjh2wBw2NRIigzdMu7yFYs9b9zxEAq1n/3ZFjJyJTpR8uf4wc3Q
	jiIkWwN+XgbcEFquSStFEOoHjRkFyYSi5chu11eYG9p9cOfdhBpNLyPKxuIK7FTFghA7GCxSHK+
	Ag6sniOGl6qIUSTt+1eyMtAcEMdPNyTUyMVDL4wp1JPisWHJL0TGC0DHStGS1PfGpj71+6RDrpH
	AHfK08shujn1P1s4dGMCCA6wduJAR6XSncqDkP68baWQKm7ERe1zMdd2B+WRiTWP/J3H5DRXKx9
	qX0wXosTqBbR9izCyHp29GvdKKssIuu0UxjPIXx3M7lNVWGLDkBPGAF0mecxtI3V35RcGFHnRIj
	L4BX52jbHyTIkscQIFaLQCiT/lMVJOqvctyIa7FfUYuK5QZG8Bb41Q4UF6TLF5bXE7KVXQL+S2g
	V1mMB6ybQTp0zj4A6lRBFa2w==
X-Received: by 2002:a05:6214:8009:b0:8a0:846e:8850 with SMTP id
 6a1803df08f44-8c7b9d6a34dmr79395336d6.20.1778704455206; Wed, 13 May 2026
 13:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
From: Steve French <smfrench@gmail.com>
Date: Wed, 13 May 2026 15:34:03 -0500
X-Gm-Features: AVHnY4LdSaGvyovg6RvG5pKhPWnEZkoZnNgrzQdw3V-htIBym1ah9EOHikjxM8Q
Message-ID: <CAH2r5msnYVb3hhXHwqDVHGGC1h4E6mLCRS4ktCrQoD9zdUW81g@mail.gmail.com>
Subject: Re: improve the swap_activate interface
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just tried this on 7.1-rc3 with the swap patches (full kernel build,
on Ubuntu 25,10) and boot failed with out of memory which I had never
seen before.  Any idea how to workaround this with the swap patch
series, or is there a fix for this in the swap series already?

On Tue, May 12, 2026 at 12:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Hi all,
>
> Darrick recently posted iomap support for fuse-iomap, which was trivial
> but a bit ugly, which triggered me into looking how this could be done
> in a cleaner way.  The result of that is this fairly big series that
> reworks how the MM code calls into the file system to activate swap
> files to make it much cleaner and easier to use.
>
> I've tested this with swap devices manually, and using the swap tests
> in xfstests on btrfs, ext3, ext4, f2fs and xfs to exercise the different
> implementation.  Out of those all passed, but f2fs actually notruns all
> tests even in the baseline as it requires special preparation for
> swapfiles which never got wired up in xfstests.
>
> Diffstat:
>  Documentation/filesystems/iomap/operations.rst |    3
>  Documentation/filesystems/locking.rst          |   35 +--
>  Documentation/filesystems/vfs.rst              |   40 ++--
>  block/fops.c                                   |   15 +
>  fs/btrfs/btrfs_inode.h                         |    3
>  fs/btrfs/file.c                                |    4
>  fs/btrfs/inode.c                               |   72 -------
>  fs/ext4/file.c                                 |    6
>  fs/ext4/inode.c                                |   11 -
>  fs/f2fs/data.c                                 |   50 -----
>  fs/f2fs/f2fs.h                                 |    2
>  fs/f2fs/file.c                                 |    4
>  fs/iomap/swapfile.c                            |  165 +++---------------
>  fs/nfs/direct.c                                |    1
>  fs/nfs/file.c                                  |   21 --
>  fs/nfs/nfs4file.c                              |    3
>  fs/ntfs/aops.c                                 |    8
>  fs/ntfs/file.c                                 |    6
>  fs/smb/client/cifsfs.c                         |   18 +
>  fs/smb/client/cifsfs.h                         |    3
>  fs/smb/client/file.c                           |   16 -
>  fs/xfs/xfs_aops.c                              |   48 -----
>  fs/xfs/xfs_file.c                              |   39 ++++
>  fs/zonefs/file.c                               |   30 +--
>  include/linux/fs.h                             |   11 -
>  include/linux/iomap.h                          |    5
>  include/linux/nfs_fs.h                         |    3
>  include/linux/swap.h                           |  129 +-------------
>  mm/page_io.c                                   |   45 ----
>  mm/swap.h                                      |   92 ++++++++++
>  mm/swapfile.c                                  |  227 ++++++++++++++----=
-------
>  31 files changed, 471 insertions(+), 644 deletions(-)
>


--=20
Thanks,

Steve
