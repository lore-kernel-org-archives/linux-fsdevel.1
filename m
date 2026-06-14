Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4860A2857EE
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781481053; cv=none; b=JUh7S+Q/itVr8RG8ImQ8qdEpONyTg08HLX6mApMUlwaBotHOdQTOMKe10G0Ml3lDD9CrpgHItXQCwUbzV6MP96yD3x/H4uPeJAOFBBgh0WjtYhC4yWKsMSJSVhmk3rD9HQ2wiIE21v1eCYDRyMXTHERUGWHR9yFjHXtQD4iS4fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781481053; c=relaxed/simple;
	bh=UW7/Ihdw+9W/vSwxqi/6gQhdyY+drgay45wXlinJ5Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RWpWfCkVMN8AvpJRU32sC+odTtynquAjwiW1JrX5jVf3/+G7nKaNaL8aENbJIo4lgC7qLhTXvovCrc2RcxKepnZxYJXTqowY4GxnkjIJII8Uc60do/3l4zbdxltk6uf8yX3opbtq+GpTSzN4CfB1czuVijsbg97/Tg09tZacET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xlk9xUDV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xlk9xUDV"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8585cd8400so750183a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781481051; x=1782085851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ThRJcMH0PyZSvPFm4gsYwv37Umg1BmJaF9nZCzOVr0=;
        b=Xlk9xUDV5xYVgiejM9RZ6SpAatq/gdI57Uzf/ei5vaXHry1yf8Sjv4NtN3VxjPgPkB
         318o4eWpVnlCR7yXyKvLETaWIXY5cJXPKVyXaQxTtTfD5gWYf+BoFT+2n/ZcEQ2hAaW7
         UhT2m0jY5Fkw1hZhwtYA9/sr9WU4JMdFv55DhWtfQECZHAlHX6FdkEnGhnOUv0k0FqIj
         79aD/lArI0T2SDmDc539Gf0ZqFhl0ZY1yY884zhEGuYpeKz63jqR87mt8Re2tA8fO6kg
         wGKLUCzxNEe0fLPn866QWEvNxn1UDIwe+bn/bk6iWnzCWMi8nJHoadwjrk9GbBXECq3g
         p0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781481051; x=1782085851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ThRJcMH0PyZSvPFm4gsYwv37Umg1BmJaF9nZCzOVr0=;
        b=JFyqCv+1/IAm/AhVbQ5v/P6cejXW3Q7xASPI4rtSX4GnHfG+pytxuX6R2WUC0pCTnS
         Pu62HuMnjOTGjMWXTdhCmdjkV0yLEZJWBqtYteH/ZpMyh2rrXvoRuIfDx8fc/xrKEJD4
         KaMaghD4t06TrOeXNgPVj9tfx9afXfgh1pjtOxjKHc8kDJgt3aPG5abi8lhZY1HXIhWO
         Tr7fBAhufd5OxH4v7RWJ4gbSFeqlTRd1yiH+JcVRwV/YC9Pb717bQWe3dXd6fGkiCRJO
         gTO+J3/8YLGf0IuIaIsPdjeZrYRMI5PcphCuvW93EMDCfPL+9KmJdx5KAwdlJ1jMfjFx
         tgRg==
X-Forwarded-Encrypted: i=1; AFNElJ/A7pNWwazFUhMsfFn9ryNZgxguSi2OoqF6PemrXix4MEBE8T0F5Hsqg72ET/8libsQUK3XqN2A6nsWT8mw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmk2BnzDKM8TGi/jKZpMxh5R5QOU5w2R1dCCS79Y6tx0yWOA8F
	49W8coa/8ZffYdU6TV2LxoHFwmF+z85toW4wcTAOSxO3JZqmGprU5hEy
X-Gm-Gg: Acq92OHtpdVUfe304Sv8BEG+Th3gbqsjCvswr8ZGXy09qHXpbayDR1bunUtOqNzKLfY
	vQpS741ZbMy5D9ZXK1/HbrBWzs9zfUA4C7KjAQl8HqpQbD4pcobOJq9E7Xv0Yf3Qj79NXkcDT3s
	+XVNlN02CZXV0HA0W82A9c//SJ0a7hi0reunmIdZnnCTiW+Jr3uFIggFsuAVCnBJvf3/8i9cqr2
	aRo7HZX0KXk4TXlXfUFayD7BVZkE/VEAzmi5Qu36m6amy05dnnp3BuT+JVNZalh71Ywd2QPHkNT
	zooqtGRUjhQQJpjanlzxmxcsulwiCucFFLBzizKqa11maqJqRGQ64YemK22+yoogFg+/mRiPxh6
	bHmPnOe97xVxSsTCyAWd/dqnkRcOdQ+44pxserihGy8j+jPXUbO54Ha2zrEoEgBhVDTD7WYfl94
	WgDN/YEhIiCwTRp3UCkrwrIUSrmnT+TQ==
X-Received: by 2002:a17:903:2310:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2c411d79afemr116021715ad.25.1781481051537;
        Sun, 14 Jun 2026 16:50:51 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm86651425ad.38.2026.06.14.16.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 16:50:50 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] ntfs: Support Windows native symbolic links
