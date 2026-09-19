Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B93451CE
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851980; cv=none; b=CXPiL0vA9VB91XHkfm9dSTmErGtj/wMm9WspMFqdcqD/JsjlaDRKJ0iq2cO0QUGdvmh91r37QnqLFw/E2nwjJkWnDSt3ALWmB6vYH+QL9IS2b2fOgW3rYuh2PJ9RiNpxKvsys9BROfOuf7VunTjAZAtKC4WNDJMP6jUuDJAOSuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851980; c=relaxed/simple;
	bh=hyohMFDPXJj/bTGIv3VYpFFLZFYM24WkV44sc7f+myY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=puy/yGiMWIjKrITyR/zXBGAP0Bi7z1qyWlFO7AR8q4dSCD24Crj4xnMH+/9VEi362NLK7B2ckk8PcXiJwIC2rI3tDHebptDaYADYAQz9UsQWuU2GVNqoa4vV4Czr3jVNHClTgzwL4LJMIliG9clnIaFKVOdwyal8RuDou/7LJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW8CmPgC; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW8CmPgC"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91a931f66so11808135ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 14:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851978; x=1790456778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EzucT7q6zHC86vSqtMKbjtU4XqPVAJVIZbXQxy7cJtw=;
        b=SW8CmPgCxgBDuT+cuc7s88lC68NILuicI4M+Nis9hZByR1TNLCd6ram/jGZAh7edhi
         w1OpWmxq1u20d7EKXHbw2ZEASGezLOPMI5rl5GH2ZZ5XFh+6VAuRiAKJYeElF+xvPh7s
         H3+KmkJRjnE6sm7JUS0onzCkgpaHHgR5DqhQhthMjRWztmetdC/FoMGUlfbASPFjHCtQ
         hRFW1EunbbzmXWmqN3RQb9WVAv6bG8skUnZHkiq5bg0aIAu87njrqfdXm046z8VCQCtl
         WndIF47pfQWM/5z9uoBCMwRr24eiH0nWmNNwTcDAEuSYaBtwhIAj8WN2SWUL19GE0DEd
         uORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851978; x=1790456778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EzucT7q6zHC86vSqtMKbjtU4XqPVAJVIZbXQxy7cJtw=;
        b=hEZwyyQAQUNl9ypK5giBIOtzig/oYUTcoHh/S8PdDA83gQkGkYC5Y5vToaxmzCHODA
         Zgkp30TnDrAusM9kQBIDsGaqHycl8G6NP8t7hUodSpwwTrl6+NwsHdgiy7vE4M1uv5YP
         5d5mVc+jRFSIViXwGpDbm7b+rEdS2IEM7KNTJRUqc8hTyVGFB0EoE+urWID8e/LxNzOG
         k8QZHUlNKUHcVR4psnanWg5+3xOWK0VfCBCT3xWTOz7PtgAuLeBhA4YasYQ4owId2vpc
         3CtVbMekTvVrMp1PQj7u+w3ISOSR2W8ipOCmkT5OahAKgq9/8QKY2l3jujgoVqqjLhuz
         voyA==
X-Forwarded-Encrypted: i=1; AKwUvBwIq/zPMmhVLXuOyk4vF9o4ZqrVgpjBptjsIeYD58VkjuZAcqIBut1xL0CQIdbAMHW4eBdKFqt0wuKjvxpL@vger.kernel.org
X-Gm-Message-State: AFuF++k1+P9rXnvAoQgvUcKzUwpeNQ+XIt4366RWrhemjtGaHA6N+vJw
	lN/vPO4zMcDZpAkLSz7fMbOSxpPKNTB8oRSaePGK3CR2tQyLWSbS/8RB
X-Gm-Gg: AYBFou0GSQ7/b+F0aafJR6VKYuhiSu+VCW7i1RM2C5VnXdWfywXlV01LjAemAatmfWH
	cXl7lnmzgUonGG+TTK/8s0zmoWSkjwb3S3yJKcf3Uhe3vx4RhGT+/Iv3CXzEG5ossh5+Kd4jDPl
	MO2fzCZva+fAsSfnWdh483ldDx4YmjnXTmPWCHJPtCcHYCKgeEMraq8wZPCFOHxast6Yf7cXIwI
	jBWx34hGIP/pwg/a5EJeQqt2IAThycmzyJHJXRYnUkO7NBeUXZnE2D+gI79zThAScGVQpIYlogb
	dmIroVtgvYZZX4qZUXc7tAVrYkV0vsdmx1k9o77adGeQ1xsO5+XmLuD/1bbASfm4aMnZoGukstD
	R+NqCDQGu4j0+qP6xP9xknbwDVkrFlcLW8n4NmjqqGrgWdeXyW1Nr1vE1mWHI8YX/C7LSZ67g6w
	tr2G/1kAkIIfQ/c21Dh0mJ/iY4ooR0C8HAh7qIC5CDFTEYg/IZTx/XLZkE42ABiGSOTXQXlf7hA
	KQcvEbUiNF+H5JuHf1AfhFhZUCIpdgD+UZfUGdiVbL3VZFxjodKtzmXk1hWRPQyN+CRC25aGByl
	X1Mqw2ZJQ1D9Mz3URpKW
X-Received: by 2002:a17:903:1a8d:b0:2dd:c100:4b83 with SMTP id d9443c01a7336-2ddc1005f81mr51236095ad.58.1789851978170;
        Sat, 19 Sep 2026 14:06:18 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17888b9sm12985705ad.23.2026.09.19.14.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:06:17 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jlayton@kernel.org,
	cel@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: alex.aring@gmail.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] filelock: prevent FL_LEASE and FL_DELEG flavor confusion in generic_add_lease()
Date: Sat, 19 Sep 2026 21:06:17 +0000
Message-ID: <20260919210617.3028917-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic_add_lease() searches ctx->flc_lease for an existing entry
matching (flc_file == filp && flc_owner == lease->c.flc_owner) in order
to modify an existing lease in place via lease_modify(). However, it
does not verify that the existing entry's flavor (FL_LEASE vs FL_DELEG)
matches the newly requested lease's flavor in flc_flags.

Since both F_SETLEASE and F_SETDELEG pass filp as flc_owner from
userland (fcntl_setlease() and fcntl_setdeleg()), calling F_SETDELEG on
a file descriptor that already holds an FL_LEASE modifies flc_type in
place and returns 0 without setting FL_DELEG in flc_flags. Conversely,
calling F_SETLEASE on a file descriptor that holds an active FL_DELEG
modifies the delegation in place without holding inode_lock() (which
vfs_setlease() only acquires when is_deleg is true).

Reject cross-flavor modifications in generic_add_lease() when the
existing entry on ctx->flc_lease has a different (FL_LEASE | FL_DELEG)
flag mask from the requested lease.

Fixes: 1602bad16d7d ("vfs: expose delegation support to userland")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 fs/locks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 6e4ff7fcec05..15d73f8f48cd 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1938,6 +1938,9 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 	list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
 		if (fl->c.flc_file == filp &&
 		    fl->c.flc_owner == lease->c.flc_owner) {
+			if ((fl->c.flc_flags & (FL_LEASE | FL_DELEG)) !=
+			    (lease->c.flc_flags & (FL_LEASE | FL_DELEG)))
+				goto out;
 			my_fl = fl;
 			continue;
 		}
-- 
2.55.0.1082.g2b9226bbc0-goog

