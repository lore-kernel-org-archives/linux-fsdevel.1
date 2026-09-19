Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2285432AAA8
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841402; cv=none; b=ebec2aPqHTUKEiqsrJ29jULuMNWbUMO26XNJ2G1ZeJRcTjsvbOSCtJqR/t+o3hHkWMG/ovTbzgssnb9ycg5QUreDQBsMzfwq5BmttQTXbD1X7F3mtgw7P41NJVAke5BAG/OSiQUEr0fPhpuls+l/VpUhy1fLaKSW10drkLROpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841402; c=relaxed/simple;
	bh=gHqFe6eGXXFB8sKeBRGQ/axF1hls+iHKOBOScQ/BUUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBvOZHP7d4FjkqgVZ4ai7VtpT/EcGcYg9zqQXXwu1NHHe22j4mtodNejpCJzHNE3WYRde+lm4ABgttrqfwpwM7Bsj3gjXAzqUZtXzN05Tbp9dIXZF1YZMJejc1cgfZKkVO42N8uLaU+kUBi3HPMWXEW4td4fvoHy9KqITDyK/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTmS+qsc; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTmS+qsc"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8674704dab1so2585266b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789841400; x=1790446200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+leKu+1qBvaX9SQAflmbpFDOda53LtTnr+DkqjC8UBo=;
        b=DTmS+qscF21PdkVlYwgnWOn8fZRCur/iLWteTYa1MIfMOHIe1pW9GV0UI4AQQ3WPtb
         //MUHEjkkLvPPcX7AmrCj3LFX8kg+KPaVcxKwCLJN2HmMRCEZwyVFaDFVvGxIBTGZEY3
         QksaXQ8wLF25Uv6I1b+TcpLAeQU29HXQmgcCqn21EstvqJH41fVnSyBOqU48TGYfuCcI
         p8YZVXQBddX7aYOXmGqeGaqqtAFKlslS/5yVj6dzB91ZIWEoZFlFQNLSFzK7YgWZDn9E
         v+k1qUglOSmIG20fXlAqdMFRNYhIJa3sco6+94Fx4tCAdHZzSoMeC2sp19qiqUPzHXfM
         mkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789841400; x=1790446200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+leKu+1qBvaX9SQAflmbpFDOda53LtTnr+DkqjC8UBo=;
        b=0rJSK2gATdU3jdEgsDM4jYYkpLgBncVk36WX6hOcAljFUa7ol3YiaEBSWMD64OZBCJ
         9F3s9h2FXjSvgNvCctp3AT0kGWZNW2UBrPRInb8j6r/1uOexuEylXMxNTucs35fK6Amj
         /2+cKPXlus2W/Oa9ucVInMNZx4pU+Ugqhdm0t3j/+SK7y62rA9CWhO8tsLjIYJMu/uIR
         LTJzL1/crblldFC5BsQniDQl2+bx5HewjEPRY0CBNDTu/92/yG3rQclotowxYUo7DgCM
         deT0dBuf1HByglqKZ7g4PDZGmReHkRlfgg0kMlfHjd/DlPortgr/nGrlzdBaOKX/+fd+
         2BRg==
X-Gm-Message-State: AFuF++ll8UsUWJVyppVP9SDSypiHtTo89bsGBMfso9kqn5+PTECSrd9M
	3nPvCx9HvHTveiOVCLnsCnPRlvkJ31oP6yeHA4ze0izpLbHpldM2bjs2
X-Gm-Gg: AYBFou2f6tTF5re9vXCRkUfll6lgmmoVygE/HCEbYqvxqyQB0YtJITdrBUNWurOyDJn
	kdZqC16DDw7FnJflk+cI5v+aQHSWn6GAWwHqguXFTOnzzwejUKEejd1uItRl/QWXy2+fju2LZF/
	r2ONMGwPUEx0eUEZGXeI6AWPm+zHl701XS7I0GszHFySbroXmiYcfo+c2Hh5LZDbDVC5SbFGXIS
	0lXX+NWmAzg/8qDGNw88GMxz4+XbEMMCu0Rqhsi7KoUG1ubiZvSA9AHJiLUF919QUhxOd/UO1dd
	ioVFIyrw9VOIaXhjboOQycfy+oVtoAN2/Vl85rGmz9J7MFSl4CzbQvSYpm2jtvpmN3dQwUGo9om
	kwRYBz+ebPoCiTBcZ8d1MWFv04FI8sbxZejusGKYoTf004D83S8/0U25MPy8n44mfTsWJb4QyHu
	u/EaP/WWzPcsA+smOwIDUZNvB/ZyPm7REmo+kqrOqdB3p3x8Q8UZHvPUrHiNyfgd1DfOavwrSVn
	sghu1FL0z9nnK2xs7ZuEi6kfTiNLJOvG19Z7qOkejqVTHkhou8vDSXZI6ohErvtXED8BNmJizhT
	4lkF+P3tMQ==
X-Received: by 2002:a05:6a00:856:b0:869:d8e5:dc01 with SMTP id d2e1a72fcca58-874dbde4f84mr9919960b3a.4.1789841400356;
        Sat, 19 Sep 2026 11:10:00 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a94f8c39sm1190168b3a.28.2026.09.19.11.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 11:09:59 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] affs: fix out-of-bounds bitmap access on crafted images
Date: Sat, 19 Sep 2026 18:09:54 +0000
Message-ID: <20260919180958.1362943-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While fuzzing AFFS with KASAN I hit an out-of-bounds read roughly 8.45 MB
past sbi->s_bitmap, triggered by truncating a file on a crafted image.
Tracking it down turned up three separate problems, all dating back to
the start of git history.

The root cause is that affs_free_block() and affs_alloc_block() each
open code their own block range test, and both get it wrong in the same
two ways: neither rejects a block below s_reserved, so the subsequent
`block - s_reserved` underflows, and both use `> s_partition_size` where
the last valid block is s_partition_size - 1.

AFFS already has affs_validblock() expressing the correct range, and
affs_bread() and friends have gated on it since 2005 - so these two
functions were happily operating on blocks the rest of the filesystem
has always refused to touch. Patches 1 and 3 simply make them use it.
Patch 2 is unrelated except that I found it on the same path: the
extension block walk in affs_truncate() never checks affs_bread() for
NULL, which a crafted extension chain turns into a NULL dereference.

  1/3 is the one with the reproducer and the KASAN splat.
  2/3 is a straightforward missing NULL check.
  3/3 is the sibling of 1/3 with no reproducer - closer to hardening.

I kept them separate rather than folding 3/3 into 1/3 because the
reachability stories are quite different and I did not want the
unreproducible one to hold up the other. Equally happy to squash if you
would rather have one patch.

I also deliberately left out two extra defensive checks I had written
(a post-division `bmap >= s_bmap_count` test, and an early return when
sbi->s_bitmap is NULL); both are provably unreachable once 1/3 lands.
The reasoning is spelled out under the --- in 1/3.

Per Documentation/process/threat-model.rst these are regular bugs rather
than vulnerabilities, since mounting an image is privileged, so there is
no stable Cc and I have posted in the open.

Built with CONFIG_AFFS_FS=y, no new warnings; checkpatch clean.

Hui Peng (3):
  affs: reject out-of-range blocks in affs_free_block()
  affs: check affs_bread() return value in affs_truncate()
  affs: validate the allocation goal in affs_alloc_block()

 fs/affs/bitmap.c | 4 ++--
 fs/affs/file.c   | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.43.0
