Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376737;
	b=gsiAKeNNzMEO6kdTs8dNSJ2oxmjcUvm4gH3XtWksGu3f3I/0vVNX7whlO0ZDKYIGvlY0
	 yCu9X2weyvhM0tp/p4MHXtjI3ywChU3R5SR2wFTFaD9l1to/LPNpGFSk97kOpyvGPEteQ
	 D1uoqIaDtJFKs4sgs0+Bg11Ea5EaxUavVzWGfP65lqZQhJy3MLnTOZqVLlHGZCPDVNLW1
	 24eIWC9PHjBWmNiArQIvjQnHvtexA+mBR8zELmvrVJKe08J4DhQa80cSwuDUV2iyosApa
	 /PSMMMvIDePNfBW7M2H/a4FyWo2bUPB09PGBce3ZZA4CimU9TAhMgkjxGn5/8xF3tsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376737;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LsPBX9d2NWf0YzcC9yRlg4OwHPmwqAvnoUuad5cDj4Q=;
	b=Y5ih1zcMWZwZjR7jj5q+1rgvNVpllK0tj5Snu/BYcEHboW1e0kGtyrtnrFCQou1xGTIG
	 uhvoUbLzI2DarMg+b8co+k2JUJ0gPnWUgGCHCweqyAPoSRxJGCNti18e8rEQmSKK5e058
	 FN/eBQYVNxbITq3MNTf3NIHj/ZJsc9V8Bl1HDxkXiwggQ8la4yaka36wfObp4opeTAYKK
	 LDu4x5uqAWBsS5zvRZTXxSf14mNfk4oLPkphgO1hJ/h/vVgv9G+c5NRRMt3ma5sG1Ni3O
	 RiYyRqqt0ecgpJrOjAQNWltO70dv0d4VhEw8xYERrucZBobOM+qwVu76GJEZhYofbMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byvvavSM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216C3606A327
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byvvavSM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810141F0093A;
	Fri, 30 Oct 2026 16:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376737;
	bh=LsPBX9d2NWf0YzcC9yRlg4OwHPmwqAvnoUuad5cDj4Q=;
	h=From:Subject:Date:To:Cc;
	b=byvvavSMEawTDFW8s0aHTY7Z+gdHO5PZlNLgyMr2PZKcwORmkqJvWM4phWT5AT/h4
	 jTbRxwk+1nQjkNbDAk6xXreoc4il/iXBOuqxr9mi5ymSXbieoQWoz9ZJxxOyIDrtWT
	 flzK9e/G3L+PuUDRly3KSMditNizCxdAIY2C6YeaGKhvy8GcZRxN0LqfWmw3hsM7Jc
	 Z5vVoScV9xbmDVMK29jo8rs/Kv4kxgDRpONdu4/vjcAIY69rs9wy4f2rqNBUQAD7uG
	 hPuW+TxiCmfcDBsS/tBPDUK1hPDtJ+3PAR647pjdtuL9NNtX9sF78aq7Ap+qYBqGAC
	 ZQK/qd+IygOKQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/7] proc: stop /proc/<pid> files at a privileged execve()
Date: Fri, 30 Oct 2026 17:11:52 +0100
Message-Id: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMyw7CIBBFf6WZtUMAtST+inEBdLBoUpoZX0nTf
 xdsXJ77OAsIcSaBU7cA0ytLLlMFs+sgjn66EuahMlhte6P3Gt+F7zhziUnQZ0z5Q4LWusEcD71
 zKUC9zky/oj7Pl43lGW4UH83VFsELYWA/xbFFzao2q/pbVdvAun4BYdW2qKQAAAA=
X-Change-ID: 20261030-work-procfs-ai-fixes-227d154677fb
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2719; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1Bpo+qbKnUT22MAfsKoKPtjMiDXWWVp15bo7jIakJQg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9OXh3/wL/78/Cvv7WrInnYDvUq2a8UMNyTd9t3YW7I
 l9Y+01+3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR168Z/rvIvDMv8j7x57bL
 yorNBu23RIQelL7tkGddbfnn4Bf/WYyMDOti/L1ULOY23b28JfarSZec9PyeWYcWzHxckcVdpHF
 uOx8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

So that's part of a larger procfs series I have and is split out of it
as it's pretty standalone.

Some files in /proc/<pid> check access when they're opened and then
look at the task on every read. They keep working after the task
executed a set-user-ID program: fdinfo/<fd>, ksm_stat, ksm_merging_pages
and the fd/ and fdinfo/ directories.

I discussed a prior version of this with Jann a bit and they weren't
mergeable as is. So I rewrote it all.

None of this has much of a security impact. It tells you which
descriptors a set-user-ID program has open, their fdinfo and its ksm
counters.

The files now remember ->self_exec_id when they're opened. If the task
executed another program since, the file only keeps working if its
opener would be allowed to open it now. Only the opener counts, not the
reader. Otherwise you just hand the file to a set-user-ID binary as
stdin and let it do the reading for you.

That check needs exec_update_lock. The task's own threads don't take
it, so /proc/self is unaffected. getdents() checks again for every
entry because the copy to userspace can take as long as the caller
wants.

There's also a fix for lookups in fd/ that start at a descriptor for
the directory and go by a stale owner. So that one is technically
correct but I worry a little about performance regressions. But we can
certainly try.

On a KASAN and lockdep kernel the selftest fails without the series,
apart from the control case, and passes with it. The other proc
selftests behave the same with and without the series.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (7):
      proc: get the inode from the file instead of ->private
      proc: add helpers for files that outlive an execve()
      proc: stop fdinfo files at a privileged execve()
      proc: stop the ksm files at a privileged execve()
      proc: stop fd directories at a privileged execve()
      proc: refresh the owner of fd/ before checking access
      selftests/proc: check /proc/<pid> files across a set-user-ID exec

 fs/proc/base.c                                     | 189 ++++++-
 fs/proc/fd.c                                       |  79 ++-
 fs/proc/internal.h                                 |   8 +
 tools/testing/selftests/proc/.gitignore            |   1 +
 tools/testing/selftests/proc/Makefile              |   1 +
 tools/testing/selftests/proc/config                |   2 +
 .../testing/selftests/proc/proc-pid-setuid-exec.c  | 546 +++++++++++++++++++++
 7 files changed, 793 insertions(+), 33 deletions(-)
---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261030-work-procfs-ai-fixes-227d154677fb

