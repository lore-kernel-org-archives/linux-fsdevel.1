Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF56439006
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986478; cv=none; b=HDNZDy/ht9zdJtZ9NXJM71Z57g4htdxkGp8lJeJkn1v0UfC4onCs1u0I8cAaYIqJLxXBdmujAU6UffY4WaycXnsBv3T7X+E1WYPcjWboYSSzE4FlprBbPVkmKlDcLu5wbAWBhbrtcwJl2zKyRGtlmzNMES9xMsT9q1sbKN5jYXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986478; c=relaxed/simple;
	bh=Q6SXDpqU63NFHn5FrOBden7fw/FR3oqSGsDd5NS5ZuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MaWQI14T+7SLiKA5/VgGEoC1RkNh2EZ/sfYqDYDfUv11ecW5Tnd4F8Z4mq/Dj525H60hX9C6TtuBEP9G3KkMY/+9DXJune1yZNQicqzMUITOeIczD1bt1nVPvirmgUp6yIAQjMti07zG9TP5GPNmtZsv4nFnDiD9IlRUIq9+gkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5sFg6S6; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5sFg6S6"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-364746755a8so706277a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777986477; x=1778591277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkTwVL7LGECVeCTpfgAJSB3ElVSiqfbTlUillJueMgM=;
        b=V5sFg6S6g/6Y4Oq1xZlMgpa22nkuNAxcqLAAPy5v1QeCqxOFcEmR1ZldmfdJqZWSwZ
         eKQSJOn0awZkPnPCrIsKq6X8pNeBj/zNykQV1j+PE8VHV3WdTqZ9Pym1WFVT8c/xPVb4
         RItr0cn8tm8Af+96I7DI6wZMckuc2LzjCzBCqHUSifSh2FfOsGikNgf14gvA7ErJeMeI
         OijDjpWTUM2rmc7OzZULE1g0M+5gM96tmnpjKDaV3qXctrH7N8KmJ1B+Sdp0f1fOdl6/
         wngVtZhFq6iY6RsVeJa06lQWbs3MfXLU0Wf+IcQp2sounmz2QcB2ZmtDd7vp3Yol+Dmw
         I/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986477; x=1778591277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkTwVL7LGECVeCTpfgAJSB3ElVSiqfbTlUillJueMgM=;
        b=HFaJdczEIBDAPtQGa0dSnh31eld4uwsYOpqHmBN7SeOaTxoP+4WIqMiUieLFiLS4zF
         frCyhtc9+tc7bzlS4G4nR3TDHI1ypl5/bg5sFW1imMPEKcyXoYB0eS4GsfiWu8oiWbko
         sDXiovjPKVblWlOaeIaV6sS/SjHlOTTsoPfmW+ze4I1Gtb8ROsN9pxgIBPYg4WYPGI5G
         vsyaw8lqwyMQmNh2X/b9GIrW0dmTKrimGZh3OZZ7JtivAEqcqfqrp7op5CyA290le8Kq
         1SG5Htfu/WuRfGhHkGDFp0OkUk8I6J5k11ZQ+jJVh2sK76hAvYk436Cpyt13b9qhKUFL
         SGMg==
X-Gm-Message-State: AOJu0YwKFrA4q5/3m9p0cm/wFishnQCaK6BiQd8hPy0qt1fE+VPfdljE
	JpU4yYAFxE7t5G+KbzcE8dyTlYOqj0L3rjBLn8TBnWlGj+VXn3PDQBVT
X-Gm-Gg: AeBDieuSBAGYWeJM0LJSkSJ/7nS9t0Sq2pmSH/kaYskaUlYZ1KnY7CtihT7YApueTX5
	HZPX7IoMIX/ht1UrbOvtmcWnVc3M7PTu+zPQr9bWnmoRRTe13KYZTgXfgNdu6tnjxtbK2yAiljy
	U37xdzW800GwHspRMuefwGcbTaN9EjDRuHeOrn/OMyBGraYMRrFwq5NGqsPwzOz5W16VaS90XzH
	lVwF7Ti3icp3SPwTLKbttP+WuTe8OovrQlnKbHNLwxR0ZDrwxmiBZNUujEjfKcGtwJpnt+mNsmo
	ZHLNMpemgd65SzFpruXkiGvGQmLK+z3NBmPFT9jlxLqXLatkpHWbBmnW5bTwjzsStqams7PuDI/
	cF1HxNQeygSP3H+K11Ec++pA/nQ8GllJpoHBiVT9KPloU4CDo1mt/bBp5PjgT1bQqajItzSIFeP
	0+NCqrDZG9SdGeUQX/fle0rR0VjCviWXrGFP8rbA==
