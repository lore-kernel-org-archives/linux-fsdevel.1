Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A03E49C5
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787409220; cv=none; b=lbhfkV0k8VoL037O3cD9To+sYNtIuGnJbXCAAi6c2lsMhIDsDmulu4N3dhC6qkD6axb2ymY9TdA73F9Rt0dm2vnCuydwpAtGOwfdFolBlHbf5XyPDVAu1MEXjfxjOwQ5ORghQ4gjYB/5k+TZ9Efl3wHENTlEAOfMpR3mIXDtTaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787409220; c=relaxed/simple;
	bh=1QYYX+dMeDVWguBVqVdPZsENj4GiL2hyJu2I8REDjMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZHVMRXM/ygYCxW2NdpXkis395bLdEDEMG1mwwntJ/s92yLgUdL0buh/7AmYEWstFY2N0JJZgjDYnMIZIai9uZkOld9j9VZkSxCYQ3/NLCKD4RhajqqoFn7XFjLgeu/I83EzFC5Wo2yy3uHTbmpjQ06/MsbLVFrb8RcmRcYwTHaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu51+/oH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu51+/oH"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso318862266b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787409214; x=1788014014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cwRcbP/fNP1CPhzOzRsFPIXRpX22RcpOUMzf+VeQAxs=;
        b=Mu51+/oHNeLrl8eube1iA53/zlOHHloD9LKKPQKG3QfcfcPLZnOLNp7oRtZINv6/Ga
         4lSu/KVUDuQFY3tiToAwFTGVxAVbLQ0H1gvTa9tVkb5qIT3DB7tMCvjEJ9U6EZZENGL4
         8RZDW1E535xzb7L3PmKHsZQf/67u9b2+8LDjce6bByLRMHLwpFYsl1JRnHNC9XSPOT2r
         N1UxY4ZB0joUpphK/ia6uVj35miowD++0GoO3a15kERJNPEarJCA5dqEgZ3lO/TNMLZh
         rWFZ3SGMy01+HYodxbfyYk1EHd4p7lFlihJpjEj0SxlHbZU2Kt/ppY0XatQrf/RoC0dt
         LY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787409214; x=1788014014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwRcbP/fNP1CPhzOzRsFPIXRpX22RcpOUMzf+VeQAxs=;
        b=MhjS0w9i/EjwkiL8fEjlasGhYACojlPAI5tHgmWKtlrEaVNLbfKJaZljd7bSwtL9IO
         kQClqwZQavfsjqEQQ749WwB11aJ2TGuITiADnG4JNnKnxkM+711ZzVHhaiEeM5h74n/b
         r/sV0TLwxuVxDFsD6EEA4mwOHr7am+7yFq2yMS//o4fODJnNyGGi/LWclHm0Sm8UUnSy
         zpshXxB8MiK1cDu7GAJSre88p62GudWAE+SDfJ1E2JE3nXenAEjJD0+u9VJ6ys0ysnSU
         +hLCZV6SSviEstNrhAkPYUaWoE4bLlaNHk+ZzjQEuPB9vI8laT8ZBu8zmrHcIGgieBKp
         N/vw==
X-Forwarded-Encrypted: i=1; AHgh+RrfXEBJijEswNQymRpOXNp1E44EdJC36UHClRC3/zzmKw2D+SgWwcZBKpIBBrXc1vkaEEL09f7tXsi9Jesw@vger.kernel.org
X-Gm-Message-State: AFuF++lqe6Mmrq/aZ+XDnea+bnT3lZtoP6iUUdYsxeZIdIpyFI8YqusA
	XVc9cIGaw5GbQ6xAUhO9nJugjZI/XgyyFsivzrsBGLGL7vCXwNF+A0En
X-Gm-Gg: AR+sD13cQbvkaMfITMzfkw/OD6gpY0wVK6hf2KDVJoxvBQxio0V/TeQs24Kz9uCtP/Z
	Ia4DGSIcDscYxVGK4M01fJcZwZbU73GfPCWXHD9Z2ErFkKDJV+rmmGOGx09AsU8qYIcLd7h+++g
	uz6IVOrjrqfd4kapJefqMgEJJcUMMW2powZGBV5A4Pbyag2iW05jGUBkGXAKAMQGGnub/HWXmVq
	VzmzK4z+YBusrmVptKA8BVz/LahXURDlxwbPT+ZAQZFeTGci1iuZ+vl+6G5/6MKRLXKjgEcPcvL
	GyY4/voGLJpQ0V7lQ0QWIrANBWuNgIIuytBbMSHPv3yKkqJrxfDxVvHNaeohuI+wUT7I3L5yg3w
	zV4o7u93Na47+9eJorqu9osGP4iLfoFyfgBvhD8Y5Qv6QKXaGMuLzCpgWcM7EyybNdjVeHUOYOZ
	qYob8kLNjUXeyQ2AGSG4l2+w0Zb8WZ8yubmfDtXxCFWFWsHVxgBgjh7mgeLbjop6ZFSASl34o7T
	nexwVj362nwUiiEgBpxYQiYx91f6MFr+Tn+Hwkt0qgsocawpSi0L2/pwOASvsHWAB9BWbXfXUlf
	j/MLAfByq0etTu6DPNqzyka47pmWXYD5lvVjpj+yuXKv7hmd2Tct7vDBeSx5OytG4dNq
X-Received: by 2002:a17:907:a4a:b0:c20:3733:a8c5 with SMTP id a640c23a62f3a-c246a36f311mr1274423366b.8.1787409214359;
        Sat, 22 Aug 2026 07:33:34 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967459aesm326597666b.48.2026.08.22.07.33.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 07:33:33 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] squashfs: harden fragment index table sizing
Date: Sat, 22 Aug 2026 16:33:26 +0200
Message-Id: <20260822143328.68867-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two integer overflows undermine fragment index table handling.  One is
in the original fragment sizing macros.  The other is in a bounds check
added by commit 1cac63cc9b2f ("Squashfs: add sanity checks to fragment
reading at mount time").

Patch 1: the fragment byte count wraps on 32-bit, so the index table
is allocated too small and squashfs_frag_lookup() reads out of bounds.
A crafted image triggers a KASAN out-of-bounds read on a 32-bit build.
With the fix the same image fails cleanly at mount.

Patch 2: the check that the table fits before the next one adds two u64
values controlled by the filesystem image and can wrap.

Built W=1 with gcc (x86_64, i386) and clang (x86_64).  Strict
checkpatch is clean.

Karl Mehltretter (2):
  squashfs: fix fragment index table sizing overflow on 32-bit
  squashfs: make the fragment index table bounds check overflow-safe

 fs/squashfs/fragment.c    | 6 ++++--
 fs/squashfs/squashfs_fs.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.53.0
