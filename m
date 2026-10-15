Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B056213E9C
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074973; cv=none; b=Kv/c8w3VZRTIRuiD8f5+vOMVSTWqJ/qJp8rLF1Klx2xOFP7FS9772PucB0bWB1P4ZmrNyN+MWZ0zDBykGOQ7Z3hyekUX4bGq7eDg35XV0fvfGzX/T+uaNEu3P6KCCLkXksy964VCbI7yZfxbpqxHtwxjInRndP1E8D7rydhHVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074973; c=relaxed/simple;
	bh=E0czfzjCEhnFfOAYL3zbIcbUqx//eIdQtoUrL+xez4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JmQlE+kmor773E89iLp6F5QbIVpu7GnySJoMs5+ld4HB8AAD77yfK8jnQTQ29o/lNpsbrAMFbLAQQGIhPbolH7hOT6vmhneLSgSgA0VADsEXz53tNlUyEKtStUuUHGAzwKdCX5SD2Lj3egGT+kHRcykdNt1SXITGv1tj+Dzi8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWzrgulV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWzrgulV"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c3fd91337baso62376366b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074963; x=1792679763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IT8EYhCgYU6GyVGiPMcATqxuWpptkCrT+sYQM2M/SoE=;
        b=MWzrgulVmUTm6Yvv86FjskwBtns1j0/GsynTs50fPZpLhz9V33tzbfTS5zuBlsVWAG
         UoxQENeD6ii9DdHA6v/CCFgOh8I2OT4ACE9ObpGq1pjGD/KWVi4k6OpOexELLtBe95/L
         +KDKLnWjarQ04gd4o4orugO6pMEw+BhBXqmsMVcvFQ6OcsyQ/kE7868+KZa8V76Snb8y
         QVtzf2FhrtUvTJdKZeBQwSulcX4Z874ibwUngPCQY26S8y1FSB7WQ3PtNnpm6mdcOvQE
         yHOgGOka8Dd5IRpVTfDWcH1MN4GMwjDf5a3f44ptU6BpFrrZJ/gdPra6NRzLud7yQmzg
         SRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074963; x=1792679763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IT8EYhCgYU6GyVGiPMcATqxuWpptkCrT+sYQM2M/SoE=;
        b=jf/DnAhMTZGripeXLAdduIJVEtCcH4IWSUtWd0iUuyIe0IdFmnXfiyqFLllcJ6yBa3
         fGfW2pRxGXGs7qHQMtMoXWJ0mTjdtUkqkGeIStxmkoftx6eT4+CWvawr5Sts8No8xQsR
         k37ge0rhC9zJsipMLPkQMY9AOyKY4KJQodMLpoSMaLbxfbrb6DWDp0rrkVVYIScMp27O
         43TVl1iUiMVDr6LswRmkwa+MztNSjTN34AJbQTEEzAurrX5UO20mGDyTvoQYZKkPLw+P
         fyd6wHsYryvYd0Z3u+eNXdz83f7I3pBhPv8Y/ct6hV0Jlhbz+bjEI8pIYs7LiHsp11Tz
         QH9w==
X-Forwarded-Encrypted: i=1; AKwUvBwCjVXAgedCsKzKIyMz78oy0Qdw9Mk1Vl9zfTiTBQy8Y4IyLlosgd1G4spwHndv3FK+n9MOaR8hIanBUZ8C@vger.kernel.org
X-Gm-Message-State: AFq9FYINUYFRVVwxw13WjK6O+BitUo4pVfpI/osOAbrWJvE3oz0MmxB9
	8laaDO4e/Nyw9u3M8bzBRYeiRLC7OsOdoPULZNAz55Uz2ImKiTHxNcJF