Date: Mon, 15 Jun 2026 08:49:51 +0900
Message-ID: <20260615-topic-symlink-v2-0-648a769d01f8@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2961; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=UW7/Ihdw+9W/vSwxqi/6gQhdyY+drgay45wXlinJ5Kk=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqLz3J1RPtuHZwPzF9D4EJMjGUxd7S81ADEEz/s
 OzA58e93p+JAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCai89yQAKCRA08jD6945I
 08t1D/9DbG+mKalqhjaPA89k6SYIzZDX2ztqrDLezdYhWH4ZYpIiK3FAek0yroNh4iJAzpEka2m
 cnNUAfxDfCEcaDW7D3FVhe/z610l+ewpE6i8J+IwVekafbEzaJgOJBqaZ8DSe0fOu6REUlYQ/0H
 KqZD6bpHyDTJJE2BhepQmM8OEBS5EdEF3MFWyUiKeR+J49WO5nnfhqlFjDF9G1gxElr3qhqyFcq
 eMQts6I3JQlYqvm2RKitMTMJR4sVjqTTRDFq+w86/gIE2LM7hrPtyADnfnne8oe5b27bJm137e4
 JyVRhyQEZx+wYBsucXILQJBfUrl8n+OtBotrtks2XN+eV5wH9RM/9yuzIDEmMQcWX72Uh6LJRJY
 5g27sYgMp8n5LONat8LvxpDEvzo90D7uBnDWrdata6U4/xUw33dlMgfbNK8EFHhaykMCsAYqPSJ
 rRiR7cQiv/M7t+WBhVffTy5dnjNnoTz+NqqTQmVpeNTnqmsvFeJPeu1oKgNyXEDWJgnwWZi28Tj
 CXVsUNpX6+ZOAXtaQnpXVfJj/k1Pv98ThhUtiDkDmYV7VvzXTI+XyDeIFjY7F6EQEVnnIGEf2K1
 16B9p6VlreCPEiBEqFsW2DJQ88Xs+kw+tqVdOQjZCmWS3M1alU5FJ4pYYTc7/MT5wh3jYnmo+td /f+oXqqlfspAR6g==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

This patch series adds support for Windows native symbolic links and
introduces mount options to configure how symbolic links are resolved
and created.

Currently, the NTFS driver creates WSL-compatible symbolic links and
has limited support for native Windows symbolic links. This series
addresses these limitations.

1. Following/Resolving Symlinks & Junctions:
  - Add support for parsing and following Windows native symbolic links.
  - Introduce the "native_symlink=raw|rel" mount option to configure
    absolute target resolution.

2. Creating Symlinks:
  - Introduce the "symlink=wsl|native" mount option to choose the
    creation behavior of symlinks. Under "native", Windows native
    symbolic links are created by converting the target path to UTF-16
    Windows format.

3. Fixes & Cleanups:
  - Fix an issue where the size of symbolic links is reported as 0.
  - Clean up target name conversion for WSL symlinks by avoiding
    redundant conversion.

4. Documentation:
  - Document the newly introduced mount options in ntfs.rst.

Changes since v1:
- Add a boundary check to verify that reparse point attribute size is
  at least the size of the `reparse_point`.
- Fix target inode fields (`reparse_tag`, `reparse_flags`) not being
  updated `ntfs_reparse_set_wsl_symlink()`,
  `ntfs_reparse_set_wsl_not_symlink()`, and
  `ntfs_set_ntfs_reparse_data()`.
- Improve absolute path validation in `ntfs_reparse_set_native_symlink()`
  by ensuring that absolute paths actually start with a valid drive
  letter and a path separator.
- Optimize memory allocations in `ntfs_reparse_set_native_symlink()` by
  sharing the same buffer for print name and substitute name in the
  relative symlink path.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
Hyunchul Lee (7):
      ntfs: fix incorrect size of symbolic link
      ntfs: support following Windows native symlink with relative paths
      ntfs: support following Windows native symlink with absolute paths
      ntfs: add native_symlink mount option
      ntfs: clean up target name conversion for WSL symlinks
      ntfs: support creating Windows native symlinks
      docs/fs/ntfs: add mount options to support Windows native symbolic links

 Documentation/filesystems/ntfs.rst |  13 +
 fs/ntfs/file.c                     |  24 +-
 fs/ntfs/inode.c                    |  49 ++--
 fs/ntfs/inode.h                    |   2 +
 fs/ntfs/layout.h                   |  19 ++
 fs/ntfs/namei.c                    |  22 +-
 fs/ntfs/reparse.c                  | 476 +++++++++++++++++++++++++++++++++----
 fs/ntfs/reparse.h                  |   6 +-
 fs/ntfs/super.c                    |  38 +++
 fs/ntfs/volume.h                   |   5 +
 10 files changed, 577 insertions(+), 77 deletions(-)
---
base-commit: 5aec1efb11ab2a87d1e4be063830268f7980ec4a
change-id: 20260612-topic-symlink-d70873e4721e

Best regards,
-- 
Thanks,
Hyunchul

