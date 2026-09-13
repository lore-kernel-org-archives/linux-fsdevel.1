Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812F921ABC9
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789310992; cv=none; b=Sc7wBCjMWwyQ0l4P1J9PXlpT+0QgDn4+wdBBzl2sCIJWzUkrPFv+TC8SewLHnanwNQfujmP75WF1KASgF+fUQDB9+zivDQIi2P1MTL3VWy0JLM7aXxsk1YIq7KNhlbdqBU0f9YdrsOoUG25cXurkux5sa9tTBPrupZoDB/eDf3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789310992; c=relaxed/simple;
	bh=U8dx4z7lnyllJ+6JAd+UOAAmPATgrg/BtWHKWvClBK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQ/j84O/AoeNSNDOgyP8b7UBZRBGMCuknqLfqW+njgWO5ZaqDoHAJOCs119QwHlMIwL3nBuXiEPAkcllp242L2KvJKdrX92NEwkSc1OI1tElRf25tiWRvLmZmrFjaMzffMf1E4tyaZXky9zUX5ptu7kuiIwoK1iqpeVoIeO9oY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2JqyXCO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2JqyXCO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49e717c9841so5925375e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789310989; x=1789915789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+IUVAdxsXkpHSpKAcwhzoqAkwM9BlQ0eSfO829Y7ly4=;
        b=F2JqyXCOy/hjfUClOKPhlw7xjV9SMYgwKvih/+nV9qDRwTjg09YOD74lJ6lWs4xV4h
         4SINZ+vIhTh/sKDy3sNsvtIuOzBsPD21ZYeVlnAEC+9aDA0bz+wKbUp3NgBbkmD05u/O
         j2Bi3YAK6x6VOqTsq9jQpwpXawZMn51RnUOw4W1feO4QeN4nUZ1zIjdbSW9KRYVWbEe8
         Agne02efZmsdqnJI8++wwD1DVNLsrklX/5Qc2+GYr/qgu2igP54kUFYacM+QCLPizmGk
         hFW4nKnIgrO16wbApz49+0ueqST7PWTsfscs888mfOVF7fBHsbyaZJTr9Lf5DqVVS5Q9
         98wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789310989; x=1789915789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+IUVAdxsXkpHSpKAcwhzoqAkwM9BlQ0eSfO829Y7ly4=;
        b=ij5LIPmuDESxzngAgwDi3aZy0L+yVp53KJ5du9AyCOzHj9JQqhMhgLGHY5MlS4a077
         TChj01v4rSMBTJWzLOlq/1lEHJfSf8qH4a0b/E0kHqrBKdabU1J1aelvQkmGgIS0jwOd
         VivEowFhGckJEhc5ac+tyHKPQmiP6vSgdvwAu15o+6UjN+30/UhhkDHmtJtKfzugP6Ik
         7y11bV2CEaiP0qMYkbM2Y8y9Vufx75EvRtUEvba5JM7ilRzyjcoRk2MnpKfpBR1hdFeT
         4OctmahjotrV2qBFl+whrKEOTs/gd+mIU0VFcXyNuuY5uDBPDfkrsY2H40hWkYPhOMVq
         CdQw==
X-Forwarded-Encrypted: i=1; AKwUvBxsbhwEQfOPJFCRqjZz24JtvclYSAYrALIvCeWAVI7CtmvVxaQ6Oyg0mh9Xc+TxIXEUmVB/k3DQ56pZ1RlR@vger.kernel.org
X-Gm-Message-State: AFuF++lIXZ4iUoEfQWGB9U1dFkjbBv3KGJZ/gvdHEKs8drKUiJ64y1J+
	WVcgC4n/zOFdoXFIRHbAcidDtguuX1k87gB5FPh4Km67R/frAXIzhJmf
