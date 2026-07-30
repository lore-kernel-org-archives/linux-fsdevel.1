Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBD73F077C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404083; cv=none; b=ksAlMxG6CIkyZRYQq1eHGDKcFJIErG4V8AZqwQhTpNQiXVFD5aMJryaUZcMdMLyo9uQAaHgBk7NwsjUbPSaDVEXgLPt1LgT5/7D4Ohe9+jNOavKOqtkrRwTlkx9bExYeejZZ/orbgE1JcaDBcLhK7DlA2RP1XIOR8q9WbtxXg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404083; c=relaxed/simple;
	bh=7eaxt08mtN6zo0xFSjRxwPoRb3odH0Rzb02ZpzqbEIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfbEiABwdTWV/3weQZivLae4KKyaI7Wrv68Eqj2ooCv88VPPyL/4q7XTFK6gX+E1pLc6ORygsPsngVgY5uaYhOHQTNyfswkL8lpgpkGEH/tRlj+5sCqNkvtJP1+5a6IWrWuLakUlOyOnhx6KYmV0bBjyvy6zuFbEcAJjPdAfSOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdJ+R0pX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdJ+R0pX"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f97d310caso1820051f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 02:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785404078; x=1786008878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tu9mUrT2j9QVQ/0jr7AGyW7PZp640JOYo5v2vN8k1Cc=;
        b=IdJ+R0pXxYY0Lt6BoY3EQqiGTBwGJLniFtRsUI9SZC8zNu9ougUk3y502bIhh42l4q
         5RPQg2nmjkAxlcbZGQeIvBAHgEbys5U+Twa9F0Q7twSIC2STAT6ztwkGGMzIPvHov4c7
         RejSNUCQtjt5icdrsLS68R+0WJ4ZKUfCwg+ROHn+bXQMELgfVBW6iUniam64tlYsn+W0
         YFimoc+znqwMum3si53Wuqbp0UvzKK4DRKIaEqlDBVwlHz6gJ5uJQXuHn0CVJ/w3jXfK
         NmP5iCRa7ocAMKc0OVvHqlKV8YFX/O9P5oNWJXe+Rf39KnE3aPu6/2B8yWNv7J3QUf3W
         TenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404078; x=1786008878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tu9mUrT2j9QVQ/0jr7AGyW7PZp640JOYo5v2vN8k1Cc=;
        b=Dl+PecasZo1n1hNq4iB+POnNr6BoVwig2Q6d7m2gQpA/PHeZ3EJ9XcTWhJ44ounI0i
         +/uEU+tUjQars5jrvclQZI8jmqZ1q0xPXKvYPU3kOFVY0b7a+CNLuqCDkvaQ9I4Szu59
         2N6VVPy4b5uwdMLZmz+/Sb+b6f1KP1RykpAesstyOd4iL1Rdf8f0E1s6/nr41Z9ifxfZ
         QjAwllHLyY4PNCLyo3/VW0qeUboNeVw6zNbdI2SkENyxa4cpgeUtuCUR0zbruJvLxL/6
         N5UdvOBveyODtrpptk5N4AiE97FRSY0RqaUOuvcs3Tdz/Bo0E8NdXqIob9PdECXrSFqk
         HbLg==
X-Forwarded-Encrypted: i=1; AHgh+Rpf0XkHEZUgRo9epz0TRI3JSYWBgCnW5oqeiDcixZpWuFOmfhmyx39nQk2M20uXJ5bzwzNXgTmtpQKljdw/@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQRQQ/D/sDbLgtDXEoVRpMIrp3ZW3YnwfFpPjIPhDd5A8KkwT
	aKz9YWIxO9PPL8wgMdS9Ih0EPuwMokFtZKGjA47QQ8wkhCk1PalXnCjF6qT4XX2A
X-Gm-Gg: AR+sD11tUalmcHa/2zRmo3pLhbKNQM9Yb1vZeOt8RJnNfgX6BLNk/AK0CvHutpmE45E
	mE7gs9pnK9iN7QXH9X7eZFMLxcVFl2LcoLS3PUTcJSJ4nMmQ5YcaT/bKUc0tKedIAxpWLgLOzHl
	0JjYHn2mxIrrBJadfXBQnJ2vhsivAyr3Whil63o2zgzRbHI+P/f0n6BR3GFvvJfVz9EkQTYwRD0
	eLgphNqnXeP3j6+Hoinc2BEkRROIyHsX+F35UB1ah/vW6oolHtcxhsFRno1gGkg691Z1akyTZeP
	DQkU1iPT6beuk9vKBR3WMy9TjPYudkcSZBR0PBom9vRVwmQoO2b2cit4Gu5wFMM4xxmdySzJqrP
	e8Le5lqLASwlLay/wkja4s/e03HBKusDoUu6EuZVFqy3cymQod53302AdAXcZx2VBfgxLENt1Ni
	8m2Gv/Nw3mEMzTdgwhb9OgSF2WqTtAlm1Jhn8IIj5kt8toigmUyoSYU2rCGJwg3U451nbnwZ4o+
	8qYTuVNuZlE1hvscVZz3lz7AVMFU6Mue6iUCU+xXtDWohlP2MznhFZMMHlCiY0/Kl4vzQ==
X-Received: by 2002:a05:6000:400e:b0:47f:6f92:84aa with SMTP id ffacd0b85a97d-47fc82149c1mr2185466f8f.53.1785404078438;
        Thu, 30 Jul 2026 02:34:38 -0700 (PDT)
Received: from valmpani.fritz.box (cgn-195-14-216-95.nc.de. [195.14.216.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d985csm4897793f8f.1.2026.07.30.02.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:34:37 -0700 (PDT)
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
Subject: [PATCH 0/2] configfs: fix use-after-free of symlink target racing with rmdir
Date: Thu, 30 Jul 2026 11:30:23 +0200
Message-ID: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzkaller reported a slab-use-after-free in config_item_get() when
symlink(2) races with rmdir(2) of the symlink target:

  BUG: KASAN: slab-use-after-free in config_item_get+0x26/0x90
   configfs_get_config_item fs/configfs/configfs_internal.h:127 [inline]
   get_target fs/configfs/symlink.c:128 [inline]
   configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185

configfs_symlink() resolves the target with no locks, with the idea
that a hashed dentry means a live config_item. configfs_rmdir() drops
the last reference to the item before the dentry gets unhashed by
d_delete() in vfs_rmdir(), so get_target() could take a reference on
an already freed item.

Patch 2 fixes this by unhashing the dentry in configfs_remove_dir(),
before the item can be freed.  Patch 1 fixes a second lifetime bug in
the same path that the earlier unhashing makes easy to hit: an item
reference does not pin the item's dentry, so create_link() must not
reach the target's configfs_dirent through ->ci_dentry.  The patches
must be applied in this order.

Tested with the syzkaller reproducer, which no longer triggers either
the KASAN report or the s_count warning.

Vasileios Almpanis (2):
  configfs: pin the symlink target's dirent instead of chasing
    ->ci_dentry
  configfs: unhash the dentry before dropping the item in rmdir

 fs/configfs/dir.c     |  9 +++++++++
 fs/configfs/symlink.c | 24 ++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.47.3