X-Gm-Gg: AYBFou1Sxpk+eMfRcGUrTIqyXlu7P0B/VYxma5MeS/4EZNpCxMHppJzSRYs3++0PRlk
	HR6oShoWAMZDjEpQ4zGEiXYYrltSohtW0hrDSndECgsf7dvfNWQSYks9b42J8fSWMt/nUOiShIc
	2Q4Tg8ARZ3FXMchHbTlM2ScrfKqjdMCzh/n+QIRLc8ebRvyxhgpf4uq+wJxyvS9uNRk2PhuVCAl
	y4U0yOSAsp8LCm2Yct3UCxewEbwMczOhXJ6DmJ1nKREJqM0452jsw5mDUSKsde51BhiQ2N823Cj
	0ufOq6HT3UrqwiV2yVAJH7+Xc0hNEepBDtcjnqbg5EH0HaYDqSOCp9X5KwqO+urmGn96/Vueanc
	lvxPimA6AwBahkDa0vbETMoSdmGVXN5Kp+6vThR0PJMSElOiBzUSd8fiY/GEgIAV+zSzdDR07Jz
	ZxDgRC/cc3tpU8noChL5DcaAUiYpRKKqGqExy315D7qhHWzy5e2dzTQA3oFsvBK6TphVQf819j8
	QKzdqgOijm74r+GGOWUdZR/6IHijCRugyzE
X-Received: by 2002:a17:907:7b87:b0:c2d:c739:30e0 with SMTP id a640c23a62f3a-c31aa0d3aa4mr1740222566b.38.1792074962924;
        Thu, 15 Oct 2026 07:36:02 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed9b3abe2sm134175966b.38.2026.10.15.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:02 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 00/14] Partition the fanotify watchers by type
Date: Thu, 15 Oct 2026 16:35:46 +0200
Message-ID: <20261015143601.2095784-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

As discussed on the "namespace monitoring" patch set [1], the proposed
namespace events do not need to be mixed on the same group with legacy
fanotify filesystem events.

The mount events are already not mixable with filesystem events, but we
want to be able to mix them with the new namespace events.

Therefore, introduce the concept of "watcher type" where all the legacy
events belong to the filesystem watcher type and the new mount events
belong to a new namespace watcher type.

The new watcher type is free to reuse most of the 32bit mask space that
we have internally in fsnotify for event masks.

The prep patch set only does the partitioning by watcher type.
Followup namepsace events work in available for review in my tree [2].

If you are fine with this plan and have time to review the patches,
perhaps it is not too late to stage this prep series for next cycle?

Otherwise, we could aim for merging this together with the namespace
events for the following cycle.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20260424170503.2096847-1-amir73il@gmail.com/
[2] https://github.com/amir73il/linux/commits/fan_mark_userns

Amir Goldstein (14):
  fsnotify: rename fsnotify group flag macros
  fsnotify: introduce fsnotify group types
  fsnotify: separate the events bitmask macros by group type
  fanotify: test event->type instead of event mask when possible
  fsnotify: do not report mount events with fsnotify()
  fanotify: gate filesystem event classification by group type
  fanotify: define event mask constants as 64bit
  fanotify: define new FAN_NS_MNT_* constants
  fanotify: gate event mask in fanotify_mark() by group type
  fanotify: introduce FAN_REPORT_MNTID
  fanotify: introduce FAN_EVENT_MATCH() macro
  selftests/filesystems: create fanotify test dir
  selftests/fanotify: update the uapi tools header copy
  selftests/fanotify: test the FAN_REPORT_MNTID mode

 fs/notify/fanotify/fanotify.c                 | 186 +++++++++-----
 fs/notify/fanotify/fanotify.h                 |  38 ++-
 fs/notify/fanotify/fanotify_user.c            | 230 ++++++++++++------
 fs/notify/fsnotify.c                          | 106 +++++---
 fs/notify/group.c                             |  15 +-
 fs/notify/inotify/inotify_user.c              |   2 +-
 fs/notify/mark.c                              |   2 +-
 include/linux/fanotify.h                      |  45 +++-
 include/linux/fsnotify.h                      |   6 +-
 include/linux/fsnotify_backend.h              |  83 +++++--
 include/trace/misc/fsnotify.h                 |   4 +-
 include/uapi/linux/fanotify.h                 | 100 +++++---
 kernel/audit_fsnotify.c                       |   2 +-
 tools/include/uapi/linux/fanotify.h           | 100 +++++---
 tools/testing/selftests/Makefile              |   2 +-
 .../{mount-notify => fanotify}/.gitignore     |   0
 .../{mount-notify => fanotify}/Makefile       |   0
 .../mount-notify_test.c                       |  51 +++-
 .../mount-notify_test_ns.c                    |  54 +++-
 19 files changed, 707 insertions(+), 319 deletions(-)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/.gitignore (100%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/Makefile (100%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/mount-notify_test.c (90%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/mount-notify_test_ns.c (90%)

-- 
2.55.0