X-Gm-Gg: AYBFou35IjMDulCYkt0c79BprJYmwOI6F7Ja5MVi9+xR+vlzPE+T2lkytE0HRNZOPzW
	naA1VfuNPdL0iUfYIYldMlg9eqk0/OIemNU9U9aB2hFnn0Jtfk+ofHyLJLxAwhTkJsj0jVGl1Lz
	2ajbNRGkZZKvvOxjIDS3T6ZORAO7XtyaAKQdaQc63kVJUYmbw4d5M0B6DwTUrKEUgK1ZeCs3Es2
	n5HTxUjJ+unfiLoHg1BmdHX2vGAs3isV3q6SVhSuFHFCOU8mJ21B0ovThpxfBnkEm2j28jhIX8J
	0D6fe1AwvtcgMuFKjUuNqnn5dBDFC7RWeFdIcrrf9M/Qrd/obssyXUdc2IHKAmchWQLJQJBbWke
	SynrExp4lH8yCbizfkfNvBvVFrDPqtw0termaDHFBOy2ug7EeEHaFsw/+mMkF9t+bImHvmJK6r5
	/2xUdj5BfEx0gwkM/oES5jPepLNJYAKHz+j1RE+lnfb5axPuw2uSElPfoaw6YGg503nqZ/ebnue
	u06Upp1Jxa7J6G5s+d2ZC0uYf1clB4RLUCtLDajKHMmnMhErDvuJQ==
X-Received: by 2002:a05:600d:864d:10b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-49e61983764mr96141535e9.2.1789310988499;
        Sun, 13 Sep 2026 07:49:48 -0700 (PDT)
Received: from f.. (cst-prg-84-1.cust.vodafone.cz. [46.135.84.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6420de77sm109534235e9.3.2026.09.13.07.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:49:47 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 00/10] Towards safer path_* API
Date: Sun, 13 Sep 2026 16:49:07 +0200
Message-ID: <20260913144918.1606123-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the handling is highly error-prone with consumers allowed to
arbitrarily manipulate references, notably with path_get().

In the past this resulted in preventable bugs.

The end goal, not yet achieved with this patchset, will provide an
invariant that a populated 'struct path' has precisely one set of
references on it.

While consumers can still cause leaks by neglecting to path_put(), the
footgun of path_get() can be eliminated.

With this patchset instead of hand-rolling a path copy and issuing
path_get() on it, callers can resort to path_clone() instead.

Almost all path_get() consumers get converted, most of which with
coccinelle.

Few instances are left until I figure out a nice way to sort them out.

Overall almost entirety of this patchset is a NOP.

Mateusz Guzik (10):
  fs: unexport backing_file_set_user_path() and make it take the ref on
    its own
  fs: add path_create(), path_move() and path_clone()
  fs: use path_clone() in path_init()
  fs: use path_clone() and path_move() in vfs_open*
  fs: use path_clone() in backing_file_set_user_path()
  Coccinelle-based conversion of path_* consumers to use the new
    primitives
  autofs: use path_create()
  fsnotify: use path_clone()
  proc: use path_clone()
  nfsd: use path_clone()

 drivers/block/loop.c               |  3 +-
 fs/autofs/dev-ioctl.c              |  3 +-
 fs/autofs/expire.c                 |  4 +--
 fs/backing-file.c                  |  2 --
 fs/devpts/inode.c                  |  6 ++--
 fs/failfs.c                        |  3 +-
 fs/fhandle.c                       |  3 +-
 fs/file_attr.c                     |  6 ++--
 fs/file_table.c                    |  3 +-
 fs/fs_struct.c                     |  6 ++--
 fs/namei.c                         | 44 ++++++++++++++++++++++++------
 fs/namespace.c                     |  3 +-
 fs/nfsd/export.c                   |  6 ++--
 fs/nfsd/nfs4xdr.c                  |  8 +++---
 fs/notify/fanotify/fanotify.c      |  6 ++--
 fs/notify/fanotify/fanotify_user.c |  3 +-
 fs/nsfs.c                          |  3 +-
 fs/open.c                          | 10 ++-----
 fs/overlayfs/params.c              |  3 +-
 fs/pidfs.c                         |  3 +-
 fs/proc/base.c                     |  6 ++--
 fs/proc/fd.c                       |  3 +-
 fs/smb/server/vfs.c                |  3 +-
 fs/xfs/xfs_handle.c                |  3 +-
 include/linux/path.h               | 14 ++++++++--
 kernel/trace/bpf_trace.c           |  3 +-
 security/apparmor/task.c           |  3 +-
 security/keys/big_key.c            |  3 +-
 security/landlock/fs.c             |  3 +-
 security/landlock/syscalls.c       |  3 +-
 30 files changed, 87 insertions(+), 85 deletions(-)

-- 
2.53.0

