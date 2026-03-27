Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D263A9D9D
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621901; cv=none; b=LoZA5sJzYzdjvlo4gGrzEMYxOApHdc6Pa0KhlCwslwpyTNDXxo08wro3eacbW+k4CdlQ1oIJTqP7PQENP8V2czjrmjHuJs5uIInddAXcuwcDsxautJr7dWIcH8aTgRY1Nei0LJrgraZUXrYjaQd4rzU2q3BIkYBRYxc3X/qh048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621901; c=relaxed/simple;
	bh=wTWPsLZLjTdHXqVGzL8ldy8dTc6aNnVtgNcFoUiBjiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fltLNl546rW0YgH/uMEHSHiRpOzxd0YcaqbsBCM4GU3ydiFfL7yifJ6KMtDPsNnXzWm7Z0HNh+Q5L9IDtdQo2XMVjgyO/khm0vM6nbgk6/YsvWcaRsfw9V36dFgStkJvFdrIJZMkNs6LgNResRECyuaNRUJ38HyhoZdRaZmlaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNlTfwY3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTreVxpc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNlTfwY3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTreVxpc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774621899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wKRCSGhjp3JJfBN4HsapCNygZwEljeRSphUGPKITJJU=;
	b=RNlTfwY3YuQIT4k/X729SpYffPeogQWMsDbeHGRtRj9cbaZESsCUdq8RGV0uJQqrsW1Xtk
	pnFpxe3qULkllgriexJ+BSCEhHT7IsdBgGN7Z8wjKU97h41DcD8KIH0U8R551zRKqdFOwN
	RDQiunqI+eug19qVZRa7zDUzitSyNwU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-BTXoxbCdPL67NbJbtLzQmQ-1; Fri, 27 Mar 2026 10:31:21 -0400
X-MC-Unique: BTXoxbCdPL67NbJbtLzQmQ-1
X-Mimecast-MFC-AGG-ID: BTXoxbCdPL67NbJbtLzQmQ_1774621881
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cfd8067379so516973385a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774621881; x=1775226681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKRCSGhjp3JJfBN4HsapCNygZwEljeRSphUGPKITJJU=;
        b=BTreVxpceJHmFPnl64WPbCFG0UwpPLzqvY3RjyQ7uKoiGrVSQg96gJNyqoKH3Lf+c7
         Rpro7TG2ULGY8z5fC/5cfj4E/uf348mccD8ex0kMM5+FSHDYRRh9M5Lh9PWvp6tRXXH7
         X+3AGmt8rOf9fD2CAxQg02uxkMJmSy0xsBywusHutYs19V/gslhIRIrc+Cht8P0ASq1J
         AS6ofq3v25i8ytPPRZI02IO1z3klKfP4dTTDeZN+B37051zU0UUztahTofQ/gh1Xwj3k
         y32BNh5j92JYunYPE6zoxtxyMZK/NUjvgBJThVDTGLcdgsh8EAT0YLDMYjwta0EUXXOS
         yH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621881; x=1775226681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKRCSGhjp3JJfBN4HsapCNygZwEljeRSphUGPKITJJU=;
        b=QU8rcaioBaYw/bpdK05JUSMPug/uZOpX/Fghc/MJAvajkzyPqMx7RVAgpyy2UuImU+
         VLGSosztKNzmslNYTvw1oPOdudocNgUGjH3FEsUuYfZvJvTL0p/xNLnIk/1IebpCBwVI
         +OdiErjDxQjNC3LUFqtPjRQnsHgyI7QINg7POXWxuN/ansWL622sZidpvFQfzOgmJwGz
         H6lL0f2uy+SeWYLdfthAaxg65xgDb8yB/uzQKMbgfyRS44nfzKUHdl132uFnjXP+MmaV
         6S8dpxJW5OaZ++Y4mTXL/AUItVLEqTKhELjQyXX6ukKVR3bfGlXhcOO4DjcmHFq4gHs4
         9pLA==
X-Forwarded-Encrypted: i=1; AJvYcCVMnU6F1wjfkRPGCQGaX8W1Pkg9EG2EiAmuL0dDZARrfQWISGegcvplc0BgG9A/4XJIucY/NahlF1cnYIGI@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDgVBuI0C6A7S6A/oUw7NvmyXspZ4NfF8S0sdLX6Rilm7ME/T
	I62rqbAD8O0z/gvksCk36AteT6zVoWJiC4tdNSU+A/E31Sm1YqpndFqFL8oF2WpqNLtGkutUHvP
	zU07gzV0Udkjk0EG7lh/L39DFwI7xMjMU5UIeVHhG/mkVfHVK3zZfaur6yr3rpS+stU8=
X-Gm-Gg: ATEYQzwqA4D60NAj3K0ebk1wgM+j3qWivEX9kCNp4iyWftLvjLTRA7ZMUdYyjnXKHSn
	Ho8FzAEbhmgojDJG3uXFjmps+SwqsIsIv/AXzSMK7FOHxILKBNyjCXdRDnhqJRgQe/M37MpLQj5
	vaKrqmBm5Y+KCxY2EYHVU5887RptOb5jUZNLu6lURzFLIt8RtwDJGEF3av9D31arSJxtAPH3DQn
	Y1WDguYpyLOdR0w6pq5Mvd8A7wUaxq+8NVeJMOcYPTftSHXwCU2i9mTR0dQu1WNgfFdiOa3vh1M
	iszMLG+TVC5uhW89JLj9D39sm23pHmuB585QUbrD288dfse358zRP4nnnwdw6acfjV8M+mCIwKV
	bbo5eTcvFtFQrkGQAhEcJhT4WCsmdZstuwv8fNUAMPfAJtuKVcoB3B6c=
