Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65C33F5B4
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050308; cv=none; b=VGS0CI5Hs4T4fnB2FnSAHPdA4sxTH8e8ASePm3A9GgT400Cg7pWW/dkmi8QnDlYUJarky08TsYsWNhSscJ3idAUPrcFgAySs78XuqzuRSLIt8c68kjSvv6tuAc1ZRvVIcHuIjLg4dPEtyyQeftOxv7AVRxPGRoQOET3e9wzYNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050308; c=relaxed/simple;
	bh=zm7tjbBanETsgnDaRhWsBeTpzpSPPjWqB6qB4c1q1Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjHRfT44FRV9COM7IaeN66Dp84GsZNOhLznghYKUJUW0Bb1YwDL+p6PYyp84UmBrFkZTt+NL5GtwVGuyLAH7Hm29RzDeVv5WUA37h95Vo88ufw3cgdb7r5C8pgyvzasHS/jiYSvCEQgAnqzPgGCbiTdYOcK32hw2pDOo0QLq1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0LTPlnA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0LTPlnA"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba9ad0fbc3aso633757966b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050306; x=1777655106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QQacq1sjWjjitADZ8Jmt6MmpafRMfjTHB+ERmTO/Kg=;
        b=X0LTPlnAxVEzmERGakAQ+1MKQXJtcaA5n7mGYitG/f1DvevOqLXBmOVbX6Qk4U/xiS
         3gJdmZfuSXW1+VzQdVkonAoq4VIJ8l/l5x0PYe1+Q99BlyqJG5oQf1hPq6UMy9aLjCZZ
         ljD5yoEWCYjd05qmOoghi1CJK/RxbP37D/LgV56MdsPgU9rogn686UsNjXj6jv6ibFSn
         eWO/YIWZvDsNlTOlQSvtBc9NEs0NQ8BqEBPj245gIp0ssopim2uj0k9iQJTkIlHiHba3
         HUb8QRGzumHCrlCoe3kiTxM3iJ4pWpC8oWctXNW60qnRrSW83HHkELP+w/rh/rPzJk5Y
         DhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050306; x=1777655106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QQacq1sjWjjitADZ8Jmt6MmpafRMfjTHB+ERmTO/Kg=;
        b=st7C6TA45wf1JjAY9mvPxbanDjDi48/yk8SolBbv2T3gbpZz0MfTnx+CQKji8l5Aaq
         fDQfnA/01maG9JbodlXCJFSUKSZC4qabQNt8x8REPew5RsMR8kkcBVjhCXeY2xWFre2p
         EVx2FPbcyz0CwyRp7FS4mRWlz6wtJ9CkaAH7lj4AX9WaBUMfJ3oGRBRnyeglXLuO4qdY
         TE99if1Gqw6hFR1Eqaj7uyYLtIDCqr3D7mUIN1Nvl39tZA/s0B8qC6UaIlU8IHT9H5Ic
         zltwGGRaqj34OpQP5MntcF6eNoM0kYq8fleb1qai934XcdPDLH0hZ2NSoeSChd3qEQ9i
         ++/A==
X-Forwarded-Encrypted: i=1; AFNElJ8w9KhXBm0h5qX+8wUPpZxcv/OWRtYOL1Qk3DMoSByM7aXZKnNWPDQMPioz1sj8gjyiEyxwq9svwKTGLB/M@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QH5pNKX7dXUvVvSBHoNNwvmjLOz5jyasAHQs25ikvPicKBgE
	uL2lJeBE8w1BEwhkPHX6MUQANiMHS/OOHq33w4tOq5NbIMvKgNNuJNuyg8XRAWpV9cw=
X-Gm-Gg: AeBDiet3/o7UbdOSNyDoz8wkZCO3qc2o3dKGq7uBO2agORVQ9JgUZoXkdL5BXIPh0KP
	WZjZ1Sdzo0wKFaFZZK0mEFSsk/bCXoPjU3jMGc0XIQ4npghy1p9ozAKC0hmdiAuLhmbF/1wgqk2
	D5o+xCwpJ+6Ox7ArNJ3L38a2BxVlxOi5gboy0he7ijIsaveCSNPwpNfw4yhI/lpNPkdr71hTVd6
	0K9xviGLOjWfeTOu/FR9h60zs3pLia/WcO8dkJX6mWI+TNpo6y1/7gqeVyp1XSwYkxyQqqs4aRj
	8mhyG7MTQHZhPP81pzMdbJtmCR3NFj+vesLJdPu6oGzG4NHfgxhcX/J0r6TCeI2oYZdIZr+GsNA
	WIiaI2cHpKV0CgwZUwTL9mck04TFo7VrEh9QwU4bzFjRdqBIJBLWluWu6IKWgJuX6SzViCl3m7D
	MvINxkjNNZGy5ex1Dab4XRDil1YVSIt+to+7isVIooXugegY2n6isP4gty6CtaiQXDZC05PzfI0
	Jii8gOOi9dXInIMM7WRBnR5NN08rqH0BCSOFNc=
