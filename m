Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EBF33A029
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075135; cv=none; b=g0YdqGagSgqJNbzS+I8xzDYaXMpln+I62elNFUIfNtN63DA6u7BPJVTG/9GxiKpquXkeZt3A9nwMu48eLGcO4KLS5bsqDtxR12rfGLq7zgPcMAktGGZIjGpY/PXJLcGiawIu5vVevXNh1s8gt27xVQCkwDylH9IQY53epUPjWC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075135; c=relaxed/simple;
	bh=TRlCvqxLO7Icqzc+zPIRr0BKl6SwlvU17ERW9PLkylo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwaB2e3G1Wrqyo+HHqIayEs2b/I+VcCvZuc2DPk7/tD6i9lhe4P4JnLJa/PTSy4vlkrOsT+BfI7n9Skmy9877m61Y+sk4rKB0my8vpGAAy0MBNRlVACgRYgfAtF409WvZ9ZqeIwnn+4zUff01EYlbV6xA/2/7IYux2oy+27wJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIr0h2NJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIr0h2NJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so90661815e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780075133; x=1780679933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3K1/NYF43STErmnAfgG58SuvnOt3ltd46qczkd3B6YI=;
        b=QIr0h2NJj3kx2DaPpIerm57+rkpMl5xwabEhQzggRDoduHO6N1/J55Zy1+RAXqip1d
         pg4iEHcZl0E4kaHeIZx77YxeyPViHV47sc9mpY7ccn9jVvKSFhqlNbdQy4F4+9s4uL49
         wLFaHBCZPZssYK8NIt9XcPp6uOOMa5g6WrrGL73ZPSC54UveLvxckE25OloUE5Vl5rCm
         odDvjIqybE5f4bvCPfYtsVzyo7luLF52dWG8xn9l7MAaUc9BwAGOKo2dhyjIpP6PP9zs
         T6OD/LMR8Y3y5cOhNOSe/zoUwJ4BApAyZCboCRvNLfWFYCTo/VVOtROqkOU9AX5rcjXk
         r/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780075133; x=1780679933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K1/NYF43STErmnAfgG58SuvnOt3ltd46qczkd3B6YI=;
        b=ZQB7I4djASiGHN0jGEsYSvUAuxVXvynQR3FO/TrdO7zcv+qjElBTLsQIYbFwfDvrEY
         wXqZyWfYYNSK8EKumu6Vt+W4y705woZi6yk19PUa2pRVqgSnHoa/TW+w6Wi6oFtgc/Yi
         T2cTJ2YK4sCMcceTrchpZyFn7QXY+76XtneBg9LL5N5DAg45RTthWNmYFEgB557NqeY+
         nik3ma0FTeIl5O2n13GEFoCAx6COkgR2GBnsJoMwFcoC6+qWHSoIl9ODBPLkbcAahx6E
         OTzrsUFqtt8uUjz5C5d1TXC21KzqKaZk4nj5BFjoSvalMr73dQNlDRt4cE1ZBk/NML4c
         /GYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vF3WfMoO8LCe4O1l35CnuGb/YPGDFq50CYWycR5hzDykc+7RLgjTNJAiHvTemLvTXCgRsiQC6tNCX44PZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwWHngBopddXadnXdFRrgUYJRBQetGVo7CRNXTgi3gtM11pk23R
	VWbYjOOllX5cfMDVlm7r/biMcOtNUQUrIzWpk3XGLZJvy/IY5d8+h9udAEx++w==
X-Gm-Gg: Acq92OGjNLH6iaqGJKJ5kdPXOSKeBIL8sUtE0tKvWH9NcrFUDRIxdmSRwZC1KEKZGyG
	cSQJFHXgfSndCgzcay4QgutgUnD6S/T+CilUkovzOLKwLDzXShu969JzVdTtlpNxzpJI9z0tL9+
	L+eSEbaPF1jQ0//+M1Ru2PKLf1LC+7MylxjfIb3X91yPge5nc5neyimiBHKY0z0DXG/u2WTZD/H
	wM8lt/IzwteKsiQ7JCm2Jj+7KQz235ktjIHWZs6szVEoraqli9urPqsuLENSXfsCL6veBK6PYUX
	PpxXJHpoU6sxv6MgSwK14sgBZPWQEdJj9cvXGkQpx5hZx6EtaysD9DpED4+n+1BQK34tbtnVvOd
	6/OuZntOynd8CgEPoJV++KtFGNKfehnocABfIOJSm8kC1n2IirW+eEvZ3LsDUr8EZZbOjB+LeZS
	ADlIVoCv1QcZoUMLL7NCFPyAtLufeS4utT5e8l7HCUtR5q79U7aLA+gigjTY3GQoxw9Tlxlrm8f
	viQe4pzaFgezlGjINzmeZM=
X-Received: by 2002:a05:600c:34c8:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-490a2b6e3d2mr2625655e9.5.1780075132993;
        Fri, 29 May 2026 10:18:52 -0700 (PDT)
Received: from f.. (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909caa7faasm56255375e9.11.2026.05.29.10.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:18:52 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	adobriyan@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 0/3] revamp fs/filesystems.c
Date: Fri, 29 May 2026 19:18:37 +0200
Message-ID: <20260529171840.2576445-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file is a mess with a hand-rolled linked list in a desperate need of
a clean up.

The code to emit /proc/filesystems is used frequently because libselinux
reads the file, which in turn is linked into numerous frequently used
programs (even ones you would not suspect, like sed!). In order to
combat that pre-gen the string instead of pointer-chasing and printfing
one by-one.

open+read+close cycle single-threaded (ops/s):
before: 442732
after:  1063462 (+140%)

Additionally scalability is also improved thanks to bypassing ref
maintenance on open/close.

open+read+close cycle with 20 processes (ops/s):
before: 606177
after:	3300576 (+444%)

The main bottleneck afterwards is the spurious lockref trip on open.

v4:
- add missing unlocks in some corner cases
- whitespace touch ups
- s/smp_store_release/rcu_assign_pointer/ [nop, the macro expands to the same thing]
- mark file_systems_string as __read_mostly

Alexey Dobriyan (1):
  proc: allow to mark /proc files permanent outside of fs/proc/

Christian Brauner (1):
  fs: RCU-ify filesystems list

Mateusz Guzik (1):
  fs: cache the string generated by reading /proc/filesystems

 fs/filesystems.c        | 330 +++++++++++++++++++++++++++-------------
 fs/ocfs2/super.c        |   1 -
 fs/proc/generic.c       |  12 ++
 fs/proc/internal.h      |   3 +
 include/linux/fs.h      |   2 +-
 include/linux/proc_fs.h |  10 ++
 6 files changed, 250 insertions(+), 108 deletions(-)

-- 
2.48.1

