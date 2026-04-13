Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0563AF667
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073286; cv=none; b=Sus8iq0v0tfVZMK0b6s1+L7sNNSGVmFJ0w47hdQKzpWXOCPIA2zkQsDpI6/GLwomJNevXRg7AJ/iuVaJxL8/pyvjrg0L2IwTnEhTGONeBf35WZKJ7ut1XiLRJU4ymYIzmD8q2+oq1UVOXembW4wR8hhtVOOxrjQtt/yTeUl8L0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073286; c=relaxed/simple;
	bh=AYgMO8orETGEoNQ5KR2Hk5OZqWEsKJP9Um0payT4u9w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pderrqB/YQice//Wv4ZP3K/FI2qivtNXEYt/QAUSuDJ7hd8j+/3qXPq0dq7nsfLyzaKkDfNWYfOUU9inqlExa22CZFfOjBEECI7+cpBg4hixN+I/zvCLx0ygJa9tlfTgJE3jdy8R4hHaFYOTlMzkfiN8OaeJIZEFATGHG4a0BXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP4rN4di; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP4rN4di"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2792EC2BCAF;
	Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776073286;
	bh=AYgMO8orETGEoNQ5KR2Hk5OZqWEsKJP9Um0payT4u9w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tP4rN4diImeIutkMm9u1XH3ETThQsxyvbFgeSyaERudosYKkZhrHCsE3c7mC7y1uz
	 7v37UOiYD8CZRRDGJKd6HvDZc5/eyn559ewDDl+RqsttgV1JWKFO4p2BxHt8ILxr7+
	 1p9xXQYsXxArvgjjloqlZE0eRGxcDlt+F3wz7/z3hHiR1m8L62aGax3GC2r/LnBbxp
	 o72BAtnzfnXWnr8G4l3yuHNU/LUM2ds3R1annJ57l7pmWKIo3nuyQMSA2/uYxAwR94
	 sVefKIHOOzQwlLxkjpgFgh+nR+RYUbqkRhNBoWRG7mrtPKmIYNj/0mxuit3m6jBfPm
	 vR+WF959B08rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C29EBFD27;
	Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
From: Bernd Schubert via B4 Relay <devnull+bernd.bsbernd.com@kernel.org>
Subject: [PATCH v4 0/8] fuse: {io-uring} Allow to reduce the number of
 queues and request distribution
Date: Mon, 13 Apr 2026 11:41:23 +0200
Message-Id: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEO63GkC/43Nyw6CMBCF4VchXVvTC9DiyvcwxoztAF1YtBWiI
 by7hYWXDXH5n2S+GUnE4DCSXTaSgIOLrvMp8k1GTAu+QepsaiKYKJgSgga0vUFLfaDB+Ybeeuw
 xniQtwZxVZcFWSpN0fg1Yu8dCH46pWxfvXXgunwY+r3+gA6eMAmiUCrBSWO6t9VvTXchMDuLNc
 MbkCiMSo3JR1xx0bQr9y8gvhq8xMjGl1cpoAMkBP8w0TS/5S30/TAEAAA==
X-Change-ID: 20250722-reduced-nr-ring-queues_3-6acb79dad978
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>, Bernd Schubert <bernd@bsbernd.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776073284; l=2588;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=AYgMO8orETGEoNQ5KR2Hk5OZqWEsKJP9Um0payT4u9w=;
 b=+p2yCPDTjU0sgCtn1wVYrq0J3JjtJrpqKVifALPfz0ghb41UD8BR7GzKBTwDTXdjBS/w6KehS
 pi367cqPDxZDXFpS+Ik+0/y9DBusSLCDeozx4r31vCc0kmDQENTSdZL
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-Endpoint-Received: by B4 Relay for bernd@bsbernd.com/20240529 with
 auth_id=732
X-Original-From: Bernd Schubert <bernd@bsbernd.com>
Reply-To: bernd@bsbernd.com

This adds bitmaps that track which queues are registered and which queues
do not have queued requests.
These bitmaps are then used to map from request core to queue
and also allow load distribution. NUMA affinity is handled and
fuse client/server protocol does not need changes, all is handled
in fuse client internally.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Changes in v4:
- Fix leak of ring->numa_q_map
- Fix q-imbalance due to an issue in static cpu->qid mapping
- Performance tunings, like preferring the current cpu
- Removal of distribution among queues, Joanne had concerns about it.
  As it is an optimization, it can be added later again. At least
  most of it was removed, some light distribution is still left in.
- Link to v3: https://lore.kernel.org/r/20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com

Changes in v3:
- removed FUSE_URING_QUEUE_THRESHOLD (Luis)
- Fixed accidentaly early return of queue1 in fuse_uring_best_queue()
- Fixed similar early return 'best_global'
- Added sanity checks for cpu_to_node()
- Removed retry loops in fuse_uring_best_queue() for code simplicity
- Reduced local numa retries in fuse_uring_get_queue
- Added 'FUSE_URING_REDUCED_Q' FUSE_INIT flag to inform userspace
  about the possibility to reduced queues
- Link to v2: https://lore.kernel.org/r/20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com
- Removed wake-on-same cpu patch from this series, 
  it will be send out independently
- Used READ_ONCE(queue->nr_reqs) as the value is updated (with a lock being
  hold) by other threads and possibly cpus.

---
Bernd Schubert (8):
      fuse: {io-uring} Add queue length counters
      fuse: {io-uring} Rename ring->nr_queues to max_nr_queues
      fuse: {io-uring} Use bitmaps to track registered queues
      fuse: Fetch a queued fuse request on command registration
      fuse: {io-uring} Allow reduced number of ring queues
      fuse: {io-uring} Queue background requests on a different core
      fuse: Add retry attempts for numa local queues for load distribution
      fuse: {io-uring} Prefer the current core over mapping

 fs/fuse/dev_uring.c       | 303 ++++++++++++++++++++++++++++++++++------------
 fs/fuse/dev_uring_i.h     |  25 +++-
 fs/fuse/inode.c           |   2 +-
 include/uapi/linux/fuse.h |   3 +
 4 files changed, 252 insertions(+), 81 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20250722-reduced-nr-ring-queues_3-6acb79dad978

Best regards,
-- 
Bernd Schubert <bernd@bsbernd.com>