X-Received: by 2002:a17:907:9494:b0:bab:29d9:babf with SMTP id a640c23a62f3a-bab29d9bc40mr723839066b.27.1777050305199;
        Fri, 24 Apr 2026 10:05:05 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-4aab-734a-1928-df3f.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:4aab:734a:1928:df3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45553980csm798975266b.58.2026.04.24.10.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:05:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/10] fanotify namespace monitoring
Date: Fri, 24 Apr 2026 19:04:53 +0200
Message-ID: <20260424170503.2096847-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

Following your feedback from v1 [1] review, I've made the changes
to clear the way for reusing the fs watcher event bits for ns watcher
event bits.

The terminology of "ns watcher" vs. "ns events" is a little confusing:
- "ns watcher" group can place mark on ns objects with
  mntns/userns marks
- The events that can be requested by ns watcher are
  mount (tree monitoring) and ns (tree monitoring) events
- We could imagine requesting all mount events of all mntns owned
  by a specific userns, but this was not implemented
- "fs watcher" group can place mark on fs objects with
  inode/mnt/sb marks
- The events that can be requested by fs watcher are
  fs (monitoring, permission and pre-content) events

To simplify the implementation, the event flags (ON_CHILD, ISDIR)
live in a shared space that cannot be overloaded by neither group types.
This is not because ISDIR makes sense for ns watcher, just to reduce the
number of gates in common code. ON_CHILD flag might be usable for ns
watchers, not sure.

Thanks,
Amir.

Changes since v1:
- Introduce group type and gates
- FAN_NS_CREATE/FAN_NS_DELETE overload FAN_CREATE/FAN_DELETE in uapi
  instead of using high 32bit

[1] https://lore.kernel.org/linux-fsdevel/20260307110550.373762-1-amir73il@gmail.com/

Amir Goldstein (10):
  fsnotify: rename fsnotify group flag macros
  fsnotify: introduce fsnotify group types
  fsnotify: separate the events bitmask macros by group type
  fanotify: test event->type instead of event mask when possible
  fsnotify: do not report mount events with fsnotify()
  fanotify: gate fs event classification by group type
  fanotify: gate fs events checks in fanotify_mark() by group type
  fanotify: add support for watching the namespaces tree
  selftests/filesystems: create fanotify test dir
  selftests/filesystems: add fanotify namespace notifications test

 fs/notify/fanotify/fanotify.c                 | 141 ++++++--
 fs/notify/fanotify/fanotify.h                 |  62 +++-
 fs/notify/fanotify/fanotify_user.c            | 218 +++++++++---
 fs/notify/fdinfo.c                            |   9 +-
 fs/notify/fsnotify.c                          | 123 +++++--
 fs/notify/fsnotify.h                          |  12 +
 fs/notify/group.c                             |  14 +-
 fs/notify/inotify/inotify_user.c              |   2 +-
 fs/notify/mark.c                              |   9 +-
 fs/nsfs.c                                     |  21 ++
 include/linux/fanotify.h                      |  40 ++-
 include/linux/fsnotify.h                      |   5 +
 include/linux/fsnotify_backend.h              | 108 ++++--
 include/linux/proc_fs.h                       |   2 +
 include/linux/user_namespace.h                |   6 +
 include/uapi/linux/fanotify.h                 |  37 +-
 kernel/audit_fsnotify.c                       |   2 +-
 kernel/nscommon.c                             |  47 +++
 kernel/user_namespace.c                       |   2 +
 tools/include/uapi/linux/fanotify.h           |  37 +-
 tools/testing/selftests/Makefile              |   2 +-
 .../{mount-notify => fanotify}/.gitignore     |   0
 .../{mount-notify => fanotify}/Makefile       |   3 +-
 .../mount-notify_test.c                       |   0
 .../mount-notify_test_ns.c                    |   0
 .../filesystems/fanotify/ns-notify_test.c     | 330 ++++++++++++++++++
 26 files changed, 1045 insertions(+), 187 deletions(-)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/.gitignore (100%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/Makefile (67%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/mount-notify_test.c (100%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/mount-notify_test_ns.c (100%)
 create mode 100644 tools/testing/selftests/filesystems/fanotify/ns-notify_test.c

-- 
2.54.0

