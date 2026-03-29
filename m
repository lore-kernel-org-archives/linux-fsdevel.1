Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F272BEC52
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774776423; cv=none; b=ZRrhm7Q4ZCimmyO8I6YPocyPC1u57QsBK/bgVeDX9a1dNlCaS7Lfg4mQ0g5o//myP9Gm/md0BorbYpLZxfgHj78o39U8hIO3ZgN/UVjZSV2qk4O62NEk3+CcQ9e3yYAn7RxfPgh1Zy83kHIKFAjLyKBGdIx5oARc0mVLo7OEaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774776423; c=relaxed/simple;
	bh=LpGECJxUAlUMKo1joZzZiQhs3hwDPvgm8N6IKu8Ky8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUN5BAB0aIOspI+R01czpj2TfROwLdNgAFtK0wBuxFLtU2ehlOBhsiRRxcpfsV9p0e548ZWcZAUqSEVCrd8IKdJVCiZObpdHUBtccJ6AGqCwZIsTzNbhyBRoTOPz5DSovWzHpUlc5IFgPR/VlT2cV29jWWbuhaVWzZnlHgjxnCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkNP1iBS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkNP1iBS"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b982b0889d8so417022366b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774776420; x=1775381220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1pOBvNq97bdGzDJHCDKOSBm+QEbxiD1zQcrqgsMvIjU=;
        b=HkNP1iBShysBM0EagRnBNvjh5CEfolio/cFS1QFa2i+DAMKfo60dTLFZ+/qNcwLmkX
         7KZ5J0HVg/E7kj6CJzh2HztwouaMtXcrtsz/EQZlcUEPbAY3R5pKC224P20FPCyHyr9i
         r1Vb98wPzgfTa0L+FE0tSt7FYCffwkShrNUJjpx0hCqrZWwz18OJArnjnIAszt5+6ZHZ
         k0LAw9BTg/HvA5xWpTE15OeF6eM+Q5TJgFORNa3nu6sbxzrV3DG29/OH/ofxPkG+QnX9
         C8MM1DJrDQVUEEpNl4GXkR0pMvS8A0+LKSWytosuhTec5iOFbxpcwDChRXBO4OaLMzd8
         5DPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774776420; x=1775381220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pOBvNq97bdGzDJHCDKOSBm+QEbxiD1zQcrqgsMvIjU=;
        b=Pk4jSJLLKyCn2BGB4eFAl/u9eZDKDy0HicfUi/hElpK8xwy1R2eO+2JlVxOrLCxft8
         cSRqgXS7V/qXtpESn/yGWrFIl3bHbu1ZAFljocq7ML+oHDj55Kvm7vdtWeBtYw7MRnIH
         VXcEhWrdLgSa/uZUokukEy22yHuMuFpV4RjbJ3pugbooNcpOyznphwIgExInc3Bet6/4
         u5IGbzrHdHUpUlO9c/j9l/pDp30eZ5tYM3vG2vX3OkbdGgRq/+gVmg3w8ezuPiU3/Msz
         /MoTi+j0+aow3oMPMiwcwdM3VI0LzfVFpXva5yLX+RztCqGe0v/42ZleanI8jiKWzEiZ
         BwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqhWw2AJ74pDJOyFs9HWRgKL4cfpFXFnvkAnjgLXn04tNqsPLUFUZY+9B+wwY+BhL1ROQXEjoVaAJCCobA@vger.kernel.org
X-Gm-Message-State: AOJu0YyHc+fb3PJgGv6mHm6cs64AmQ6a0SPfKvUEObDwiTGJf0+9Hht7
	05r/9D/Glpp2dAOTJeiudSOVpPWVJFW9xugLjGeSzqIMyCpsJApwXcUM
X-Gm-Gg: ATEYQzx3kf9BWqokyshQJjt+yNQ3viMA3XYSw2xLaXgVqihOvsEVqKyS4Ht4prTZ+0F
	EuBHIOXFmuSnPejb5O6JA7dSh7nrQKhjxzJ6eNLoIs6PsA6CNwvzDnNDISE68yMZzG1GFDcgvqD
	MO6on54CZDEy3M11+1g9xXlylo/lJq0IDYpdhXCLtUT+9N9CDuj101jquVozSztq2/oP1m64fqa
	PpR9D3fk31mGc68mNFp+qU/MwjXydErKriHGqzYaOteXQcJ6KeH/SSzkrycW/0dceyzzDk7OeGo
	XQ8HV57v4nLWhEwtTWhQDEe/+2VEQt2ydl+gRQsQy0e+nT2h9tw9bZyFaRmqVhmSwB5Wv8Y/E3S
	HKuP9kzMnlYY3Z1LZnz4N8viU6HlvU/lUcTJY6JvP0CDNg0PMtiyabILu0mL+xprTM2HBjQwvsf
	z9cORm9plu88hFme/NlK8IQCV5rIqdEr9qa0UiHI+L0T4FsfZTAgXYl51uC40ZaDUvZ9v4ebzLR
	GGJ+YuPSkhsLCU2bRHczICLWUZc
X-Received: by 2002:a17:907:1b1f:b0:b97:9139:738 with SMTP id a640c23a62f3a-b9b50909ac0mr547783666b.33.1774776419330;
        Sun, 29 Mar 2026 02:26:59 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-cfdf-bf3f-5ad7-346a.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:cfdf:bf3f:5ad7:346a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1df761sm156863366b.42.2026.03.29.02.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 02:26:58 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Chenglong Tang <chenglongtang@google.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 7.0-rc6
Date: Sun, 29 Mar 2026 11:26:58 +0200
Message-ID: <20260329092658.90712-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull overlayfs fixes for 7.0-rc6 to fix two regressions
from v6.7 (minor impact) and from v6.12 (major performance impact).

This branch has been sitting in linux-next for a couple of day and
it has gone through the usual overlayfs test routines.

The branch merges cleanly with master branch of the moment.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-7.0-rc6

for you to fetch changes up to 1f6ee9be92f8df85a8c9a5a78c20fd39c0c21a95:

  ovl: make fsync after metadata copy-up opt-in mount option (2026-03-27 12:48:10 +0100)

----------------------------------------------------------------
overlayfs fixes for 7.0-rc6:

- Fix regression in 'xino' feature detection.
  I clumsily introduced this regression myself when working on another
  subsystem (fsnotify).  Both the regression and the fix have almost
  no visible impact on users except for some kmsg prints.

- Fix to performance regression in v6.12.
  This regression was reported by Google GOC developers.
  It is not uncommon these days for the year-old mature LTS to
  get adopted by distros and get exposed to many new workloads.
  We made a sub-smart move of making a behavior change in v6.12
  which could impact performance, without making it opt-in.
  Fixing this mistake retroactively, to be picked by LTS.

----------------------------------------------------------------
Amir Goldstein (1):
      ovl: fix wrong detection of 32bit inode numbers

Fei Lv (1):
      ovl: make fsync after metadata copy-up opt-in mount option

 Documentation/filesystems/overlayfs.rst | 50 +++++++++++++++++++++++++++++++++
 fs/overlayfs/copy_up.c                  |  6 ++--
 fs/overlayfs/overlayfs.h                | 21 ++++++++++++++
 fs/overlayfs/ovl_entry.h                |  7 +----
 fs/overlayfs/params.c                   | 33 ++++++++++++++++++----
 fs/overlayfs/super.c                    |  2 +-
 fs/overlayfs/util.c                     |  5 +++-
 7 files changed, 108 insertions(+), 16 deletions(-)
