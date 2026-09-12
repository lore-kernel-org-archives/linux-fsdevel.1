Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0832DE702
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219455; cv=none; b=IKhAdYIJgvLWS2DGSsurvgs+SXY4DM9lnmZYRC7n8eYOaG+Y6igVlznbypOvLK3UkW+4MzUo9q09x9S0YKzdqXsgx1FamIA3lY2F7LGXAfD2UgYl1qPwm1ZWo6K4iClFCg+uylDWJ9NvZM5TdoWWxjkHNbLp21CC6zvdwsxE9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219455; c=relaxed/simple;
	bh=yK3c9e0zDeIOMm4gAUQkZH3mKRVJqBbXyrMQkQLTbAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnKjXunoOU5RcjEk/GF2MO9ER7vzD7wGMjObx6N9IW2iNRt/mnQTXsFVhChdh7oZHAlnekmTBo1zjN6udrTo/gave7Zb3SdtaSLVcxxQzFpsA6n0Yr8zmU1yupyCTx99PuWvyns6UZKHc2UvOKVFQrAXSgFH+k/+zTNMnGqm+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=armMb1qP; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="armMb1qP"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-86b90133ae8so589437b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789219453; x=1789824253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HKwfTFbzWp8eIFZA2uPvZQvXQp4cwuFO9YpGu6VpEnE=;
        b=armMb1qPwwsHgfInOPb3tnu/2QQPgqpUEo8QGAmyZM5Oc+hLh9/Ksp3NwUKQSszmia
         JmZgMnafoYrKAQvgO7AQfa3pDSV5RvA5Qw/cjG4faOa2pEdyv/E+CVXA9YL+qDbgjyxi
         UGxWlY1lFUyKIJhDha/leez4Jv1mYq2kdMK8JkRo/04742aQf0hcYfVeYK/dofWfjHSz
         0V4Vx3iICjjJOMmFUQYQusUCUp8Tddh9Plu+Hh8j53sga+Wpzne5gS1PJ0f8chKYWcNK
         ZcMg/8pWuW0VfD8iB9Pi74JMzz7o9Fz50J0TB5dhi2KCN+SH76j3foUwVQWIAhZJo0yk
         w3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789219453; x=1789824253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HKwfTFbzWp8eIFZA2uPvZQvXQp4cwuFO9YpGu6VpEnE=;
        b=sL23XVSCxxnCMT0PJtEQOQFos1j/se9QJ015GhGfy/vFFnQ24E9Rb5ZTsIheeu334x
         +JUnxZ4AeRraQbc5UHKlHUCYRTZ0XC7TYoGvydD4CpaVwbrNJupee5dvOKGSL0U6ir46
         2QR9wjXRyP68mcWBdVuBq+MJJdMbTm4+ulPAL8IZi4zEHelUQniNoSGE7DE0s525lTFw
         o7McLMtGQmKYhunqndqvn6g3bx1kFUGB/gaPfM8arxSWFI+5V0GoEQAlzTbwAUBgtrJi
         vDe8WKhqSiIG43OFlhG7RcDyR+etqkLJS3ndw3O90jKSNYxlD5MFD27X1O9KRJ29R98j
         lo0g==
X-Forwarded-Encrypted: i=1; AKwUvBygK0Wsu9vn1fA8Yr24TiltCxzo6ku84gzT9U/76f7KBEdQVgENrR27uFjtp6Id3Ypel3r5Bxcaz7No2FOt@vger.kernel.org
X-Gm-Message-State: AFuF++mch8//CuarO+ymwdHCiuOXi+h8bRQ4Oim/m/+Qg1qF3H/j5G1f
	aJoxnlWu24BaSEZt21qOmjgNZ0eGjy8pHKDUZajbkVYusaiJhVBvpp0w
X-Gm-Gg: AYBFou3YrI6l5Ni604KisJPoNgwvVPbqzXHW2XYu2rzwuyT6stpG0tBhLocH5hdHVvf
	9W8JHmrzPiETt/6U4d7tK1hygSi4t0bxL5f9x8zmA4w1XklLjqsotD6uKjjvU1QIq1DqM8T9BSP
	hIZgv9TcQxbNc/GSgjcA34NcuJbkp6/PuSpzjS5UU6JsevusNcOx3Jn7jtRYy8deh+C84YCYNnI
	vFsl0BPA7IqRupShuX3RA/7l0C3l5xqJc4XF0ckwe+/4d4vTrEWJCKKbrioc5yHktCEY4bIn/Eb
	1QPnWJiVNHRV3eCB1Zmb16l0/GAKx/j2p3jJ4JSAsE8BTEzOvIgUaqz0qvSQK2FDquejJqKZidB
	EiM7uSZBqM8z+qi34z9tyJnBaGLdvjOBXs0BDxyOO/bcbYZLWAvK2K3gD69/erOGkZT0ueZfkKH
	IjFn+eDhcTexXFIDyM/VukQ7w4FvRkmHXt/Zx3K6+xJCRdsBrz0q6rRn/Ju4Fb8rwK8XtTDLkBk
	dzCYE9zQ3TJVO8jXw==
X-Received: by 2002:a05:6a00:448c:b0:868:e6d3:fc18 with SMTP id d2e1a72fcca58-86b3180648dmr16192224b3a.15.1789219453132;
        Sat, 12 Sep 2026 06:24:13 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:dfd9:c41e:7c9b:c69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b292c9839sm2410819b3a.33.2026.09.12.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:24:12 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Subject: [PATCH v4 0/2] hfsplus: fix the extents overflow file recursive tree_lock and its root cause
Date: Sat, 12 Sep 2026 20:24:05 +0700
Message-ID: <20260912132407.16856-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c6b841becc5b1709a9f54a1c0efd0a14f02ad97b.camel@dubeyko.com>
References: <c6b841becc5b1709a9f54a1c0efd0a14f02ad97b.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot: WARNING: possible recursive locking in hfsplus_find_init
https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce

This is the whole solution Slava asked for, in one series:

Patch 1 fixes the recursive tree_lock itself: hfsplus_ext_read_extent()
now refuses to look up an overflow extent for the extents overflow
file's own inode (it can never have one), and hfsplus_file_extend()
tests whether the fork actually has room before allocating blocks for
it, instead of allocating and undoing the allocation on failure.

Patch 2 addresses "how would we check the fork itself" and "how could
we check the forks of other b-trees", asked across the last few
rounds: hfsplus_check_fork() validates the eight fork extents of the
extents, catalog and attributes trees at hfs_btree_open() time,
following the severity split discussed -- first extent unusable ->
mount fails; a later extent corrupt (the syzbot image's case) -> open
read-only.

v3 -> v4:
 - hfsplus_file_extend() tests fork capacity before allocating instead
   of allocating and freeing on -ENOSPC (Slava)
 - added hfsplus_check_fork(), called from hfs_btree_open() for all
   three trees, with the mount-fail/read-only severity split (Slava)
 - hfsplus_reconfigure() and hfsplus_fill_super() check the resulting
   per-tree corrupt flag instead of re-deriving it on every remount

Nguyen Ngoc Thang (2):
  hfsplus: fix recursive tree_lock in hfsplus_file_extend()
  hfsplus: validate b-tree fork extents at mount time

 fs/hfsplus/btree.c      | 12 ++++++
 fs/hfsplus/extents.c    | 96 +++++++++++++++++++++++++++++++++++++++--
 fs/hfsplus/hfsplus_fs.h |  4 ++
 fs/hfsplus/super.c      |  9 ++++
 4 files changed, 117 insertions(+), 4 deletions(-)

-- 
2.43.0