X-Received: by 2002:a05:620a:468c:b0:8cd:9322:d449 with SMTP id af79cd13be357-8d01c7e338dmr352973985a.56.1774621872589;
        Fri, 27 Mar 2026 07:31:12 -0700 (PDT)
X-Received: by 2002:a05:620a:468c:b0:8cd:9322:d449 with SMTP id af79cd13be357-8d01c7e338dmr352787885a.56.1774621852301;
        Fri, 27 Mar 2026 07:30:52 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm515168585a.36.2026.03.27.07.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:30:51 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v1 0/10] ceph: add manual client reset and selftests
Date: Fri, 27 Mar 2026 14:30:36 +0000
Message-Id: <20260327143045.1393612-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Manual client reset gives operators a way to break client/MDS capability
ownership stalemates without unmounting the client. The reset blocks new
metadata work, gives dirty state a bounded chance to drain, asks each MDS
to close the session, and then tears the local sessions down so the client
can rebuild clean state.

The debugfs interface in this series is only the control surface used to
develop and validate the reset flow. It is not the core feature, and the
long-term intent is to have the client trigger the reset automatically
when it detects the stuck condition.

A reconnect-only reset would require MDS support for accepting reconnects
outside the normal MDS RECONNECT phase. Because that support does not
exist today, the series first wires up the reconnect-based worker for
validation and then switches the recovery path over to direct session
teardown.

I split the work into smaller reviewable steps so the preparatory cleanup
lands first, then the reset framework and control path, then the initial
worker, then the direct-teardown refinements, and finally the single-client
selftests and validation harness.

Patch breakdown:
- 1/10 converts the Ceph inode flags to named bit positions and keeps the
  file-lock error bit ready for atomic bitops.
- 2/10 adds a bounded wait and diagnostics to wait_caps_flush().
- 3/10 adds reset state tracking and blocks new metadata requests and lock
  acquisition while reset is in progress.
- 4/10 adds the manual reset debugfs control surface, status reporting
  plumbing, scheduling hooks, and tracepoints.
- 5/10 adds the initial reconnect-based reset worker and the reconnect
  completion tracking needed by that worker.
- 6/10 switches reset recovery from reconnect to direct session teardown.
- 7/10 adds the explicit reset state machine, bounded drain phase, and
  richer status reporting.
- 8/10 removes reconnect bookkeeping left behind by the direct-teardown
  design.
- 9/10 queues CEPH_SESSION_REQUEST_CLOSE before the forced teardown so
  the MDS can release state immediately.
- 10/10 adds the single-client stress, corner-case, and validation tests
  used to exercise the reset flow, and passes the configured debugfs root
  through the validation wrapper so child scripts observe the same client
  namespace.

Alex Markuze (10):
  ceph: convert inode flags to named bit positions
  ceph: add bounded timeout and diagnostics to wait_caps_flush()
  ceph: add client reset state and request gating
  ceph: add manual reset debugfs control and trace plumbing
  ceph: implement reconnect-based manual reset worker
  ceph: replace reconnect with direct session teardown in manual reset
  ceph: add reset state machine, drain phase, and status reporting
  ceph: drop reset reconnect bookkeeping after direct teardown switch
  ceph: send SESSION_REQUEST_CLOSE before forced teardown in manual
    reset
  ceph: add single-client reset selftests and validation harness

 fs/ceph/caps.c                                |   7 +
 fs/ceph/debugfs.c                             | 172 ++++-
 fs/ceph/file.c                                |   2 +-
 fs/ceph/locks.c                               |  24 +-
 fs/ceph/mds_client.c                          | 630 +++++++++++++++-
 fs/ceph/mds_client.h                          |  38 +-
 fs/ceph/super.h                               |  60 +-
 include/trace/events/ceph.h                   |  60 ++
 tools/testing/selftests/filesystems/Makefile  |   1 +
 .../selftests/filesystems/ceph/HOWTO.md       | 121 +++
 .../selftests/filesystems/ceph/Makefile       |   6 +
 .../selftests/filesystems/ceph/README.md      |  40 +
 .../filesystems/ceph/reset_corner_cases.sh    | 707 ++++++++++++++++++
 .../filesystems/ceph/reset_stress.sh          | 682 +++++++++++++++++
 .../filesystems/ceph/run_validation.sh        | 317 ++++++++
 .../filesystems/ceph/validate_consistency.py  | 291 +++++++
 16 files changed, 3105 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/ceph/HOWTO.md
 create mode 100644 tools/testing/selftests/filesystems/ceph/Makefile
 create mode 100644 tools/testing/selftests/filesystems/ceph/README.md
 create mode 100755 tools/testing/selftests/filesystems/ceph/reset_corner_cases.sh
 create mode 100755 tools/testing/selftests/filesystems/ceph/reset_stress.sh
 create mode 100755 tools/testing/selftests/filesystems/ceph/run_validation.sh
 create mode 100755 tools/testing/selftests/filesystems/ceph/validate_consistency.py

-- 
2.34.1