X-Received: by 2002:a17:90b:3849:b0:359:ff8a:ee4d with SMTP id 98e67ed59e1d1-3650ce56654mr8737509a91.6.1777986476801;
        Tue, 05 May 2026 06:07:56 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365437b50b0sm10477833a91.0.2026.05.05.06.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:07:56 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH] ntfs: fix default_upcase refcount underflow and UAF on fs_context teardown
Date: Tue,  5 May 2026 22:07:52 +0900
Message-ID: <20260505130752.3906509-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_init_fs_context() allocates a fresh ntfs_volume with vol->upcase
left as NULL. ntfs_free_fs_context() unconditionally calls
ntfs_volume_free() during fs_context teardown, even when ntfs_fill_super()
never ran or already cleaned up. ntfs_volume_free() then executes:

	mutex_lock(&ntfs_lock);
	if (vol->upcase == default_upcase) {
		ntfs_nr_upcase_users--;
		vol->upcase = NULL;
	}

When the global default_upcase is also NULL (very first mount attempt,
or all prior mounts have released the table), the comparison is
NULL == NULL, and ntfs_nr_upcase_users is decremented even though this
volume never claimed a reference. ntfs_nr_upcase_users is unsigned long,
so the decrement wraps to ULONG_MAX.

A subsequent successful mount can then free the shared table while the
mounted volume still points at it:

  1. ntfs_fill_super() does the temporary ntfs_nr_upcase_users++ at the
     "Generate the global default upcase table if necessary" block. With
     the prior wraparound this brings the counter back to 0.
  2. If the volume's $UpCase matches the default, the match path does
     ntfs_nr_upcase_users++ and sets vol->upcase = default_upcase. The
     counter is now 1.
  3. On the success path, !--ntfs_nr_upcase_users evaluates true and
     default_upcase is kvfree()'d while vol->upcase still points at it.
     Subsequent upcase comparisons through that mount touch freed
     memory.

This was reproduced with KASAN by closing a fresh fsopen("ntfs") context,
then mounting an NTFS image whose $UpCase table matches
generate_default_upcase(), and finally doing a case-insensitive lookup.
KASAN reports the dangling vol->upcase access:

  BUG: KASAN: use-after-free in ntfs_collate_names+0x3b4/0x420
  Read of size 2 at addr ffff888008d40048 by task init/1
   ntfs_collate_names+0x3b4/0x420
   ntfs_lookup_inode_by_name+0x1921/0x3130
   ntfs_lookup+0x193/0xc40
   vfs_statx+0xc7/0x190
   vfs_fstatat+0x4b/0xa0
   __do_sys_newfstatat+0x92/0xf0

The same QEMU reproducer was rerun after this change with KASAN
enabled. It reached "reproducer finished", and the log contained no
KASAN, use-after-free, Oops, or panic signatures.

Guard each comparison with an explicit vol->upcase non-NULL check so a
volume that never took a reference cannot decrement the global users
counter. Apply the same guard to the other default_upcase release sites
so all cleanup paths follow the same ownership rule: only volumes that
actually hold a default_upcase reference may drop one.

Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 22dc7865eca7..e9de84fb8297 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1671,7 +1671,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 iput_upcase_err_out:
 	vol->upcase_len = 0;
 	mutex_lock(&ntfs_lock);
-	if (vol->upcase == default_upcase) {
+	if (vol->upcase && vol->upcase == default_upcase) {
 		ntfs_nr_upcase_users--;
 		vol->upcase = NULL;
 	}
@@ -1701,7 +1701,7 @@ static void ntfs_volume_free(struct ntfs_volume *vol)
 	 * the number of upcase users if we are a user.
 	 */
 	mutex_lock(&ntfs_lock);
-	if (vol->upcase == default_upcase) {
+	if (vol->upcase && vol->upcase == default_upcase) {
 		ntfs_nr_upcase_users--;
 		vol->upcase = NULL;
 	}
@@ -2494,7 +2494,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	vol->upcase_len = 0;
 	mutex_lock(&ntfs_lock);
-	if (vol->upcase == default_upcase) {
+	if (vol->upcase && vol->upcase == default_upcase) {
 		ntfs_nr_upcase_users--;
 		vol->upcase = NULL;
 	}
-- 
2.43.0
